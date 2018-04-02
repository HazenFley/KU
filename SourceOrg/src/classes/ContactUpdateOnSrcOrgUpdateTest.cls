@isTest
private class ContactUpdateOnSrcOrgUpdateTest {

   private static testMethod void ContactUpdateOnSrcOrgUpdateTriggerTest(){
     
     Account a = new Account (Name='TestAccount789');
     insert a;
     
     Account aa = new Account (Name='TestAccount147');
     insert aa;
     
     Source_Organization__c so = new Source_Organization__c (Name ='TestSourceAccount789', Master_Organization__c = aa.Id);
     insert so;
     
     so = [Select Id, Master_Organization__c From Source_Organization__c WHERE Id = :so.Id];
     
     Contact co = new Contact (RecordTypeId='012i00000015Qwj',
     Contact_Source_Organization__c = so.Id,
     LastName = 'TestContact789',
     FirstName = 'Tester'
     );
     
     insert co;
     
     Interaction__c i = new Interaction__c (RecordTypeId='012i00000015Qwl',
     Source_Organization__c = so.Id,
     Interaction_Type__c = 'Agreement',
     Interaction_Source_System_ID__c = 'ApexIt2013456',
     Agreement_Type__c = 'Other',
     Status__c = 'Expired',
     Interaction_Source_System__c = 'Other',
     Interaction_Source_KU_Division__c = 'Technology Transfer'
     );
     
     insert i;
     
     
  
     Test.startTest();
    
    so.Master_Organization__c = a.Id;
    
    update so;
    
    so = [Select Id, Master_Organization__c From Source_Organization__c WHERE Id = :so.Id];
    
    update co;
    
    co = [Select Id, Contact_Source_Organization__c, AccountId From Contact Where Id=: co.Id];
    
    update i;
    
    i = [Select Id, Source_Organization__c, Related_Master_Organization__c From Interaction__c Where Id=: i.Id];
    
    System.assertEquals(co.AccountId, so.Master_Organization__c);
    System.assertEquals(i.Related_Master_Organization__c, so.Master_Organization__c);
     
     Test.stopTest();

}
}