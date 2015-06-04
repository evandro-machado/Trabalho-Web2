package br.com.magazine.servlet;

import br.com.magazine.dao.ProdutoDAO;
import br.com.magazine.entidade.Produto;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Anonymous-pc
 */
@WebServlet(name = "Produtos", urlPatterns = {"/Produtos"})
public class Produtos extends HttpServlet{
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, ParseException, ClassNotFoundException {
    response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if ("cadastrar".equals(request.getParameter("action"))) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet Produtos</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Servlet Produtos at " + request.getContextPath() + "</h1>");
                out.println("</body>");
                out.println("</html>");
                Produto produto = new Produto();

                produto.setTitulo(request.getParameter("titulo"));
                produto.setAutor(request.getParameter("autor"));
                produto.setEditora(request.getParameter("editora"));
                produto.setCategoria(request.getParameter("categoria"));
                produto.setPreco(Double.parseDouble(request.getParameter("preco")));
                //sem imagem
                //produto.setidImg(Integer.parseInt(request.getParameter("idImg")));

                ProdutoDAO dao = new ProdutoDAO();
                dao.cadastrarProduto(produto);
            }
        }
    }
        
        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(Produto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Produto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(Produto.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Produto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
        
      