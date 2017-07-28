/**
* @ClassName : M2O_CaptureDeleteRecordsDAOTest
* @Description : 
* @Author : Bindesh K
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_CaptureDeleteRecordsDAOTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_insertDeletedRecord() {
        list<Delete_Notifications__c> listDeleteRecord;
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            listDeleteRecord= M2O_CaptureDeleteTestDataUtility.getListOfDeleteNotification();
            insert listDeleteRecord;
            M2O_CaptureDeleteRecordsDAO.insertDeletedRecord(listDeleteRecord);
            System.assertNotEquals(listDeleteRecord,null);
            test.stoptest(); 
        }
   }  
}