public with sharing class CustomSettingHandler {


    @AuraEnabled(cacheable=true) 
    public static AdminStep__c getCustomSettings(){
        return AdminStep__c.getOrgDefaults();
    }


}
