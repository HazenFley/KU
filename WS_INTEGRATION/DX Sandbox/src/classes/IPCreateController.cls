public class IPCreateController {
	@AuraEnabled
    public static List<IP__c> getIP(Id invId) {
        return [
            SELECT id, name, Invention_Link__c , IP_Status__c, Parent_IP_Link__c, Record_Type_Name__c
            FROM IP__c
            WHERE Invention__c = :invId
            ORDER BY IP_Status__c ASC];        
    }
}