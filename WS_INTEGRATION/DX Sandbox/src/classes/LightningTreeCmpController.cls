public class LightningTreeCmpController {
    @AuraEnabled
    public static List<HierarchyData> findHierarchyData(string recId, string sObjectName, string parentFieldAPIname, string labelFieldAPIName, String ultimateParentField, String ultimateParentId){
        List<HierarchyData> returnValue = new List<HierarchyData>();
        string queryString = 'select id, '+labelFieldAPIName+ ' ,' +parentFieldAPIname+ ' from '+sObjectName;
        
            Integer level = 0;
        
        //Loop though all children
        List<sObject> queryOutput = new List<sObject>();
        String finalQueryString = queryString + ' where '+ultimateParentField+' = \''+ultimateParentId+'\' ORDER BY '+parentFieldAPIname +'  Limit 1000';
        System.debug('query: '+finalQueryString);
        
        queryOutput = database.query(finalQueryString);
        
        for(sObject so: queryOutput){
            HierarchyData ss = new HierarchyData();
            if(so.get('id') == recId || level == 0){
                ss.expanded = true;
            }else{
                ss.expanded = false;
            }
            ss.rec = so;
            returnValue.add(ss);
            level++;
        }

        system.debug('**********returnValue:'+returnValue);
        return returnValue;
    }
    
    // Find the top most element in Heirarchy  
    // @return objId
    public static String GetUltimateParentId( string recId, string sObjectName, string parentFieldAPIname ){
        Boolean top = false;
        while ( !top ) {
            string queryString = 'select id , ' +parentFieldAPIname+ ' from '+sObjectName + ' where Id =:recId LIMIT 1';
            system.debug('**********queryString GetUltimateParentId:'+queryString);
            sobject sb = database.query(queryString);
            
            if ( sb.get(parentFieldAPIname) != null ) {
                recId = string.valueof(sb.get(parentFieldAPIname));
            }else {
                top = true;
            }
        }
        return recId ;
    }
    
    public class HierarchyData{
        @AuraEnabled
        public sObject rec{get;set;}
        @AuraEnabled
        public boolean expanded{get;set;}
        public HierarchyData(){
            expanded = false;
        }
    }
}