/**
* Tests Lookup
**/
@isTest
private class Lookup_Test{
    
    // Create common test data
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
    @isTest static void testSearchDB()
    {
        Lookup.searchDB('Account', 'Name', 'Id', 5, 'Name', 'Account');
    }
    
    //test InventionResearcherController.deleteInventionContact
    @isTest static void testSearchDB_Id()
    {
        List<Contact> cs = [SELECT Id FROM Contact LIMIT 1];
        Lookup.searchDB_Id('Invention__c', 'Name', 'Id', 5, 'Id', cs[0].Id, 'Invention__c', 'Invention_Contact__c', 'Researcher__c');
    }
}