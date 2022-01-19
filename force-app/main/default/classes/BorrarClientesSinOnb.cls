public with sharing class BorrarClientesSinOnb {

    //Autor: Rubén Izquierdo Molina.
    //Clase invocada desde el scheduled- trigger flow: "Flow Borrar Clientes sin Onb".
    //Comprueba entre todos los casos, cuáles cumplieron todos los pasos añadiendo sus identificaciones a una lista.
    //Tal lista será usada como filtro para borrar los diferentes registros relacionados a ella.
    //
 

    @InvocableMethod(label='Borrar clientes sin Onb' description='Clase para borrar aquellos datos pertenecientes a procesos de onboarding no cerrados.')
    public static void metodoBorrarClientes(){

        List<Case> queryOnb =[SELECT Id, Contrato_Aceptado__c, Tarea_Call_Me_Back__c, Telefono_Creado__c, Errores_Creados__c, Identificacion_Creada__c, KYC_creado__c FROM Case];

        List<Id> casesToDelete = new List<Id>();
        List<Id> idAcc = new List<Id>();

        for (Case c : queryOnb) {
            if(c.Contrato_Aceptado__c==false || c.Tarea_Call_Me_Back__c==false || c.Telefono_Creado__c==false || c.Errores_Creados__c==false || c.Identificacion_Creada__c==false || c.KYC_creado__c == false){
                casesToDelete.add(c.Id);
            }           
        }
        System.debug('RIM casesToDelete: ' + casesToDelete);


        try {
            List<ONB_phone__c> queryPhones = [SELECT Id, PhoneCaseId__c FROM ONB_phone__c WHERE PhoneCaseId__c IN : casesToDelete];
            System.debug('RIM queryPhones: ' + queryPhones);
            delete queryPhones;
        } catch (System.QueryException e) {
            System.debug('RIM catch queryPhones');                                   
        }

        try {
            List<ONB_contract__c> queryContrts = [SELECT Id, CntroCaseId__c FROM ONB_contract__c WHERE CntroCaseId__c IN : casesToDelete];
            System.debug('RIM queryContrts: ' + queryContrts);
            delete queryContrts;
        } catch (System.QueryException e) {
            System.debug('RIM catch queryContrts');                       
        }

        try {
            List<Error_Log__c> queryError = [SELECT Id, ErrorCaseId__c FROM Error_Log__c WHERE ErrorCaseId__c IN : casesToDelete];
            System.debug('RIM queryError: ' + queryError);    
            delete queryError;       
        } catch (System.QueryException e) {
            System.debug('RIM catch queryError');                       
        }

        try {
            List<ONB_identificacion__c> queryIdent = [SELECT Id, IdentCaseId__c FROM ONB_identificacion__c WHERE IdentCaseId__c IN : casesToDelete];
            System.debug('RIM queryIdent: ' + queryIdent);   
            delete queryIdent;        
        } catch (System.QueryException e) {
            System.debug('RIM catch queryIdent');                        
        }


        List<Case> queryOnb2 = [SELECT Id, AccountId FROM Case WHERE Id IN : casesToDelete];
        System.debug('RIM queryOnb2: ' + queryOnb2);   

        for (Case c2 : queryOnb2) {
            idAcc.add(c2.AccountId);
        }
        System.debug('RIM idAcc: ' + idAcc);
        List<Account> accToDelete= [SELECT Id FROM Account WHERE Id IN : idAcc];
        System.debug('RIM accToDelete: ' + accToDelete);

        delete queryOnb2;

        delete accToDelete;










        //Para sacar los casos asignados a una cuenta y por ende, las cuentas que tienen onboarding:    
        /*List<Case> queryCasos = new List<Case>();
        queryCasos = [SELECT Id, AccountId FROM Case WHERE AccountId != null];
        System.debug('RIM queryCasos: ' + queryCasos);
        List<Id> idCuentasOnb = new List<Id>();

        for (Case c : queryCasos) {
            idCuentasOnb.add(c.AccountId);
        }
 

        System.debug('RIM idCuentasOnb: ' + idCuentasOnb);

        List<Task> queryTarea = new List<Task>();
        queryTarea = [SELECT Id, WhatId FROM Task WHERE WhatId NOT IN : idCuentasOnb];
        System.debug('RIM queryTarea: ' + queryTarea);


        List<ONB_contract__c> queryContrato = new List<ONB_contract__c>();
        queryContrato = [SELECT Id, ContractAccountId__c FROM ONB_contract__c WHERE ContractAccountId__c NOT IN : idCuentasOnb];
        System.debug('RIM queryContrato: ' + queryContrato);

        List<Error_Log__c> queryError = new List<Error_Log__c>();
        queryError = [SELECT Id, ErrorAccount__c FROM Error_Log__c WHERE ErrorAccount__c NOT IN : idCuentasOnb];
        System.debug('RIM queryError: ' + queryError);*/
       // delete queryTarea;

    }
}
