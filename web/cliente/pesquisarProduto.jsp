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
<h1>Pesquisar</h1>
                    <div id="accordion" class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading" style="font-size:16px;padding: 2px">
                                <strong>Gêneros</strong>
                            </div>
                                
                            <div class="panel-body" style="padding: 2px;">
                                <c:forEach var="genero" items="${listaGeneros}">
                                    <a href="./Clientes?action=pesquisar&genero=${genero.idGenero}">
                                        
                                <div class="col-md-3">
                                    ${genero.nome}
                                </div>
                                    </a>
                            </c:forEach>
                        </div>
                    </div>
<br/>
                    <div class="row">
                        <div class="col-md-5 col-md-offset-1" style="padding: 0px">
                            <input type="text" name="str" class="form-control" placeholder="Pesquisar por..." />
                        </div>
                        <div class="col-md-3" style="padding: 0px">
                            <select name="escolha" id="escolha" class="form-control " >
                                <option >Tudo</option>
                                <option value="t" required>Título</option>
                                <option value="g" required>Gênero</option>
                                <option value="a" required>Autor</option>
                            </select>
                        </div>
                        <div class="col-md-1" style="padding: 0px">
                            <button class="btn btn-default form-control" type="text">
                                <span class="glyphicon glyphicon-search"></span>
                            </button>
                        </div>
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
                                            <img src="${pageContext.request.contextPath}/Imagens/${produto.idImg}.jpg" style="width: 120px;height: 120px" class="media-object" alt="">
                                    <div class="caption">
                                        <h4>
                                            <a href="verProduto.jsp">
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