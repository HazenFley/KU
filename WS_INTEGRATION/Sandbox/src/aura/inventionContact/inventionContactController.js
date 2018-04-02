({
    doInit : function(component, event, helper) {
        
        //Prepare new record from template
        
        component.find("inventionRecordCreator").getNewRecord(
            "Invention_Contact__c", // sObject Type (entityAPIName)
            "", //recordTypeID - blank means default
            false, //skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newInventionContact");
                var error = component.get("v.invContError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }else{
                    console.log("Record template initialized ");
                }
            })
        );
        
    }, //don't forget the comma if you have more stuff
    
    //Get related Divisions --------------------------------------------------------
    relDivisions : function(component, event) {
        var givenIdVar;
        
        console.log("relDivisions is starting up...");
        console.log("GivenID before server call: " + component.get("v.selectedContactLookupRecord"));
        if(component.get("v.selectedContactLookupRecord").Id != undefined){
            givenIdVar = component.get("v.selectedContactLookupRecord").Id;
        }
        
        var relDivAction = component.get("c.getRelDivisions");
        
        //Pass the parameters to the APEX class
        relDivAction.setParams({
            'givenId' : givenIdVar
        });
        
        
        //Give the results
        relDivAction.setCallback(this, function(response) {
            var state = response.getState();
            console.log('relDivisions server response state = ' + state);
            
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
                //Return doesn't work for async server action call
                var list = response.getReturnValue();
                component.set("v.relatedDivisions", list);
            }
        })
        $A.enqueueAction(relDivAction);
    },
    
    
    //Get related Accounts --------------------------------------------------------
    relAccounts : function(component, event) {
        console.log("relAccounts is starting up...");
        console.log("GivenID before server call: " + component.get("v.selectedContactLookupRecord").Id);
        
        if(component.get("v.selectedContactLookupRecord").Id != undefined){
            var data ={
                givenIdVar: component.get("v.selectedContactLookupRecord").Id,
                givenIdFieldName: "Researcher__c",
                junctionObjectName: "Invention_Contact__c",
                destinationObjectFieldName: "Contact_Account__c",
                destinationObject:"Account"
            	};
            }
        
        var relAcctAction = component.find("c.echoJunctionAccount");
        childComponent.getRelRecords(data);
        
        //Pass the parameters to the APEX class
        //relDivAction.setParams({
        //    'givenId' : givenIdVar
            //component.get("v.invContFields.Contact__c")
        //});
        
        
        //Give the results
        relAcctAction.setCallback(this, function(response) {
            var state = response.getState();
            console.log('relAccounts server response state = ' + state);
            
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
                //Return doesn't work for async server action call
                var list = response.getReturnValue();
                component.set("v.relatedAccounts", list);
            }
        })
        $A.enqueueAction(relAcctAction);
    }
})