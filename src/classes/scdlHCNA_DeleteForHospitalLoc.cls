global class scdlHCNA_DeleteForHospitalLoc implements Schedulable {
   set<Id> accountIdSet= new set<Id>();
   
   public scdlHCNA_DeleteForHospitalLoc(Set<Id>acctIdSet) {
       accountIdSet= acctIdSet.Clone();
          
   }
   global void execute(SchedulableContext SC) {
      HCNA_DeleteForHospitalLoc batchUpdate= new HCNA_DeleteForHospitalLoc(accountIdSet); 
       Database.executeBatch(batchUpdate,200);
   }
}