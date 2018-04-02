trigger InventionAccountTrigger on Invention_Account__c (before insert, after insert, before update, after update) {
    if(trigger.isbefore){
        InventionAccount inv2Act = new InventionAccount();
        inv2Act.newInvActName(trigger.new);
        inv2Act.primarySponsor(trigger.new);
    }
}