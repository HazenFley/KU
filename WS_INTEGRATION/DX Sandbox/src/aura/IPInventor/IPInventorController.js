({
    //initializes lightning data service template and grabs datatable columns and data
    doInit: function(component, event, helper) {      
        helper.doInit(component, event, helper);
    },
    //uses lightning data service to create new invention contact records
    saveRecord : function(component, event, helper) {
        helper.saveRecord(component, event, helper);
    },
    //shows invention contact creation dialog
    enableCreateDialog : function (component, event, helper){
        helper.enableCreateDialog(component, event, helper);
    },
    //hides invention contact creation dialog
    disableCreateDialog : function(component, event, helper) {
        helper.disableCreateDialog(component, event, helper);
    },
    //deletes selected invention contact
    handleRowAction: function (component, event, helper) {
        helper.handleRowAction(component, event, helper);
    },
    //hides invention contact deletion screen
    closeModal: function(component, event, helper) {
        helper.closeModal(component, event, helper);
    },
    //deletes invention contact
    deleteRow: function (component, event, helper) {
        helper.deleteRow(component,helper);
    }
})