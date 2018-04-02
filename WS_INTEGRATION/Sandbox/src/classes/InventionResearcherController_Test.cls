/**
 * Tests InventionResearcherController
**/
@isTest
private class InventionResearcherController_Test{
    
    // Create common test invention contacts
    @testSetup static void setup() {
        Account a = new Account(Name='Account');
        insert a;
        Contact c = new Contact(FirstName='First',LastName='Last',AccountId=a.Id);
        insert c;
        Invention__c i = new Invention__c(Name='Invention',Location__c='Lawrence');
        insert i;
        Invention_Contact__c ic = new Invention_Contact__c(Name='InventionContact',Researcher__c=c.Id,Contact_Account__c=a.Id,Invention__c=i.Id);
        insert ic;        
    }
    
    //test get InventionResearcherController.getInventionContacts
    @isTest static void testGetInventionContacts()
    {
        List<Invention__c> invIds = [SELECT Id FROM Invention__c LIMIT 1];
        InventionResearcherController.getInventionContacts(invIds[0].Id);
    }
    
    //test delete InventionResearcherController.deleteInventionContact
    @isTest static void testDeleteInventionContact()
    {
        List<Invention_Contact__c> iCs = [SELECT Id FROM Invention_Contact__c LIMIT 1];
        InventionResearcherController.deleteInventionContact(iCs[0]);
    }
}