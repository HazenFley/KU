trigger InteractionsMasterOrgUpdateTrigger on Interaction__c (after insert, after update) {
    list<Interaction__c> interactionsToUpdate = new list<Interaction__c>();
    
    list<Id> interactionIdList = new list<Id>();
    
    for(Interaction__c c: trigger.new){
        interactionIdList.add(c.Id);
    }
    
    list<Interaction__c> interactionList = new list<Interaction__c>([select Id, Source_Organization__c, Source_Organization__r.Master_Organization__c
                                                    from Interaction__c
                                                    where Id in :interactionIdList]);
    map<Id,Id> masterAccountIdMap = new map<Id,Id>();
    
    for(Interaction__c c: interactionList){
        masterAccountIdMap.put(c.Id, c.Source_Organization__r.Master_Organization__c);
    }
    
    if(trigger.isUpdate){
        for(integer i = 0; i < trigger.new.size(); i++){
            
            if(trigger.old[i].Source_Organization__c != null){
                if(trigger.new[i].Source_Organization__c != trigger.old[i].Source_Organization__c){
                    Interaction__c con = new Interaction__c(Id = trigger.new[i].Id);
                    con.Related_Master_Organization__c = masterAccountIdMap.get(con.Id);
                    interactionsToUpdate.add(con);
                }
            }else{
                Interaction__c con = new Interaction__c(Id = trigger.new[i].Id);
                con.Related_Master_Organization__c = masterAccountIdMap.get(con.Id);
                interactionsToUpdate.add(con);
                }
        }
    }
    
    if(trigger.isInsert){
        for(integer i = 0; i < trigger.new.size(); i++){
            Interaction__c con = new Interaction__c(Id = trigger.new[i].Id);
            con.Related_Master_Organization__c = masterAccountIdMap.get(con.Id);
            interactionsToUpdate.add(con);
        }
        
    }
    
    update interactionsToUpdate;    

}