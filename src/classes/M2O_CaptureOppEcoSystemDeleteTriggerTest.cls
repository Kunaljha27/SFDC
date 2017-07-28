/**
* @ClassName : M2O_CaptureOppEcoSystemTriggerTest
* @Description : 
* @Author : Vishal Kashyap
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=true)
private class M2O_CaptureOppEcoSystemDeleteTriggerTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_captureOpportunityEcoSystemDelete() {
        list<Opportunity> listOpportunityRecord;
        list<Account> listAccountRecord;
        list<Opportunity_Ecosystem__c> listOpportunityEcoSystem;
        
        Set<ID> oppIDList = new Set<ID>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        //insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            listAccountRecord =  M2O_CaptureDeleteTestDataUtility.getListAccountRecord();
            insert listAccountRecord;
            listOpportunityRecord = M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(listAccountRecord[0].ID);
            insert listOpportunityRecord;
            listOpportunityEcoSystem = M2O_CaptureDeleteTestDataUtility.getListOfOptyEcosystem(listOpportunityRecord,listAccountRecord);
            
            insert listOpportunityEcoSystem;
            delete listOpportunityEcoSystem;
            System.assertNotEquals(listOpportunityRecord,null);
            test.stoptest(); 
        }
    }  
  
}