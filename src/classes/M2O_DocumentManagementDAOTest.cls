/**
@Classname :       M2O_DocumentManagementDAOTest
@Description :     This test class is written to test the Apex class M2O_DocumentManagementDAO. 
@Author:           Ramita
@Last Modified:    9/24/2013
**/
@isTest(SeeAllData=false)
public class M2O_DocumentManagementDAOTest{

    static TestMethod void test_getOpptyRelatedAttachmentsRecord(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            ID exceptionID='00aB0000000Cd8q';
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            test.startTest();
            M2O_DocumentManagementDAO.getOpptyRelatedAttachmentsRecord(opp.id);
            M2O_DocumentManagementDAO.getOpptyRelatedAttachmentsRecord(exceptionID);
            test.stopTest();
        }
    }
    
    static TestMethod void test_getOpptyPrivateAttachmentsRecord(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            ID exceptionID='00aB0000000Cd8q';
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            test.startTest();
            M2O_DocumentManagementDAO.getOpptyPrivateAttachmentsRecord(opp.id);
            M2O_DocumentManagementDAO.getOpptyPrivateAttachmentsRecord(exceptionID);
            test.stopTest();
        }
    }
}