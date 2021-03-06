public class Lookup {

    /**
     * Returns JSON of list of ResultWrapper to Lex Components
     * @objectName - Name of SObject
     * @fld_API_Text - API name of field to display to user while searching
     * @fld_API_Val - API name of field to be returned by Lookup COmponent
     * @lim   - Total number of record to be returned
     * @fld_API_Search - API name of field to be searched
     * @searchText - text to be searched
     * */
    @AuraEnabled 
    public static String searchDB(String objectName, String fld_API_Text, String fld_API_Val, 
                                  Integer lim,String fld_API_Search,String searchText,String addlText){
        
        searchText='\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';
            
            String query;

        	if(!String.isBlank(addlText)){
                query = 'SELECT '+fld_API_Text+' ,'+fld_API_Val+' ,'+addlText+
                    ' FROM '+objectName+
                    ' WHERE '+fld_API_Search+' LIKE '+searchText+ 
                    ' LIMIT '+lim;
                                          
            } else {
                query = 'SELECT '+fld_API_Text+' ,'+fld_API_Val+
                    ' FROM '+objectName+
                    ' WHERE '+fld_API_Search+' LIKE '+searchText+ 
                    ' LIMIT '+lim;
            }
        
        
        System.debug('Query: '+query);
        List<sObject> sobjList = Database.query(query);
        List<ResultWrapper> lstRet = new List<ResultWrapper>();
        
        if(!String.isBlank(addlText)){
            for(SObject s : sobjList){
            ResultWrapper obj = new ResultWrapper();
            obj.objName = objectName;
            obj.text = String.valueOf(s.get(fld_API_Text))+' - ' + String.valueOf(s.get(addlText));
            obj.val = String.valueOf(s.get(fld_API_Val))  ;
            lstRet.add(obj);
            }
        } else {
           for(SObject s : sobjList){
            ResultWrapper obj = new ResultWrapper();
            obj.objName = objectName;
            obj.text = String.valueOf(s.get(fld_API_Text));                        
            obj.val = String.valueOf(s.get(fld_API_Val));
            lstRet.add(obj);
        	}  
        }
                                      
        
         return JSON.serialize(lstRet) ;
    }
    
    @AuraEnabled 
    public static String searchDB_Id(String objectName, String fld_API_Text, String fld_API_Val, 
                                  Integer lim,String fld_API_Search,String searchText, 
                                  String fld_API_Id, String junctionObjectName, String fld_API_Jun_Search){
        
        String junctionQuery = 'SELECT '+fld_API_Id+
            			' FROM '+junctionObjectName+
            			' WHERE '+fld_API_Jun_Search+' = \''+searchText+'\'';

        List<sObject> jobjList = Database.query(junctionQuery); 
        List<String> idList = new List<String>();
        for(sObject j:jobjList){
        	idList.add(String.valueOf(j.get(fld_API_Id)));                                  
        }
                                      
        String query = 'SELECT '+fld_API_Text+' ,'+fld_API_Val+
            			' FROM '+objectName+
            				' WHERE '+fld_API_Search+' IN :idList '+ 
            			' LIMIT '+lim;
        
        System.debug('Query: '+query);
        List<sObject> sobjList = Database.query(query);
        List<ResultWrapper> lstRet = new List<ResultWrapper>();
        
        for(SObject s : sobjList){
            ResultWrapper obj = new ResultWrapper();
            obj.objName = objectName;
            obj.text = String.valueOf(s.get(fld_API_Text)) ;
            obj.val = String.valueOf(s.get(fld_API_Val))  ;
            lstRet.add(obj);
        } 
         return JSON.serialize(lstRet) ;
    }
    
    public class ResultWrapper{
        public String objName {get;set;}
        public String text{get;set;}
        public String val{get;set;}
    }
}