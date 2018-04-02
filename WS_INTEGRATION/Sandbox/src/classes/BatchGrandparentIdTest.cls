@isTest
private class BatchGrandparentIdTest {
	
    //timing of the schedule
    // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    
    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
       
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='Account '+i));
        }
        insert accounts;
       
        List<Account> accountChildren = new List<Account>();
        
        // insert 10 accounts as children
        for (Account a:accounts) {
            accountChildren.add(new Account(name='Account ' + a.name, 
                parentId = a.id));
        }
        insert accountChildren;
        
    }

    static testmethod void test() {        
        Test.startTest();
        BatchGrandparentId grandparentBatch = new BatchGrandparentId(); 
		Id batchId = Database.executeBatch(grandparentBatch);
        Test.stopTest();

        // after the testing stops, assert records were updated properly        
        List<Account> testResult = [SELECT Id, parentId, Grandparent_Account_ID__c FROM Account];
        for(Account a:testResult){
            if(a.ParentId == NULL){
                System.assertEquals(a.Id,a.Grandparent_Account_ID__c);
            } else {
                System.assertEquals(a.ParentId,a.Grandparent_Account_ID__c);
            }                
        }
        
    }
    
    //second test to test scheduler
    static testmethod void testschedule() {        
        Test.startTest();
        String jobId = System.schedule('jobName', CRON_EXP, new BatchGrandparentIdSched());
        Test.stopTest();        
    }
    
}