({
	doInit: function (component, event, helper) { 
        console.log('doInit of myLightningTree component called');
        var currentRecordId = component.get('v.currentRecordId');
        var sObjectName= component.get('v.sObjectName');
        var parentField= component.get('v.parentField');
        var labelField= component.get('v.labelField');
        var whereField = component.get('v.whereField');
        var whereValue = component.get('v.whereValue');
        
        helper.callToServer(
            component,
            "c.findHierarchyData",
            function(response) {
                var apexResponse = response;
                var roles = {};
                console.log('*******apexResponse:'+JSON.stringify(apexResponse));
                var results = apexResponse;
                
                roles[undefined] = { Name: "Root", items: [] };
                
                apexResponse.forEach(function(v) {
                    roles[v.rec.Id] = { 
                        label: v.rec[labelField] ,
                        name: v.rec.Id, 
                        //expanded:v.expanded,
                        expanded:true,
                        items: [] };
                });
                console.log('*******roles:'+JSON.stringify(roles));
                apexResponse.forEach(function(v) {
                    roles[v.rec[parentField]].items.push(roles[v.rec.Id]);   
                });                
                component.set("v.items", roles[undefined].items);
                console.log('*******roles[undefined].items:'+JSON.stringify(roles[undefined].items));
            }, 
            {
                currentRecordId: component.get('v.currentRecordId'),
                sObjectName: component.get('v.sObjectName'),
                parentField: component.get('v.parentField'),
                labelField: component.get('v.labelField'),
                whereField: component.get('v.whereField'),
                whereValue: component.get('v.whereValue')
            }
        );
        
    },
    
    showSpinner: function(component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
    hideSpinner: function(component, event, helper) {
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    },
    handleSelect: function (component, event, helper) {
        //return name of selected tree item
        var myName = event.getParam('name');
        console.log('handleSelect variable myName = ' + myName);        
        
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": myName,
            "slideDevName": "detail"            
        });
        navEvt.fire();
    }
})