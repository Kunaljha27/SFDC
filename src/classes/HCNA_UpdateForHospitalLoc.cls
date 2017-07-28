global class HCNA_UpdateForHospitalLoc implements Database.Batchable<sObject> {
    Public set<id>setOfAccountId = new set<id>();
    HCNA_GSPTriggerDAOClass dAOHelper= new HCNA_GSPTriggerDAOClass();
    public List<Account> listOfTriggerRecords = new List<Account>();
    public Map<Id, Account> mapOfAccountIdAndAccount= new Map<Id, Account>();
    
    Public HCNA_UpdateForHospitalLoc (List<Account> listOfTriggerRecordsFrmTrig,Map<Id, Account> mapOfAccountIdAndAccountFromTrig,Set<Id> setOfAccountIdFrmTrig) {
        mapOfAccountIdAndAccount= mapOfAccountIdAndAccountFromTrig.deepClone();
        setOfAccountId= setOfAccountIdFrmTrig.Clone();
        listOfTriggerRecords= listOfTriggerRecordsFrmTrig.deepClone();
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        if((setOfAccountId!= null) && !(setOfAccountId.isEmpty()) && (listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())) {
            return Database.getQueryLocator([select Id,Account_Id__c from Hospital_Locations__c where Account_Id__c In: listOfTriggerRecords]);
        } 
        else {
            return null;
        }      
     
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Hospital_Locations__c> listOfHospitalLocationsToUpdate = New  List<Hospital_Locations__c>();
        List<Hospital_Locations__c> listOfHospitalLocations=new List<Hospital_Locations__c>();
        List<Hospital_Locations__c> finalListOfHospitalLocations=new List<Hospital_Locations__c>();
        listOfHospitalLocations = scope;
        if((listOfHospitalLocations!= null) && !(listOfHospitalLocations.isEmpty())) {   
            for(Hospital_Locations__c hospitalLocationsRecord: listOfHospitalLocations) {
                if(hospitalLocationsRecord.Account_Id__c != null && mapOfAccountIdAndAccount.get(hospitalLocationsRecord.Account_Id__c)!=null) {
                    Account accountRecord = (mapOfAccountIdAndAccount.get(hospitalLocationsRecord.Account_Id__c));          
                    hospitalLocationsRecord.Account_Id__c = accountRecord.Id;
                    listOfHospitalLocationsToUpdate.add(hospitalLocationsRecord);
                }   
            }
        } 
        if((listOfHospitalLocationsToUpdate!= null) && !(listOfHospitalLocationsToUpdate.isEmpty())) {
            finalListOfHospitalLocations.addall(listOfHospitalLocationsToUpdate);       
        }
        dAOHelper.updateHospitalLocations(finalListOfHospitalLocations);
     
    }
    global void finish(Database.BatchableContext BC) {   
    }
}