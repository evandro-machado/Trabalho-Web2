<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Cadastro de Cliente</title>
            
        <!--JQuery CSS-->
        <link rel="stylesheet" href="../js/jquery-ui.css">
        
        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet" />

        <!-- Custom CSS -->
        <link href="../css/shop-homepage.css" rel="stylesheet" />
        
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
            $(function() {
              $( "#datepicker" ).datepicker({ 
                minDate: "-100Y",
                maxDate: "-13Y",
                changeMonth: true,
                changeYear: true
                });
            });
        </script>
    </head>
    <body>
            <!--Inclui cabeçalho-->
            <jsp:include page="navAnonimo.jsp"/>
        
        <div class="container">
            <div class=" col-sm-offset-3 col-sm-6">
        <h1>Dados Cadastrais</h1>
        <form class="form-horizontal">
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Nome Completo</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Sexo</label>
                <div class="col-sm-8">
                    <select class="form-control">
                        <option>Selecione</option>
                        <option>Masculino</option>
                        <option>Feminino</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">CPF</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Data de Nascimento</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="datepicker" placeholder="">
                </div>
            </div>      
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Telefone</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder=""/>
                </div>
            </div>   
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Senha</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="" placeholder=""/>
                </div>
            </div> 
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Confirme sua Senha</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="" placeholder="">
                </div>
            </div>       
            
            <h2>Endereço de Entrega</h2>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">CEP</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Endereço</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>            
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Número</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Complemento</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>            
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Bairro</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>  
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Cidade</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="" class="col-sm-4 control-label">Estado</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="" placeholder="">
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
        
        <!--Inclui Rodapé-->
        <jsp:include page="rodape.jsp"/>    


        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
    </body>
</html>