<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Relatório de Compras por período</title>

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
                end.setFullYear(end.getFullYear() - 0);
                $('#de').datepicker({
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
                    onClose: function (selectedDate) {
                        $("#ate").datepicker("option", "minDate", selectedDate);
                    }
                });

                $('#ate').datepicker({
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
                    onClose: function (selectedDate) {
                        $("#de").datepicker("option", "maxDate", selectedDate);
                    }
                });
            });
        </script>

    </head>
    <body>
        <!--Inclui cabeçalho-->
        <jsp:include page="navGerente.jsp"/>
        <c:if test="${empty sessionScope.logado}">
            <jsp:forward page="/comum/login.jsp" />
        </c:if>
        <c:if test="${sessionScope.cliente.getPerfil()  != 3}">
            <jsp:forward page="semPermissao.jsp" />
        </c:if>   

        <div class="container">
            <div class="row">
                <jsp:include page="menuGerente.jsp"/>
                <div class="col-md-9 ">   
                    <h1>Relatório de compras por período</h1>
                    <div class="row">
                        <form class="form-horizontal" action="Gerentes?action=compraPeriodo" method="post">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <h3>Período:</h3>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-6">

                                    <label for="de" class="col-md-1 control-label">de</label>
                                    <div class="col-md-4">
                                        <input class="form-control" type="text"  maxlength="10" id="de" name="de" placeholder="dd/mm/aaaa" OnKeyPress="formatar(this, '##/##/####')" required/>
                                    </div>
                                    <label for="ate" class="col-md-1 control-label">até</label>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" maxlength="10" id="ate" name="ate" placeholder="dd/mm/aaaa" OnKeyPress="formatar(this, '##/##/####')" required/>
                                    </div>
                                    <div class="col-md-2" >
                                        <button class="btn btn-default form-control" type="submit">
                                            <span class="glyphicon glyphicon-search"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <br/>

                </div>
            </div>
        </div>
        <!--Inclui Rodapé-->
        <jsp:include page="../comum/rodape.jsp"/>

        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="../js/bootstrap.min.js"></script>
    </body>
</html>