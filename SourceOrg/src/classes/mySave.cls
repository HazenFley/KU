public class mySave{
    ApexPages.StandardController controller;
    public mySave(ApexPages.StandardController con){
        controller = con;
     }            
 
    public PageReference save() {
        controller.save();
        return page.ActualANDExpectedValues_View;
    }
}