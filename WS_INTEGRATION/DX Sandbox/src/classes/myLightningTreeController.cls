public class myLightningTreeController {
    @AuraEnabled
    public static List<HierarchyData> findHierarchyData(string currentRecordId, string sObjectName, string parentField, string labelField, String whereField, String whereValue){
        //Use wrapper class to set return list
        List<HierarchyData> returnValue = new List<HierarchyData>();
        
        //Basic query, to be modified by the where clause
        string queryString = 'select id, '+labelField+ ' ,' +parentField+ ' from '+sObjectName;
        List<sObject> queryOutput = new List<sObject>();        
        
        //Modify where clause based on given variables        
        if(String.isNotBlank(whereField) || String.isNotEmpty(whereField)){
            String finalQueryString = queryString+ ' where '+whereField+' = \''+whereValue+'\' ORDER BY '+parentField +'  Limit 1000';
            queryOutput = database.query(finalQueryString);
        } else {
            queryOutput = topParent(currentRecordId, sObjectName, parentField, labelField);            
        }
        
        System.debug('query Output = ' + queryOutput);
        
        //Loop through the values
        Integer level = 0;
        for(sObject so: queryOutput){
            HierarchyData ss = new HierarchyData();
            if(so.get('id') == currentRecordId /*|| level == 0*/){
                ss.expanded = true;
                //This next line is where I am trying to modify the name.
                so.put('name', so.get('name')+': Current Record');
            }else{
                ss.expanded = false;
            }
            ss.rec = so;
            returnValue.add(ss);
            level++;
        }
        
        //return values to the component
        system.debug('**********returnValue:'+returnValue);
        return returnValue;
    }
    
    //Find the top most element in Hierarchy, return id --------------------------------------
    public static List<sObject> topParent(string currentRecordId, string sObjectName, string parentField, String labelField){
        System.debug('topParent method running....');
        
        //Get all records into a list
        List<sObject> allRecords = Database.query('SELECT id, ' +parentField+ ', ' +labelField+ ' FROM ' +sObjectName + ' LIMIT 100');
        System.debug('allRecords = ' + allRecords);
        
        Set<id> hierarchyIDs = new Set<id>();
        Set<id> newIDs = new Set<id>();
        hierarchyIDs.add(currentrecordId);
        newIDs.add(currentrecordId);
        
        
        Integer count = 1;
        while(count < 21/*!newIDs.isEmpty()*/){
            //newIDs.clear();
            for(sObject s: allRecords){
                id sid = s.id;
                id parentValue = (id)s.get(parentField);
                
                if(hierarchyIDs.contains(parentValue) && !hierarchyIDs.contains(sid)){
                    hierarchyIDs.add(sid);
                    newIDs.add(sid);
                }
                
                if(!hierarchyIDs.contains(parentValue) && hierarchyIDs.contains(sid) && String.isNotBlank(parentValue)){
                    hierarchyIDs.add(parentValue);
                    newIDs.add(parentValue);
                }
                
                System.debug('newIDs = ' + newIDs);
            }
            
            count++;
        }
        
        System.debug('hierarchyIDs = ' + hierarchyIDs);
        
        //Set variable we want returned        
        List<sObject> Hierarchy = new List<sObject>();
        
        //Loop through again to put full hierarchy in list
        Integer counter = 0;        
        for(sObject o: allRecords){           
            if(hierarchyIDs.contains(o.id)){
                System.debug('Hierarchy record found! id = ' + o.id);
                Hierarchy.add(allRecords[counter]);
            }
            counter++;
        }
        
        System.debug('Hierarchy = ' + Hierarchy);
        return Hierarchy;        
    }
    
    //Wrapper class---------------------------------------------------------------------------
    public class HierarchyData{
        @AuraEnabled
        public sObject rec{get;set;}
        @AuraEnabled
        public boolean expanded{get;set;}
        public HierarchyData(){
            expanded = true;
        }
    }
    
    
}