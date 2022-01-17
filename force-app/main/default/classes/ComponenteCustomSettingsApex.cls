public with sharing class ComponenteCustomSettingsApex {
        
        @AuraEnabled
        public static List<AdminStep2__c>  metodoAdminStep()
        {        
          
           List<AdminStep2__c> adminStepList = AdminStep2__c.getAll().values(); 
           System.debug('RIM adminStepList: ' + adminStepList);
           return adminStepList;
        }
}
