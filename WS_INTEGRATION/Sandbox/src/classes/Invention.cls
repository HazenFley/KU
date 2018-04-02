public class Invention {
    
    //Apex Method - getNextTrackCode
    public void getNextTrackCode(Invention__c[] newInv){
        
        //Set specific fields
        integer currentFYLastTwo;
        string spacer;
        string newName;
        integer nextNum;
        Integer currentFY;
        Date today = system.today();
        
        //Metadata
        List<Configuration__mdt> campusLetters = [SELECT developername, masterlabel, value__c FROM Configuration__mdt WHERE type__c='CampusLetter'];
        Map<string,string> campusLetterMap = new Map<string,string>();
        for(Configuration__mdt c: campusLetters){
            campusLetterMap.put(c.masterlabel,c.value__c);
        }
        
        //Define which record types to exclude. These will be the Record Type Name
        set<string> recordtypes = new set<string>{'External Invention','Pending Disclosure'};
            
            //Get information about our Fiscal Year
            Organization orgInfo = [select FiscalYearStartMonth, UsesStartDateAsFiscalYearName from Organization
                                    where id=:Userinfo.getOrganizationId()];    
        
        //Determine the Fiscal Year for the current date
        if (today.month() >= orgInfo.FiscalYearStartMonth) {
            if (orgInfo.UsesStartDateAsFiscalYearName) {currentFY = today.year();}
            else {currentFY = today.year() + 1;}}
        else {
            if (orgInfo.UsesStartDateAsFiscalYearName) {currentFY = today.year() - 1;}
            else {currentFY = today.year();}}
        
        currentFYLastTwo = integer.valueOf(string.valueOf(currentFY).right(2));
        
        //List and Set of ID for records
        List<Invention__c> holdList = new List<Invention__c>();
        Set<id> invSet = new Set<id>();
        
        for(Invention__c a: newInv){
            holdList.add(a);
            invSet.add(a.id);                
        }        
        
        //Get a list of all inventions this FY to count
        List<Invention__c> invFY = [SELECT Id, Name, RecordType.DeveloperName, Fiscal_Year__c, Track_Code_Counter__c
                                    FROM Invention__c 
                                    WHERE (Fiscal_Year__c = :currentFYLastTwo)
                                    ORDER BY Track_Code_Counter__c DESC
                                    LIMIT 1
                                   ];
        
        if (invFY.size()>0){
            nextNum = Integer.valueOf(invFY[0].get('Track_Code_Counter__c')) + 1;
        } else {
            nextNum = 1;
        }
        
        
        
        //List of records to update
        List<Invention__c> updateList = new List<Invention__c>();
        
        //Actual work
        for(Invention__c y : holdList){         
            
            //Don't apply to excluded record types
            if( !recordtypes.contains(y.RecordType.DeveloperName)){
                
                //Set the campus letter (using custom meta data type) --better way to do it
                String campusLetter;
                if(campusLetterMap.containsKey(y.Location__c) && campusLetterMap.get(y.Location__c)!=NULL){
                    campusLetter = campusLetterMap.get(y.Location__c);
                }
                
                //set the campus letter (using explicit code)
                /*if(y.campus__c == 'Lawrence'){
                    campusLetter = 'L';
                    }
                    if(y.campus__c == 'Kansas City Med Center'){
                    campusLetter = 'M';
                    }
                    if(y.campus__c == 'Wichita'){
                    campusLetter = 'M';
                    }*/
                
                
                //Create new name --------------------------------------------------------------------
                if(nextNum<10){
                    spacer = '00';
                    newName = currentFYLastTwo + 'KU' + spacer + nextNum + campusLetter;
                    updateList.add(new Invention__c(id=y.Id,name=newName,Fiscal_Year__c=currentFYLastTwo, Track_Code_Counter__c=nextNum));
                }else
                    if(nextNum<100){
                        spacer = '0';
                        newName = currentFYLastTwo + 'KU' + spacer + nextNum + campusLetter;
                        updateList.add(new Invention__c(id=y.Id,name=newName,Fiscal_Year__c=currentFYLastTwo, Track_Code_Counter__c=nextNum));
                    }else{
                        newName = currentFYLastTwo + 'KU' + nextNum + campusLetter;
                        updateList.add(new Invention__c(id=y.Id,name=newName,Fiscal_Year__c=currentFYLastTwo, Track_Code_Counter__c=nextNum));
                    }
            }
            nextNum = nextNum + 1;
        }
        
        //Bulk insert
        if(updateList.size()>0){
            //Standard syntax, false makes it not fail the whole process on error
            Database.SaveResult[] srList = Database.update(updateList,false);
        }        
    }   
}