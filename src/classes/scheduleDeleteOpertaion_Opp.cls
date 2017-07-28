global class scheduleDeleteOpertaion_Opp implements Schedulable {


global void execute(SchedulableContext SC) {
    BatchDelete_Opportunity BODel = new BatchDelete_Opportunity();
    Database.executeBatch(BODel);
    
   
   
}

}