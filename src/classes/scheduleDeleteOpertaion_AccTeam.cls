global class scheduleDeleteOpertaion_AccTeam implements Schedulable {


global void execute(SchedulableContext SC) {
    
   
    BatchDelete_AccountTeam BATDel = new BatchDelete_AccountTeam();
    Database.executeBatch(BATDel);
    

}

}