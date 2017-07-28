/**
@Classname :       M2O_CreateDummyRecordsDAOTest
@Description :     This test class is written to test the Apex class M2O_CreateDummyRecordsDAO. 
@Author:           Ramita
@Last Modified:    9/17/2013
**/
@isTest(SeeAllData=false)
public class M2O_CreateDummyRecordsDAOTest {
    
    
    static TestMethod void test_insertRelatedAttachments(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            test.startTest();
            List<Related_Attachments_Record__c> relatedRecordsList = M2O_RelatedPrivateAttachmentsUtility.getRelatedAttRecords(opp);
            insert relatedRecordsList;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.insertRelatedAttachments(relatedRecordsList);
            test.stopTest();
        }
    }
    
    static TestMethod void test_insertDSRRelatedAttachments(){
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
            dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            Test.startTest();
            insert dsr;
            List<DSR_Related_Attachments_Record__c> dsrRelatedRecordsList = M2O_RelatedPrivateAttachmentsUtility.getDSRRelatedAttRecords(dsr);
            insert dsrRelatedRecordsList;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.insertDSRRelatedAttachments(dsrRelatedRecordsList);
            test.stopTest();
        }
    }
    
    static TestMethod void test_insertPrivateAttachments(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            test.startTest();
            List<Private_Attachments_Record__c> opr = M2O_RelatedPrivateAttachmentsUtility.getPrivateOppRecords(opp);
            insert opr;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.insertPrivateAttachments(opr);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_fetchOpportunityRecord(){
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
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.fetchOpportunityRecord(opp.id);
            daoClassObj.fetchOpportunityRecord(acc.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_updateOpportunityRecords(){
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
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.updateOpportunityRecords(opp);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_fetchAccountRecord(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.fetchAccountRecord(acc.id);
            daoClassObj.fetchAccountRecord(regionData.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_updateAccountRecords(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.updateAccountRecords(acc);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_fetchContactRecord(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            List<Contact> conRecord = M2O_AccountContactTestDataUtility.getContactRecord(); 
            insert conRecord[0];
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.fetchContactRecord(conRecord[0].id);
            daoClassObj.fetchContactRecord(regionData.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_updateContactRecords(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            List<Contact> conRecord = M2O_AccountContactTestDataUtility.getContactRecord(); 
            insert conRecord[0];
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.updateContactRecords(conRecord[0]);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_fetchDSRRecord(){
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
            dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            Test.startTest();
            insert dsr;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.fetchDSRRecord(dsr.id);
            daoClassObj.fetchDSRRecord(m2oSystemAdminUser.id);
            test.stopTest();
        }
    }
    
    static TestMethod void Test_updateDSRRecords(){
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
            dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            Test.startTest();
            insert dsr;
            M2O_CreateDummyRecordsDAO daoClassObj = new M2O_CreateDummyRecordsDAO();
            daoClassObj.updateDSRRecords(dsr);
            test.stopTest();
        }
    }
}