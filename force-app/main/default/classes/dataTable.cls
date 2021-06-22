public with sharing class dataTable 
{
    @AuraEnabled
    public static List<SObject> getEntity(String entityType){
        List<SObject> sobj = new List<SObject>();
        try {  
            if(entityType != null) {
                String query = 'SELECT Name, Id FROM '+entityType ;
                sobj = database.query(query);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return sobj;
    }
}
