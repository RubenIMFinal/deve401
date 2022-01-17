@RestResource(urlMapping='/Account/*')
global with sharing class restAccount {
   @HttpGET
   global static list<Account> getAccount()
   {
       return [Select Id, Name,numDNI__c, Phone, Process_Type__c, AccountNUmber From Account where Name = 'prueba 4'];
   }

   @HttpPost
   global static Account postAccount( String Nombre, String DNI)
   {
       Account cliente = new Account();
        cliente.Name = Nombre;
        cliente.numDNI__c = DNI;
       insert cliente;
       return cliente;
   }

   @HttpPut
   global static string putAccount(String Nombre, String DNI )
   {
        Account cliente = new Account();
        try{
            cliente = [Select Name, id, numDNI__c FROM Account Where numDNI__c = :DNI];
            cliente.Name = Nombre;
            update cliente;
            return JSON.serializePretty(cliente);
        }catch(Exception e)
        {
            RestContext.response.statusCode = 400;
            SalesforceError[] errs = new SalesforceError[]{ 
                new SalesforceError('BAD_REQUEST', 'Param: DNI NO EXISTE EN LA BASE DE DATOS')
                };
            RestContext.response.responseBody = Blob.valueOf(JSON.serializePretty(errs));
            return JSON.serializePretty(errs);
        }   
   }

   //standard salesforce error response structure
    public class SalesforceError {
        public String errorCode;
        public String message;
        public SalesforceError(String errorCode, string message){
            this.errorCode = errorCode;
            this.message = message;
        }
    }
}
