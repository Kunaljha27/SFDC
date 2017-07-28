/**
@Classname :       M2O_CaptureDeleteRecordsServiceTest 
@Description :     This test class is written to cover the code of Apex class  M2O_CaptureDeleteRecordsService.
@Author:           Meeta Pramaniik
@Last Modified:    16/01/2014
**/

@isTest(SeeAllData=false)
private class M2O_CaptureDeleteRecordsServiceTest {
    /**
    @Description: This test method is written for the method captureOnDelete of M2O_CaptureDeleteRecordsService class.
    @Return:      null
    **/
    public static testMethod void test_captureOnDelete() {
    list<Opportunity> listOpportunityRecord;
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        insert userRecordTest;
        System.runAs(userRecordTest) {
            test.startTest();
            Region__c regiondata = new Region__c();
            regiondata = M2O_CaptureDeleteTestDataUtility.getRegionData();
            insert regiondata;
            List <Account> listAccount = new List<Account>();
            listAccount = M2O_CaptureDeleteTestDataUtility.getListAccountRecordCD(regiondata);
            insert listAccount;
            List <Lead> listLead = new List<Lead>();
            listLead = M2O_CaptureDeleteTestDataUtility.getLeadRecords();
            insert listLead;   
            account testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecordCD(regiondata);
            insert testAccount;
            testAccount = M2O_CaptureDeleteTestDataUtility.updateAccountRecord(userRecordTest.ID,testAccount.ID);
            listOpportunityRecord= M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert listOpportunityRecord; 
            List <Opportunity_Ecosystem__c> listOppEcoSystem = new List<Opportunity_Ecosystem__c>();
            listOppEcoSystem = M2O_CaptureDeleteTestDataUtility.getListOfOptyEcosystem(listOpportunityRecord,listAccount);
            insert listOppEcoSystem;
            M2O_CaptureDeleteRecordsService.captureOnDelete(listLead);
            M2O_CaptureDeleteRecordsService.captureOnDelete(listOpportunityRecord);
            M2O_CaptureDeleteRecordsService.captureOnDelete(listOppEcoSystem);
            test.stopTest();
            
        }
    }
}