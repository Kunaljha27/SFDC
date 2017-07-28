/**
* @ClassName : M2O_CaptureLeadDeleteTriggerTest
* @Description : 
* @Author : Bindesh K
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_CaptureLeadDeleteTriggerTest{

  /* 
  * @Description : This test method covers the  trigger
  */ 
    public static testMethod void test_captureLeadDeleteTrigger() {
        list<Lead> listLeadRecord;
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            listLeadRecord= M2O_CaptureDeleteTestDataUtility.getLeadRecords();
            insert listLeadRecord;
            delete listLeadRecord;
            System.assertNotEquals(listLeadRecord,null);
            test.stoptest(); 
        }
   }  
  
}