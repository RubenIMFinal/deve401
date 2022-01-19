trigger TriggerComprobarDni on Account (before update){ //, before insert) { 

    //Autor: Rubén Izquierdo Molina.
    //trigger para comprobar dni...
    //invoca la clase "ComprobarDni".
    //
    
    ComprobarDni.metodoComprobarDni(trigger.new);

    System.debug('RIM trigger DNI trigger.new: ' + trigger.new);









    /*Set<String> dniSet = new Set<String>();

    for (Account acc : trigger.new) {
        dniSet.add(acc.numDNI__c);
    }
    List<Account> accountList = new List<Account>();
    accountList = [SELECT numDNI__c FROM Account WHERE numDNI__c IN : dniSet];

    for (Account acc : trigger.new) {

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
        
    }*/

}
