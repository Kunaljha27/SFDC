/**
* @ClassName : M2O_BatchUpdateAccountHasAccTeamMember
* @Description : This batch class runs every day and update the account if any account team member is added in any account within last 24 hours 
* @Author : Srutadeba Chanda
* @Last Modified : 16/12/2013
* @Discussionpoints : No Information
*/
global class M2O_BatchUpdateAccountHasAccTeamMember implements Database.Batchable<sObject> {
    /**
    * @Description : start method extracts all the newly added account team member for last 24 hours 
    * @param       : Database.BatchableContext
    * @return      : Database.QueryLocator
    **/ 
    global Database.QueryLocator start(Database.BatchableContext BC){
        String queryAcountTeamList;
        Datetime currentDateTime = System.now();
        currentDateTime = currentDateTime .addDays(-1);   
        queryAcountTeamList= 'Select User.Email, Id, AccountId From AccountTeamMember where CreatedDate >= :currentDateTime' ;
        return Database.getQueryLocator(queryAcountTeamList);
    }

    /**
    * @Description : This method executes the Batch process for newly added Account Team Members and update it on associated Account
    * @param       : Database.BatchableContext and List of sObjects
    * @return      : None
    **/    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
         List<AccountTeamMember> listAccountTeamMember = (List<AccountTeamMember >)scope;
         system.debug('Team member'+listAccountTeamMember);
         try{
             if(listAccountTeamMember != Null && !listAccountTeamMember.isEmpty()){
                M2O_AccountDataQualityService.updateHasAccTeamMemberOnAccount(listAccountTeamMember );
             }
          }
          catch(Exception e){
              system.debug('Error : ' + e.getMessage());
          }   
     
    }
    
    /**
    * @Description : The Finish method is called after all batches are processed.
                     As we are doing any execute post-processing operations like sending confirmation emails, this method is left empty.
    * @param       : Database.BatchableContext
    * @return      : None
    **/
    global void finish(Database.BatchableContext BC){
    
    }
    
 }