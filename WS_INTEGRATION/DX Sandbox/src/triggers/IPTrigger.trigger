trigger IPTrigger on IP__c (before insert, after insert, before update, after update) {
	IP__c[] newIP = Trigger.new;
    
    if(trigger.isinsert){
        if(trigger.isbefore){
            IP IP = new IP();        
            //Autoname
            IP.nameIP(newIP);
        }
        
        if(trigger.isafter){
            IP IP = new IP();        
            //Pull Invention Contacts and replicate on IP
            IP.pullInventors(newIP);
            IP.nationalization(newIP);
        }
		
        
        
    }
}