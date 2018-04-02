({
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
    },
    
    noLeadInventor2 : function(){
        $A.createComponent(
            "ui_modal:modal", {'aura:id': 'theDynamicModal'},
            function(newModal, status, errorMessage){
                if (status === "SUCCESS") {
                    //Add the new modal to the app body
                    var body = component.get("v.body");
                    body.push(newModal);
                    component.set("v.body", body);
                    // Display an alert modal with a title, a message and an OK button
                    // This method is a shorthand that:
                    // - pre-populates the modal attributes
                    // - displays the modal
                    newModal.openModalAlert("Alert", "Hello world!");
                } else {
                    console.log("Failed to create modal");
                    console.log("Error status: " + status);
                    console.log("Error message: " + errorMessage);
                }
            }
        );
    }
})