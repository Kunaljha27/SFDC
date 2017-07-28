global class HCNA_DeleteForHospitalLoc implements Database.Batchable<sObject> {
    Public set<id>setOfToBeDeletedIds = new set<id>();
    HCNA_GSPTriggerDAOClass dAOHelper= new HCNA_GSPTriggerDAOClass();
       
    Public HCNA_DeleteForHospitalLoc (Set<Id> setOfToBeDeletedIdsFrmTrig) {
        setOfToBeDeletedIds= setOfToBeDeletedIdsFrmTrig.Clone();        
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        if((setOfToBeDeletedIds!= null) && !(setOfToBeDeletedIds.isEmpty()) ) {
            return Database.getQueryLocator([select Id from Hospital_Locations__c where Account_Id__c In: setOfToBeDeletedIds]);
        } 
        else {
            return null;
        }      
     
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Hospital_Locations__c> listOfHospitalLocationsRecords = New  List<Hospital_Locations__c>();
        listOfHospitalLocationsRecords = scope;
        if((listOfHospitalLocationsRecords!= null) && !(listOfHospitalLocationsRecords.isEmpty())) {   
            dAOHelper.listOfHospitalLocationsRecordsToDelete(listOfHospitalLocationsRecords);    
        } 
        
        
     
    }
    global void finish(Database.BatchableContext BC) {   
    }
}