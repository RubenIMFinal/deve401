@RestResource (urlMapping = 'https://login.salesforce.com/services/data/v43.0/sobjects/Account')
global with sharing class RestCreacionCliente {

    @HttpPost
    global static String crearCliente(String LastName,
                                    String Process_Type__c,
                                    String Pasos__c,
                                    String Landing_Version__c,
                                    String Legal_Documents_Version__c,
                                    String ONB_utm_content__c,
                                    String ONB_utm_source__c,
                                    String ONB_utm_medium__c,
                                    String ONB_utm_term__c,
                                    String ONB_utm_campaign__c,
                                    String ONB_Analytics_ID__c,
                                    String ONB_ID_Session__c,
                                    String ONB_Google_Analytics_Link__c){

       Account nuevoCliente = new Account();

       nuevoCliente.LastName = LastName;
       nuevoCliente.ProccesType = processType;
       nuevoCliente.Pasos__c = Pasos__c;
       nuevoCliente.Landing_Version__c = Landing_Version__c;
       nuevoCliente.Legal_Documents_Version__c = Legal_Documents_Version__c;
       nuevoCliente.ONB_utm_content__c = ONB_utm_content__c;
       nuevoCliente.ONB_utm_source__c = ONB_utm_source__c;
       nuevoCliente.ONB_utm_medium__c = ONB_utm_medium__c;
       nuevoCliente.ONB_utm_term__c = ONB_utm_term__c;
       nuevoCliente.ONB_utm_campaign__c = ONB_utm_campaign__c;
       nuevoCliente.ONB_Analytics_ID__c = ONB_Analytics_ID__c;
       nuevoCliente.ONB_ID_Session__c = ONB_ID_Session__c;
       nuevoCliente.ONB_Google_Analytics_Link__c = ONB_Google_Analytics_Link__c;

       insert nuevoCliente;
       String idnuevoCliente = nuevoCliente.Id;
       return idNuevoCliente;
    }

}
