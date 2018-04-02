({
    itemSelected : function(component, event, helper) {
		helper.itemSelected(component, event, helper);
	}, 
    serverCall :  function(component, event, helper) {
		helper.serverCall(component, event, helper);
	},
    clearSelection : function(component, event, helper){
        helper.clearSelection(component, event, helper);
    },
    itemSelected : function(component, event, helper) {
        var searchText = component.get("v.picklistSelect");
        if(searchText != null){
            component.set("v.selItem",searchText);
        }
    }
})