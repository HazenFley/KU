trigger IPContactTrigger on IP_Contact__c (before insert, after insert, before update, after update) {
	IP_Contact__c [] newIPContact = trigger.new;
    
    for(IP_Contact__c n: newIPContact){
        if(trigger.isbefore){
            if(trigger.isinsert){
                IPContact ipCont = new IPContact();
                ipCont.newIPContName(trigger.new);
            }
            //Always run these before
            IPContact ipCont = new IPContact();
            ipCont.primaryInventor(trigger.new);
        }
        
        if(trigger.isafter){
            
        }
    }
}