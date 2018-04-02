/*
 * Controller for Invention Researcher Lightning Component
 * Test Class: InventionResearcherController_Test
 */
public class InventionResearcherController {

    //Returns list of Invention contacts related to an Invention
    @AuraEnabled
    public static List<Invention_Contact__c> getInventionContacts(Id invId) {
        return [
            SELECT Id, Name, Lead_Inventor__c, Lead_Inventor_Text__c,
            Researcher__c, Researcher_Name__c, Researcher_Link__c,
            Contact_Account__c, Contact_Account_Name__c, Contact_Account_Link__c, 
            Division__c, Division_Name__c, Division_Link__c,
            Invention__c, Invention_Name__c, Invention_Link__c
            FROM Invention_Contact__c
            WHERE Invention__c = :invId
            ORDER BY Lead_Inventor__c DESC];
    }
    
    //Deletes a single Invention contact
    @AuraEnabled
    public static Invention_Contact__c deleteInventionContact(Invention_Contact__c i2c) {
        delete i2c;
        return i2c;
    }
}