@isTest
private class ContactMasterAccountUpdateTest {

   private static testMethod void ContactMasterAccountUpdateTriggerTest(){
     
     Account a = new Account (Name='TestAccount456');
     insert a;
     
     Source_Organization__c so = new Source_Organization__c (Name ='TestSourceAccount456', Master_Organization__c = a.Id);
     insert so;
     
     so = [Select Id, Master_Organization__c From Source_Organization__c WHERE Id = :so.Id];
     
     Contact co = new Contact (RecordTypeId='012i00000015Qwj',
     Contact_Source_Organization__c = so.Id,
     LastName = 'TestContact456',
     FirstName = 'Tester'
     );
     
     insert co;
     
     co = [Select Id, Contact_Source_Organization__c, AccountId From Contact Where Id=: co.Id];
     
     
     
     
     Test.startTest();
    
    System.assertEquals(co.AccountId, so.Master_Organization__c);
     
     Test.stopTest();

}
}