({
	//initializes lightning data service template and grabs datatable columns and data
    doInit : function(component, event, helper) {
		//Related IP colums
        component.set('v.mycolumns',[
            //{label: 'Invention', fieldName:'Invention_Link__c', type: 'url',typeAttributes: {label:{ fieldName: 'Invention_Name__c' }}}, 
            {label: 'Track Code', fieldName:'Name_Link__c', type:'url',typeAttributes: {label:{ fieldName: 'Name' }}, initialWidth:150, sortable: true},            
            {label: 'Country', fieldName:'Country__c', type:'text', initialWidth:150, sortable: true},
            {label: 'Record Type', fieldName:'Record_Type_Name__c', type:'text', initialWidth:75, sortable: true},
            {label: 'App Number', fieldName:'Application_Number__c', type:'text', initialWidth:75},
            {label: 'IP Number', fieldName:'IP_Number__c', type:'text', initialWidth:75},
            {label: 'App Date', fieldName:'Application_Date__c', type:'date', initialWidth:75},
            {label: 'Status', fieldName:'IP_Status__c', type:'text', initialWidth:150 },
            {label: 'Issue Date', fieldName:'Issue_Date__c', type:'date', initialWidth:75},
            {label: 'Pub Number', fieldName:'Publication_Number__c', type:'text'},
            {label: 'Pub Date', fieldName:'Publication_Date__c', type:'date'},
            {label: 'PCT Number', fieldName:'PCT_Number__c', type:'text'},
            {label: 'EPO Number', fieldName:'EPO_Number__c', type:'text'}            
			//{label: 'Parent IP', fieldName:'Parent_IP_Link__c', type:'url', typeAttributes: {label:{ fieldName: 'Parent_IP_Name__c' }}},            
            
        ]);
        
        //this block of code to get the treeItems for hierarchy
        helper.setObjectVariables(component);
        
        // Fetch the invention2contact list from the Apex controller   
        helper.getIPList(component);
        
        //this block of code to get the IP Record types
        helper.getRecordTypes(component);
    },
    
    // Client-side controller called by the onsort event handler
    updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        // assign the latest attribute with the sorted column fieldName and sorted direction
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },
    
    showRecType : function(component, event, helper) {
        console.log('The selected Record Type is: ' +component.get("v.selRecType"));
    },
        
    //display/hide the combo box that allows a record to be created
    showBox : function(component, event, helper) {
        component.set("v.hideCreateDialog", false);
    },
    
    hideBox : function(component, event, helper) {
        component.set("v.hideCreateDialog", true);
    },
    
    //uses lightning data service to create new ip records
    newInvIP : function(component, event, helper) {
        helper.newInvIP(component, event, helper);
    },
    
    //uses lightning data service to create new ip records
    newChild : function(component, event, helper) {
        helper.newChild(component, event, helper);
    }
})