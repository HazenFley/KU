public class LightningTreeTwoObjectController {    
    @AuraEnabled
    public static List<sObject> getParentWithChildren(String ParentObj, String ChildObj, String ParentObjNameField, String ChildObjNameField, String WhereField, String WhereValue)    {
        String query = 'SELECT ' + ParentObjNameField + ', (SELECT  ' + ChildObjNameField + ' FROM ' + ChildObj + ') FROM ' + ParentObj + ' WHERE ' + WhereField + ' = \'' + WhereValue + '\'';
        return (List<sObject>)Database.query(query);
    }
}