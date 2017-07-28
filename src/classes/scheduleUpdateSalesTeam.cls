global class scheduleUpdateSalesTeam implements Schedulable {


global void execute(SchedulableContext SC) {
    
   
    BatchUpdateSalesTeam Batopp = new BatchUpdateSalesTeam();
    Database.executeBatch(Batopp,100);
    
    Id cronTrigId2 = sc.getTriggerId();
     System.abortJob(cronTrigId2);

}

}