({
    doInit: function (cmp, event, helper) {
        
        //var items = [];
        var parentObj = cmp.get('v.parentObj');
        var childObj = cmp.get('v.childObj');
        var parentObjNameField = cmp.get('v.parentObjNameField');
        var childObjNameField = cmp.get('v.childObjNameField');
        var whereField = cmp.get('v.whereField');
        var whereValue = cmp.get('v.whereValue');  
        
        var action = cmp.get('c.getParentWithChildren');
        
        action.setParams({
            ParentObj : parentObj,
            ChildObj : childObj,
            ParentObjNameField : parentObjNameField,
            ChildObjNameField : childObjNameField,
            WhereField : whereField,
            WhereValue : whereValue
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log("state:" + state);
            if (state === "SUCCESS") {
                // replace parent object name with label
                var objects = JSON.stringify(response.getReturnValue()).replace(new RegExp(parentObjNameField, 'g'), 'label');
                // replace child object name with label
                objects = objects.replace(new RegExp(childObjNameField, 'g'), 'label');
                // replace child object title with items
                objects = objects.replace(new RegExp(childObj, 'g'), 'items');                
                
                //var accounts = JSON.stringify(response.getReturnValue()).replace(new RegExp('Name', 'g'), 'label').replace(new RegExp('Opportunities', 'g'), 'items');
                console.log('Before update:'+ objects);
                
                cmp.set("v.items", JSON.parse(objects) );
            }
            else{
                console.log("Failed with state: " + response.getError());
            }
        });
        $A.enqueueAction(action);
        
    },
    showSpinner: function (cmp, event){
        cmp.set("v.spinner", true);
    },
    hideSpinner: function (cmp, event){
        cmp.set("v.spinner", false);
    }
})