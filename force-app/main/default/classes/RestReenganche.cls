@RestResource(urlMapping='/pantalla001/*')
global with sharing class RestReenganche {

    //Autor: Rubén Izquierdo Molina.
    //Clase para ser invocada por un servicio web de tipo get.
    //Toma los parámetros de la URl que pasará a la clase que invoca "Reenganche" para que realice su lógica.
    
  
    @HttpGet
    global static Account restComprobarDni(){

        RestRequest restReq = RestContext.request;
        String dni = restReq.params.get('numDNI');
        System.debug('RIM restReq dni: ' + dni);
        String valorOrigen = restReq.params.get('valorOrigen');
        System.debug('RIM restReq valor origen: ' + valorOrigen);


        //String dni = 'a2';
        //String dni = '9';
       //String dni = '888';

        Account cuentaComprobada = Reenganche.comprobarDni(dni, valorOrigen);
        System.debug('RIM cuentaComprobada: ' + cuentaComprobada);
        return cuentaComprobada;

    }
}
