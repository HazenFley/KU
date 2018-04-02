public class myCancel{
    ApexPages.StandardController controller;
    public myCancel(ApexPages.StandardController con){
        controller = con;
     }            
 
    public PageReference cancel() {
        controller.cancel();
        return page.ActualANDExpectedValues_View;
    }
}