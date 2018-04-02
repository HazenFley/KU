public class junctionObjectRelLookupController {
    @AuraEnabled
    public static List<RelatedObject> getRecordsIntoList(String givenId, String givenIdFieldName, String junctionObjectName, String destinationObjectFieldName, String destinationObject){
        System.debug('getRecordsIntoList method starting...');
        System.debug('The givenID is: ' + givenId);
        System.debug('The givenIdFieldName is: ' + givenIdFieldName);
        System.debug('The junctionObjectName is: ' + junctionObjectName);
        System.debug('The destinationObjectFieldName is: ' + destinationObjectFieldName);
        
        //List to hold the final values
        List<RelatedObject> pickListValuesList = new List<RelatedObject>();
        
        //Make sure there is a givenID
        if(String.isblank(givenID)) {
            String.valueOf(Database.query('SELECT ' + givenIdFieldName + ' FROM ' + junctionObjectName + ' LIMIT 1'));}
        
        //List to hold the junction object results
        List<sObject> relJunctionObjects = //new Set<id>();
            Database.query('SELECT ' + destinationObjectFieldName + ' FROM ' + junctionObjectName + ' WHERE ' + givenIdFieldName + ' = ' + givenId);
        System.debug('relJunctionObjects List contains: ' + relJunctionObjects);
        
        //Query on the destinationObjectFieldName results
        List<sObject> desinationObjectList =
            Database.query('SELECT Id, Name FROM ' + destinationObject + 'WHERE Id IN :relJunctionObjects' );
        System.debug('desinationObjectList List contains: ' + desinationObjectList);
        
        //Add the results into the RelatedObject list
        for(sObject s: desinationObjectList) {
            pickListValuesList.add(new RelatedObject(s.Id,(String)s.get('Name')));
        }
        
        system.debug('pickListValuesList = ' + pickListValuesList);
        return pickListValuesList;
    }
}