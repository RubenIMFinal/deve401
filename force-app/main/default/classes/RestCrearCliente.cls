@RestResource(urlMapping='/sobjects/Account/*')
global with sharing class RestCrearCliente {

  //Autor: Rubén Izquierdo Molina.
  //Clase llamada por servicio web método post.
  //Llama a la clase "CrearCliente" a la que le pasa los parámetros del servicio web.

    @HttpPost
    global static void restMetodoCrearCliente(String name, String lastName, String dni, String email, String phone, String processType){// = '222222222'){

      /*  String name = 'Cliente Rest';
        String lastName = 'LastName Rest';
        String dni = '123456789';
        String email = 'restEmail@gmail.com';
        String phone = '222222222';*/

        CrearCliente.metodoCrearCliente(name, lastName, dni, email, phone, processType);
        System.debug('RIM RestCrearCliente');

    }
}
