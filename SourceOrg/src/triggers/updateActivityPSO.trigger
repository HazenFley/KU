trigger updateActivityPSO on Account (after update) {
    Set<ID> setAccountIds = new Set<ID>();
    //Create a list of new updated accounts.
    
    List<Task> taskList = new List <Task>();
    List<Event> eventList = new List<Event>();
    List<Task> taskToUpdate = new List <Task>();
    List<Event> eventToUpdate = new List<Event>();
    
    Map<ID, String> mapAccount = new Map<ID,String>();
    
    for(Account newAcc:Trigger.New){
        if(newAcc.Primary_Source_Org_Id__c != null && Trigger.oldMap.get(newAcc.Id).Primary_Source_Org_Id__c != newAcc.Primary_Source_Org_Id__c){
            setAccountIds.add(newAcc.Id);
            mapAccount.put(newAcc.Id, newAcc.Primary_Source_Org_Id__c);
        }
    }
    
    
    
    if(setAccountIds.size()>0){
        
        taskList = [Select id, WhatId, Master_Org_s_Primary_Source_Org_Id__c from Task Where WhatId in:setAccountIds];
        if(taskList.size()>0){
            for(Task task:taskList){
            
            task.Master_Org_s_Primary_Source_Org_Id__c = mapAccount.get(task.WhatId);
            taskToUpdate.add(Task);
            
            }
        }
        eventList = [Select id, WhatId, Master_Org_s_Primary_Source_Org_Id__c from Event Where WhatId in:setAccountIds];
        if(eventList.size()>0){
        for(Event event:eventList){
            
            event.Master_Org_s_Primary_Source_Org_Id__c = mapAccount.get(event.WhatId);
            eventToUpdate.add(event);
            }
        }
    }
    update taskToUpdate;
    update eventToUpdate;
   
}