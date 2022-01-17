public with sharing class TareaCallMeBack {

    //Autor: Rubén Izquierdo Molina.
    //Clase para crear una tarea relacionada a la cuenta especificada a través de los parámetros pasados por servicio web.
    //Comprueba de paso si dicha cuenta está relacionada ya a un caso actualizándolo.
    //De no ser así, crea una. Todo esto para que pueda ser mostrada en el componente path.
    //esta clase es invocada por la clase "RestCallMeBack".
  
    public static void crearTarea(String processType, String phone){
        System.debug('RIM callmeback processType: ' + processType);
        System.debug('RIM callmeback phone: ' + phone);

        Account queryAcc = [SELECT Id, Name, Process_Type__c, Phone FROM Account WHERE Phone =: phone AND Process_Type__c =: processType];
        System.debug('RIM queryAcc: ' + queryAcc);
        //queryAcc.Process_Type__c = processType;
        Id accId = queryAcc.Id;
        //update queryAcc;

        Task nuevaTarea = new Task();
        //nuevaTarea.WhoId = '0037Q000001tr8lQAA'; //simplemente para ubicar mejor la tarea en la org.
        nuevaTarea.Subject = 'Call me back ' + queryAcc.Name;
        nuevaTarea.WhatId = accId; //vínculo Account-Tarea.


        insert nuevaTarea;  

        try{

            Case onboarding = [SELECT Id, AccountId, Account_Phone__c FROM Case WHERE AccountId =: accId AND Account_Phone__c =: phone];
            onboarding.Tarea_Call_Me_Back__c = true;
            onboarding.Status = 'New';
            //onboarding.Account_Phone__c = queryAcc.Phone;
            System.debug('RIM onboarding: ' + onboarding);

            update onboarding;  
        }catch(System.QueryException e){

            Case newOnbrd = new Case();
            newOnbrd.AccountId = accId;
            newOnbrd.Status = 'New';
            newOnbrd.Tarea_Call_Me_Back__c = true;
            newOnbrd.Account_Phone__c = queryAcc.Phone;
            System.debug('RIM catch onbrd: ' + newOnbrd);

            insert newOnbrd;


        }

      
    }
}
