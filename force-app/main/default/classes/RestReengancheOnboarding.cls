@RestResource (urlMapping = 'https://login.salesforce.com/services/apexrest/pantalla001?dni=(numDNI)?Origen=(valorOrigen)')
global with sharing class RestReengancheOnboarding {

    @HttpGet
    global static Boolean autenticarDni(String numDNI){   //¿cómo sacar numDNI del url? ¿Cómo inserta el usuario el dni en un get?

        Boolean enProcesoOnboarding = false;
        Boolean movilInformado = false;

        String recId = ApexPages.currentPage().getParameters().get('numDNI'); //¿algo así para sacar el numDNI?

        String selectUsuario = [SELECT Id, name, ProccesType, PersonMobilePhone__c FROM Account WHERE numDNI =: recId];

        if(selectUsuario.ProccesType == 'Onboarding'){
            enProcesoOnboarding= true;
        }
        if(selectUsuario.PersonMobilePhone__c != null){
            movilInformado= true;
        }
        return enProcesoOnboarding;

    }

}
