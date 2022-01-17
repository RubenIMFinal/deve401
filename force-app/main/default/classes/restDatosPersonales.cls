@RestResource (urlMapping = 'https://login.salesforce.com/services/data/v43.0/sobjects/Account/ONB_SESSION__c/idSesion')
global with sharing class restDatosPersonales {
    

    @HttpPatch
    global static void comprobarOnboarding (String dni){

         Account cuentaComprobar = [SELECT id, Name, numDNI FROM Account WHERE numDNI =: dni];
         if(cuentaComprobar != null){
            //comprobar que está activo ¿?
         }else{
             //iniciar en la sección 1 ¿?
         }



    }


}
