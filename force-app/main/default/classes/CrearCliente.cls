public with sharing class CrearCliente {

    //Autor: Rubén Izquierdo Molina.
    //Clase para crear un cliente teniendo en cuenta los parámetros pasados.
    //A su vez, crea un caso relacionado
    //Crea también un objeto "teléfono" (ONB_phone__c) para ir registrando los diferentes números.
    //Crea también un objeto "identificación" (ONB_identificacion__c) para ir registrando los diferentes ids. 
    //
  

    public static Account metodoCrearCliente(String firstName, String lastName, String dni, String email, String phone, String processType, String pasos, String landingVersion , String legalDocuments, String utmContent , String utmSource , String utmMedium, String utmTerm, String utmCampaign , String analyticsId , String idSession, URL googleLink ){

        Account cliente = new Account();
        cliente.Name = firstName;
        cliente.LastName__c = lastName;
        cliente.numDNI__c = dni;
        cliente.PersonEmail__c = email;
        cliente.Phone = phone;
        cliente.Process_Type__c = processType;

        cliente.Pasos__c = pasos;
        cliente.Landing_Version__c = landingVersion ;
        cliente.Legal_Documents_Version__c = legalDocuments ;
        cliente.ONB_utm_content__c = utmContent ;
        cliente.ONB_utm_source__c = utmSource ;
        cliente.ONB_utm_medium__c = utmMedium ;
        cliente.ONB_utm_term__c = utmTerm ;
        cliente.ONB_utm_campaign__c = utmCampaign ;
        cliente.ONB_analytics__c = analyticsId ;
        cliente.ONB_ID_Session__c = idSession ;
        //cliente.ONB_Google_Analytics_Link__c = googleLink ;



        System.debug('RIM cliente: ' + cliente);
        insert cliente;


        //crear el onboarding relacionado:
        Case newOnbrd = new Case();
        newOnbrd.AccountId = cliente.Id;
        newOnbrd.Apellido_Cliente__c = lastName;
        newOnbrd.DNICliente__c = dni;
        newOnbrd.EmailCliente__c = email;
        newOnbrd.Account_Phone__c = phone;

        newOnbrd.Cliente_Creado__c = true;
        newOnbrd.Telefono_Creado__c = true;
        newOnbrd.Errores_Creados__c = true;
        newOnbrd.Identificacion_Creada__c = true;

        System.debug('RIM newOnbrd: ' + newOnbrd);
        insert newOnbrd;



        //crear el objeto teléfono relacionado:
        ONB_phone__c newTlfn = new ONB_phone__c();
        newTlfn.Account__c = cliente.Id;
        newTlfn.Name = 'Teléfono de: ' + cliente.Name;
        newTlfn.Numero_Cliente__c = cliente.Phone;
        newTlfn.PhoneCaseId__c = newOnbrd.Id;

        System.debug('RIM newTlfn: ' + newTlfn);
        insert newTlfn;

        //crear el objeto identificaciones relacionado:
        ONB_identificacion__c newIdnt = new ONB_identificacion__c();
        newIdnt.identificacionesAccount__c = cliente.Id;
        newIdnt.Name = 'Identificación de: ' + cliente.Name;
        newIdnt.IdentCaseId__c = newOnbrd.Id;

        System.debug('RIM newIdnt: ' + newIdnt);
        insert newIdnt;

        return cliente;


    }


}
