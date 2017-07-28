@istest
public class storeDeletedRecordofOpp_test {

Public static testMethod void StoreDeletedRecordofOpptest (){

Profile prof =[Select Id from Profile where Name = 'MDB IT Administrator' Limit 1];
    User u =  M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
    insert u;
    Region__c r = M2O_OpportunityTestDataUtility.getRegionData();
    insert r;
    
    Account acc =M2O_OpportunityTestDataUtility.getAccountRecord(r);
    acc.SourceSystem__c='Siebel';
     system.runas(u){
    insert acc;
    Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
    insert opp;
    opp.Cmr_Rep__c='test';
    update opp;
  
    test.startTest();
    delete opp;
    test.stopTest();
    }
    }
    }