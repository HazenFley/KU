@isTest
public class Division2ContactTest {
    
    static testMethod void validateDivision2Contact(){
        
        //Set up the lists we will use. The values in parenthesies passes the value on to the methods below.
        //createContact('Test',10,2) = base name will be Test, we will make 10 contacts, and there will be 2 contacts per account
        List<Contact> c = createContact('Test',10,2);
        List<Division__c> d = createDivision('TestDiv',20);
        
        insert c;
        insert d;
        
        //Place to put the data we are going to test against
        List<Division2Contact__c> sampleD2C = new List<Division2Contact__c>();
        
        //Add in some Division2Contact data
        for(integer i=0; i<20; i++){
            sampleD2C.add(new Division2Contact__c(Contact__c=c[i].id, Division__c=d[i].id,Primary_Division__c=TRUE));
        }
        insert sampleD2C;       
        
        
        test.startTest();
        //Another list to test against to see how many were added (after we already had some data on the contacts/divisions from before)
        List<Division2Contact__c> testD2C = new List<Division2Contact__c>();
        
        //Attempt to add another primary to each contact, should fail
        for(integer i=0; i<20; i++){
            testD2C.add(new Division2Contact__c(Contact__c=c[i].id, Division__c=d[i].id,Primary_Division__c=TRUE));
        }
        
        try{
            //We expect this insert to fail
            insert testD2C;
        }catch(Exception error){
            //Since it failed, we check to make sure we got the error message from the class
            System.assert(error.getmessage().contains('Each Contact can only have one Division marked as primary.'));
        }        
        
        test.stopTest();
        
        //Now we check to make sure that we didn't break the code with any future development.
        List<Division2Contact__c> reviewInsert = [SELECT id, Contact__r.Department FROM Division2Contact__c];
        System.assertequals(sampleD2C.size(),reviewInsert.size());
        
        //Make sure the contact department got updated, too
        for(Division2Contact__c checkDiv2Cont : reviewInsert){
            System.assertEquals('Department X', checkDiv2Cont.Contact__r.Department);
        }
    }
    
    
    //Generic Account Creation
    public static List<Account> createAccount(string baseAcctName, Integer AcctCount){
        List<Account> results = new List<Account>();
        for(integer i=0; i<AcctCount; i++){
            results.add(new Account(Name=baseAcctName+string.valueOf(i)));
        }
        return results;        
    }
    
    //Generic Contact Creation
    public static List<Contact> createContact(string baseContName, Integer contCount, Integer contactPerAccount){
        List<Contact> contResults = new List<Contact>();
        List<Account> testAccounts = createAccount(baseContName, contCount);
        
        insert testAccounts;
        
        for(Account a: testAccounts){
            for(integer i=0; i<contactPerAccount; i++){
                contResults.add(new Contact(LastName=baseContName+string.valueOf(i), Accountid=a.id));
            }            
        }
        return contResults;
    }
    
    //Generic Division Creation
    public static List<Division__c> createDivision(string baseDivName, Integer divCount){
        List<Division__c> results = new List<Division__c>();
        for(integer i=0; i<divCount; i++){
            results.add(new Division__c(Department__c='Department X',
                                        Campus__c=baseDivName+string.valueOf(i),
                                        Campus_XID__c=baseDivName+string.valueOf(i),
                                        Cost_Center__c=baseDivName+string.valueOf(i),
                                        Cost_Center_XID__c=baseDivName+string.valueOf(i),
                                        Department_XID__c=baseDivName+string.valueOf(i),
                                        School__c=baseDivName+string.valueOf(i),
                                        School_XID__c=baseDivName+string.valueOf(i),
                                        Unit__c=baseDivName+string.valueOf(i),
                                        Unit_XID__c=baseDivName+string.valueOf(i),
                                        Unit_WXID__c=i,
                                        School_WXID__c=i,
                                        Department_WXID__c=i,
                                        Cost_Center_WXID__c=i,
                                        Campus_WXID__c=i));
        }
        return results;        
    }
}