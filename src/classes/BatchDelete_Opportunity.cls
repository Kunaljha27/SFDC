global class BatchDelete_Opportunity implements Database.Batchable<sObject> {
   public String query;
 
   global Database.QueryLocator start(Database.BatchableContext BC){
   query = 'SELECT Id FROM Delete_Opportunity__c';
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
      delete scope;
      
      
   }

   global void finish(Database.BatchableContext BC){
              
        
   }
}