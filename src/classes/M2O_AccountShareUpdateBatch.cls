/**
* @ClassName : M2O_AccountShareUpdateBatch
* @Description : This batch class runs every day and update the AccountShare if any ContactAccessLevel is not Private(None) 
* @Author : Navaneet Pujar
* @Last Modified : 28 May 2015
* @Discussionpoints : No Information
*/
global class M2O_AccountShareUpdateBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT RowCause FROM AccountShare WHERE ContactAccessLevel != 'None' AND RowCause IN ('Team','Owner')]);
    }

    global void execute(Database.BatchableContext BC, List<AccountShare > scope){
        List<AccountShare> accShareList = new List<AccountShare>();
        for(AccountShare accShare : scope){
            accShare.ContactAccessLevel = 'None';
            accShareList.add(accShare);
         }
         if(accShareList!=null && !accShareList.isEmpty()){
             update accShareList;
         }
    }
    global void finish(Database.BatchableContext BC){
    }
}