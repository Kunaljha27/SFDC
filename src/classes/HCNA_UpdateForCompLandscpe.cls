global class HCNA_UpdateForCompLandscpe implements Database.Batchable<sObject> {
    Public set<id>setOfAccountId = new set<id>();
    HCNA_GSPTriggerDAOClass dAOHelper= new HCNA_GSPTriggerDAOClass();
    public List<Account> listOfTriggerRecords = new List<Account>();
    public Map<Id, Account> mapOfAccountIdAndAccount= new Map<Id, Account>();
    
    Public HCNA_UpdateForCompLandscpe (List<Account> listOfTriggerRecordsFrmTrig,Map<Id, Account> mapOfAccountIdAndAccountFromTrig,Set<Id> setOfAccountIdFrmTrig) {
        mapOfAccountIdAndAccount= mapOfAccountIdAndAccountFromTrig.deepClone();
        setOfAccountId= setOfAccountIdFrmTrig.Clone();
        listOfTriggerRecords= listOfTriggerRecordsFrmTrig.deepClone();
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        try {
            if((setOfAccountId!= null) && !(setOfAccountId.isEmpty()) && (listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())) {
                return Database.getQueryLocator([select Id,AccountId_lookup__c,IHN_lookup__c,Consultants_Clinical__c,Consultants_IT__c,Contracting_Vendor__c,EHR_Supplier_lookup__c from Competitive_Landscape__c where AccountId_lookup__c In : listOfTriggerRecords]);
            } 
            else {
                
                return null;
            }
        }
        catch(Exception x){
           System.debug('error message' +x);
           return null;
        }   
              
     
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Competitive_Landscape__c> listOfCompetitiveLandscape=new List<Competitive_Landscape__c>();
        List<Competitive_Landscape__c> listOfCompetitiveLandscapeToUpdate=new List<Competitive_Landscape__c>();
        List<Competitive_Landscape__c> listOfFinalCompetitiveLandscape=new List<Competitive_Landscape__c>();
        listOfCompetitiveLandscape = scope;
        if((listOfCompetitiveLandscape!= null) && !(listOfCompetitiveLandscape.isEmpty())) {   
            for(Competitive_Landscape__c competitiveLandscapeRecord: listOfCompetitiveLandscape) {
                if(competitiveLandscapeRecord.AccountId_lookup__c != null) {
                    Account accountInformation= (mapOfAccountIdAndAccount.get(competitiveLandscapeRecord.AccountId_lookup__c));
                    competitiveLandscapeRecord.IHN_Lookup__c = accountInformation.IHN__c;
                    competitiveLandscapeRecord.EHR_Supplier_Lookup__c = accountInformation.EHR_Vendor__c;
                    competitiveLandscapeRecord.Consultants_Clinical__c = accountInformation.Consultants_Clinical__c;
                    competitiveLandscapeRecord.Consultants_IT__c = accountInformation.Consultants_IT__c;
                    competitiveLandscapeRecord.Contracting_Vendor__c = accountInformation.Contracting_Vendor__c;
                    listOfCompetitiveLandscapeToUpdate.add(competitiveLandscapeRecord);
                }   
            }
        }
        if((listOfCompetitiveLandscapeToUpdate!= null) && !(listOfCompetitiveLandscapeToUpdate.isEmpty())) {
            listOfFinalCompetitiveLandscape.addall(listOfCompetitiveLandscapeToUpdate);
        }
        dAOHelper.updateAccountOnCompetitiveLandscape(listOfFinalCompetitiveLandscape);
     
    }
    global void finish(Database.BatchableContext BC) {   
    }
}