@isTest
public class myCancelTest {
public static testMethod void constructorTest(){
     Account a = new Account(name='Test123');
            insert a;
            
    Test.startTest();
    Test.setCurrentPage(Page.ExpectedValue);
  
     
    myCancel controller = new myCancel(new ApexPages.StandardController(a));
            
            controller.cancel();
            
            Test.stopTest();
           
}
}