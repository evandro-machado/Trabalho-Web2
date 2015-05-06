<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Cadastro de Categoria</title>

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
            <div class="col-md-9 ">
                <h1>Cadastro de Categoria</h1>
                <form class="form-horizontal">
                    <fieldset disabled>
                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="disabledTextInput">Código</label>
                            <div class="col-sm-6">
                                <input type="text" id="disabledTextInput" class="form-control" placeholder="1234">
                            </div>
                        </div>
                    </fieldset>
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">Descrição</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="" placeholder="" required />
                        </div>
                    </div>   
                    <div class="form-group">
                        <label for="" class="col-sm-2 control-label">Ativo</label>  
                        <div class="radio col-sm-6 ">
                            <label class="radio-inline">
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                Ativo
                            </label>
                                                        <label class="radio-inline">
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" />
                                Inativo
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-6">
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