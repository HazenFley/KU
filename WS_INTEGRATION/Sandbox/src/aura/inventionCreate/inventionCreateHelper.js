({
    getLocationValues : function(component){
        //Pull campus picklist values
        var action = component.get("c.getLocationValues");
        var inputsel = component.find("InventionLocation");
        var campus=[]; 
        
        //system.debug("Show what vars were received: action=" action + ", inputsel=" + inputsel + ", campus=" + campus);
        
        action.setCallback(this, function(a) {
            for(var i=0;i< a.getReturnValue().length;i++){
                campus.push({"class": "optionClass", label:a.getReturnValue()[i], value:a.getReturnValue()[i]});
            }
            inputsel.set("v.options", campus);
        });
        
        $A.enqueueAction(action);
    },
    
    
    validateInventionForm : function(component) {
        var validInvention = true;        
        
        //Show error messages if required fields are blank
        console.log("Starting helper...")        
        
        if (component.find('invLocation').get("v.value") == "NULL" | component.find('invLocation').get("v.value") == ""){
            console.log("Inside the if statement");
            component.find('invLocation').showHelpMessageIfInvalid();
            validInvention = false;
        } else {
         return(validInvention);   
        }
        
        /*
        if(allValid) {
            //Verify there is an account to attach it to
            var account = component.get("v.newContact");
            if($A.util.isEmpty(account)) {
                validContact = false;
                console.log("Quick action context doesn't have a valid account.");
            }
            */
        //}
        
    },
    
    
    navigateTo : function(component, recId){
        var navEvt = $A.get("e.force:navigatetoSObject");
        navEvt.setParams({
            "recordId": recId
        });
        navEvt.fire();
    }
})