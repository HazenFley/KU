public class InventionAccount {
	
    public void newInvActName(Invention_Account__c[] newInvAct){
        string newName;
        Set<id> actSearch = new Set<id>();
        Map<Id,String> nameMap = new Map<Id,String>();
        
        //Information about the related Invention
        Set<id> invSearch = new Set<id>();
        
        for(Invention_Account__c z : newInvAct){
            invSearch.add(z.Invention__c);
            actSearch.add(z.Sponsor__c);
        }
        
        List<Invention__c> invList = [SELECT name FROM Invention__c WHERE id IN :invSearch ];
        
        for(Invention__c inv:invList){
            nameMap.put(inv.Id,inv.Name);
        }
        
        List<Account> actList = [SELECT Name FROM Account WHERE id IN :actSearch];
        
        for(Account act:actList){
            nameMap.put(act.Id,act.Name);
        }

        //List of records to update
        List<Invention_Account__c> updateList = new List<Invention_Account__c>();
        
        //Update the name for each record
        for(Invention_Account__c a : newInvAct){
            newName = nameMap.get(a.Invention__c) + '-' + nameMap.get(a.Sponsor__c);
            a.Name = newName;
        }        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------
    public void primarySponsor(Invention_Account__c[] newInvAct){
        //set up lists to compare
        List<Invention_Account__c> primaryI2A = new List<Invention_Account__c>();
        Set<id> inventionSet = new Set<id>();
        Set<id> actSet = new Set<id>();
        
        //if the new i2a is primary, pull the needed information on invention and account
        for(Invention_Account__c n: newInvAct){
            if(n.Primary_Agency__c==TRUE && n.Sponsor__c!=NULL && n.Invention__c!=NULL){
                primaryI2A.add(n);
                inventionSet.add(n.Invention__c);
                actSet.add(n.Sponsor__c);
            }
        }
        
        //If the new i2a is primary, do some stuff
        if(!primaryI2A.isEmpty()){
            //put all i2a's related to original invention into a map
            List<Invention_Account__c> relI2A = [SELECT id, Primary_Agency__c
                                                 FROM Invention_Account__c
                                                 WHERE Invention__c in :inventionSet AND Primary_Agency__c=TRUE];
            //List to be updated
            List<Invention_Account__c> updateList = new List<Invention_Account__c>();
            
            for(Invention_Account__c m: relI2A){
                updateList.add(new Invention_Account__c(id=m.id, Primary_Agency__c=FALSE));
            }
            
            //Make sure there is something to update
            if(updateList.size()>0){
                Database.SaveResult[] srList = Database.update(updateList,false);
            }
            
            //Update Invention to explicitly state the primary sponsor            
            //list to hold the invention to be updated
            List<Invention__c> updateInv = new List<Invention__c>();
            
            for(Invention_Account__c p: primaryI2A){
                updateInv.add(new Invention__c(id=p.invention__c, Primary_Agency__c=p.Sponsor_Name__c));
            }    
            
            //update the invention if successful            
            if(updateInv.size()>0){
                Database.SaveResult[] srList2 = Database.update(updateInv,false);
            }
        } 
    }    
}