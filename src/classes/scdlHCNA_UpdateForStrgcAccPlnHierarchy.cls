global class scdlHCNA_UpdateForStrgcAccPlnHierarchy implements Schedulable {
   set<Id> accountIdSet= new set<Id>();
   
   public scdlHCNA_UpdateForStrgcAccPlnHierarchy(Set<Id>acctIdSet) {
       accountIdSet= acctIdSet.Clone();
          
   }
   global void execute(SchedulableContext SC) {
      HCNA_UpdateForStrgcAccPlnHierarchy batchUpdate= new HCNA_UpdateForStrgcAccPlnHierarchy(accountIdSet); 
       Database.executeBatch(batchUpdate,200);
   }
}