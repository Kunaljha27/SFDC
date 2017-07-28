global class scdlHCNA_InsertForHospitalLocations implements Schedulable {
   set<Id> accountIdSet= new set<Id>();
   
   public scdlHCNA_InsertForHospitalLocations(Set<Id>acctIdSet) {
       accountIdSet= acctIdSet.Clone();
          
   }
   global void execute(SchedulableContext SC) {
      HCNA_InsertForHospitalLocations batchUpdate= new HCNA_InsertForHospitalLocations(accountIdSet); 
       Database.executeBatch(batchUpdate,200);
   }
}