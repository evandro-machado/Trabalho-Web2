/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.magazine.dao;

import br.com.magazine.entidade.Cliente;
import br.com.magazine.entidade.Editora;
import br.com.magazine.entidade.Genero;
import br.com.magazine.entidade.ItemPedido;
import br.com.magazine.entidade.Pedido;
import br.com.magazine.entidade.Produto;
import br.com.magazine.entidade.StatusPedido;
import br.com.magazine.util.ConnectionFactory;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Grupo X
 */
public class PedidoDAO {

    private final String stmtCadastraPedido = "insert into Pedido (idCliente,idstatuspedido,data,valortotal) values (?,?,?,?)";
    private final String stmtAtualizaStatusPedido = "update Pedido set idStatusPedido = ? where idPedido = ?";

//    private final String stmtRemoveCliente = "delete from Cliente where idCliente = ?";
//    private final String stmtRemoveItemPedidoCliente = "delete from itempedido where idpedido = (select idpedido from pedido where idcliente = ?)";
//    private final String stmtRemovePedidoCliente = "delete from pedido where idpedido = (select idpedido from pedido where idcliente= ? )";
//    private final String stmtProcuraNome = "select * from Cliente where nome like ";
//    private final String stmtProcuraSobreNome = "select * from Cliente where sobrenome like ";
//    private final String stmtProcuraCPF = "select * from Cliente where cpf like ";
    public void cadastrarPedido(Pedido pedido) throws ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            stmt = con.prepareStatement(stmtCadastraPedido, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, pedido.getIdCliente());
            stmt.setInt(2, pedido.getStatusPedido().getIdStatusPedido());
            stmt.setTimestamp(3, pedido.getData());
            stmt.setDouble(4, pedido.getValorTotal());
            stmt.executeUpdate();
            /* pegar id do pedido inserido */
            ResultSet rs = stmt.getGeneratedKeys();
            int idPedido = 0;
            if (rs != null && rs.next()) {
                idPedido = rs.getInt(1);
            }
            con.commit();
            List<ItemPedido> listaItensPedido = pedido.getItens();
            for (ItemPedido cada : listaItensPedido) {
                cada.setIdPedido(idPedido);
            }
            //chamar funcao inserir produtos na item pedido ///
            this.cadastrarItensDoPedido(listaItensPedido);

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir um pedido no banco de dados. Origem: " + e.getMessage());
        } finally {
            try {
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
            }
        }
    }
    /* função privada para cadastrar os itens do carrinho*/

    private void cadastrarItensDoPedido(List<ItemPedido> p) throws ClassNotFoundException {
        for (ItemPedido cada : p) {
            ItemPedidoDAO ip = new ItemPedidoDAO();
            ip.cadastrarItemPedido(cada);
        }
    }

    public void atualizarStatusPedido(Pedido p) throws ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtAtualizaStatusPedido);
            stmt.setInt(1, p.getStatusPedido().getIdStatusPedido());
            stmt.setInt(2, p.getIdPedido());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
            }
        }
    }

    private final String stmtListaPedido = "select * from Pedido join statuspedido using (idStatusPedido) where idcliente = ? order by data desc";
    private final String stmtListaPedidoAberto = "select * from Pedido join statuspedido using (idStatusPedido) where idcliente = ? and idStatusPedido = 1 order by data desc";
    private final String stmtListaPedidoFinalizado = "select * from Pedido join statuspedido using (idStatusPedido) where idcliente = ? and idStatusPedido != 1 order by data desc";
    private final String stmtListaItensPedido = "select iditempedido, quantidade, valorunitario, idproduto , titulo, autor, ideditora, editora.nome as nomeEditora, preco, idgenero,genero.nome as generoNome, idImg,produto.inativo as produtoInativo from itempedido inner join produto using(idproduto) inner join editora on(fkeditora = ideditora) inner join genero on(fkgenero = idgenero)  where idpedido = ?";
    
    public List<Pedido> listaItensPedidosCliente(Cliente cliente) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmt = null;
        PreparedStatement stmt2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtListaPedido);
            stmt.setInt(1, cliente.getIdCliente());
            rs = stmt.executeQuery();
            List<Pedido> listaPedidos = new ArrayList();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idpedido"));
                pedido.setIdCliente(cliente.getIdCliente());
                StatusPedido statusPedido = new StatusPedido();
                statusPedido.setIdStatusPedido(rs.getInt("idStatusPedido"));
                statusPedido.setDescricao(rs.getString("descricao"));
                pedido.setStatusPedido(statusPedido);
                
                pedido.setData(rs.getTimestamp("data"));
                pedido.setValorTotal(rs.getDouble("valortotal"));
                stmt2 = con.prepareStatement(stmtListaItensPedido);
                stmt2.setInt(1, pedido.getIdPedido());
                rs2 = stmt2.executeQuery();
                List<ItemPedido> listaItensPedido = new ArrayList();
                while (rs2.next()) {
                    ItemPedido itemPedido = new ItemPedido();
                    itemPedido.setIdItemPedido(rs2.getInt("iditempedido"));
                    itemPedido.setIdPedido(pedido.getIdPedido());
                    itemPedido.setQuantidade(rs2.getInt("quantidade"));
                    itemPedido.setValorUnitario(rs2.getDouble("valorunitario"));

                    Produto produto = new Produto();
                    produto.setIdProduto(rs2.getInt("idproduto"));
                    produto.setTitulo(rs2.getString("titulo"));
                    produto.setAutor(rs2.getString("autor"));
                    produto.setPreco(rs2.getDouble("preco"));
                    produto.setidImg(rs2.getInt("idImg"));
                    produto.setInativo(rs2.getBoolean("produtoInativo"));

                    Editora editora = new Editora();
                    editora.setIdEditora(rs2.getInt("ideditora"));
                    editora.setNome(rs2.getString("nomeEditora"));

                    Genero genero = new Genero();
                    genero.setIdGenero(rs2.getInt("idGenero"));
                    genero.setNome(rs2.getString("generoNome"));

                    produto.setEditora(editora);
                    produto.setGenero(genero);
                    
                    itemPedido.setProduto(produto);
                    
                    listaItensPedido.add(itemPedido);
                }
                pedido.setItens(listaItensPedido);
                listaPedidos.add(pedido);

            }
            return listaPedidos;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
            }
            try {
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
            }
        }

    }
    public List<Pedido> listaPedidosAbertosCliente(Cliente cliente) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmt = null;
        PreparedStatement stmt2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtListaPedidoAberto);
            stmt.setInt(1, cliente.getIdCliente());
            rs = stmt.executeQuery();
            List<Pedido> listaPedidos = new ArrayList();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idpedido"));
                pedido.setIdCliente(cliente.getIdCliente());
                StatusPedido statusPedido = new StatusPedido();
                statusPedido.setIdStatusPedido(rs.getInt("idstatuspedido"));
                statusPedido.setDescricao(rs.getString("descricao"));
                pedido.setStatusPedido(statusPedido);
                pedido.setData(rs.getTimestamp("data"));
                pedido.setValorTotal(rs.getDouble("valortotal"));
                stmt2 = con.prepareStatement(stmtListaItensPedido);
                stmt2.setInt(1, pedido.getIdPedido());
                rs2 = stmt2.executeQuery();
                List<ItemPedido> listaItensPedido = new ArrayList();
                while (rs2.next()) {
                    ItemPedido itemPedido = new ItemPedido();
                    itemPedido.setIdItemPedido(rs2.getInt("iditempedido"));
                    itemPedido.setIdPedido(pedido.getIdPedido());
                    itemPedido.setQuantidade(rs2.getInt("quantidade"));
                    itemPedido.setValorUnitario(rs2.getDouble("valorunitario"));

                    Produto produto = new Produto();
                    produto.setIdProduto(rs2.getInt("idproduto"));
                    produto.setTitulo(rs2.getString("titulo"));
                    produto.setAutor(rs2.getString("autor"));
                    produto.setPreco(rs2.getDouble("preco"));
                    produto.setidImg(rs2.getInt("idImg"));
                    produto.setInativo(rs2.getBoolean("produtoInativo"));

                    Editora editora = new Editora();
                    editora.setIdEditora(rs2.getInt("ideditora"));
                    editora.setNome(rs2.getString("nomeEditora"));

                    Genero genero = new Genero();
                    genero.setIdGenero(rs2.getInt("idGenero"));
                    genero.setNome(rs2.getString("generoNome"));

                    produto.setEditora(editora);
                    produto.setGenero(genero);
                    
                    itemPedido.setProduto(produto);
                    
                    listaItensPedido.add(itemPedido);
                }
                pedido.setItens(listaItensPedido);
                listaPedidos.add(pedido);

            }
            return listaPedidos;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
            }
            try {
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
            }
        }

    }
    public List<Pedido> listaPedidosFinalizadosCliente(Cliente cliente) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stmt = null;
        PreparedStatement stmt2 = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtListaPedidoFinalizado);
            stmt.setInt(1, cliente.getIdCliente());
            rs = stmt.executeQuery();
            List<Pedido> listaPedidos = new ArrayList();
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idpedido"));
                pedido.setIdCliente(cliente.getIdCliente());
                StatusPedido statusPedido = new StatusPedido();
                statusPedido.setIdStatusPedido(rs.getInt("idstatuspedido"));
                statusPedido.setDescricao(rs.getString("descricao"));
                pedido.setStatusPedido(statusPedido);
                pedido.setData(rs.getTimestamp("data"));
                pedido.setValorTotal(rs.getDouble("valortotal"));
               stmt2 = con.prepareStatement(stmtListaItensPedido);
                stmt2.setInt(1, pedido.getIdPedido());
                rs2 = stmt2.executeQuery();
                List<ItemPedido> listaItensPedido = new ArrayList();
                while (rs2.next()) {
                    ItemPedido itemPedido = new ItemPedido();
                    itemPedido.setIdItemPedido(rs2.getInt("iditempedido"));
                    itemPedido.setIdPedido(pedido.getIdPedido());
                    itemPedido.setQuantidade(rs2.getInt("quantidade"));
                    itemPedido.setValorUnitario(rs2.getDouble("valorunitario"));

                    Produto produto = new Produto();
                    produto.setIdProduto(rs2.getInt("idproduto"));
                    produto.setTitulo(rs2.getString("titulo"));
                    produto.setAutor(rs2.getString("autor"));
                    produto.setPreco(rs2.getDouble("preco"));
                    produto.setidImg(rs2.getInt("idImg"));
                    produto.setInativo(rs2.getBoolean("produtoInativo"));

                    Editora editora = new Editora();
                    editora.setIdEditora(rs2.getInt("ideditora"));
                    editora.setNome(rs2.getString("nomeEditora"));

                    Genero genero = new Genero();
                    genero.setIdGenero(rs2.getInt("idGenero"));
                    genero.setNome(rs2.getString("generoNome"));

                    produto.setEditora(editora);
                    produto.setGenero(genero);
                    
                    itemPedido.setProduto(produto);
                    
                    listaItensPedido.add(itemPedido);
                }
                pedido.setItens(listaItensPedido);
                listaPedidos.add(pedido);

            }
            return listaPedidos;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
            }
            try {
                stmt.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
            }
            try {
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
            }
        }

    }
//    
//    public List<Cliente> procuraNome(String nome) throws SQLException {
//        Connection con = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        try {
//            con = ConnectionFactory.getConnection();
//            stmt = con.prepareStatement(stmtProcuraNome+"'%"+nome+"%'");
//            rs = stmt.executeQuery();
//            List<Cliente> listaClientes = new ArrayList();
//          
//            while (rs.next()) {
//                Cliente cliente = new Cliente(rs.getString("nome"), rs.getString("sobrenome"), rs.getString("cpf"));
//                cliente.setIdCliente(rs.getInt("idcliente"));
//                listaClientes.add(cliente);
//            }
//            return listaClientes;
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        } finally {
//            try {
//                rs.close();
//            } catch (Exception ex) {
//                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
//            }
//            try {
//                stmt.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
//            }
//            try {
//                con.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
//            }
//        }
//
//    }
//    
//    
//    public List<Cliente> procuraSobreNome(String sobrenome) throws SQLException {
//        Connection con = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        try {
//            con = ConnectionFactory.getConnection();
//            stmt = con.prepareStatement(stmtProcuraSobreNome+"'%"+sobrenome+"%'");
//            rs = stmt.executeQuery();
//            List<Cliente> listaClientes = new ArrayList();
//          
//            while (rs.next()) {
//                Cliente cliente = new Cliente(rs.getString("nome"), rs.getString("sobrenome"), rs.getString("cpf"));
//                cliente.setIdCliente(rs.getInt("idcliente"));
//                listaClientes.add(cliente);
//            }
//            return listaClientes;
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        } finally {
//            try {
//                rs.close();
//            } catch (Exception ex) {
//                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
//            }
//            try {
//                stmt.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
//            }
//            try {
//                con.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
//            }
//        }
//
//    }
//    
//        public List<Cliente> procuraCPF (String cpf) throws SQLException {
//        Connection con = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        try {
//            con = ConnectionFactory.getConnection();
//            stmt = con.prepareStatement(stmtProcuraCPF+"'%"+cpf+"%'");
//            rs = stmt.executeQuery();
//            List<Cliente> listaClientes = new ArrayList();
//          
//            while (rs.next()) {
//                Cliente cliente = new Cliente(rs.getString("nome"), rs.getString("sobrenome"), rs.getString("cpf"));
//                cliente.setIdCliente(rs.getInt("idcliente"));
//                listaClientes.add(cliente);
//            }
//            return listaClientes;
//
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        } finally {
//            try {
//                rs.close();
//            } catch (Exception ex) {
//                System.out.println("Erro ao fechar result set.Erro: " + ex.getMessage());
//            }
//            try {
//                stmt.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar statement. Ex = " + ex.getMessage());
//            }
//            try {
//                con.close();
//            } catch (SQLException ex) {
//                System.out.println("Erro ao fechar a conexao. Ex = " + ex.getMessage());
//            }
//        }
//
//    }
//    
//    
//        public void removerCliente(Cliente cliente) throws SQLException{
//        Connection con = null;
//        PreparedStatement stmt1 = null;
//        PreparedStatement stmt2 = null;
//        PreparedStatement stmt3 = null;
//        try{
//            con = ConnectionFactory.getConnection();
//            stmt1 = con.prepareStatement(stmtRemoveItemPedidoCliente);
//            stmt1.setLong(1,cliente.getIdCliente());
//            stmt1.executeUpdate();
//            stmt2 = con.prepareStatement(stmtRemovePedidoCliente);
//            stmt2.setLong(1,cliente.getIdCliente());
//            stmt2.executeUpdate();
//            stmt3 = con.prepareStatement(stmtRemoveCliente);
//            stmt3.setLong(1,cliente.getIdCliente());
//            stmt3.executeUpdate();
//        }catch (SQLException e){
//            throw new RuntimeException(e);
//        } finally{
//            try{
//                stmt1.close();
//                stmt2.close();
//                stmt3.close();
//            }catch (Exception ex){
//                System.out.println("Erro ao fechar stmt. Ex="+ex.getMessage());
//            }
//            try{
//                con.close();
//            }catch(Exception ex){
//                System.out.println("Erro ao fechar conexao. Ex = "+ex.getMessage());
//            }
//        }
//    
//    }
}
