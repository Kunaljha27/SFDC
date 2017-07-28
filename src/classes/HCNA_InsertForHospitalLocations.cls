global class HCNA_InsertForHospitalLocations implements Database.Batchable<sObject> {
    Public set<id>accountIdSet = new set<id>();
    Public Set<Id> setOfParentAccountsId = New Set<Id>();
    Public Map<Id,Account> mapOfParentAccounts=new Map<Id,Account>();
    Public  Set<Id> setOfConsolidatedAccountIds = New Set<Id>();
    Public Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan = New Map<Id, list<Strategic_Account_Plan__c>>();
    Public List<Hospital_Locations__c> listOfHospitalLocationsRecordsToInsert = New List<Hospital_Locations__c>();  
    HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
    Public HCNA_InsertForHospitalLocations (Set<ID>accIdSet) {
        accountIdSet=accIdSet.Clone();
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
         return Database.getQueryLocator([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: accountIdSet]);
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
         Set<Id> tempInsideLoop;
        List<Account> listOfParentAccounts = New List<Account>();
        Set<Id> tempSet;
        tempSet = accountIdSet;
        Boolean top= false;
        while(!top) {
            listOfParentAccounts=scope;
            tempInsideLoop = New Set<Id>();
            if((listOfParentAccounts!= null) && !(listOfParentAccounts.isEmpty())) {
                for(Account parentAccount: listOfParentAccounts) {
                    if(parentAccount.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                        tempInsideLoop.add(parentAccount.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c);
                    }
                }
            }
            if(!(tempInsideLoop.isEmpty())) {
                accountIdSet.addall(tempInsideLoop);
                tempSet = tempInsideLoop;
            }
            else {
                top = true;
            }            
        } 
        mapOfParentAccounts = serviceClass.retrieveMapOfParentAccounts(accountIdSet);   
        setOfConsolidatedAccountIds = serviceClass.retriveSetOfConsolidatedAccountIds(mapOfParentAccounts);
        mapOfStrategicAccountPlan = serviceClass.getListOfStrategicAccountPlan(setOfConsolidatedAccountIds);
        listOfHospitalLocationsRecordsToInsert = serviceClass.getListOfHospitalLocationsRecordsToInsert(Trigger.new,mapOfParentAccounts,mapOfStrategicAccountPlan);
        if(!(listOfHospitalLocationsRecordsToInsert.isEmpty())) {
            serviceClass.insertListOfHospitalLocationsRecords(listOfHospitalLocationsRecordsToInsert);
        }
    }
     global void finish(Database.BatchableContext BC) {   
    }
}