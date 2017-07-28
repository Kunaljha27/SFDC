global class HCNA_UpdateForStrgcAccPlnHierarchy implements Database.Batchable<sObject> {
    Public set<id>accountIdSet = new set<id>();
    Public Set<Id> setOfAccountIdForHierarchyChange = New Set<Id>();
    Public Map<Id,Account> mapOfHierarchyChangedParentAccounts=new Map<Id,Account>();
    Public Map<Id,Account> mapOfAccountIdAndAccountForHierarchyChange;
    Public  List<Strategic_Account_Plan__c> listOfStrategicAccountPlan = New  List<Strategic_Account_Plan__c>();  
    HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
    Public HCNA_UpdateForStrgcAccPlnHierarchy (Set<ID>accIdSet) {
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
        mapOfHierarchyChangedParentAccounts = serviceClass.retrieveMapOfParentAccounts(accountIdSet);
        setOfAccountIdForHierarchyChange = serviceClass.retriveSetOfConsolidatedAccountIds(mapOfHierarchyChangedParentAccounts);
        mapOfAccountIdAndAccountForHierarchyChange = New Map<Id, Account>([Select Id from Account where Id in: setOfAccountIdForHierarchyChange]);
        listOfStrategicAccountPlan = serviceClass.retrieveListOfStrategicAccountPlanForChangedHierarachy(mapOfAccountIdAndAccountForHierarchyChange.values(),setOfAccountIdForHierarchyChange); 
        if(!(listOfStrategicAccountPlan.isEmpty())) { 
             serviceClass.updateStrategicAccountPlan(listOfStrategicAccountPlan);
        }
    }
    global void finish(Database.BatchableContext BC) {   
    }
}