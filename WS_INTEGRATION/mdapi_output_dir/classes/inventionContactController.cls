public class inventionContactController {
    @AuraEnabled
    public static List<RelatedObject> getRelDivisions(String givenId){
        System.debug('getRelDivisions method starting...');
        System.debug('The givenID is: ' + givenId);
        
        //List to hold the final values
        List<RelatedObject> pickListValuesList = new List<RelatedObject>();
        
        //Make sure there is an id for contact
        if(String.isblank(givenID)){
            String.valueof(Database.query('SELECT Contact__c FROM Division2Contact__c LIMIT 1'));}
        //givenID = '0031D000001tqHyQAI';
        
        
        //List to hold the junction object results
        List<Division2Contact__c> relJunctionObjects = [SELECT Division__c,Division__r.Name FROM Division2Contact__c WHERE Contact__c = :givenId];
            //new Set<id>();
            //Database.query('SELECT Division__c FROM Division2Contact__c WHERE Contact__c = ' + givenId);
        System.debug('relJunctionObjects List contains: ' + relJunctionObjects);
        
        //Add the results into the String list
        for(Division2Contact__c s: relJunctionObjects) {
            pickListValuesList.add(new RelatedObject(s.Division__c,s.Division__r.Name));            
        } 
        
        //for(Integer i=0; i<relJunctionObjects.size(); i++) {
        //    pickListValuesList.add(StringValueof(new Division2Contact__c(relJunctionObjects.Division__c[i],Division__r.Name[i])));
        
        system.debug('pickListValuesList = ' + pickListValuesList);
        return pickListValuesList;
    }
}