global class scheduleUpdateOpprtunityOwner implements Schedulable {


global void execute(SchedulableContext SC) {
    
   
    BatchUpdateOpportunityOwner Batopp = new BatchUpdateOpportunityOwner();
    Database.executeBatch(Batopp,100);
    
    Id cronTrigId2 = sc.getTriggerId();
     System.abortJob(cronTrigId2);

}

}