<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Visualizar Produto</title>

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

        <jsp:include page="navCliente.jsp"/>
        <!-- Page Content -->
        <div class="container">

            <div class="row">

                <jsp:include page="menuCliente.jsp"/>

                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-offset-2">
                            <img src="${pageContext.request.contextPath}/Imagens/${produto.idImg}.jpg" style="width: 300px;height: 400px" class="media-object" alt="">
                            <h4>
                                ${produto.titulo}
                            </h4>
                            Gênero: ${produto.genero.nome}<br/>
                            Editora: ${produto.editora.nome}<br/>
                            Autor: ${produto.autor}<br/>
                            <h4 class="pull-left"><fmt:formatNumber value="${produto.preco}" minFractionDigits="2" type="currency"/></h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1">

                            <c:choose>
                                <c:when test="${empty genero && empty escolha && empty str}">
                                    <a href="./Clientes">
                                        <button class="btn btn-default">
                                            Voltar
                                        </button>
                                    </a>
                                </c:when>
                                <c:when test="${empty escolha && empty str}">
                                    <a href="./Clientes?action=pesquisar&genero=${genero}">
                                        <button class="btn btn-default">
                                            Voltar
                                        </button>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="./Clientes?action=pesquisar">
                                        <form action="Clientes?action=pesquisar" method="post" style="display: inline">
                                            <button type="submit" class="btn btn-default">
                                                Voltar
                                            </button>
                                            <input type="hidden" value="${escolha}" name="escolha"/>
                                            <input type="hidden" value="${str}" name="str"/>
                                        </form>                
                                    </a>
                                </c:otherwise>

                            </c:choose>
                        </div>
                        <div class="col-md-2 col-md-offset-4">
                            <a href="../Carrinhos?action=addCarrinho&id=${produto.idProduto}">
                                <button class="btn btn-primary">
                                    Adicionar ao Carrinho
                                    <span class="glyphicon glyphicon-shopping-cart"></span>
                                </button>
                            </a>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

</div>
<!-- /.container 

<!--Inclui Rodapé-->
<jsp:include page="../comum/rodape.jsp"/>



<!-- jQuery -->
<script src="../js/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../js/bootstrap.min.js"></script>

</body>

</html>