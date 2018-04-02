({
    doInit : function(component, event, helper) {
                
        //Get Record Type Id of Anticipated
        /*
        console.log('getRecordTypeId has started...');
        var action = component.get("c.getRecordTypeId");
        action.setCallback(this,function(response) {
            var devRecordTypeId = response.getReturnValue();
        })
        $A.enqueueAction(action);
        console.log('The recordID pulled is ' + devRecordTypeId);
        */
        
        //Prepare new record from template        
        component.find("inventionRecordCreator").getNewRecord(
            "Invention__c", // sObject Type (entityAPIName)
            "0121D0000004tOLQAY", //recordTypeID
            false, //skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newInvention");
                var error = component.get("v.newInventionError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }else{
                    console.log("Record template initialized: " + rec.sobjectType);
                }
            })
        );
        
    }, //don't forget the comma if you have more stuff
    
    handleSaveInvention: function(component, event, helper) {
        if(helper.validateInventionForm(component)) {
            
            //Name will be set by APEX class Invention
            component.set("v.simpleInvention.Name", ''); 
            
            //Campus is selected from the picklist, so we set it in the field set
            console.log("campus__c = " + component.find('invCampus').get("v.value"));
            component.set("v.simpleInvention.Campus__c", component.find('invCampus').get("v.value"));
            
            //Working Title should have been already set with lightning input
            console.log("Working Title = " + component.get("v.simpleInvention.Working_Title__c"));
            
            //Lead Researcher was part of the lookup, so we need to set it
            console.log("Lead Researcher = " + component.get("v.selectedContactLookupRecord.Id"));
            component.set("v.simpleInvention.Lead_Inventor__c", component.get("v.selectedContactLookupRecord.Id"));
            
            //Now we try to save
            component.find("inventionRecordCreator").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    //record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();
                    
                    //Great, the record is saved. Lets try to navigate to it now
                    console.log("Save result: " + JSON.stringify(saveResult));                    
                    var recId = saveResult.recordId;
                    console.log("Specific Id: " + recId);
                    
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        "recordId": recId
                    });
                    navEvt.fire();
                    
                    //helper.navigateTo(component, recId);
                    
                } else if(saveResult.state === "INCOMPLETE") {
                    //handle incomplete state
                    console.log("User is offline, device doesn't support drafts.")
                } else if(saveResult.state === "ERROR") {
                    //handle the error state
                    console.log('Problem saving contact, error: ' + JSON.stringify(saveResult.error));
                } else {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }                
            });
        }
    }
})