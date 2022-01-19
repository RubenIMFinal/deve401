public with sharing class CrearKYC {

    //Autor: Rubén Izquierdo Molina.
    //Clase para actualizar una cuenta según parámetros pasados.
    //Actualiza (o crea de no haber) el caso relacionado.
    //

    public static void crearKYC(String dni, String sexo, String nacionalidad, String pais, Date fecha, String processType, String landingVersion, String legalDocVersion, String pasos, String civilStatus , String OptInCode) {

        System.debug('RIM dni: ' + dni);
        System.debug('RIM sexo: ' + sexo);
        System.debug('RIM nacionalidad: ' + nacionalidad);
        System.debug('RIM pais: ' + pais);
        System.debug('RIM fecha: ' + fecha);



        Account queryCliente = [SELECT Id, Name, LastName__c, Sexo__c, Nacionalidad__c, Pais_nacimiento__c, Fecha_de_nacimiento__c FROM Account WHERE numDNI__c =: dni];
        
        queryCliente.Sexo__c = sexo;
        queryCliente.Nacionalidad__c = nacionalidad;
        queryCliente.Pais_nacimiento__c = pais;
        queryCliente.Fecha_de_nacimiento__c = fecha;
        queryCliente.Process_Type__c = processType;
        queryCliente.Landing_Version__c = landingVersion;
        queryCliente.Legal_Documents_Version__c = legalDocVersion;
        queryCliente.Pasos__c = pasos;
        queryCliente.Civil_Status__c = civilStatus;
        queryCliente.OptIn_Code__c = OptInCode;



        System.debug('RIM queryCliente: ' + queryCliente);

        update queryCliente;

        try{  
            Case onboarding = [SELECT Id, DNICliente__c FROM Case WHERE DNICliente__c =: dni];
            onboarding.Status = 'Closed';
            onboarding.SexoCliente__c  = sexo;
            onboarding.NacionalidadCliente__c  =nacionalidad;
            onboarding.PaisNacimientoCliente__c  =pais;
            onboarding.FechaNacimientoCliente__c  =fecha;

            System.debug('RIM onboarding: ' + onboarding);
    
            update onboarding;  
        }catch(System.QueryException e){
    
            Case newOnbrd = new Case();
            newOnbrd.AccountId = queryCliente.Id;
            newOnbrd.Status = 'Closed';
            newOnbrd.SexoCliente__c  = sexo;
            newOnbrd.NacionalidadCliente__c  =nacionalidad;
            newOnbrd.PaisNacimientoCliente__c  =pais;
            newOnbrd.FechaNacimientoCliente__c  =fecha;
            System.debug('RIM catch onbrd: ' + newOnbrd);
    
            insert newOnbrd;
        }

    }
}
