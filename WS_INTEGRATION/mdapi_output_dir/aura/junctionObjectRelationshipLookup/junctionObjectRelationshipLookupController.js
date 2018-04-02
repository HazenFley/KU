({
    getRelRecords : function(component, event, helper) {
        console.log("Aura Method getRelRecords starting...")
        
        var params;
        var callback;
        
        params = event.getParam('data');        
        if (params) {
            console.log("Given params are: " + params)
            callback = params.callback;
        }
        
        var relAction = component.get("c.junctionObjectRelLookupController");
        
        //Pass the parameters to the APEX class
        relAction.setParams({
            givenId: component.get("v.givenId"),
            givenIdFieldName: component.get("v.givenIdFieldName"),
            junctionObjectName: component.get("v.junctionObjectName"),
            destinationObjectFieldName: component.get("v.destinationObjectFieldName"),
            destinationObject: component.get("v.destinationObject")
        });
        
        //Give the results
        relAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "ERROR" || state === "INCOMPLETE") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
                
            } else {
                var list = response.getReturnValue();
                component.set("v.picklistValues", list);
            }
        })
        $A.enqueueAction(relAction);
    }
})