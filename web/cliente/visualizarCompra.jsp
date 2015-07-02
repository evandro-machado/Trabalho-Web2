<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Visualizar Compra</title>

        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link href="../css/shop-homepage.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="navCliente.jsp"/>
        <div class="container">
            <div class="row">
                <jsp:include page="menuCliente.jsp"/>
                <div class="col-md-9 ">   
                    <h1>Compras</h1>
                    <div id="accordion" class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="font-size: 20px">
                                <strong>Compras em Aberto</strong>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>Número da Compra #</th>
                                        <th>Data</th>
                                        <th>Valor Total</th>
                                        <th>Situação</th>
                                        <th>Ação</th>
                                    </tr>
                                    <c:forEach var="pedido" items="${listaPedidosAbertos}">
                                        <tr>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    ${pedido.idPedido}
                                                </a>
                                            </td>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    <fmt:formatDate value="${pedido.data}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </a>
                                            </td>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    <fmt:formatNumber value="${pedido.valorTotal}" minFractionDigits="2" type="currency"/>  
                                                </a>
                                            </td>
                                            <td data-toggle="collapse" href="#collapse${pedido.idPedido}" >
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    ${pedido.statusPedido.descricao}
                                                </a>
                                            </td>
                                            <td>
                                                 <a href="Clientes?action=confirmarRecebimento&id=${pedido.idPedido}"><span class="glyphicon glyphicon-ok-circle" style="color: green;" title="Confirmar Recebimento"></span></a>&nbsp;&nbsp;
                                                <a href="Clientes?action=cancelar&id=${pedido.idPedido}"><span class="glyphicon glyphicon-remove-circle" title="Cancelar Pedido" style="color: red;"></span></a>
                                                <!--Inicio do modal-->
                                                <div class="modal fade" id="exampleModal${pedido.idPedido}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h4 class="modal-title" id="exampleModalLabel">Detalhes da Compra #${pedido.idPedido} </h4>
                                                                <div class="modal-body">
                                                                    <table class="table table-striped table-bordered">
                                                                        <tr>
                                                                            <th>ID #</th>
                                                                            <th>Título</th>
                                                                            <th>Quantidade</th>
                                                                            <th>Valor Unitárioa</th>
                                                                        </tr>
                                                                        <c:forEach var="itemPedido" items="${pedido.itens}">
                                                                            <tr>
                                                                                <td>${itemPedido.produto.idProduto}</td>
                                                                                <td>${itemPedido.produto.titulo}</td>
                                                                                <td>${itemPedido.quantidade}</td>
                                                                                <td><fmt:formatNumber value="${itemPedido.valorUnitario}" minFractionDigits="2" type="currency"/> </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </table>
                                                                    <div class="col-md-offset-8">
                                                                        <h3>Total: <fmt:formatNumber value="${pedido.valorTotal}" minFractionDigits="2" type="currency"/> </h3>
                                                                    </div>
                                                                    <br/>
                                                                    <div class="col-md-2">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                                                                    </div>
                                                                    <div class="col-md-2 col-md-offset-3">
                                                                        <a href="Clientes?action=cancelar&id=${pedido.idPedido}">
                                                                        <button type="button" class="btn btn-danger">Cancelar Pedido</button>
                                                                        </a>
                                                                    </div>
                                                                    <div class="col-md-2 col-md-offset-1">
                                                                        <a href="Clientes?action=confirmarRecebimento&id=${pedido.idPedido}">
                                                                        <button type="button" class="btn btn-success">Confirmar Recebimento</button>
                                                                        </a>
                                                                    </div>
                                                                    <br/>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Fim do modal-->
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="accordion" class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="font-size: 20px">
                                <strong>Compras Finalizadas</strong>
                            </div>
                            <div class="panel-body">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>Número da Compra #</th>
                                        <th>Data</th>
                                        <th>Valor Total</th>
                                        <th>Situação</th>
                                    </tr>
                                    <c:forEach var="pedido" items="${listaPedidosFinalizados}">
                                        <tr>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    ${pedido.idPedido}
                                                </a>
                                            </td>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    <fmt:formatDate value="${pedido.data}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </a>
                                            </td>
                                            <td>
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    <fmt:formatNumber value="${pedido.valorTotal}" minFractionDigits="2" type="currency"/>  
                                                </a>
                                            </td>
                                            <td data-toggle="collapse" href="#collapse${pedido.idPedido}" >
                                                <a href="" data-toggle="modal" data-target="#exampleModal${pedido.idPedido}">
                                                    ${pedido.statusPedido.descricao}
                                                </a>
                                                <!--Inicio do modal-->
                                                <div class="modal fade" id="exampleModal${pedido.idPedido}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h4 class="modal-title" id="exampleModalLabel">Detalhes da Compra #${pedido.idPedido} </h4>
                                                                <div class="modal-body">
                                                                    <table class="table table-striped table-bordered">
                                                                        <tr>
                                                                            <th>ID #</th>
                                                                            <th>Título</th>
                                                                            <th>Quantidade</th>
                                                                            <th>Valor Unitário</th>
                                                                        </tr>
                                                                        <c:forEach var="itemPedido" items="${pedido.itens}">
                                                                            <tr>
                                                                                <td>${itemPedido.produto.idProduto}</td>
                                                                                <td>${itemPedido.produto.titulo}</td>
                                                                                <td>${itemPedido.quantidade}</td>
                                                                                <td><fmt:formatNumber value="${itemPedido.valorUnitario}" minFractionDigits="2" type="currency"/> </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </table>
                                                                    <div class="col-md-offset-8">
                                                                        <h3>Total: <fmt:formatNumber value="${pedido.valorTotal}" minFractionDigits="2" type="currency"/> </h3>
                                                                    </div>
                                                                    <br/>
                                                                    <div class="col-md-2">
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                                                                    </div>
                                                                    <br/>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!--Fim do modal-->
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div>
                </div>
            </div>
        </div>
        <!--Inclui Rodapé-->
        <jsp:include page="../comum/rodape.jsp"/>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../js/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
        <script>
//            $(function () {
//
//                $('#exampleModal').on('show.bs.modal', function (event) {
//                    var button = $(event.relatedTarget); // Button that triggered the modal
//                    var idItemPedido = button.data('idItemPedido'); // Extract info from data-* attributes
//                    var titulo = button.data('titulo');
//                    var modal = $(this);
//                    modal.find('#genero-id').val(idItemPedido);
//                    modal.find('#genero-nome').val(titulo);
//                });
//            });

        </script>
    </body>
</html>