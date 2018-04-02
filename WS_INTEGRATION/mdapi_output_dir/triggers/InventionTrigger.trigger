trigger InventionTrigger on Invention__c (after update, after insert) {
Invention__c[] newInv = Trigger.new;

    if(trigger.isupdate){}
    
    if(trigger.isinsert){
        //Autofill Track Code
        Invention Inv = new Invention();
        Inv.getNextTrackCode(newInv);
    }

}