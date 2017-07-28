global class scheduleDeleteOpertaion_AffAcc implements Schedulable {


global void execute(SchedulableContext SC) {
    
   
    BatchDelete_AffiliatedAccount BAADel = new BatchDelete_AffiliatedAccount();
    Database.executeBatch(BAADel);
 
     
   
}

}