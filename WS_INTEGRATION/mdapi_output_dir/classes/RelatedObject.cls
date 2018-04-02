public class RelatedObject {
        
    @AuraEnabled public String Id { get; set; }
    @AuraEnabled public String Name { get; set; }
    
    // Trivial constructor, for server-side Apex -> client-side JavaScript
    public RelatedObject(String id, String name) {
        this.Id = id;
        this.Name = name;
    }
    
    // Default, no-arg constructor, for client-side -> server-side
    public RelatedObject() {}
    
}