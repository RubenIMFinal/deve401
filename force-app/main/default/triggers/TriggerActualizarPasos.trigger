trigger TriggerActualizarPasos on Account (before update) {


    System.debug('RIM trigger Trigger.new: ' + Trigger.new);

  //  List<Case> queryOnbrdng = [SELECT Id, Status, AccountId FROM Case WHERE AccountId IN : Trigger.new];
   // System.debug('RIM trigger query queryOnbrdng: ' + queryOnbrdng);

 //  if(queryOnbrdng.Contrato_Aceptado__c==true && queryOnbrdng.Tarea_Call_Me_Back__c==true && queryOnbrdng.Telefono_Creado__c==true && queryOnbrdng.Errores_Creados__c==true && queryOnbrdng.Identificacion_Creada__c==true){

    /* for (Account acc2 : Trigger.new) {

            String pasos = acc2.Pasos__c;
            System.debug('RIM acc2.Pasos__c: ' + acc2.Pasos__c);

            if(pasos.equals('1')){
                acc2.Pasos__c = '2';
            // queryOnbrdng.Status = 'Bienvenido';
            }
            if(pasos.equals('2')){
                acc2.Pasos__c = '3';
            // queryOnbrdng.Status = 'Bienvenido';
            }
            if(pasos.equals('3')){
                acc2.Pasos__c = '4';
            // queryOnbrdng.Status = 'Bienvenido';
            }
            
        }*/

  // }


}