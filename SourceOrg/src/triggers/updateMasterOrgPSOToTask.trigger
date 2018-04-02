trigger updateMasterOrgPSOToTask on Task (before insert) {

    List<Task> TaskList = new List<Task>();
    Map<Id, Task> mapTasks = new Map<Id, Task>();
    Set<Id> tIds = new Set<Id>();

    for(Task t : Trigger.new){
         
        if (t.WhatId != null){
       
            //Accounts Id start with '001
            if( string.valueOf(t.WhatId).startsWith('001') ){
           
                //Add the task to the Map and Set
                mapTasks.put(t.WhatId, t);
                tIds.add(t.WhatId);
            }
        }
    }

    //Get all the accounts of the task
    List<Account> aList = [Select Primary_Source_Org_Id__c From Account Where Id IN : tIds];

    //Update the field of task and get its value from account PSO
    for(Account a : aList){
        Task t = mapTasks.get(a.Id);
        t.Master_Org_s_Primary_Source_Org_Id__c = a.Primary_Source_Org_Id__c;
    }

    //From the task in the map that had been updated, transfer it to the instance of the original task
    for(Task t : Trigger.new){
        Task tmap = mapTasks.get(t.WhatId);
            if (tmap != null){
            t.Master_Org_s_Primary_Source_Org_Id__c = tmap.Master_Org_s_Primary_Source_Org_Id__c;
        }
    }

}