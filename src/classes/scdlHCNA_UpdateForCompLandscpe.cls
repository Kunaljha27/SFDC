global class scdlHCNA_UpdateForCompLandscpe implements Schedulable {
   Public set<id>setOfAccountId = new set<id>();
   public List<Account> listOfTriggerRecords = new List<Account>();
   public Map<Id, Account> mapOfAccountIdAndAccount= new Map<Id, Account>();
   
   public scdlHCNA_UpdateForCompLandscpe(List<Account> listOfTriggerRecordsFrmTrig,Map<Id, Account> mapOfAccountIdAndAccountFromTrig,Set<Id> setOfAccountIdFrmTrig) {
       mapOfAccountIdAndAccount= mapOfAccountIdAndAccountFromTrig.deepClone();
        setOfAccountId= setOfAccountIdFrmTrig.Clone();
        listOfTriggerRecords= listOfTriggerRecordsFrmTrig.deepClone();
   }
   global void execute(SchedulableContext SC) {
      HCNA_UpdateForCompLandscpe batchUpdate= new HCNA_UpdateForCompLandscpe(listOfTriggerRecords,mapOfAccountIdAndAccount,setOfAccountId); 
      Database.executeBatch(batchUpdate,200);
   }
}