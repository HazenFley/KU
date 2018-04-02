({
    getIPList: function(component){
        //gets record id from current invention page
        var invention = component.get("v.invID");
        console.log('getIPList var invention: '+ invention);
        
        //calls InventionResearcherController.getInventionContacts
        var action = component.get('c.getIP');
        
        //sets Invention id used for controller query to current record id
        action.setParams({
            invId : invention
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
                alert('Problem with connection. Please try again. Error Code: relIPViewHelper.getIPList.action.setCallback');
                resultsToast.setParams({
                    "title": "Error",
                    "message": "Invention contacts failed to load due to: " + JSON.stringify(result.error)
                });
                resultsToast.fire();
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    
    setObjectVariables: function(component) {//------------------------------------------------------
        console.log('setObjectVariables helper starting...');
        
        //Check the first three characters of the id to see if it is an invention or IP
        //IP=a03
        //inv=a04
        //objDef will return TRUE if the record is an IP record
        var objDef = component.get("v.recordId").includes("a03");
        
        if(objDef){
            console.log("Object appears to be an IP record");
            component.set("v.IPID", component.get("v.recordId"));
            component.set("v.invID", component.get("v.simpleRecord.Invention__c"));
            console.log("IPID is " + component.get("v.IPID") + ". invID is " + component.get("v.invID"));
        } else {
            console.log("Object appears to be an invention record");
            component.set("v.invID", component.get("v.recordId"));
            console.log("IPID is not set. invID is " + component.get("v.invID"));
        }
        
        
    },
    
    getRecordTypes : function(component){//------------------------------------------------------
        console.log('getRecordTypes helper starting...');
        
        //calls InventionResearcherController.getInventionContacts
        var action = component.get('c.getRecordTypes');
        
        // Set up the callback
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            var resultsToast = $A.get("e.force:showToast");
            if(state === "SUCCESS"){
                //if successful stores query results in ipRecordTypes
                var recordTypes = response.getReturnValue();
                console.log('getRecordTypes returned: ' +recordTypes);                
                
                component.set('v.ipRecordTypes', response.getReturnValue());
            } else if (state === "ERROR") {
                //otherwise write errors to console for debugging
                alert('Problem with connection. Please try again. Error Code: relIPViewHelper.getIPList.action.setCallback');
                resultsToast.setParams({
                    "title": "Error",
                    "message": "Invention contacts failed to load due to: " + JSON.stringify(result.error)
                });
                resultsToast.fire();
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    
    sortData: function (cmp, fieldName, sortDirection) {
        console.log('sortData starting...');
        var data = cmp.get("v.mydata");
        var reverse = sortDirection !== 'asc';
        console.log('sortData variable data = ' + data);
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.mydata", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    },
    
    newInvIP : function(component, event, helper) {//------------------------------------------------------
        //Get record information
        var recID = component.get("v.recordId");
        var invID = component.get("v.invID");
        var recTypeID = component.get("v.selRecType");
        
        //Check the first three characters of the id to see if it is an invention or IP
        //IP=a03
        //inv=a04
        //objDef will return TRUE if the record is an IP record
        var objDef = component.get("v.recordId").includes("a03");
        
        var title;
        
        if(objDef){
            title = component.get("v.simpleRecord.Invention_Title__c");
        } else {
            title = component.get("v.simpleRecord.Invention_Title__c"); 
        }
              
        
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "IP__c",
            "recordTypeId": recTypeID,
            "defaultFieldValues": {                
                'Name' : 'This will be autonamed',
            	'Invention__c' : invID,
                'Title__c' : title
            }
        });
        createRecordEvent.fire();
    },
    
    newChild : function(component, event, helper){//------------------------------------------------------
        //Get record information
        var recID = component.get("v.recordId");
        var invID = component.get("v.invID");
        var title = component.get("v.simpleRecord.Title__c");
        var recTypeID = component.get("v.selRecType");
        var attorneyFirm = component.get("v.simpleRecord.Attorney_Firm__c");
        var attorney = component.get("v.simpleRecord.Attorney__c");
        var priorityDate = component.get("v.simpleRecord.Priority_Date__c");
        var priorityNum = component.get("v.simpleRecord.Priority_Number__c");
        var USPTOEntitySize = component.get("v.simpleRecord.USPTO_Filing_Entity_Size__c");        
        
        //Create record with given information
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "IP__c",
            "recordTypeId": recTypeID,
            "defaultFieldValues": {
                'Name' : 'This will be autonamed',
            	'Invention__c' : invID,
            	'Parent_IP__c' : recID,
                'Title__c' : title,
            	'Attorney_Firm__c' : attorneyFirm,
            	'Attorney__c' : attorney,
            	'Priority_Date__c' : priorityDate,
            	'Priority_Number__c' : priorityNum,
            	'USPTO_Filing_Entity_Size__c' : USPTOEntitySize
            }
        });
        createRecordEvent.fire();
    }
    
})