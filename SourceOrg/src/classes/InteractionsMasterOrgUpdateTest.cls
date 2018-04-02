@isTest
private class InteractionsMasterOrgUpdateTest {

   private static testMethod void InteractionsMasterOrgUpdateTriggerTest(){
     
     Account a = new Account (Name='TestAccount123');
     insert a;
     
     Source_Organization__c so = new Source_Organization__c (Name ='TestSourceAccount123', Master_Organization__c = a.Id);
     insert so;
     
     so = [Select Id, Master_Organization__c From Source_Organization__c WHERE Id = :so.Id];
     
     Interaction__c i = new Interaction__c (RecordTypeId='012i00000015Qwl',
     Source_Organization__c = so.Id,
     Interaction_Type__c = 'Agreement',
     Interaction_Source_System_ID__c = 'ApexIt2013123',
     Agreement_Type__c = 'Other',
     Status__c = 'Expired',
     Interaction_Source_System__c = 'Other',
     Interaction_Source_KU_Division__c = 'Technology Transfer'
     );
     
     insert i;
     
     i = [Select Id, Source_Organization__c, Related_Master_Organization__c From Interaction__c Where Id=: i.Id];
     
     
     
     
     Test.startTest();
    
    System.assertEquals(i.Related_Master_Organization__c, so.Master_Organization__c);
     
     Test.stopTest();

}
}