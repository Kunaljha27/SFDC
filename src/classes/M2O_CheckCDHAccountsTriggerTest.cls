/**
* @ClassName : 
* @Description : M2O_CheckCDHAccountsTriggerTest
* @Author : Vishal Kashyap
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_CheckCDHAccountsTriggerTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_checkCDHAccountsTrigger() {
        Account testAccount = new Account();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        Region__c regiondata = new Region__c();
        regiondata = M2O_CaptureDeleteTestDataUtility.getRegionData();
        insert regiondata;
        testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecordCD(regiondata);
        System.runAs(userRecordTest) { 
            test.starttest();
            insert testAccount;
            test.stoptest();
        }
   }  
}