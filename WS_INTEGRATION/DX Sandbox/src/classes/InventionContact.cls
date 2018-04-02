public class InventionContact {
    public void newInvContName(Invention_Contact__c[] newInvCont){
        string newName;
        string contactName;
        string inventionTrackCode;
        Set<id> contSearch = new Set<id>();
        Map<Id,String> nameMap = new Map<Id,String>();
        
        //Information about the related Invention
        Set<id> invSearch = new Set<id>();
        
        for(Invention_Contact__c z : newInvCont){
            invSearch.add(z.Invention__c);
            contSearch.add(z.Researcher__c);
        }
        
        List<Invention__c> invList = [SELECT name FROM Invention__c WHERE id IN :invSearch ];
        
        for(Invention__c inv:invList){
            nameMap.put(inv.Id,inv.Name);
        }
        
        List<Contact> contList = [SELECT LastName FROM Contact WHERE id IN :contSearch ];
        
        for(Contact con:contList){
            nameMap.put(con.Id,con.LastName);
        }

        //List of records to update
        List<Invention_Contact__c> updateList = new List<Invention_Contact__c>();
        
        //Update the name for each record
        for(Invention_Contact__c a : newInvCont){
            newName = nameMap.get(a.Invention__c) + '-' + nameMap.get(a.Researcher__c);
            a.Name = newName;
        }        
    }
    
    public void primaryInventor(Invention_Contact__c[] newInventionContact){//----------------------------------------------------------------
        //Set up lists to compare
        List<Invention_Contact__c> primaryIC = new List<Invention_Contact__c>();
        Set<id> contactSet = new Set<id>();
        Set<id> inventionSet = new Set<id>();
        
        //If the new Invention_Contact__c is primary, pull the needed information from both contact and invention
        
        for(Invention_Contact__c n: newInventionContact){
            if(n.Lead_Inventor__c ==true && n.Researcher__c!=null && n.Invention__c!=null){
                primaryIC.add(n);
                contactSet.add(n.Researcher__c);
                inventionSet.add(n.Invention__c);
            }
        }
        
        //If the new InventionContact is primary, do some stuff
        if(!primaryIC.isEmpty()){
            
            //Put all ICs related to original invention into a map
            List<Invention_Contact__c> relIC = [SELECT id, Lead_Inventor__c
                                                FROM Invention_Contact__c
                                                WHERE Invention__c in :inventionSet AND Lead_Inventor__c=TRUE];
            
            //List to be Updated
            List<Invention_Contact__c> updateList = new List<Invention_Contact__c>();
            
            for(Invention_Contact__c u: relIC){
                updateList.add(new Invention_Contact__c(id=u.id,Lead_Inventor__c=FALSE));
            }
            
            //Make sure there is something to update
            if(updateList.size()>0){
                //Standard syntax, false makes it not fail the whole process on error
                Database.SaveResult[] srList = Database.update(updateList,false);
            }
            
            //Update Invention to explicitly state the primary inventor            
            //list to hold the invention to be updated
            List<Invention__c> updateInv = new List<Invention__c>();
            
            for(Invention_Contact__c p: primaryIC){
                updateInv.add(new Invention__c(id=p.invention__c, Lead_Inventor__c=p.Researcher__c, Division__c=p.Division__c));
            }    
            
            //update the invention if successful            
            if(updateInv.size()>0){
                Database.SaveResult[] srList2 = Database.update(updateInv,false);
            }
        }        
    }
    
    public void inventorListing(Invention_Contact__c[] newInventionContact){//----------------------------------------------------------------
        //Method to concat all the different inventor names into a single field for the invention
        //Create set and store invention id
        Set<id> invSet = new Set<id>();
        
        for(Invention_Contact__c n: newInventionContact){
            invSet.add(n.Invention__c);
        }
        
        //Get all related invention2contact information
        List<Invention_Contact__c> relI2C = [SELECT id, Researcher_Name__c
                                             FROM Invention_Contact__c
                                             WHERE Invention__c IN :invSet];
        
        //get information related to original invention
        List<Invention__c> relInv = [SELECT id, Inventor_Listing__c
                                     FROM Invention__c
                                     WHERE id IN :invSet];
        
        //variable to store cumulative inventor names
        String invNames;
        
        //run through related Invention Contacts and concat name
        for(Invention_Contact__c c: relI2C){
            if(invNames == null){
                invNames = c.Researcher_Name__c;
            } else {
                invNames = invNames + '; ' + c.Researcher_Name__c;
            }
        }
        
        //List to hold updated values
        List<Invention__c> updateList = new List<Invention__c>();
        
        for(Invention__c v: relInv){
            updateList.add(new Invention__c(id=v.id,Inventor_Listing__c=invNames));            
        }
        
        //standard syntax for updating records
        if(updateList.size()>0){
            Database.SaveResult[] srList = Database.update(updateList,false);
        }
    }    
}