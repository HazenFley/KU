global class BatchGrandparentId implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name, ParentId FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<Account> accounts){
        List<Account> acctsToUpdate = new List<Account>();
        Map<Id,Id> acctMap = new Map<Id,Id>();
        
        for(Account a:accounts){
            if(a.ParentId != NULL){
                acctMap.put(a.Id, a.ParentId);
            }
        }
        
        for(Account a:accounts){
            Id grandparentId = a.Id;
            
            
            if(acctMap.containsKey(grandparentId)){
                for(Integer i=0;i<15;i++){
                    if(acctMap.containsKey(grandparentId)){
                        grandparentId = acctMap.get(grandparentId);
                    }
                }
            }
            
            a.Grandparent_Account_ID__c = grandparentId;
            
            acctsToUpdate.add(a);
        }
        
        // The ! on the acctsToUpdate makes the method the opposite. It reverses stuff
        if(!acctsToUpdate.isEmpty()){ 
            update acctsToUpdate;
        }
        
        
    }    

    global void finish(Database.BatchableContext bc){
        
    }    

}