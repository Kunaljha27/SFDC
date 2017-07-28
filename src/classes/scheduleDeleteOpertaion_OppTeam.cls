global class scheduleDeleteOpertaion_OppTeam implements Schedulable {


global void execute(SchedulableContext SC) {
    
   
    BatchDelete_OpportunityTeam BOTDel = new BatchDelete_OpportunityTeam();
    Database.executeBatch(BOTDel);
    
   
   
}

}