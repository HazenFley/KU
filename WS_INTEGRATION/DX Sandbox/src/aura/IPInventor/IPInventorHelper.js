({
    //initializes datatable and new record template
    doInit: function(component, event, helper) {      
        //create lightning:datatable component columns
        //uses formula fields to simulate related list with name and link to record
        //can't display checkbox values so we use another formula field to get lead inventor
        //delete button triggers handleRowAction function 
        component.set('v.mycolumns',[
            {label: 'IP',fieldName: 'IP_Link__c',type: 'url',typeAttributes: {label:{ fieldName: 'IP_Name__c' }}}, 
            {label: 'Inventor',fieldName: 'Inventor_Link__c',type: 'url',typeAttributes: {label:{ fieldName: 'Inventor_Name__c' }}},
            {label: 'Division',fieldName: 'Division_Link__c',type: 'url',typeAttributes: {label:{ fieldName: 'Division_Name__c' }}},
            {label: 'Contact Account',fieldName: 'Contact_Account_Link__c',type: 'url',typeAttributes: {label:{ fieldName: 'Contact_Account_Name__c' }}},
            {label: 'Lead Inventor',fieldName: 'Lead_Inventor_Text__c',type:'text'},
            {label: 'Delete', type: 'button', typeAttributes: { iconName : 'utility:delete', iconPosition : 'center', variant : 'destructive' }}
        ]);
        // Fetch the ip2contact list from the Apex controller   
        helper.getipContactList(component); 
        //initialize the lightning data service record for ip contact creation
        component.find("recordCreator").getNewRecord(
            "IP_Contact__c",
            null,
            false,
            $A.getCallback(function() {
                var rec = component.get("v.newIpContact");
                var error = component.get("v.newIpError");
                if (error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
            })
        );
    },
    //grabs ip contacts from recordId from record page
    getipContactList: function(component) {
        //gets record id from current ip page
        var recId = component.get("v.recordId");
        
        //calls IPInventorController.getIpContacts
        var action = component.get('c.getIpContacts');
        
        //sets ip id used for controller query to current record id
        action.setParams({
            ipId : recId
        });
        
        // Set up the callback
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            var resultsToast = $A.get("e.force:showToast");
            if(state === "SUCCESS"){
                //if successful stores query results in mydata
                component.set('v.mydata', response.getReturnValue());
            } else if (state === "ERROR") {
                //otherwise write errors to console for debugging
                resultsToast.setParams({
                        "title": "Error",
                        "message": "ip contacts failed to load due to: " + JSON.stringify(result.error)
                    });
                    resultsToast.fire();
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    //deletes an ip contact based on which delete button was pressed
    deleteRow: function(component,helper) {
        var recId = component.get("v.ipConId");
        
        if(recId != null){
            //calls IPInventorController.deleteIpContact
            var action = component.get("c.deleteIpContact");
            
            //sets query id to row that delete was pressed on
            action.setParams({
                "i2c":recId
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                var resultsToast = $A.get("e.force:showToast");
                if (state === "SUCCESS") {
                    helper.getipContactList(component);
                    component.set("v.showDeleteConfirmation", false);
                    resultsToast.setParams({
                        "title": "Deleted",
                        "message": "The record was deleted."
                    });
                    resultsToast.fire(); 
                }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    resultsToast.setParams({
                        "title": "Error",
                        "message": "There was an error deleting the record: " + JSON.stringify(result.error)
                    });
                    resultsToast.fire();
                    console.error(errors);
                }
            });
            $A.enqueueAction(action);
        }
    },
    //uses lightning data service to create ip contact records
    saveRecord : function(component, event, helper) {
        //pulls contact from lookup component, and division and account ids from picklist components
        component.set("v.newIpError",null);
        var contactId = component.get("v.selItem.val");
        var divisionId = component.get("v.selDiv");
        if(divisionId === "select"){
            divisionId = null;
        }
        var accountId = component.get("v.selAcct");
        if(accountId === "select"){
            accountId = null;
        }
        
        //only run if contact is selected as contact is required
        if(contactId === null){
            //pop error if user tried to submit without first selecting a contact
            component.set("v.newIpError", "Please select an Inventor before submitting.");
        }else if(divisionId === null && accountId === null){
            //pop error if user tried to submit without either a Division or an Account
            component.set("v.newIpError", "Please select either a Division or an Account.");
        }else if(divisionId != null && accountId != null){
            //pop error if user tried to submit with both a Division or an Account
            component.set("v.newIpError", "Please select either a Division or an Account, and not both.");
        }else {
            //contact id is pulled from the variable above
            component.set("v.newIpContactFields.Inventor__c", contactId);    
            //ip id is pulled from current record page
            component.set("v.newIpContactFields.IP__c", component.get("v.recordId"));
            
            //division is optional
            if(divisionId != null && divisionId != "select"){
                component.set("v.newIpContactFields.Division__c", divisionId);
            }
            //account is optional
            if(accountId != null && accountId != "select"){
                component.set("v.newIpContactFields.Contact_Account__c", accountId);
            }
            //lead inventor field set
            component.set("v.newIpContactFields.Lead_Inventor__c", component.get("v.leadInventor"));
            
            //grab lightning data service template
            component.find("recordCreator").saveRecord($A.getCallback(function(saveResult){
                
                var resultsToast = $A.get("e.force:showToast");
                
                //on success
                //hide creation form
                //clear contact selection
                //reset creation error
                //pop creation notification
                if (saveResult.state === "SUCCESS") {
                    console.log('SUCCESS');
                    component.set("v.showCreateDialog", "false");
                    
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();   
                    helper.getipContactList(component);
                    helper.resetForm(component,event,helper);
                //on error record error to log and pop error notification
                } else if (saveResult.state === "ERROR") {
                    console.log('Error: ' + JSON.stringify(result.error));
                    resultsToast.setParams({
                        "title": "Error",
                        "message": "There was an error saving the record: " + JSON.stringify(result.error)
                    });
                    resultsToast.fire();
                } else {
                    console.log('Unknown problem');
                }
            }));
        }
    },
    // for Hide/Close Modal,set the "showDeleteConfirmation" attribute to "False"  
    closeModal: function(component, event, helper) {
        component.set("v.showDeleteConfirmation", false);
        component.set("v.ipConId",null);
    },
    // deletes ip contact records on delete button press
    handleRowAction: function (component, event, helper) {
        var row = event.getParam('row');
        component.set("v.ipConId",row);
        component.set("v.showDeleteConfirmation", true);
    },
    //shows ip contact creation dialog
    enableCreateDialog : function (component, event, helper){
        component.set("v.showCreateDialog", "true");
    },
    //hides ip contact creation dialog
    //resets selected contact
    //resets ip contact creation error
    disableCreateDialog : function(component, event, helper) {
        component.set("v.showCreateDialog", "false");
        component.set("v.selItem", null);
        component.set("v.newIpError", null);
    },
    resetForm : function(component, event, helper) {
        component.set("v.selItem", null);
        component.set("v.selAcct", null);
        component.set("v.selDiv", null);
        component.set("v.leadInventor",false);
        component.set("v.newIpContact",null);
        component.set("v.newIpContactFields",null);
        component.set("v.newIpError",null);
        component.find("recordCreator").getNewRecord(
            "IP_Contact__c",
            null,
            false,
            $A.getCallback(function() {
                var rec = component.get("v.newIpContact");
                var error = component.get("v.newIpError");
                if (error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
            })
        );
    }
})