trigger ContactUpdateOnSrcOrgUpdate on Source_Organization__c (after update) {
	
	list<Contact> contactToUpdate = new list<Contact>();
	
	list<Id> sourceAccountIDList = new list<Id>();
	
	for(Source_Organization__c s: trigger.new){
		sourceAccountIDList.add(s.Id);
	}
	
	list<Contact> contactList = new list<Contact>([select Id, Contact_Source_Organization__c
													from Contact
													where Contact_Source_Organization__c in :sourceAccountIDList]);
	
	map<Id,list<Contact>> sourceAccountContactMap = new map<Id,list<Contact>>();
	
	for(Contact c : contactList){
		if(sourceAccountContactMap.containsKey(c.Contact_Source_Organization__c)){
			sourceAccountContactMap.get(c.Contact_Source_Organization__c). add(c);
		}else{
				sourceAccountContactMap.put(c.Contact_Source_Organization__c, new List <Contact> {c});
			}	
	}
	
													
	list<Source_Organization__c> sourceAccountList = new list<Source_Organization__c>([select Id, Master_Organization__c
																						from Source_Organization__c
																						where Id in :sourceAccountIDList]);
																						
	map<Id,Id> sourceMasterAccountMap = new map<Id,Id>();
	
	for(Source_Organization__c s: sourceAccountList){
			sourceMasterAccountMap.put(s.Id, s.Master_Organization__c);
	}
	
	if(trigger.isUpdate){
		for(integer i = 0; i < trigger.new.size(); i++){
			if(trigger.old[i].Master_Organization__c != null){
				if(trigger.new[i].Master_Organization__c != trigger.old[i].Master_Organization__c){
					if(sourceAccountContactMap.containsKey(trigger.new[i].Id)){
					list<Contact> orgContact = sourceAccountContactMap.get(trigger.new[i].Id);
					for(Contact c : orgContact){
							Contact con = new Contact(Id = c.Id);
							con.AccountId = sourceMasterAccountMap.get(c.Contact_Source_Organization__c);
							contactToUpdate.add(con);
						}
					}
				}
			}else{
				list<Contact> orgContact = sourceAccountContactMap.get(trigger.new[i].Id);
				if(sourceAccountContactMap.containsKey(trigger.new[i].Id)){
					for(Contact c : orgContact){
						Contact con = new Contact(Id = c.Id);
						con.AccountId = sourceMasterAccountMap.get(c.Contact_Source_Organization__c);
						contactToUpdate.add(con);
					}
				  }
				}
			}
	}
	
	list<Interaction__c> interactionToUpdate = new list<Interaction__c>();
	list<Interaction__c> interactionList = new list<Interaction__c>([select Id, Source_Organization__c
													from Interaction__c
													where Source_Organization__c in :sourceAccountIDList]);
	
	map<Id,list<Interaction__c>> sourceAccountInteractionMap = new map<Id,list<Interaction__c>>();
	
	for(Interaction__c c : interactionList){
		if(sourceAccountInteractionMap.containsKey(c.Source_Organization__c)){
			sourceAccountInteractionMap.get(c.Source_Organization__c). add(c);
		}else{
				sourceAccountInteractionMap.put(c.Source_Organization__c, new List <Interaction__c> {c});
			}	
	}
	
	if(trigger.isUpdate){
		for(integer i = 0; i < trigger.new.size(); i++){
			if(trigger.old[i].Master_Organization__c != null){
				if(trigger.new[i].Master_Organization__c != trigger.old[i].Master_Organization__c){
					if(sourceAccountInteractionMap.containsKey(trigger.new[i].Id)){
					list<Interaction__c> orgInteraction = sourceAccountInteractionMap.get(trigger.new[i].Id);
					//if(!orgInteraction.isEmpty()){
						for(Interaction__c c : orgInteraction){
							Interaction__c con = new Interaction__c(Id = c.Id);
							con.Related_Master_Organization__c = sourceMasterAccountMap.get(c.Source_Organization__c);
							interactionToUpdate.add(con);
						}
					}
				}
			}else{
				list<Interaction__c> orgInteraction = sourceAccountInteractionMap.get(trigger.new[i].Id);
				if(sourceAccountInteractionMap.containsKey(trigger.new[i].Id)){
					for(Interaction__c c : orgInteraction){
						Interaction__c con = new Interaction__c(Id = c.Id);
						con.Related_Master_Organization__c = sourceMasterAccountMap.get(c.Source_Organization__c);
						interactionToUpdate.add(con);
					}
				}
				}
			}
	}

	update contactToUpdate;																		
	update interactionToUpdate;
}