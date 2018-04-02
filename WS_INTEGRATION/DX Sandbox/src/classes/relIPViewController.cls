public class relIPViewController {
    @AuraEnabled
    public static List<IP__c> getIP(Id invId) {
        System.debug('getIP starting...');
        return [
            SELECT id, Name, Name_Link__c, 
            		Invention__c, Invention_Link__c, Invention_Name__c, 
            		Parent_IP__c, Parent_IP_Link__c, Parent_IP_Name__c,
            		Country__c, Record_Type_Name__c, Application_Number__c, IP_Number__c, Application_Date__c, IP_Status__c, Issue_Date__c, 
            		Publication_Number__c, Publication_Date__c, PCT_Number__c, EPO_Number__c            		
            FROM IP__c
            WHERE Invention__c = :invId
            ORDER BY Name ASC];        
    }    
    
    @AuraEnabled
    public static List<Map<String, String>> getRecordTypes() {
        System.debug('getRecordTypes starting...');
        
        List<Map<String, String>> items = new List<Map<String, String>>();
        for (RecordType rt : [SELECT id, name FROM RecordType WHERE SobjectType = 'IP__c']) {
                items.add(new Map<String, String>{'value' => rt.Id, 'label' => rt.Name});
            }
        return items;
    }
}