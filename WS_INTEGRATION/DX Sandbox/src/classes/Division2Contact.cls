public class Division2Contact{
    
    public void nameDiv2Cont(Division2Contact__c[] newDivision2Contact){
        string newName;
        string contactName;
        string costCenter;
        string department;
        string divisionName;
        
        //Information about the related records
        Set<id> relSearch = new Set<id>();
        Map<Id, String> nameMap = new Map<Id,String>();        
        
        for(Division2Contact__c z : newDivision2Contact){
            relSearch.add(z.Contact__c);
            relSearch.add(z.Division__c);
        }
        
        //SOQL to get the information
        List<Contact> contList = [SELECT LastName FROM Contact WHERE id IN :relSearch];
        
        for(Contact con: contList) {
            nameMap.put(con.Id,con.LastName);
        }
        
        List<Division__c> divList = [SELECT Cost_Center__c, Department__c FROM Division__c WHERE id IN :relSearch];
        
        for(Division__c div : divList) {
            //Sometimes cost centers are null, so just get a single value out of the both of those values
            if(String.isBlank(div.Cost_Center__c)){
                nameMap.put(div.Id,div.Department__c);
            } else {
                nameMap.put(div.Id,div.Cost_Center__c);
            }
        }
        
        //Rename the record
        for(Division2Contact__c rename : newDivision2Contact){
            //Change made to only name the record after the division.
            //newName = nameMap.get(rename.Contact__c) + '-' + nameMap.get(rename.Division__c);
            newName = nameMap.get(rename.Division__c);
            rename.Name = newName;
        }
        
        //Database.update not required for a before trigger, apparently
        //if(nameList.size()>0){
        //    Database.SaveResult[] srList = Database.update(nameList,false);
        //}
        
    }    
    
    public void primaryDivision(Division2Contact__c[] newDivision2Contact){
        //Set up our lists to compare
        List<Division2Contact__c> primaryD2C = new List<Division2Contact__c>();
        Set<id> contactSet = new Set<id>();
        Set<id> divisionSet = new Set<id>();
        
        //if the new d2c is primary, pull needed information on contact and division
        for(Division2Contact__c n: newDivision2Contact){
            if(n.Primary_Division__c==TRUE && n.Contact__c!=NULL && n.Division__c!=NULL){
                primaryD2C.add(n);
                contactSet.add(n.Contact__c);
                divisionSet.add(n.Division__c);
            }            
        }
        //System.debug('primaryD2C: ' + primaryD2C);
        
        //If the new d2c is primary, do some stuff
        if(!primaryD2C.isEmpty()){
            
            //Put all D2Cs related to original contact into a map
            List<Division2Contact__c> relD2C = [SELECT id, Primary_Division__c 
                                                FROM Division2Contact__c 
                                                WHERE Contact__c in :contactSet AND Primary_Division__c=TRUE];
            
            //List to be updated
            List<Division2Contact__c> updateList = new List<Division2Contact__c>();
            
            for(Division2Contact__c m: relD2C){
                updateList.add(new Division2Contact__c(id=m.id,Primary_Division__c=FALSE));
            }
            
            //Make sure there is something to update
            if(updateList.size()>0){
                //Standard syntax, false makes it not fail the whole process on error
                Database.SaveResult[] srList = Database.update(updateList,false);
            } 
        }
    }
    
}