/**
* @ClassName : M2O_CaptureOpportunityDeleteTriggerTest
* @Description : 
* @Author : Bindesh K
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_CaptureOpportunityDeleteTriggerTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_captureOpportunityDelete() {
        list<Opportunity> listOpportunityRecord;
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            account testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            listOpportunityRecord= M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert listOpportunityRecord;
            delete listOpportunityRecord;
            System.assertNotEquals(listOpportunityRecord,null);
            test.stoptest(); 
        }
    }  
  
}