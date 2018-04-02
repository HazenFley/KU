@isTest(SeeAllData=true)
public class RHX_Interaction_TEST {
    
    static testMethod void triggerTest() {
        
        List<Interaction__c> sourceList = [SELECT Id
                                               FROM Interaction__c
                                                   LIMIT 1
                                           ];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Interaction__c()
                );
        }
    Database.upsert(sourceList);        
    }

}