public class IPContact {
    public void newIPContName(IP_Contact__c[] newIPCont){
        System.debug('newIPContName class running...');
        
        //Set up variables
        String newName;
        String contactName;
        String IPName;
        
        //Set up sets and maps
        Set<id> contSearch = new Set<id>();
        Set<id> ipSearch = new Set<id>();
        Map<Id,String> nameMap = new Map<Id,String>();
        
        //Information about the related IP
        for(IP_Contact__c z: newIPCont){
            contSearch.add(z.Inventor__c);
            ipSearch.add(z.IP__c);
        }
        
        //Get Invention Track Code from IP
        List<IP__c> ipList = [SELECT id, Invention_Name__c FROM IP__c WHERE id IN :ipSearch ];
        for(IP__c ip: ipList){
            nameMap.put(ip.Id,ip.Invention_Name__c);
        }
        
        //Get the last name of the inventor
        List<Contact> contList = [SELECT LastName FROM Contact WHERE id IN :contSearch ];
        for(Contact c: contList){
            nameMap.put(c.Id,C.LastName);
        }
        
        //Update the name of the IP_Contact__c
        for(IP_Contact__c n: newIPCont){
            n.name = nameMap.get(n.Inventor__c) + '-' + nameMap.get(n.IP__c);
        }
    }
    
    public void primaryInventor(IP_Contact__c[] newIPCont){//----------------------------------------------------------------
        System.debug('primaryInventor class running...');
        
        //Set up lists to compare
        List<IP_Contact__c> primaryIC = new List<IP_Contact__c>();
        Set<id> contactSet = new Set<id>();
        Set<id> ipSet = new Set<id>();
        
        //If the new IP_Contact__c is primary, pull the needed information from both contact and ip        
        for(IP_Contact__c n: newIPCont){
            if(n.Lead_Inventor__c ==true && n.Inventor__c!=null && n.IP__c!=null){
                primaryIC.add(n);
                contactSet.add(n.Inventor__c);
                ipSet.add(n.IP__c);
            }
        }
        
        //If the new IPContact is primary, do some stuff
        if(!primaryIC.isEmpty()){
            
            //Put all ICs related to original ip into a map
            List<IP_Contact__c> relIC = [SELECT id, Lead_Inventor__c
                                                FROM IP_Contact__c
                                                WHERE IP__c in :ipSet AND Lead_Inventor__c=TRUE];
            
            //List to be Updated
            List<IP_Contact__c> updateList = new List<IP_Contact__c>();
            
            for(IP_Contact__c u: relIC){
                updateList.add(new IP_Contact__c(id=u.id,Lead_Inventor__c=FALSE));
            }
            
            //Make sure there is something to update
            if(updateList.size()>0){
                //Standard syntax, false makes it not fail the whole process on error
                Database.SaveResult[] srList = Database.update(updateList,false);
            }
            
            //Update ip to explicitly state the primary inventor            
            //list to hold the ip to be updated
            List<IP__c> updateIP = new List<IP__c>();
            
            for(IP_Contact__c p: primaryIC){
                updateIP.add(new IP__c(id=p.IP__c, Lead_Inventor__c=p.Inventor__c));
            }    
            
            //update the ip if successful            
            if(updateIP.size()>0){
                Database.SaveResult[] srList2 = Database.update(updateIP,false);
            }
        }        
    }
}