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
}