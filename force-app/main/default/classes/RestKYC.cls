@RestResource(urlMapping='/sobjects/Account/ONB_ID_Session__c/*')
global with sharing class RestKYC {


    @HttpPatch
    global static void metodoRestKYC(String dni, String sexo, String nacionalidad, String pais, Date fecha) {

        CrearKYC.crearKYC(dni, sexo, nacionalidad, pais, fecha);
        System.debug('RIM rest crearkyc');

    }
}
