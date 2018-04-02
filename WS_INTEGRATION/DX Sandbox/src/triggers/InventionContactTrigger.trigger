trigger InventionContactTrigger on Invention_Contact__c (before insert, after insert, before update, after update) {
    Invention_Contact__c [] newInventionContact = trigger.new;
    
    for(Invention_Contact__c n : newInventionContact ){
        if(trigger.isbefore){//------------------------------isBefore--------------------------------------------
            InventionContact invCont = new InventionContact();
            invCont.newInvContName(trigger.new);
            invCont.primaryInventor(trigger.new);
        }
        
        if(trigger.isafter){
            if(trigger.isdelete){ //delete needs the old values to be able to update correctly.
                InventionContact invCont = new InventionContact();
            	invCont.inventorListing(trigger.old);
            } else {
                InventionContact invCont = new InventionContact();
            	invCont.inventorListing(trigger.new);
            }
            
        }
        
    }        

}