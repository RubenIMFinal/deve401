@RestResource(urlMapping='/sobjects/Account/ONB_ID_Session__c/*')
global with sharing class RestKYC {

    //Autor:Rubén Izquierdo Molina.
    //Clase que invoca el servicio web de método patch.
    //


    @HttpPatch
    global static void metodoRestKYC(String dni, String sexo, String nacionalidad, String pais, Date fecha, String processType, String landingVersion, String legalDocVersion, String pasos, String civilStatus , String OptInCode) {

        CrearKYC.crearKYC(dni, sexo, nacionalidad, pais, fecha, processType, landingVersion, legalDocVersion, pasos, civilStatus, OptInCode);
        System.debug('RIM rest crearkyc');

    }
}
