public with sharing class ComprobarDni {

    //Autor: Rubén Izquierdo Molina:
    //Clase para ser invocada por el trigger "TriggerComprobarDni".

    public static void metodoComprobarDni(List<Account> listAcc) {

        Set<String> dniSet = new Set<String>();

        for (Account acc : listAcc) {
            dniSet.add(acc.numDNI__c);
        }
        List<Account> accountList = new List<Account>();
        accountList = [SELECT numDNI__c FROM Account WHERE numDNI__c IN : dniSet];
    
        for (Account acc : listAcc) {
    
            if(Trigger.IsUpdate){
                if(accountList.size() == 0){
                    acc.numDNI__c.addError('Dni no coincide');
                }
            }
            if(Trigger.IsInsert){
                if(accountList.size() > 0){
                    acc.numDNI__c.addError('Dni existente');
                }
            }
            
        }

    }
}
