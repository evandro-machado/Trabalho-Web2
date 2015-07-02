<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Alterar Produto</title>

        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script>
            function valida(form) 
	{

		if (form.editora.value=="Selecione") 
		{
			alert("Escolha uma editora.");
			form.nome.focus();
			return false;
		}
                
                if (form.categoria.value=="Selecione") 
		{
			alert("Escolha uma categoria.");
			form.nome.focus();
			return false;
		}
		
    }
        </script>
    </head>
    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="navAdministrador.jsp"/>
        <c:if test="${empty sessionScope.logado}">
            <jsp:forward page="/comum/login.jsp" />
        </c:if>
        <c:if test="${sessionScope.cliente.getPerfil()  != 2}">
            <jsp:forward page="semPermissao.jsp" />
        </c:if>  
        <div class="container">
            <div class="row">
                <jsp:include page="menuAdministrador.jsp"/>
            <div class=" col-sm-6">
                <h1>Alterar Produto</h1>
                <form class="form-horizontal" id="form" method="POST" action="./Produtos?action=alterarp" onsubmit="//return valida(this);"  enctype="multipart/form-data">
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Título</label>
                        <div class="col-sm-8">
                            <input name="titulo" id="titulo" type="text" value = "${produto.titulo}"  class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Autor</label>
                        <div class="col-sm-8">
                            <input name="autor" id="autor" value = "${produto.autor}" type="text" class="form-control"  placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Quantidade em Estoque</label>
                        <div class="col-sm-8">
                            <input name="estoque" id="autor" value = "${produto.estoque}" type="text" class="form-control"  placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Editora</label>
                        <div class="col-sm-8">
                            <select name="editora" id="editora" class="form-control" >
                                <c:forEach items="${listaEditoras}" var="editora">
                                <option value="${editora.idEditora}"${editora.idEditora == produto.editora.idEditora ? 'selected' : ''} > ${editora.nome}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Categoria</label>
                        <div class="col-sm-8">
                            <select name="genero" id="categoria" class="form-control">
                                <c:forEach items="${listaGeneros}" var="genero">
                                <option value="${genero.idGenero}" ${genero.idGenero == produto.genero.idGenero ? 'selected' : ''}> ${genero.nome}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label  class="col-sm-4 control-label">Preço</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                            <span class="input-group-addon">R$</span>
                            <input name="preco" id="preco" value = "<fmt:formatNumber value="${produto.preco}" minFractionDigits="2" type="number"/>" type="text" class="form-control" placeholder="">
                            </div>
                        </div>
                    </div>                     
                    <div class="form-group">
                            <input type="hidden" value="${escolha}" name="escolha"/>
                            <input type="hidden" value="${str}" name="str"/>
                            <input type="hidden" value="${produto.idProduto}" name="idProduto"/>

                            <div class="col-sm-offset-4 col-sm-8">
                            <button type="submit" class="btn btn-success btn-lg btn-block ">Salvar</button>
                    </div>
                    </div>
                </form>
        </div>
        </div>
        
        
        <!--Inclui Rodapé-->
        <jsp:include page="../comum/rodape.jsp"/>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="../js/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
        
    </body>
</html>