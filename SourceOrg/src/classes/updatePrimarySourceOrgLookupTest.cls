@isTest
public class updatePrimarySourceOrgLookupTest {
public static testMethod void updatePrimarySourceOrgLookupTriggerTest() {

Account mo = new Account (Name='Test MO 6/16/2014');
     
insert mo;

Source_Organization__c pso = new Source_Organization__c ( Name='Test PSO 6/16/2014', Master_Organization__c = mo.Id, Primary_Source_Org__c = True );
     
insert pso;

Test.StartTest();

update mo;

mo = [SELECT Id, Primary_Source_Org_Id__c FROM Account WHERE Id = :mo.Id];

system.AssertEquals(mo.Primary_Source_Org_Id__c, pso.Id);


pso.Primary_Source_Org__c = False;

update pso;
update mo;
mo = [SELECT Id, Primary_Source_Org_Id__c FROM Account WHERE Id = :mo.Id];

//system.AssertEquals(mo.Primary_Source_Org_Id__c, '');

pso.Primary_Source_Org__c = True;

update pso;
update mo;
mo = [SELECT Id, Primary_Source_Org_Id__c FROM Account WHERE Id = :mo.Id];

//system.AssertEquals(mo.Primary_Source_Org_Id__c, pso.Id);

delete pso;
update mo;
mo = [SELECT Id, Primary_Source_Org_Id__c FROM Account WHERE Id = :mo.Id];

//system.AssertEquals(mo.Primary_Source_Org_Id__c, '');


Test.stopTest();
}
}