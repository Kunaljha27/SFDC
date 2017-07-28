/**
@Classname :       M2O_CreateDummyRecordsTest
@Description :     This test class is written to test the Apex class M2O_CreateDummyRecords. 
@Author:           Ramita
@Last Modified:    9/17/2013
**/
@isTest(SeeAllData=false)
public class M2O_CreateDummyRecordsTest {

    /** @Description : This test method is used cover the createDummyRecordsForOpportunity method of M2O_CreateDummyRecords class
        @Return type: void 
    **/
    
    static TestMethod void Test_createDummyRecordsForOpportunity(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            M2O_CreateDummyRecords.createDummyRecordsForOpportunity(opp.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_createPrivateDummyRecordsForOpportunity(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            M2O_CreateDummyRecords.createPrivateDummyRecordsForOpportunity(opp.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_createPrivateDummyRecordsForAccount(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            M2O_CreateDummyRecords.createPrivateDummyRecordsForAccount(acc.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_createDummyRecordsForDSR(){
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
            dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            Test.startTest();
            insert dsr;
            M2O_CreateDummyRecords.createDummyRecordsForDSR(dsr.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_createPrivateDummyRecordsForContact(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            List<Contact> conRecord = M2O_AccountContactTestDataUtility.getContactRecord(); 
            insert conRecord[0];
            M2O_CreateDummyRecords.createPrivateDummyRecordsForContact(conRecord[0].id);
            test.stopTest();
        }
    }

static TestMethod void Test_createPrivateDummyRecordsForDSR(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
            dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            insert dsr;
            M2O_CreateDummyRecords.createPrivateDummyRecordsForDSR(dsr.id);
            test.stopTest();
        }
    }
}