/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.magazine.teste;

import br.com.magazine.entidade.Cliente;
import br.com.magazine.entidade.ListaGeneros;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;


/**
 *
 * @author Evandro
 */
public class TesteWebService {
    public static void main(String[] args){
        Client client = ClientBuilder.newClient(); 
//        System.out.println(genero.getIdGenero() + genero.getNome());
//         for(Genero teste : listaGeneros.getListaGeneros()){
//            System.out.println(teste.getNome());
//        }
        Cliente cliente = new Cliente();
        cliente.setNome("Evandro");
        cliente.setBairro("Boa Vista");
//        Gson gson = new Gson();
//        String json = gson.toJson(cliente);
//        System.out.println(json);
//ListaGeneros listaGeneros = client.target("http://localhost:8080/WSTrabalho/webresources/generic?teste=alousom&teste1=somalo").request(MediaType.APPLICATION_JSON).get(ListaGeneros.class);
//        Client client = ClientBuilder.newClient();
      client.target("http://localhost:8080/WSTrabalho/webresources/generic").request(MediaType.APPLICATION_JSON).post(Entity.json(cliente), Cliente.class);
//                          
    }
}
