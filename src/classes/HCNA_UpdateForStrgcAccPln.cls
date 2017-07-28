global class HCNA_UpdateForStrgcAccPln implements Database.Batchable<sObject> {
    Public set<id>setOfAccountId = new set<id>();
    HCNA_GSPTriggerDAOClass dAOHelper= new HCNA_GSPTriggerDAOClass();
    public List<Account> listOfTriggerRecords = new List<Account>();
    public Map<Id, Account> mapOfAccountIdAndAccount= new Map<Id, Account>();
    
    Public HCNA_UpdateForStrgcAccPln (List<Account> listOfTriggerRecordsFrmTrig,Map<Id, Account> mapOfAccountIdAndAccountFromTrig,Set<Id> setOfAccountIdFrmTrig) {
        mapOfAccountIdAndAccount= mapOfAccountIdAndAccountFromTrig.deepClone();
        setOfAccountId= setOfAccountIdFrmTrig.Clone();
        listOfTriggerRecords= listOfTriggerRecordsFrmTrig.deepClone();
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
         try{
            if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isempty())) { 
                return Database.getQueryLocator([select Id,Account__c,Ehr_Vendor__c,Primary_Location_HQ__c,
                Key_Geographies__c,Parent_Account_lookup__c from Strategic_Account_Plan__c where Account__c In:listOfTriggerRecords]);
                
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
     
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlanToUpdate=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfFinalStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        listOfStrategicAccountPlan = scope;
         if((listOfStrategicAccountPlan!= null) && !(listOfStrategicAccountPlan.isEmpty())) {   
            for(Strategic_Account_plan__c straregicAccountPlanRecord: listOfStrategicAccountPlan ) {
                if(straregicAccountPlanRecord.Account__c != null) {
                    Account accountInformation= (mapOfAccountIdAndAccount.get(straregicAccountPlanRecord.Account__c));
                    straregicAccountPlanRecord.Parent_Account_lookup__c = accountInformation.Parent_IDN_of_Associated_IDN__c;
                    straregicAccountPlanRecord.Primary_Location_HQ__c = accountInformation.Region__c;
                    straregicAccountPlanRecord.EHR_Vendor__c = accountInformation.EHR_Vendor__c;
                    listOfStrategicAccountPlanToUpdate.add(straregicAccountPlanRecord);
                }   
            }
        }
        if((listOfStrategicAccountPlanToUpdate != null) && !(listOfStrategicAccountPlanToUpdate.isEmpty())) {
            listOfFinalStrategicAccountPlan.addall(listOfStrategicAccountPlanToUpdate);    
        }
        dAOHelper.updateStrategicAccountPlan(listOfFinalStrategicAccountPlan);
     
    }
    global void finish(Database.BatchableContext BC) {   
    }
}