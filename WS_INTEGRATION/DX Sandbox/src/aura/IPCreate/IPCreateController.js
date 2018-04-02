({
	//initializes lightning data service template and grabs datatable columns and data
    doInit : function(component, event, helper) {
		//get record type of initial record
		var passRecID = component.get("{!v.simpleRecord.RecordTypeId}");
        console.log('The recordID pulled is ' + passRecID);
        
        //Query for record type id/names for IP
        //SELECT id, name FROM RecordType WHERE SobjectType = 'IP__c'
                
        if(passRecID = '0121D0000009ZhFQAU'){ //Continuation
            helper.continuation(component, event, helper);
        } else if (passRecID = '0121D0000009ZhZQAU'){ //Continuation in Part
            helper.cip(component, event, helper);
        } else if (passRecID = '0121D0000009ZhKQAU'){ //Copyright
            helper.copyright(component, event, helper);
        } else if (passRecID = '0121D0000009ZhPQAU'){ //Design
            helper.design(component, event, helper);
        } else if (passRecID = '0121D0000009ZhUQAU'){ //Divisional
            helper.divisional(component, event, helper);
        } else if (passRecID = '0121D0000009ZheQAE'){ //EPO
            helper.epo(component, event, helper);
        } else if (passRecID = '0121D0000009ZhjQAE'){ //Foreign
            helper.foreign(component, event, helper);
        } else if (passRecID = '0121D0000009ZhoQAE'){ //PCT
            helper.pct(component, event, helper);
        } else if (passRecID = '0121D0000009ZhtQAE'){ //Provisional
            helper.provisional(component, event, helper);
        } else if (passRecID = '0121D0000009ZhyQAE'){ //Trademark
            helper.trademark(component, event, helper);
        } else if (passRecID = '0121D0000009Zi3QAE'){ //Utility
            helper.utility(component, event, helper);
        } else { //error if no record id passed
            helper.noRecId(component, event, helper);
        }
    },
    
    displayError : function(component) {
        alert("Lightning Data Service error: " + component.get("{!v.recordError"));
    }
})