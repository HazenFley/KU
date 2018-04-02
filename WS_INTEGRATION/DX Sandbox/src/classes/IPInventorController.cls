public class IPInventorController {
	//Returns list of Invention contacts related to an Invention
    @AuraEnabled
    public static List<IP_Contact__c> getIpContacts(Id ipId) {
        return [
            SELECT Id, Name, 
            Contact_Account__c, Contact_Account_Link__c, Contact_Account_Name__c,
            Division__c, Division_Link__c, Division_Name__c,
            Inventor__c, Inventor_Link__c, Inventor_Name__c, 
            Lead_Inventor__c, Lead_Inventor_Text__c,
            IP__c, IP_Link__c, IP_Name__c
            FROM IP_Contact__c
            WHERE IP__c = :ipId
            ORDER BY Lead_Inventor__c DESC];
    }
    
    //Deletes a single Invention contact
    @AuraEnabled
    public static IP_Contact__c deleteIpContact(IP_Contact__c i2c) {
        delete i2c;
        return i2c;
    }
}