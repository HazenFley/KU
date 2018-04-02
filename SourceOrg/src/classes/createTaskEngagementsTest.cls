@isTest
public class createTaskEngagementsTest {
public static testMethod void testBatchcreateTaskEngagements() {

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
List <Task> taskList = new List<Task>();
for (integer i = 0; i<100; i++) {
Task t = new Task (OwnerId = u.Id, WhatId = mo.Id, Subject = 'Call', Status = 'Not Started', Priority = 'High', Type = 'Engagement - Call');
taskList.add (t);
}

insert taskList;
}

Test.StartTest();
createTaskEngagements cteI = new createTaskEngagements();
List <Task> testTaskListI = new List <Task>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, ActivityDate, Subject, Priority, Status, LastModifiedDate, CreatedById, Activity_Converted_to_Engagement__c From Task WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);
//cte.query = 'Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, ActivityDate, Subject, Priority, Status, LastModifiedDate, CreatedById, Activity_Converted_to_Engagement__c ' +
//'From Task ' + 'Where OwnerId=\'' + u.Id + '\' ' + ' Limit 100';
ID batchprocessidI = Database.executeBatch(cteI);

System.runAs(u) {
List <Task> taskToUpdate = new List <Task>();
List <Task> taskListU = new List<Task>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, ActivityDate, Subject, Priority, Status, LastModifiedDate, CreatedById, Activity_Converted_to_Engagement__c From Task WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);

if(taskListU.size()>0){
for (Task tt :taskListU){
tt.Priority = 'Low';
taskToUpdate.add(tt);
}
}
Update taskToUpdate;
}

createTaskEngagements cteU = new createTaskEngagements();
List <Task> testTaskListU = new List <Task>([Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, ActivityDate, Subject, Priority, Status, LastModifiedDate, CreatedById, Activity_Converted_to_Engagement__c From Task WHERE OwnerId=: u.Id AND Master_Org_s_Primary_Source_Org_Id__c =:psoId ORDER BY LastModifiedDate DESC limit 100]);
ID batchprocessidU = Database.executeBatch(cteU);
Test.StopTest();

List<Interaction__c> engCountList = new List <Interaction__c>([Select Id FROM Interaction__c WHERE Source_Organization__c =: pso.Id]);

system.AssertEquals(engCountList.size(),100);

List<Interaction__c> engUpdateList = new List <Interaction__c>([Select Id FROM Interaction__c WHERE Source_Organization__c =: pso.Id AND Priority__c =:'low']);

system.AssertEquals(engUpdateList.size(),100);
}
}