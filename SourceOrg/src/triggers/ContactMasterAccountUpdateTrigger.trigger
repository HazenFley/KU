trigger ContactMasterAccountUpdateTrigger on Contact (after insert, after update) {
    
    list<Contact> contactsToUpdate = new list<Contact>();
    
    list<Id> contactIdList = new list<Id>();
    
    for(Contact c: trigger.new){
        contactIdList.add(c.Id);
    }
    
    list<Contact> contactList = new list<Contact>([select Id, Contact_Source_Organization__c, Contact_Source_Organization__r.Master_Organization__c
                                                    from Contact
                                                    where Id in :contactIdList]);
    map<Id,Id> masterAccountIdMap = new map<Id,Id>();
    
    for(Contact c: contactList){
        masterAccountIdMap.put(c.Id, c.Contact_Source_Organization__r.Master_Organization__c);
    }
    
    if(trigger.isUpdate){
        for(integer i = 0; i < trigger.new.size(); i++){
            
            if(trigger.old[i].Contact_Source_Organization__c != null){
                if(trigger.new[i].Contact_Source_Organization__c != trigger.old[i].Contact_Source_Organization__c){
                    Contact con = new Contact(Id = trigger.new[i].Id);
                    con.AccountId = masterAccountIdMap.get(con.Id);
                    contactsToUpdate.add(con);
                }
            }/*else{
                Contact con = new Contact(Id = trigger.new[i].Id);
                con.AccountId = masterAccountIdMap.get(con.Id);
                contactsToUpdate.add(con);
                }*/
        }
    }
    
    if(trigger.isInsert){
        for(integer i = 0; i < trigger.new.size(); i++)
        {
            if(trigger.new[i].Contact_Source_Organization__c != null)
            {
               Contact con = new Contact(Id = trigger.new[i].Id);
               con.AccountId = masterAccountIdMap.get(con.Id);
               contactsToUpdate.add(con);
             }
        }
    }
    
    update contactsToUpdate;    

}