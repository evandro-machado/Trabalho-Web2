/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.magazine.servlet;

import br.com.magazine.dao.LogDAO;
import br.com.magazine.dao.PedidoDAO;
import br.com.magazine.dao.ProdutoDAO;
import br.com.magazine.entidade.Carrinho;
import br.com.magazine.entidade.ItemPedido;
import br.com.magazine.entidade.Log;
import br.com.magazine.entidade.Pedido;
import br.com.magazine.entidade.Produto;
import br.com.magazine.entidade.StatusPedido;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
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
@WebServlet(name = "Carrinhos", urlPatterns = {"/Carrinhos"})
public class Carrinhos extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if ("addCarrinho".equals(request.getParameter("action"))) {
                int idProduto = Integer.parseInt(request.getParameter("id"));
                HttpSession session = request.getSession();
                Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
                ProdutoDAO produtoDAO = new ProdutoDAO();
                Produto produto = new Produto();
                produto = produtoDAO.listarProdutoPorId(idProduto);

                ItemPedido itemPedido = new ItemPedido();
                itemPedido.setQuantidade(1);
                itemPedido.setValorUnitario(produto.getPreco());
                itemPedido.setProduto(produto);

                if (carrinho == null) {
                    carrinho = new Carrinho();
                }
                carrinho.adicionarItem(itemPedido);

                Log log = new Log();
                log.setAcao("Item adicionado ao carrinho.");
                log.setPagina("/cliente/carrinhoCompras.jsp");
                Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                log.setData(dataLog);
                log.setIdProduto(idProduto);
                log.setIdCliente(3);
                LogDAO logDAO = new LogDAO();
                logDAO.insereLog(log);

                session.setAttribute("carrinho", carrinho);
                response.sendRedirect("./cliente/carrinhoCompras.jsp");
            }
            if ("comprar".equals(request.getParameter("action"))) {

                HttpSession session = request.getSession();
                Integer logado;
                try {
                    logado = (int) session.getAttribute("logado");
                } catch (Exception f) {
                    logado = 0;
                }
                if (logado > 0) {
                    Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
                    Pedido pedido = new Pedido();
                    Timestamp dataPedido = new Timestamp(System.currentTimeMillis());

                    pedido.setData(dataPedido);
                    pedido.setIdCliente((int)session.getAttribute("idcliente"));
                    pedido.setValorTotal(carrinho.getTotal());
                    pedido.setItens(carrinho.getListaItens());
                    StatusPedido statusPedido = new StatusPedido();
                    statusPedido.setIdStatusPedido(1);
                    pedido.setStatusPedido(statusPedido);

                    PedidoDAO pedidoDAO = new PedidoDAO();
                    pedidoDAO.cadastrarPedido(pedido);

                    Log log = new Log();
                    log.setAcao("Compra realizada.");
                    log.setPagina("/cliente/visualizarCompras.jsp");
                    Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                    log.setData(dataLog);
                    log.setIdCliente((int)session.getAttribute("idcliente"));
                    LogDAO logDAO = new LogDAO();
                    logDAO.insereLog(log);

                    carrinho = new Carrinho();
                    session.setAttribute("carrinho", carrinho);
                    response.sendRedirect("cliente/Clientes?action=pedidos");

                } else {
                    response.sendRedirect("./comum/login.jsp");
//                    request.setAttribute("mensagem", "Para continuar é necessário fazer login");
//                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/comum/login.jsp");
//                    rd.forward(request, response);
                }
            }
            if ("aumentaQuantidade".equals(request.getParameter("action"))) {
                int idProduto = Integer.parseInt(request.getParameter("id"));
                HttpSession session = request.getSession();
                Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
                carrinho.aumentaQuantidade(idProduto);
                session.setAttribute("carrinho", carrinho);
                response.sendRedirect("cliente/carrinhoCompras.jsp");
                Log log = new Log();
                log.setAcao("Quantidade incrementada no carrinho.");
                log.setPagina("/cliente/carrinhoCompras.jsp");
                Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                log.setData(dataLog);
                log.setIdProduto(idProduto);
                log.setIdCliente(3);
                LogDAO logDAO = new LogDAO();
                logDAO.insereLog(log);

            }
            if ("diminuiQuantidade".equals(request.getParameter("action"))) {
                int idProduto = Integer.parseInt(request.getParameter("id"));

                HttpSession session = request.getSession();
                Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
                carrinho.diminuiQuantidade(idProduto);
                session.setAttribute("carrinho", carrinho);
                Log log = new Log();
                log.setAcao("Quantidade decrementada no carrinho.");
                log.setPagina("/cliente/carrinhoCompras.jsp");
                Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                log.setData(dataLog);
                log.setIdProduto(idProduto);
                log.setIdCliente(3);
                LogDAO logDAO = new LogDAO();
                logDAO.insereLog(log);

                response.sendRedirect("cliente/carrinhoCompras.jsp");

            }
            if ("removeProduto".equals(request.getParameter("action"))) {
                int idProduto = Integer.parseInt(request.getParameter("id"));

                HttpSession session = request.getSession();
                Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
                carrinho.removerItem(idProduto);
                session.setAttribute("carrinho", carrinho);
                Log log = new Log();
                log.setAcao("Produto removido do carrinho.");
                log.setPagina("/cliente/carrinhoCompras.jsp");
                Timestamp dataLog = new Timestamp(System.currentTimeMillis());
                log.setData(dataLog);
                log.setIdProduto(idProduto);
                log.setIdCliente(3);
                LogDAO logDAO = new LogDAO();
                logDAO.insereLog(log);

                response.sendRedirect("cliente/carrinhoCompras.jsp");

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

        } catch (SQLException ex) {
            Logger.getLogger(Carrinhos.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Carrinhos.class
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

        } catch (SQLException ex) {
            Logger.getLogger(Carrinhos.class
                    .getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Carrinhos.class
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
