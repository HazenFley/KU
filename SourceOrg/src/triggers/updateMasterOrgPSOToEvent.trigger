trigger updateMasterOrgPSOToEvent on Event (before insert) {

    List<Event> EventList = new List<Event>();
    Map<Id, Event> mapEvents = new Map<Id, Event>();
    Set<Id> evIds = new Set<Id>();

    for(Event ev : Trigger.new){
         
        if (ev.WhatId != null){
       
            //Accounts Id start with '001
            if( string.valueOf(ev.WhatId).startsWith('001') ){
           
                //Add the Event to the Map and Set
                mapEvents.put(ev.WhatId, ev);
                evIds.add(ev.WhatId);
            }
        }
    }

    //Get all the accounts of the Event
    List<Account> aList = [Select Primary_Source_Org_Id__c From Account Where Id IN : evIds];

    //Update the field of Event and get its value from account PSO
    for(Account a : aList){
        Event ev = mapEvents.get(a.Id);
        ev.Master_Org_s_Primary_Source_Org_Id__c = a.Primary_Source_Org_Id__c;
    }

    //From the Event in the map that had been updated, transfer it to the instance of the original Event
    for(Event ev : Trigger.new){
        Event evmap = mapEvents.get(ev.WhatId);
            if (evmap != null){
            ev.Master_Org_s_Primary_Source_Org_Id__c = evmap.Master_Org_s_Primary_Source_Org_Id__c;
        }
    }

}