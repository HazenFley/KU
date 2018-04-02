@isTest(SeeAllData=true)
public class RHX_Source_Organization_TEST {
    
    static testMethod void triggerTest() {
        
        List<Source_Organization__c> sourceList = [SELECT Id
                                               FROM Source_Organization__c
                                                   LIMIT 1
                                           ];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Source_Organization__c()
                );
        }
    Database.upsert(sourceList);        
    }

}