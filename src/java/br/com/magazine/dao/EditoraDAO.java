/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.magazine.dao;
import br.com.magazine.entidade.Editora;
import br.com.magazine.util.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Groupo X
 */
public class EditoraDAO {
    //sem imagem
    private final String stmtCadastraEditora = "insert into editora (editora) values (?)";

    public void cadastrarEditora (Editora editora) throws ClassNotFoundException{ 
        Connection con = null;
        PreparedStatement stmt = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);
            stmt = con.prepareStatement(stmtCadastraEditora, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, editora.getEditora());
            stmt.executeUpdate();
            con.commit();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir uma editora no banco de dados. Origem: " + e.getMessage());
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
}