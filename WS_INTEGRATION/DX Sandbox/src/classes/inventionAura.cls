public class inventionAura {
//Pull the record type picklist values-----------------------------------------------------------------------------------------------
    @AuraEnabled    
    public static List<String> getLocationValues(){
        System.debug('getLocationValues() Running...');
        List<String> campusValue = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Invention__c.Location__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for(Schema.PicklistEntry f: ple){
            campusValue.add(f.getLabel());
        }
        
        return campusValue;
    }
    
    //Get Record Type ID ------------------------------------------
    @AuraEnabled
    public static String getRecordTypeId() {
        System.debug('getRecordTypeId Running...');
        Id devRecordTypeId = Schema.SObjectType.Invention__c.getRecordTypeInfosByName().get('Anticipated').getRecordTypeId();
        return devRecordTypeId;
    }
}