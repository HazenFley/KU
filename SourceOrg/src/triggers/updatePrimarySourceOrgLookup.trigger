trigger updatePrimarySourceOrgLookup on Source_Organization__c (after delete, after insert, after update) {
 
  set <Id> moIds = new set<Id>();
 
  if(trigger.isInsert){
    for(Source_Organization__c so : trigger.new){
    if (so.Primary_Source_Org__c == True){
      moIds.add(so.Master_Organization__c);
      }
    }
  }
  
  if(trigger.isUpdate){
  for(Source_Organization__c so : trigger.new){
  Source_Organization__c oldSo = Trigger.oldMap.get(so.Id);
    if (so.Primary_Source_Org__c != oldSo.Primary_Source_Org__c){
      moIds.add(so.Master_Organization__c);
      }
    }
  }
 
  if(trigger.isDelete){
    for(Source_Organization__c so : trigger.old){
    if (so.Primary_Source_Org__c == True){
      moIds.add(so.Master_Organization__c);
      }
    }
    
    list<Account> accountUpdate = new list<Account>([select Id, Primary_Source_Org_Id__c from Account where Id in :moIds]);
    for(Account a: accountUpdate){
    a.Primary_Source_Org_Id__c ='';
    }
    update accountUpdate;
    
  }

  Map<Id, Id>  moMap =new  Map<Id, Id>() ;
  Map <id, Source_Organization__c> soMap = new Map <Id, Source_Organization__c>();
 
  for(Source_Organization__c pso : [select Id, 
  Master_Organization__c,
  CreatedDate,
  Primary_Source_Org__c
    from Source_Organization__c where 
    Primary_Source_Org__c = True 
    AND
    Master_Organization__c IN :moIds Order By CreatedDate ASC]){
      moMap.put((Id)pso.get('Master_Organization__c'),pso.Id);
      soMap.put ((Id)pso.Id, pso);
      }
   
   if (moMap.size() == 0){
   list<Account> accountUpdate2 = new list<Account>([select Id, Primary_Source_Org_Id__c from Account where Id in :moIds]);
    for(Account aa: accountUpdate2){
    aa.Primary_Source_Org_Id__c ='';
    }
    update accountUpdate2;
    }

  List<Account> moToUpdate = new List<Account>();
 
  for(Account mo : [Select Id, 
  Primary_Source_Org_Id__c
  from Account where Id IN :moIds]){
    mo.Primary_Source_Org_Id__c = moMap.get(mo.Id);
    if (null!=mo.Primary_Source_Org_Id__c)
    {
    moToUpdate.add(mo);
    }
  }
  update moToUpdate;
 }