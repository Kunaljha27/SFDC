/**
* @ClassName     : M2O_SchedulerUpdateForAccountTeam
* @Description   : This scheduler class schedules BatchUpdateAccountHasAccTeamMember batch class to run at particular intervals to check for updated Account Team member.
* @Author        : Srutadeba Chanda
* @Last Modified : 16/12/2013
* @Discussionpoints :No Information
**/
global class M2O_SchedulerUpdateForAccountTeam implements Schedulable {
  
   /**
   @Description : This Method is used to execute the batch class M20_BatchUpdateAccountHasAccTeamMember
   @Return      : None
   **/ 
   
    global void execute(SchedulableContext SC) {
         M2O_BatchUpdateAccountHasAccTeamMember scheduleBatch= new M2O_BatchUpdateAccountHasAccTeamMember();
         Id batchprocessid = Database.executeBatch(scheduleBatch, 100);
    }
}