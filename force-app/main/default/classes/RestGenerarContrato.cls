@RestResource(urlMapping='/sobjects/Account/ONB_ID_Session__c/idSesion/*')
global with sharing class RestGenerarContrato {

    //Autor: Rubén Izquierdo Molina.
    //Clase para ser llamada por servicio web método patch.
    //Invoca la clase "GenerarContrato" a la que le pasa los parámetros adquiridos por el servicio web.

    @HttpPatch
    global static void restMetodoContrato(Boolean newAccept , String dni){
        GenerarContrato.metodoContrato(newAccept , dni);


    }
    
}
