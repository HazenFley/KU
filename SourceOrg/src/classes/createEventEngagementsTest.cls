@isTest
public class createEventEngagementsTest {
public static testMethod void testBatchcreateEventEngagements() {

     Datetime sdt = Datetime.now();
     Datetime edt = Datetime.now() + (0.024305);
     Datetime edt2 = Datetime.now() + (0.48610);

Profile p = [select id from profile where name='KU User']; 
         User u = new User(alias = 'kut', email='kuuser@test.com', 
            emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US', 
            localesidkey='en_US', profileid = p.Id, 
            timezonesidkey='America/Chicago', username='kuuser@test.com');


Account mo = new Account (Name='Test MO 3/7/2014');
     
     insert mo;

Source_Organization__c so = new Source_Organization__c ( Name='Test SO 3/7/2014', Master_Organization__c = mo.Id );
     
     insert so;
     
Source_Organization__c pso = new Source_Organization__c ( Name='Test PSO 3/7/2014', Master_Organization__c = mo.Id, Primary_Source_Org__c = True );
     
     insert pso;
     
     string psoId = pso.Id;
     
     Update mo;
     
System.runAs(u) {   
List <Event> eventList = new List<Event>();
for (integer i = 0; i<100; i++) {
Event ev = new Event (OwnerId = u.Id, WhatId = mo.Id, Subject = 'Meeting', Type = 'Engagement - Key Executive Visit', StartDateTime= sdt, EndDateTime= edt);
eventList.add (ev);
}

insert eventList;
}

Test.StartTest();
createEventEngagements ceeI = new createEventEngagements();
List <Event> testEventListI = new List <Event>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, EndDateTime, Subject, LastModifiedDate, Activity_Converted_to_Engagement__c From Event WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);
ID batchprocessidI = Database.executeBatch(ceeI);

System.runAs(u) {
List <Event> eventToUpdate = new List <Event>();
List <Event> eventListU = new List<Event>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, EndDateTime, Subject, LastModifiedDate, Activity_Converted_to_Engagement__c From Event WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);

if(eventListU.size()>0){
for (Event ee :eventListU){
ee.EndDateTime = edt2;
ee.Subject = 'Other';
eventToUpdate.add(ee);
}
}
Update eventToUpdate;
}

createEventEngagements ceeU = new createEventEngagements();
List <Event> testEventListU = new List <Event>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, EndDateTime, Subject, LastModifiedDate, Activity_Converted_to_Engagement__c From Event WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);
ID batchprocessidU = Database.executeBatch(ceeU);
Test.StopTest();

List<Interaction__c> engCountList = new List <Interaction__c>([Select Id FROM Interaction__c WHERE Source_Organization__c =: pso.Id]);

system.AssertEquals(engCountList.size(),100);

List<Interaction__c> engUpdateList = new List <Interaction__c>([Select Id FROM Interaction__c WHERE Source_Organization__c =: pso.Id AND Subject__c =:'Other' ]);

system.AssertEquals(engUpdateList.size(),100);
}
}