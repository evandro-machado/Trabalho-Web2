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

        <title>Magazine Store</title>

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


                    <div class="row carousel-holder">

                        <div class="col-md-5 col-md-offset-3">
                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                <ol class="carousel-indicators">
                                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                </ol>
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <img class="slide-image" src="${pageContext.request.contextPath}/Imagens/5.jpg" alt="" style="width: 400px; height: 500px;">
                                    </div>
                                    <div class="item">
                                        <img class="slide-image" src="${pageContext.request.contextPath}/Imagens/2.jpg" alt="" style="width: 400px; height: 500px;">
                                    </div>
                                    <div class="item">
                                        <img class="slide-image" src="${pageContext.request.contextPath}/Imagens/3.jpg" alt="" style="width: 400px; height: 500px;">
                                    </div>
                                </div>
                                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left"></span>
                                </a>
                                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <form action="./Clientes?action=pesquisar" method="post" class="form-horizontal">
                        <div class="col-md-5 col-md-offset-1" style="padding: 0px">
                            <input type="text" name="str"  class="form-control" placeholder="Pesquisar por..." />
                        </div>
                        <div class="col-md-3" style="padding: 0px">
                                    <select name="escolha" id="escolha" class="form-control " >
                                        <option value="titulo" ${escolha == 'titulo' ? 'selected' : ''} required>Título</option>
                                        <option value="genero" ${escolha == 'genero' ? 'selected' : ''} required>Gênero</option>
                                        <option value="autor" ${escolha == 'autor' ? 'selected' : ''} required>Autor</option>
                                    </select>
                        </div>
                        <div class="col-md-1" style="padding: 0px">
                            <button class="btn btn-default form-control" type="submit">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
                            </form>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="panel pull-right" >
                            Ordenar por:
                                <c:if test="${ordem != 'AZ'}">
                                <a href="./Clientes?action=nomeAZ">
                                Nome 
                                    <span class="glyphicon glyphicon-sort-by-alphabet"></span>
                                </c:if>
                                <c:if test="${ordem == 'AZ'}">
                           <a href="./Clientes?action=nomeZA">
                                Nome 
                                    <span class="glyphicon glyphicon-sort-by-alphabet-alt"></span>
                                </c:if>
                            </a> 
                                 <c:if test="${ordem != 'Asc'}">
                             <a href="./Clientes?action=Asc"> 
                                 Preço 
                                     <span class="glyphicon glyphicon-sort-by-attributes"></span>
                             </a>
                                 </c:if>
                                 <c:if test="${ordem == 'Asc'}">
                             <a href="./Clientes?action=Desc"> 
                                 Preço 
                                     <span class="glyphicon glyphicon-sort-by-attributes-alt"></span>
                             </a>
                                 </c:if>
                        </div>
                    </div>


                    <div class="row">
                        <c:forEach var="produto" items="${listaProdutos}">
                            <div class="col-sm-4 col-lg-4 col-md-4">
                                <div class="thumbnail">
                                            <img src="${pageContext.request.contextPath}/Imagens/${produto.idImg}.jpg" style="width: 100px;height: 120px" class="media-object" alt="">
                                    <div class="caption">
                                        <h4>
                                            <a href="Clientes?action=visualizarProduto&id=${produto.idProduto}">
                                                ${produto.titulo}
                                            </a>
                                        </h4>
                                        <p>
                                            Gênero: ${produto.genero.nome}<br/>
                                            Editora: ${produto.editora.nome}<br/>
                                            Autor: ${produto.autor}<br/>
                                        <h4 class="pull-left"><fmt:formatNumber value="${produto.preco}" minFractionDigits="2" type="currency"/></h4>
                                        <br/>
                                        <a href="../Carrinhos?action=addCarrinho&id=${produto.idProduto}" class="pull-right">
                                            Adicionar ao Carrinho
                                            <span class="glyphicon glyphicon-shopping-cart"></span></a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                                        
                        </c:forEach>
                    </div>

                </div>

            </div>

        </div>

    </div>
    <!-- /.container -->

    <!--Inclui Rodapé-->
    <jsp:include page="../comum/rodape.jsp"/>



    <!-- jQuery -->
    <script src="../js/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../js/bootstrap.min.js"></script>

</body>

</html>