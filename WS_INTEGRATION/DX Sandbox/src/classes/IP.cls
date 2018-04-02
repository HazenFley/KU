public class IP {
    public void nameIP(IP__c[] newIP){
        //This should only trigger on insert
        
        String newName;
        Integer nextNum;
        String trackCode;
        
        //List and Set of ID for records
        //List<IP__c> holdList = new List<IP__c>();
        Set<id> invSet = new Set<id>();
        
        for(IP__c a: newIP){
            //holdList.add(a);
            invSet.add(a.Invention__c);
        }
        
        //Information about the related Invention
        List<IP__c> topIP = [SELECT id, IP_Invention_Counter__c
                             FROM IP__c
                             WHERE (Invention__c IN :invSet) AND (IP_Invention_Counter__c != null)
                             ORDER BY IP_Invention_Counter__c DESC
                             LIMIT 1];
        
        //Determine the next number
        if(topIP.size()>0){
            nextNum = Integer.valueOf(topIP[0].get('IP_Invention_Counter__c')) + 1;
            //trackCode = String.valueOf(topIP[0].get('Name'));
        } else {
            nextNum = 1;
            //trackCode = String.valueOf(topIP[0].get('Name'));
        }
        
        //List of records to update
        //List<IP__c> updateList = new List<IP__c>();
        
        //Get invention Track Code
        
        Set<id> relInv = new Set<id>();
        
        for(IP__c tc: newIP){
            relInv.add(tc.Invention__c);
        }
        
        List<Invention__c> invList = [SELECT id, name
                                      FROM Invention__c
                                      WHERE id in :relInv
                                      LIMIT 1];
        
        trackCode = String.valueOf(invList[0].get('name'));
        
        //Actual work
        for(IP__c n: newIP){
            if(nextNum<10){                
                newName = trackCode + '-0' + nextNum;
                //updateList.add(new IP__c(id=h.Id,name=newName,IP_Invention_Counter__c=nextNum));
                n.name = newName;
                n.IP_Invention_Counter__c=nextNum;
            } else {
                newName = trackCode + '-' + nextNum;
                //updateList.add(new IP__c(id=h.Id,name=newName,IP_Invention_Counter__c=nextNum));
                n.name = newName;
                n.IP_Invention_Counter__c=nextNum;
            }            
        }        
    }  
    
    public void pullInventors(IP__c[] newIP){//----------------------------------------------------------------
        System.debug('pullInventors class running...');
        
        //Set up maps and sets
        Set<id> invSet = new Set<id>();
        Set<id> ipSet = new Set<id>();
        List<IP_Contact__c> createList = new List<IP_Contact__c>();
        
        //variables to hold current IP information
        String ip;
        String parent;
        
        for(IP__c n: newIP){
            invSet.add(n.Invention__c);
            ipSet.add(n.Parent_IP__c);
            ip = n.Id;
        }
        
        //Pull all Invention Contacts related to the invention
        List<Invention_Contact__c> relI2C = [SELECT id, Contact_Account__c, Division__c, Researcher__c, Lead_Inventor__c, Inventor_Share__c
                                             FROM Invention_Contact__c
                                             WHERE Invention__c IN :invSet];
        
        //Pull all IP Contacts related to Parent IP
        List<IP_Contact__c> parentIPcont = [SELECT id, Contact_Account__c, Division__c, Inventor__c, Lead_Inventor__c, Inventor_Share__c
                                            FROM IP_Contact__c
                                            WHERE IP__c IN :ipSet];
        
        //Create the exact same structure on the IP Contact object
        //If creating from a parent IP
        if(parentIPcont.size()>0){
            for(IP_Contact__c inv: parentIPcont){
                createList.add(new IP_Contact__c(ip__c = ip,
                                                 Contact_Account__c=inv.Contact_Account__c, 
                                                 Division__c=inv.Division__c, 
                                                 Inventor__c=inv.Inventor__c, 
                                                 Lead_Inventor__c=inv.Lead_Inventor__c,
                                                 Inventor_Share__c=inv.Inventor_Share__c));
            }
        } else{
            for(Invention_Contact__c inv: relI2C){
                createList.add(new IP_Contact__c(ip__c = ip,
                                                 Contact_Account__c=inv.Contact_Account__c, 
                                                 Division__c=inv.Division__c, 
                                                 Inventor__c=inv.Researcher__c, 
                                                 Lead_Inventor__c=inv.Lead_Inventor__c,
                                                 Inventor_Share__c=inv.Inventor_Share__c));
            }
        }
        
        
        //Standard syntax
        try{
            insert createList;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    
    
    public void nationalization(IP__c[] newIP){//----------------------------------------------------------------
        System.debug('nationalization class running...');
        
        //Get record type ids
        Id divisionalRecordTypeId = Schema.SObjectType.IP__c.getRecordTypeInfosByName().get('Divisional').getRecordTypeId();
        Id foreignRecordTypeId = Schema.SObjectType.IP__c.getRecordTypeInfosByName().get('Foreign').getRecordTypeId();
        Id utilityRecordTypeId = Schema.SObjectType.IP__c.getRecordTypeInfosByName().get('Utility').getRecordTypeId();
        Id pctRecordTypeId = Schema.SObjectType.IP__c.getRecordTypeInfosByName().get('Patent Cooperation Treaty').getRecordTypeId();
        Id epoRecordTypeId = Schema.SObjectType.IP__c.getRecordTypeInfosByName().get('European Patent Office').getRecordTypeId();
        
        //Add parent record to set 
        Set<id> parentSet = new Set<id>();        
        for(IP__c i: newIP){
            parentSet.add(i.Parent_IP__c);
        }
        
        //Get information about parents
        List<IP__c> parentList = [SELECT id, name, Nationalized__c, RecordTypeId FROM IP__c WHERE id in :parentSet];
        
        //Get a map of parent recordtypeids
        Map<id, id> parentMap = new Map<id, id>();
        for(IP__c i: parentList){
            parentMap.put(i.id, i.RecordTypeId);
        }
        
        //List to update
        List<IP__c> updateList = new List<IP__c>();
        
        //
        for(IP__c i: newIP){
            //If the child record type is foreign or utility
            if(i.RecordTypeId == foreignRecordTypeId || i.RecordTypeId == utilityRecordTypeId){
                //...and the parent is a PCT or EPO, then mark parent record as Nationalized
                if(parentMap.get(i.Parent_IP__c) == pctRecordTypeId || parentMap.get(i.Parent_IP__c) == epoRecordTypeId){
                    updateList.add(new IP__c (id=i.Parent_IP__c, Nationalized__c = TRUE));
                }
            //If the child record type is Divisional, and the parent record type is divisional, mark parent as nationalized                
            } else if (i.RecordTypeId == divisionalRecordTypeId && parentMap.get(i.Parent_IP__c) == divisionalRecordTypeId){
                updateList.add(new IP__c (id=i.Parent_IP__c, Nationalized__c = TRUE));
            }
        }
        
        System.debug('updateList = ' + updateList);
        
        if(updateList.size()>0){
            Database.SaveResult[] srList2 = Database.update(updateList,false);
        }
    }
}