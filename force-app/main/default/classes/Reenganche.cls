public with sharing class Reenganche {

    //Autor: Rubén Izquierdo Molina.
    //Clase para ubicar la cuenta correspondiente al DNI pasado por parámetro y comprobar si está relacionada a un caso.
    //Si el caso existe, devuelve los códigos de errores especificados.
    //Si el caso no existe, se actualiza la cuenta y se relaciona a un error registrado.
    //Esta clase es invocada por la clase "RestReenganche".
    

    public static Account comprobarDni(String dni, String valorOrigen){    
        System.debug('RIM dni: ' + dni);
        System.debug('RIM valorOrigen: ' + valorOrigen);


        Account queryDni = [SELECT Id, Name, numDNI__c, Error__c, ErrorMsg__c, CodigoError__c, valorOrigen__c FROM Account WHERE numDNI__c =: dni]; //NO FUNCIONA DE FORMA DINÁMICA¿?
        System.debug('RIM queryDni: ' + queryDni);
        String origenQuery = queryDni.valorOrigen__c;
        System.debug('RIM queryDni origenQuery: ' + origenQuery);
        String idQuery = queryDni.Id;
        System.debug('RIM queryDni idQuery: ' + idQuery);



        try{
            Case queryOnbrdng = [SELECT Id, AccountId, Contrato_Aceptado__c, Tarea_Call_Me_Back__c, Telefono_Creado__c, Errores_Creados__c, Identificacion_Creada__c FROM Case WHERE AccountId =: idQuery];
            System.debug('RIM queryOnbrdng: ' + queryOnbrdng);
            
            if(queryOnbrdng != null){
                System.debug('RIM queryDni tras IF no NULL');

                if (origenQuery.equals(valorOrigen)) { 
                    System.debug('RIM Cuenta con mismo origen');           
                }else{                   
                    Case onbOrigenDiferente = new Case();
                    onbOrigenDiferente.AccountId = queryDni.Id;
                    onbOrigenDiferente.SuppliedName = 'Nueva cuenta origen diferente';

                    System.debug('RIM onbOrigenDiferente: ' + onbOrigenDiferente);
                    insert onbOrigenDiferente;
                }

              //  if(queryOnbrdng.Contrato_Aceptado__c==true && queryOnbrdng.Tarea_Call_Me_Back__c==true && queryOnbrdng.Telefono_Creado__c==true && queryOnbrdng.Errores_Creados__c==true && queryOnbrdng.Identificacion_Creada__c==true){
                    queryDni.Error__c = false;
                    queryDni.ErrorMsg__c = '';
                    queryDni.CodigoError__c = null;
                    update queryDni;
                    return queryDni;    
               /* }else{
                    System.debug('RIM Aquí 1');
                }*/     

 
            }

        }catch(System.QueryException e){
            System.debug('RIM else');

            //Account cuentaNoOnboarding = new Account();
            queryDni.Error__c = true;
            queryDni.ErrorMsg__c = 'Texto prueba "error".';
            queryDni.CodigoError__c = 404;
            update queryDni;
            Error_Log__c error = new Error_Log__c();
            error.Name = 'Error de ' + queryDni.Name;
            error.Causante__c = queryDni.Name;
            error.ErrorAccount__c = queryDni.Id;
            error.Error2__c = queryDni.Error__c;
            error.ErrorMsg2__c	= queryDni.ErrorMsg__c;
            error.CodigoError2__c = queryDni.CodigoError__c;
            insert error;
            return queryDni;
            
        }



        return queryDni;





        
        /*Try{
            queryDni = [SELECT Id, Name, numDNI__c, ErrorAccount__r.ErrorMsg__c , ErrorAccount__r.CodigoError__c FROM Account WHERE numDNI__c =: dni AND Process_Type_Pick__c = 'Onboarding'];
            System.debug('RIM queryDni: ' + queryDni);
            return queryDni;
        }catch(QueryException e){
            System.debug('RIM Reenganche, entra en el catch?');
            System.debug('DmlException errormesagge: ' + e.getMessage());
            Account cuentaNoOnboarding = new Account();
            Error_Log__c error = new Error_Log__c();
            error.ErrorMsg__c = 'Ha habido un error';
            error.CodigoError__c = '404';
            cuentaNoOnboarding.ErrorAccount__c = cuentaNoOnboarding.Id;
            return cuentaNoOnboarding;
        }*/


       /* queryDni = [SELECT Id, Name, numDNI__c, ErrorAccount__r.ErrorMsg__c , ErrorAccount__r.CodigoError__c FROM Account WHERE numDNI__c =: dni AND Process_Type_Pick__c = 'Onboarding'];
        System.debug('RIM queryDni: ' + queryDni);

        if(queryDni != null){
            System.debug('RIM Reenganche, entra en el if?');

            return queryDni;
        }else{
            System.debug('RIM Reenganche, entra en el else?');

            Account cuentaNoOnboarding = new Account();
            Error_Log__c error = new Error_Log__c();
            error.ErrorMsg__c = 'Ha habido un error';
            error.CodigoError__c = '404';
            cuentaNoOnboarding.ErrorAccount__c = cuentaNoOnboarding.Id;

            return cuentaNoOnboarding;
        }*/
    }
}
