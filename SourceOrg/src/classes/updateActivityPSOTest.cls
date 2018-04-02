@isTest
public class updateActivityPSOTest {
public static testMethod void updateActivityPSOTriggerTest() {

Datetime sdt = Datetime.now();
Datetime edt = Datetime.now() + (0.024305);

Account mo = new Account (Name='Test MO 6/16/2014');
     
insert mo;

Source_Organization__c pso = new Source_Organization__c ( Name='Test PSO 6/16/2014', Master_Organization__c = mo.Id, Primary_Source_Org__c = True );
     
insert pso;

string psoId = pso.Id;

Update mo;

Task t = new Task (WhatId = mo.Id, Subject = 'Call', Status = 'Not Started', Priority = 'High', Type = 'Engagement - Call');

insert t;

Event ev = new Event (WhatId = mo.Id, Subject = 'Meeting', Type = 'Engagement - Key Executive Visit', StartDateTime= sdt, EndDateTime= edt);

insert ev;

Test.StartTest();

update mo;
update t;
update ev;

t = [SELECT Id, Master_Org_s_Primary_Source_Org_Id__c FROM Task WHERE Id = :t.Id];

ev = [SELECT Id, Master_Org_s_Primary_Source_Org_Id__c FROM Event WHERE Id=:ev.Id];

system.AssertEquals(psoId,t.Master_Org_s_Primary_Source_Org_Id__c);

system.AssertEquals(psoId,ev.Master_Org_s_Primary_Source_Org_Id__c);

Test.stopTest();
}
}