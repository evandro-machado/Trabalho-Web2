<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Compras do Cliente</title>

        <!--JQuery CSS-->
        <link rel="stylesheet" href="../js/jquery-ui.css">

        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../css/shop-homepage.css" rel="stylesheet">

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../js/jquery.min.js"></script>
        <script src="../js/jquery-ui.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script>

            $(function () {

                var start = new Date();
                start.setFullYear(start.getFullYear() - 100);
                var end = new Date();
                end.setFullYear(end.getFullYear() - 13);

                $('#datepicker,#datepicker2').datepicker({
                    dateFormat: 'dd/mm/yy',
                    dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
                    dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D'],
                    dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
                    monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
                    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
                    nextText: 'Próximo',
                    prevText: 'Anterior',
                    changeMonth: true,
                    changeYear: true,
                    minDate: start,
                    maxDate: end,
                    yearRange: -100 + ':' + end.getFullYear(),
                });
            });

        </script>

    </head>
    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="./navGerente.jsp"/>
        <c:if test="${empty sessionScope.logado}">
            <jsp:forward page="/comum/login.jsp" />
        </c:if>
        <c:if test="${sessionScope.cliente.getPerfil()  != 3}">
            <jsp:forward page="semPermissao.jsp" />
        </c:if>
        <fmt:setLocale value="pt-BR" />  
        <div class="container">
            <div class="row">
                <jsp:include page="menuGerente.jsp"/>
                <div class="col-md-9 ">  
                    <h1>Visualizar Compras</h1>
                    <div id="accordion" class="panel-group">
                        
                        <c:forEach var="pedido" items="${listaPedidos}">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse${pedido.idPedido}">
                                            <strong>Compra #: </strong>${pedido.idPedido} &nbsp;&nbsp;&nbsp; 
                                            <strong>Data: </strong><fmt:formatDate value="${pedido.data}" pattern="dd/MM/yyyy HH:mm:ss" />  &nbsp;&nbsp;&nbsp;
                                            <strong>Valor Total:</strong>
                                            <fmt:formatNumber value="${pedido.valorTotal}" minFractionDigits="2" type="currency"/>    &nbsp;&nbsp;&nbsp;
                                            <strong>Situação: </strong>${pedido.statusPedido.descricao}
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapse${pedido.idPedido}" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table table-striped table-bordered">
                                            <tr>
                                                <th>Item #</th>
                                                <th>Título</th>
                                                <th>Quantidade</th>
                                                <th>Valor Unitário</th>
                                            </tr>
                                            <c:forEach var="itemPedido" items="${pedido.itens}">
                                            <tr>
                                                <td>${itemPedido.idItemPedido}</td>
                                                <td>${itemPedido.produto.titulo}</td>
                                                <td>${itemPedido.quantidade}</td>
                                                <td><fmt:formatNumber value="${itemPedido.valorUnitario}" minFractionDigits="2" type="currency"/> </td>
                                             
                                            </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="row">
                    <form class="form" id="form" action="./Gerentes?action=buscarc" method="post">
                    <div class="form-group">
                            <input type="hidden" value="${escolha}" name="escolha"/>
                            <input type="hidden" value="${str}" name="str"/>
                            <div class="col-sm-offset-8 col-sm-4">
                                <button type="submit" class="btn btn-default btn-lg btn-block ">Voltar</button>
                            </div>
                    </div>
                    </form>
                    </div>
                </div>
            </div>
        </div>
        <!--Inclui Rodapé-->
        <jsp:include page="../comum/rodape.jsp"/>

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
    </body>
</html>
