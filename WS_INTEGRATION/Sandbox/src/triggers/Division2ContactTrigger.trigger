// 27 NOV 2017
trigger Division2ContactTrigger on Division2Contact__c (before insert, after insert, before update, after update) {
    
    //Division2Contact__c[] newDivision2Contact = trigger.new;
    
    
        if(trigger.isbefore){//------------------------------isBefore--------------------------------------------
            Division2Contact Div2Cont = new Division2Contact();
            Div2Cont.nameDiv2Cont(trigger.new);
            Div2Cont.primaryDivision(trigger.new);
        }
        
            
    
}