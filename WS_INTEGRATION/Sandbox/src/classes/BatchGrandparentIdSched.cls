global class BatchGrandparentIdSched implements Schedulable{
    global void execute(SchedulableContext ctx) {
        BatchGrandparentId grandparentBatch = new BatchGrandparentId(); 
		Id batchId = Database.executeBatch(grandparentBatch,200);
    }
}