<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Carrinho de Compras</title>

        <!-- Bootstrap Core CSS -->
        <link href="../css/bootstrap.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="../css/shop-homepage.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="navCliente.jsp"/>

        <!-- Navigation -->
        <!-- Page Content -->
        <div class="container">

            <div class="row">

                <h1>Carrinho</h1>
                <table class="table table-striped">
                    <tr>
                        <th>Item</th>
                        <th>Quantidade</th>
                        <th>Valor Unitário</th>
                        <th>Valor Total</th>
                        <th></th>
                    </tr>
                    <c:forEach var="itemCarrinho" items="${sessionScope.carrinho.listaItens}">
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/Imagens/${itemCarrinho.produto.idImg}.jpg" style="width: 50px;height: 50px" alt="">${itemCarrinho.produto.titulo}</td>
                            <td>
                                
                                <div class="qnt-count">
                                    <form class="form-horizontal" id="form" method="POST" action="Clientes?action=cadastrar" onsubmit="//return valida(this);">
                                        
                                        <a class="btn btn-default" href="../Carrinhos?action=diminuiQuantidade&id=${itemCarrinho.produto.idProduto}">
                                            <span class="glyphicon glyphicon-minus"></span></a> 
                                        <input type="text" class="form-control"  value="${itemCarrinho.quantidade}" style="width: 50px; display: inline;" disabled="disabled"/> 
                                        <a class="btn btn-default" href="../Carrinhos?action=aumentaQuantidade&id=${itemCarrinho.produto.idProduto}">
                                            <span class="glyphicon glyphicon-plus"></span></a>
                                    </form>
                                </div>
                            </td>
                            <td><fmt:formatNumber value="${itemCarrinho.produto.preco}" minFractionDigits="2" type="currency"/></td>
                            <td><fmt:formatNumber value="${itemCarrinho.produto.preco * itemCarrinho.quantidade}" minFractionDigits="2" type="currency"/></td>
                            <td><span class="glyphicon glyphicon-remove-circle"></span> 
                                <a  href="../Carrinhos?action=removeProduto&id=${itemCarrinho.produto.idProduto}">
                                remover</td>
                        </tr>
                    </c:forEach>
                    <tr class="warning text-info lead">
                        <td></td>
                        <td></td>
                        <td>Total: </td>
                        <td><fmt:formatNumber value="${sessionScope.carrinho.total}" minFractionDigits="2" type="currency"/></td>
                        <td></td>
                    </tr>
                </table>
            </div>
            <div class="row">
                <a href="../Carrinhos?action=comprar">
                    <button class="btn btn-success btn-lg col-sm-3 col-sm-push-9">Finalizar Compra</button>
                </a>
            </div>

        </div>
        <!-- /.container -->
        <jsp:include page="../comum/rodape.jsp"/>  

        <!-- jQuery -->
        <script src="../js/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="../js/bootstrap.min.js"></script>
 
    </body>

</html>
