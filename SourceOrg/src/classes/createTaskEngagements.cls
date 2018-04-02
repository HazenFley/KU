Global class createTaskEngagements implements Database.Batchable <sObject>
{

 Global static id batchManualKickOff()
    {
        Id batchInstanceId = Database.executeBatch(new createTaskEngagements()); 
        return batchInstanceId;
    }

 Global Database.querylocator start (Database.BatchableContext BC)
 {
 String query = 'Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, ActivityDate, Subject, Priority, Status, LastModifiedDate, CreatedById, Activity_Converted_to_Engagement__c From Task';
 return Database.getQueryLocator(query);
 }

 Global void execute (Database.BatchableContext BC, List<sObject> scope)
 {
 List <sObject> tList = new List <sObject>();
 List < Interaction__c> engList = new List < Interaction__c>();
 List<Interaction__c> engToUpdate = new List<Interaction__c>();
 
  for (sObject s: scope)
  {
  if (string.valueOf(s.get('WhatId'))!=null && string.valueOf(s.get('Master_Org_s_Primary_Source_Org_Id__c'))!=null && (string.valueOf(s.get('Type'))!=null && string.valueOf(s.get('Type'))!='Other Task'))
  {
  system.debug(' /forsObjectScope ');
  string myDateT = string.valueOf(date.today());
  string myDateY = string.valueOf(date.today()-1);
  string myDateTo = string.valueOf(date.today()+1);
  string createdDate = string.valueOf( s.get('CreatedDate') ).substring(0, 10);
  string LastModifiedDate = string.valueOf( s.get('LastModifiedDate') ).substring(0, 10);
  string whatIdKey = '001';
  string createdByProfileId = '00ei0000000GtR2';
  string strWhatId = String.valueOf(s.get('WhatId')).substring(0 , 3);
  string strCreatedByProfileId = String.valueOf(s.get('User_Profile_Id__c'));
  
  system.debug(' /before the first if 1 ' + string.valueOf(date.today()));
  system.debug(' /before the first if 2 ' + string.valueOf( s.get('CreatedDate') ).substring(0, 10));
  system.debug(' /before the first if 3 ' + string.valueOf(s.get('Activity_Converted_to_Engagement__c')));
  system.debug(' /before the first if 4 ' + string.valueOf( s.get('LastModifiedDate') ).substring(0, 10));
  
  if (string.valueOf(s.get('Activity_Converted_to_Engagement__c')) == 'false')
  {
   system.debug(' /Activity_Converted_to_Engagement__c ');
  if (createdDate <= myDateT)
  //if (LastModifiedDate == myDateT || LastModifiedDate == myDateY || LastModifiedDate == myDateTo)
  {
  system.debug(' /createdDate ');
  if (strWhatId == whatIdKey)
  {
  system.debug(' /WhatId '+ strWhatId);
  if (strCreatedByProfileId == createdByProfileId )
  {
  system.debug(' /profileId ');
  s.put('Activity_Converted_to_Engagement__c', true);
  system.debug(' /putTrueToCheckBox ');
  
  Interaction__c eng = new Interaction__c();
  eng.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Calls & Emails').getRecordTypeId();
  system.debug(' /newInteraction1 ');
  
  eng.Description__c = String.valueOf( s.get('Description') );
  system.debug(' /newInteraction2 '+ String.valueOf( s.get('Description') ) );
  
  eng.Assigned_To__c = String.valueOf( s.get('OwnerId') );
  system.debug(' /newInteraction3 '+ String.valueOf( s.get('OwnerId') ));
  
  eng.Activity_Due_Date__c = date.valueOf( s.get('ActivityDate') );
  system.debug(' /newInteraction4 '+ date.valueOf( s.get('ActivityDate') ));
  
  eng.Subject__c = String.valueOf( s.get('Subject') );
  system.debug(' /newInteraction5 '+ String.valueOf( s.get('Subject') ));
  
  eng.Source_Organization__c =String.valueOf( s.get('Master_Org_s_Primary_Source_Org_Id__c') );
  eng.Related_Master_Organization__c = String.valueOf( s.get('whatid') );
  eng.Interaction_Type__c = String.valueOf( s.get('Type') );
  eng.Interaction_Source_KU_Division__c = 'Corporate Partnerships';
  //eng.CreatedById = String.valueOf( s.get('CreatedById') );
  system.debug(' /newInteraction6 ');
  
  eng.Priority__c = String.valueOf( s.get('Priority') );
  eng.Status__c = String.valueOf( s.get('Status') );
  eng.Created_Date__c = date.valueOf( s.get('CreatedDate') );
  eng.Source_System_Last_Modified_Date__c = date.valueOf( s.get('LastModifiedDate') );
  eng.Interaction_Source_System__c = 'SFDC';
  eng.Interaction_Source_System_ID__c = String.valueOf( s.get('Id') );
  engList.add (eng);
  
  tList.add(s);
  }
  }
  }
  }
  else if (string.valueOf(s.get('Activity_Converted_to_Engagement__c')) == 'true')
  {
  system.debug(' /Updateelse ');
  
  if (LastModifiedDate == myDateT || LastModifiedDate == myDateY || LastModifiedDate == myDateTo)
  {
  system.debug(' /UpdatemodifyiedDate ');
  
  if (strWhatId == whatIdKey)
  {
  system.debug(' /UpdateWhatId ');
  
  if (strCreatedByProfileId == createdByProfileId )
  {
  system.debug(' /Updateprofile ');
  
  Map <string, sObject> tMap = new Map <string, sObject>();
  tMap.put(String.valueOf( s.get('Id') ), s);
  
  system.debug(' /testMap '+ tMap.size());
  
  List < Interaction__c> intList = [select Id,RecordTypeId, Description__c, Assigned_To__c, Activity_Due_Date__c, Subject__c, Source_Organization__c, Related_Master_Organization__c, Interaction_Type__c, Interaction_Source_KU_Division__c, Priority__c, Status__c, Created_Date__c, Source_System_Last_Modified_Date__c, Interaction_Source_System__c, Interaction_Source_System_ID__c From Interaction__c Where Interaction_Source_System_ID__c in :tMap.keyset() ];
  system.debug(' /test intlist '+ intList.size());
  
  for (Interaction__c inte: intList){
  if (null!=inte.Interaction_Source_System_ID__c)
    {
    system.debug(' /Updateinte ');
    sObject ss = tMap.get(inte.Interaction_Source_System_ID__c);
    inte.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Calls & Emails').getRecordTypeId();
    inte.Description__c =string.valueof(ss.get('Description'));
    inte.Assigned_To__c = String.valueOf( ss.get('OwnerId') );
    inte.Activity_Due_Date__c = date.valueOf( ss.get('ActivityDate') );
    inte.Subject__c = String.valueOf( ss.get('Subject') );
    //inte.Source_Organization__c =String.valueOf( ss.get('Master_Org_s_Primary_Source_Org_Id__c') );
    inte.Related_Master_Organization__c = String.valueOf( ss.get('whatid') );
    inte.Interaction_Type__c = String.valueOf( ss.get('Type') );
    inte.Interaction_Source_KU_Division__c = 'Corporate Partnerships';
    //inte.CreatedBy.Id = String.valueOf( ss.get('CreatedbyId') );
    inte.Priority__c = String.valueOf( ss.get('Priority') );
    inte.Status__c = String.valueOf( ss.get('Status') );
    inte.Created_Date__c = date.valueOf( ss.get('CreatedDate') );
    inte.Source_System_Last_Modified_Date__c = date.valueOf( ss.get('LastModifiedDate') );
    inte.Interaction_Source_System__c = 'SFDC';
    engToUpdate.add(inte);
    }
  }
  }
  }
  }
  }
  }
  system.debug(' /test englist '+ engList.size());
  system.debug(' /test tlist '+ tList.size());
  system.debug(' /test engtoupdatelist '+ engToUpdate.size());
  }
 insert engList;
  
 update tList;
  
 update engToUpdate;
 }
 
 global void finish (Database.BatchableContext BC)
 {
 }
}