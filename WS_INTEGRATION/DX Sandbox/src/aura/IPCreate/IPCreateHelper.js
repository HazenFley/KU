/* Name value pairs for record types.
	{value: "0121D0000009ZhFQAU", label: "Continuation"},
    {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
    {value: "0121D0000009ZhKQAU", label: "Copyright"},
    {value: "0121D0000009ZhPQAU", label: "Design"},
    {value: "0121D0000009ZhUQAU", label: "Divisional"},
    {value: "0121D0000009ZheQAE", label: "European Patent Office"},
    {value: "0121D0000009ZhjQAE", label: "Foreign"},
    {value: "0121D0000009ZhoQAE", label: "Patent Cooperation Treaty"},
    {value: "0121D0000009ZhtQAE", label: "Provisional"},
    {value: "0121D0000009ZhyQAE", label: "Trademark"},
    {value: "0121D0000009Zi3QAE", label: "Utility"},
    
    //Query for record type id/names for IP
    //SELECT id, name FROM RecordType WHERE SobjectType = 'IP__c'
*/

({
	continuation : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhFQAU", label: "Continuation"},
            {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            {value: "0121D0000009ZhUQAU", label: "Divisional"}
        ]
	},
    
	cip : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhFQAU", label: "Continuation"},
            {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            {value: "0121D0000009ZhUQAU", label: "Divisional"}
        ]
	},
    
	copyright : function(component, event, helper) {
		var options = [
            {value: "", label: "Nothing can be filed from a Copyright"}
        ]
	},
    
	design : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhFQAU", label: "Continuation"},
            {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            //{value: "0121D0000009ZhUQAU", label: "Divisional"}
        ]
	},
    
	divisional : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhFQAU", label: "Continuation"},
            {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            {value: "0121D0000009ZhUQAU", label: "Divisional"}
        ]
	},
    
	epo : function(component, event, helper) {
		 var options = [
            {value: "0121D0000009ZhUQAU", label: "Divisional"},
            {value: "0121D0000009ZhjQAE", label: "Foreign"}
        ]
	},
	foreign : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhPQAU", label: "Design"},
    		{value: "0121D0000009ZhUQAU", label: "Divisional"},
            {value: "0121D0000009ZhjQAE", label: "Foreign"},
            {value: "0121D0000009ZhoQAE", label: "Patent Cooperation Treaty"},
            {value: "0121D0000009Zi3QAE", label: "Utility"}
        ]
	},
    
	pct : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhPQAU", label: "Design"},
    		{value: "0121D0000009ZhUQAU", label: "Divisional"},
            {value: "0121D0000009ZheQAE", label: "European Patent Office"},
            {value: "0121D0000009ZhjQAE", label: "Foreign"},
            {value: "0121D0000009Zi3QAE", label: "Utility"}
        ]
	},
    
	provisional : function(component, event, helper) {
		var options = [
            //{value: "0121D0000009ZhFQAU", label: "Continuation"},
            //{value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            {value: "0121D0000009ZhPQAU", label: "Design"},
            {value: "0121D0000009ZheQAE", label: "European Patent Office"},
            {value: "0121D0000009ZhjQAE", label: "Foreign"},
            {value: "0121D0000009ZhoQAE", label: "Patent Cooperation Treaty"},
            {value: "0121D0000009Zi3QAE", label: "Utility"}
        ]
	},
    
	trademark : function(component, event, helper) {
		var options = [
            {value: "", label: "Nothing can be filed from a Trademark"}
        ]
	},
    
	utility : function(component, event, helper) {
		var options = [
            {value: "0121D0000009ZhFQAU", label: "Continuation"},
            {value: "0121D0000009ZhZQAU", label: "Continuation in Part"},
            {value: "0121D0000009ZhPQAU", label: "Design"},
            {value: "0121D0000009ZhUQAU", label: "Divisional"}
        ]
	},
    
	noRecId : function(component, event, helper) {
        alert("Error: No record type was passed");
	}
})