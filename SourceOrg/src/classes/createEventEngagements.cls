Global class createEventEngagements implements Database.Batchable <sObject>
{

 Global static id batchManualKickOff()
    {
        Id batchInstanceId = Database.executeBatch(new createEventEngagements()); 
        return batchInstanceId;
    }

 Global Database.querylocator start (Database.BatchableContext BC)
 {
 String query = 'Select Id, WhatId, Master_Org_s_Primary_Source_Org_Id__c,User_Profile_Id__c, Type, CreatedDate, Description, OwnerId, EndDateTime, Subject, Location, StartDateTime, LastModifiedDate, Activity_Converted_to_Engagement__c From Event';
 return Database.getQueryLocator(query);
 }

 Global void execute (Database.BatchableContext BC, List<sObject> scope)
 {
 List <sObject> evList = new List <sObject>();
 List < Interaction__c> engList = new List < Interaction__c>();
 List<Interaction__c> engToUpdate = new List<Interaction__c>();
 
  for (sObject s: scope)
 {
   if (string.valueOf(s.get('WhatId'))!=null && string.valueOf(s.get('Master_Org_s_Primary_Source_Org_Id__c'))!=null && string.valueOf(s.get('Type'))!=null)
  {
  system.debug(' /before the first if 1 ' + string.valueOf(s.get('WhatId')).substring(0, 3));
  string myDateT = string.valueOf(date.today());
  string myDateY = string.valueOf(date.today()-1);
  string myDateTo = string.valueOf(date.today()+1);
  string createdDate = string.valueOf( s.get('CreatedDate') ).substring(0, 10);
  string LastModifiedDate = string.valueOf( s.get('LastModifiedDate') ).substring(0, 10);
  string whatIdKey = '001';
  string createdByProfileId = '00ei0000000GtR2';
  string strWhatId = string.valueOf(s.get('WhatId')).substring(0, 3);
  string strCreatedByProfileId = String.valueOf(s.get('User_Profile_Id__c'));
  string eventType = string.valueOf(s.get('Type'));
  string call = 'Engagement - Call';
  string email = 'Engagement - Email';
  string eb = 'Engagement - Executive Briefing';
  string cov = 'Engagement - Company Onsite Visit';
  string kev = 'Engagement - Key Executive Visit';
  string kv = 'Engagement - KU Visit';
  string se = 'Engagement - Seminar By Firm At KU';
  string wo = 'Engagement - Seminar By Firm At KU';
  
  if (String.valueOf(s.get('Activity_Converted_to_Engagement__c')) == 'false')
  {
  if (createdDate <= myDateT)
  //if (LastModifiedDate == myDateT || LastModifiedDate == myDateY || LastModifiedDate == myDateTo)
  {
  if (strWhatId == whatIdKey)
  {
  if (strCreatedByProfileId == createdByProfileId )
  {
  s.put('Activity_Converted_to_Engagement__c', true);
  
  Interaction__c eng = new Interaction__c();
  eng.Description__c = String.valueOf( s.get('Description') );
  eng.Assigned_To__c = String.valueOf( s.get('OwnerId') );
  eng.Location__c = string.valueOf( s.get('Location'));
  eng.Start_Date__c = date.valueOf( s.get('StartDateTime'));
  eng.End_Date__c = date.valueOf( s.get('EndDateTime') );
  eng.Subject__c = String.valueOf( s.get('Subject') );
  eng.Source_Organization__c =String.valueOf( s.get('Master_Org_s_Primary_Source_Org_Id__c') );
  eng.Related_Master_Organization__c = String.valueOf( s.get('whatid') );
  eng.Interaction_Type__c = String.valueOf( s.get('Type') );
  eng.Interaction_Source_KU_Division__c = 'Corporate Partnerships';
  //eng.CreatedBy.Id = String.valueOf( s.get('Createdby.Id') );
  eng.Created_Date__c = date.valueOf( s.get('CreatedDate') );
  eng.Source_System_Last_Modified_Date__c = date.valueOf( s.get('LastModifiedDate') );
  eng.Interaction_Source_System__c = 'SFDC';
  eng.Interaction_Source_System_ID__c = String.valueOf( s.get('Id') );
  
  if (String.valueOf( s.get('Type') )== call ||  String.valueOf( s.get('Type')) == email)
  {
  eng.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Calls & Emails').getRecordTypeId();
  }
  else if (String.valueOf( s.get('Type') )== eb)
  {
  eng.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Executive Briefings').getRecordTypeId();
  }
  else if (string.valueOf(s.get('Activity_Converted_to_Engagement__c')) == 'true')
  {
  eng.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Company Visits & Contact Activities').getRecordTypeId();
  }
  
  
  engList.add (eng);
  
  evList.add(s);
  }
  }
  }
  }
  else
  {
  if (LastModifiedDate == myDateT || LastModifiedDate == myDateY || LastModifiedDate == myDateTo)
  {
  if (strWhatId == whatIdKey)
  {
  if (strCreatedByProfileId == createdByProfileId )
  {
  Map <string, sObject> evMap = new Map <string, sObject>();
  evMap.put(String.valueOf( s.get('Id') ), s);
  
  List < Interaction__c> intList = [select Id,RecordTypeId, Location__c, Start_Date__c, End_Date__c, Description__c, Assigned_To__c, Activity_Due_Date__c, Subject__c, Source_Organization__c, Related_Master_Organization__c, Interaction_Type__c, Interaction_Source_KU_Division__c, Created_Date__c, Source_System_Last_Modified_Date__c, Interaction_Source_System__c, Interaction_Source_System_ID__c From Interaction__c Where Interaction_Source_System_ID__c in :evMap.keyset() ];
  for (Interaction__c inte: intList){
  if (null!=inte.Interaction_Source_System_ID__c)
    {
    sObject ss = evMap.get(inte.Interaction_Source_System_ID__c);
    inte.Description__c =string.valueof(ss.get('Description'));
    inte.Assigned_To__c = String.valueOf( ss.get('OwnerId') );
    inte.Location__c = string.valueOf( s.get('Location'));
    inte.Start_Date__c = date.valueOf( s.get('StartDateTime'));
    inte.End_Date__c = date.valueOf( s.get('EndDateTime') );
    inte.Subject__c = String.valueOf( ss.get('Subject') );
    //inte.Source_Organization__c =String.valueOf( ss.get('Master_Org_s_Primary_Source_Org_Id__c') );
    inte.Related_Master_Organization__c = String.valueOf( ss.get('whatid') );
    inte.Interaction_Type__c = String.valueOf( ss.get('Type') );
    inte.Interaction_Source_KU_Division__c = 'Corporate Partnerships';
    //inte.CreatedBy.Id = String.valueOf( ss.get('Createdby.Id') );
    inte.Created_Date__c = date.valueOf( ss.get('CreatedDate') );
    inte.Source_System_Last_Modified_Date__c = date.valueOf( ss.get('LastModifiedDate') );
    inte.Interaction_Source_System__c = 'SFDC';
    
    if (String.valueOf( s.get('Type') )== call ||  String.valueOf( s.get('Type')) == email)
    {
    inte.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Calls & Emails').getRecordTypeId();
    }
    else if (String.valueOf( s.get('Type') )== eb)
    {
    inte.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Executive Briefings').getRecordTypeId();
    }
    else
    {
    inte.RecordTypeId = Schema.SObjectType.Interaction__c.getRecordTypeInfosByName().get('Company Visits & Contact Activities').getRecordTypeId();
    }
  
    engToUpdate.add(inte);
    }
  }
  }
  }
  }
  }
  }
  }
  insert engList;
  
  update evList;
  
  update engToUpdate;
 }
 
 global void finish (Database.BatchableContext BC)
 {
 }
}