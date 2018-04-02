@isTest
public class mySaveTest {
public static testMethod void constructorTest(){
     Account a = new Account(name='Test123');
            insert a;
            
    Test.startTest();
    Test.setCurrentPage(Page.ExpectedValue);
  
     
    mySave controller = new mySave(new ApexPages.StandardController(a));
            
            controller.save();
            
            Test.stopTest();
           
}
}