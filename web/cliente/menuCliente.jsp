<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div class="col-md-3">
    <div class="list-group">

        <a href="./Clientes" class="list-group-item">Inicio</a>
        <a href="./Clientes?action=pesquisarProduto" class="list-group-item">Pesquisar Produtos</a>
        <a href="Clientes?action=pedidos" class="list-group-item">Visualizar Compras</a>
        <a href="" data-toggle="modal" data-target="#exampleModal" data-idcliente="${sessionScope.cliente.idCliente}" class="list-group-item">Excluir Conta</a>


    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">Exclusao de Conta</h4>
            </div>
            <div class="modal-body">
                <form action="Clientes?action=excluir" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" id="cliente-id" value="${sessionScope.cliente.idCliente}" name="cliente-id"></textarea>
                    </div>                            
                    <div class="form-group">
                        <label for="genero-nome" class="control-label">Tem certeza de que deseja excluir sua conta?</label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Nao</button>
                        <button type="submit" class="btn btn-primary">Sim</button>
                    </div>


                </form>
            </div>
        </div>
    </div>
</div>