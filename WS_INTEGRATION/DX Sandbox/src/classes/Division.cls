public class Division {
    
    public void nameDivision(Division__c[] newDivision){
        string newName;  
        
        for(Division__c div : newDivision) {
            //Sometimes cost centers are null, so set those as just the department
            if(String.isBlank(div.Cost_Center__c)){
                newName = div.Department__c;
            } else {
                newName = div.Cost_Center__c;
            }
            
            div.Name = newName;
        }        
    }    
}