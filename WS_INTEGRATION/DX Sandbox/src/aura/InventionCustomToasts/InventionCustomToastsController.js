({
    doInit : function(component, event, helper) {
        
        //Fire if lead inventor is null
        var leadInv = component.get("v.Lead_Inventor__c");
        
        if(leadInv == null){
            helper.noLeadInventor2(component, event, helper);
        }
        
    },
    
    noLeadInventor : function() {
        var toastEvent = $A.get("e.force:showToast");
        
        if(toastEvent){
            toastEvent.setParams({
                title: "Success!",
                message: "Congrats, it works!",
                type: "success"
            });
            toastEvent.fire();
        }
    }
})