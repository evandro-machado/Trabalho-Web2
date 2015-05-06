<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Cadastro de Produto</title>

        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="navAdministrador.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                <p class="lead">Magazine Store</p>
                <div class="list-group">
                    <a href="buscarCliente.jsp" class="list-group-item">Buscar Cliente</a>
                    <a href="cadastrarProduto.jsp" class="list-group-item">Cadastrar Produto</a>
                    <a href="cadastrarCategoria.jsp" class="list-group-item">Cadastrar Categoria</a>
                    <a href="cadastrarEditora.jsp" class="list-group-item">Cadastrar Editora</a>
                </div>
            </div>
            <div class=" col-sm-6">
                <h1>Cadastro de Produto</h1>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Título</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Autor</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Editora</label>
                        <div class="col-sm-8">
                            <select class="form-control">
                                <option>Selecione</option>
                                <option>Editora 1</option>
                                <option>Editora 2</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Categoria</label>
                        <div class="col-sm-8">
                            <select class="form-control">
                                <option>Selecione</option>
                                <option>Categoria 1</option>
                                <option>Categoria 2</option>
                            </select>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Preço</label>
                        <div class="col-sm-8">
                            <div class="input-group">
                            <span class="input-group-addon">R$</span>
                            <input type="text" class="form-control" id="" placeholder="">
                            </div>
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label for="" class="col-sm-4 control-label">Imagem</label>
                        <div class="col-sm-8">
                            <input type="file" class="" id="">
                            
                        </div>
                    </div>  
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-8">
                            <button type="submit" class="btn btn-success btn-lg btn-block ">Cadastrar</button>
                        </div>
                    </div>
                </form>
            </div>
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