/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.magazine.servlet;

import br.com.magazine.dao.ClienteDAO;
import br.com.magazine.dao.GeneroDAO;
import br.com.magazine.dao.ItemPedidoDAO;
import br.com.magazine.dao.LogDAO;
import br.com.magazine.dao.PedidoDAO;
import br.com.magazine.dao.ProdutoDAO;
import br.com.magazine.entidade.Cliente;
import br.com.magazine.entidade.Genero;
import br.com.magazine.entidade.Log;
import br.com.magazine.entidade.Pedido;
import br.com.magazine.entidade.Produto;
import br.com.magazine.entidade.StatusPedido;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Evandro-PC
 */
@WebServlet(name = "Clientes", urlPatterns = {"/cliente/Clientes"})
public class Clientes extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if ("cadastrar".equals(request.getParameter("action"))) {
                Cliente cliente = new Cliente();

                cliente.setNome(request.getParameter("nome"));
                cliente.setSexo(request.getParameter("sexo"));
                cliente.setCpf(request.getParameter("cpf"));

                String nascimentoStr = request.getParameter("nascimento");
                DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                java.util.Date nascimentoUtil = format.parse(nascimentoStr);
                java.sql.Date nascimentoSql = new java.sql.Date(nascimentoUtil.getTime());
                cliente.setNascimento(nascimentoSql);

                cliente.setTelefone(request.getParameter("telefone"));
                cliente.setEmail(request.getParameter("email"));
                cliente.setSenha(request.getParameter("senha"));
                cliente.setCep(request.getParameter("cep"));
                cliente.setEndereco(request.getParameter("endereco"));
                cliente.setEndNumero(request.getParameter("numero"));
                cliente.setEndComplemento(request.getParameter("complemento"));
                cliente.setBairro(request.getParameter("bairro"));
                cliente.setCidade(request.getParameter("cidade"));
                cliente.setEstado(request.getParameter("estado"));
                cliente.setPerfil(1);

                ClienteDAO clienteDAO = new ClienteDAO();
                int idCliente = clienteDAO.cadastrarCliente(cliente);
                Log log = new Log();
                log.setAcao("Cliente cadastrado");
                log.setPagina("/cliente/cadastrarCliente.jsp");
                Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                log.setData(dataLog);
                log.setIdCliente(idCliente);
                LogDAO logDAO = new LogDAO();
                logDAO.insereLog(log);
            }
            HttpSession session = request.getSession();
            int logado;
            int perfil;
            int idCliente;
            try {
                logado = (int) session.getAttribute("logado");
                perfil = (int) session.getAttribute("perfil");
                idCliente = (int) session.getAttribute("idcliente");
            } catch (Exception f) {
                logado = 0;
                perfil = 0;
                idCliente = 0;
            }

            if (logado > 0 && perfil == 1) {
                System.out.println(logado + " " + perfil);

                if ("alterarPerfil".equals(request.getParameter("action"))) {
                    ClienteDAO clienteDAO = new ClienteDAO();
                    Cliente clienteSessao = new Cliente();
                    clienteSessao.setIdCliente(idCliente);
                    Cliente cliente = clienteDAO.buscarClienteId(clienteSessao);
                    request.setAttribute("cliente", cliente);
//                response.sendRedirect("./alterarCliente.jsp");
//                return;

                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/alterarCliente.jsp");
                    rd.forward(request, response);
                }
                if ("alterar".equals(request.getParameter("action"))) {
                    Cliente cliente = new Cliente();

                    cliente.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
                    cliente.setNome(request.getParameter("nome"));
                    cliente.setSexo(request.getParameter("sexo"));
                    cliente.setCpf(request.getParameter("cpf"));

                    String nascimentoStr = request.getParameter("nascimento");
                    DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date nascimentoUtil = format.parse(nascimentoStr);
                    java.sql.Date nascimentoSql = new java.sql.Date(nascimentoUtil.getTime());
                    cliente.setNascimento(nascimentoSql);

                    cliente.setTelefone(request.getParameter("telefone"));
                    cliente.setEmail(request.getParameter("email"));
                    cliente.setSenha(request.getParameter("senha"));
                    cliente.setCep(request.getParameter("cep"));
                    cliente.setEndereco(request.getParameter("endereco"));
                    cliente.setEndNumero(request.getParameter("numero"));
                    cliente.setEndComplemento(request.getParameter("complemento"));
                    cliente.setBairro(request.getParameter("bairro"));
                    cliente.setCidade(request.getParameter("cidade"));
                    cliente.setEstado(request.getParameter("estado"));
                    cliente.setInativo(false);
                    cliente.setPerfil(1);

                    Log log = new Log();
                    log.setAcao("Perfil do cliente alterado.");
                    log.setPagina("/cliente/alterarPerfil.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdCliente(idCliente);
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    ClienteDAO clienteDAO = new ClienteDAO();
                    clienteDAO.atualizarCliente(cliente);
                }
                if ("excluir".equals(request.getParameter("action"))) {
                    Cliente cliente = new Cliente();
                    ClienteDAO clienteDAO = new ClienteDAO();
                    cliente.setIdCliente(Integer.parseInt(request.getParameter("cliente-id")));
                    System.out.println(Integer.parseInt(request.getParameter("cliente-id")));

                    Log log = new Log();
                    log.setAcao("Conta excluida pelo cliente.");
                    log.setPagina("/cliente/menuCliente.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdCliente(idCliente);
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    clienteDAO.removerCliente(cliente);
                    response.sendRedirect("../comum/Login?action=logout");
                    return;
                }
                if ("nomeAZ".equals(request.getParameter("action"))) {
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    List<Produto> listaProdutosMaisVendidos = produtoDAO.listarProdutosMaisVendidosAZ();
                    request.setAttribute("listaProdutos", listaProdutosMaisVendidos);
                    request.setAttribute("ordem", "AZ");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/index.jsp");
                    rd.forward(request, response);
                }
                if ("nomeZA".equals(request.getParameter("action"))) {
                    ProdutoDAO produtoDAO = new ProdutoDAO();

                    List<Produto> listaProdutosMaisVendidos = produtoDAO.listarProdutosMaisVendidosZA();
                    request.setAttribute("listaProdutos", listaProdutosMaisVendidos);
                    request.setAttribute("ordem", "ZA");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/index.jsp");
                    rd.forward(request, response);
                }
                if ("Asc".equals(request.getParameter("action"))) {
                    ProdutoDAO produtoDAO = new ProdutoDAO();

                    List<Produto> listaProdutosMaisVendidos = produtoDAO.listarProdutosMaisVendidosAsc();
                    request.setAttribute("listaProdutos", listaProdutosMaisVendidos);
                    request.setAttribute("ordem", "Asc");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/index.jsp");
                    rd.forward(request, response);
                }
                if ("Desc".equals(request.getParameter("action"))) {
                    ProdutoDAO produtoDAO = new ProdutoDAO();

                    List<Produto> listaProdutosMaisVendidos = produtoDAO.listarProdutosMaisVendidosDesc();
                    request.setAttribute("listaProdutos", listaProdutosMaisVendidos);
                    request.setAttribute("ordem", "Desc");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/index.jsp");
                    rd.forward(request, response);
                }
                if ("pedidos".equals(request.getParameter("action"))) {
                    Cliente cliente = new Cliente();
                    cliente.setIdCliente((int) session.getAttribute("idcliente"));
                    PedidoDAO pedidoDAO = new PedidoDAO();
                    List<Pedido> listaPedidosAbertos = pedidoDAO.listaPedidosAbertosCliente(cliente);
                    List<Pedido> listaPedidosFinalizados = pedidoDAO.listaPedidosFinalizadosCliente(cliente);

                    request.setAttribute("listaPedidosAbertos", listaPedidosAbertos);
                    request.setAttribute("listaPedidosFinalizados", listaPedidosFinalizados);

                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/visualizarCompra.jsp");
                    rd.forward(request, response);
                    return;

                }
                if ("confirmarRecebimento".equals(request.getParameter("action"))) {

                    Pedido pedido = new Pedido();
                    pedido.setIdPedido(Integer.parseInt(request.getParameter("id")));
                    StatusPedido statusPedido = new StatusPedido();
                    statusPedido.setIdStatusPedido(2);
                    pedido.setStatusPedido(statusPedido);
                    PedidoDAO pedidoDAO = new PedidoDAO();
                    pedidoDAO.atualizarStatusPedido(pedido);

                    Log log = new Log();
                    log.setAcao("Pedido confirmado.");
                    log.setPagina("/cliente/visualizarPedidos.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdCliente(idCliente);
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    response.sendRedirect("./Clientes?action=pedidos");
                    return;
                }
                if ("cancelar".equals(request.getParameter("action"))) {

                    Pedido pedido = new Pedido();
                    pedido.setIdPedido(Integer.parseInt(request.getParameter("id")));
                    StatusPedido statusPedido = new StatusPedido();
                    statusPedido.setIdStatusPedido(0);
                    pedido.setStatusPedido(statusPedido);
                    PedidoDAO pedidoDAO = new PedidoDAO();
                    pedidoDAO.atualizarStatusPedido(pedido);

                    Log log = new Log();
                    log.setAcao("Pedido cancelado.");
                    log.setPagina("/cliente/visualizarPedidos.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdCliente(idCliente);
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    response.sendRedirect("./Clientes?action=pedidos");
                    return;
                }
                if ("visualizarProduto".equals(request.getParameter("action"))) {
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    int id = Integer.parseInt(request.getParameter("id"));
                    Produto produto = produtoDAO.listarProdutoPorId(id);
                    String escolha = request.getParameter("escolha");
                    String str = request.getParameter("str");
                    String idGenero = request.getParameter("genero");
                    request.setAttribute("escolha", escolha);
                    request.setAttribute("str", str);
                    request.setAttribute("genero", idGenero);
                    request.setAttribute("produto", produto);

                    Log log = new Log();
                    log.setAcao("Item visualizado.");
                    log.setPagina("/cliente/visualizarProduto.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdProduto(id);
                    log.setIdCliente(idCliente);
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/visualizarProduto.jsp");
                    rd.forward(request, response);
                }
                if ("pesquisarProduto".equals(request.getParameter("action"))) {
                    GeneroDAO generoDAO = new GeneroDAO();
                    List<Genero> listaGeneros = generoDAO.listarGeneros();
                    request.setAttribute("listaGeneros", listaGeneros);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/pesquisarProduto.jsp");

                    rd.forward(request, response);
                    return;
                }
                if ("pesquisar".equals(request.getParameter("action"))) {
                    GeneroDAO generoDAO = new GeneroDAO();
                    List<Genero> listaGeneros = generoDAO.listarGeneros();
                    request.setAttribute("listaGeneros", listaGeneros);
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    if (request.getParameter("genero") != null) {
                        int idGenero = Integer.parseInt(request.getParameter("genero"));
                        List<Produto> listaProdutos = produtoDAO.listarProdutoPorGenero(idGenero);
                        request.setAttribute("genero", idGenero);
                        request.setAttribute("listaProdutos", listaProdutos);
                    } else if (request.getParameter("str") != null) {
                        List<Produto> listaProdutos = new ArrayList();
                        String escolha = request.getParameter("escolha");
                        String str = request.getParameter("str");
                        if ("titulo".equals(escolha)) {
                            listaProdutos = produtoDAO.buscarTituloProduto(str);
                        } else if ("genero".equals(escolha)) {
                            listaProdutos = produtoDAO.buscarGeneroProduto(str);
                        } else if ("autor".equals(escolha)) {
                            listaProdutos = produtoDAO.buscarAutorProduto(str);
                        }
                        request.setAttribute("escolha", escolha);
                        request.setAttribute("str", str);
                        request.setAttribute("listaProdutos", listaProdutos);
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/pesquisarProduto.jsp");
                        rd.forward(request, response);
                        return;
                    }
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/pesquisarProduto.jsp");
                    rd.forward(request, response);
                    return;
                } else {
                    ProdutoDAO produtoDAO = new ProdutoDAO();

                    List<Produto> listaProdutosMaisVendidos = produtoDAO.listarProdutosMaisVendidos();
                    request.setAttribute("listaProdutos", listaProdutosMaisVendidos);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/cliente/index.jsp");
                    rd.forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("mensagem", "Para continuar é necessário fazer login");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/comum/login.jsp");
                rd.forward(request, response);
            }
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Clientes.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
