// 13 Feb 2018
trigger DivisionTrigger on Division__c (before insert, after insert, before update, after update) {
    
    //Division2Contact__c[] newDivision2Contact = trigger.new;
    
    
        if(trigger.isbefore){//------------------------------isBefore--------------------------------------------
            Division Div = new Division();
            Div.nameDivision(trigger.new);
        }
        
            
    
}