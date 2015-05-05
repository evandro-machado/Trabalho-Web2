<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>HQ Shop</title>

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
        <jsp:include page="navAnonimo.jsp"/>

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#"><img src="images/logo.png"/></a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="#">Home</a>
                        </li>
                        <li>
                            <a href="#">Serviços</a>
                        </li>
                        <li>
                            <a href="#">Contato</a>
                        </li>
                    </ul>
                    <ul class="nav pull-right navbar-nav">
                        <li class="dropdown" id="menuLogin">
                            <a class="dropdown-toggle" href="#" data-toggle="dropdown" id="navLogin">Login<strong class="caret"></strong></a>

                            <div class="dropdown-menu pull-left" style="padding:17px;">
                                <form class="form" id="formLogin">
                                    <div style="padding: 5px">
                                        <input name="email" id="username" type="text" placeholder="Username">
                                    </div>
                                    <div style="padding: 5px">
                                        <input name="password" id="password" type="password" placeholder="Password"><br>
                                    </div>
                                    <div style="padding: 5px">
                                        <button type="button" id="btnLogin" class="btn" >Login</button>
                                    </div>
                                </form>
                            </div>
                        </li>
                        <li>
                            <a href="#"> Cadastrar </a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

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
                    </tr>
                    <tr>
                        <td><img src="http://placehold.it/50x50" alt="" /> Turma da Monica Ed.50</td>
                        <td>2</td>
                        <td>R$ 109,90</td>
                        <td>R$ 218,80</td>
                    </tr>
                    <tr>
                        <td><img src="http://placehold.it/50x50" alt="" /> Wolverine Aniversário</td>
                        <td>1</td>
                        <td>R$ 85,60</td>
                        <td>R$ 85,60</td>
                    </tr>
                    <tr>
                        <td><img src="http://placehold.it/50x50" alt="" /> Casa e Construção maio/2015</td>
                        <td>1</td>
                        <td>R$ 10,99</td>
                        <td>R$ 10,99</td>
                    </tr>
                    <tr class="warning text-info lead">
                        <td></td>
                        <td></td>
                        <td>Total: </td>
                        <td>R$ 340,00</td>
                    </tr>
                </table>
            </div>
            <div class="row">
            <button class="btn btn-success btn-lg col-sm-3 col-sm-push-9">Finalizar Compra</button>
            </div>

            <div class="row">


                <div class="container">

                    <hr>

                    <!-- Footer -->
                    <footer>
                        <div class="row">
                            <div class="col-lg-12">
                                <p>Site desenvolvido por Bruno R. Sella, Evandro Luís Machado e Yuri Jungles para aprovação nas matérias de Web 2 e DAC.</p>
                            </div>
                        </div>
                    </footer>

                </div>
                <!-- /.container -->

                <!-- jQuery -->
                <script src="../js/jquery.min.js"></script>

                <!-- Bootstrap Core JavaScript -->
                <script src="../js/bootstrap.min.js"></script>

                </body>

                </html>
