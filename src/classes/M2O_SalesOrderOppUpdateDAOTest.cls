/**
* @ClassName : M2O_SalesOrderOppUpdateServiceTest
* @Description : 
* @Author : Vishal Kashyap
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_SalesOrderOppUpdateDAOTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_updateOpportunity() {
        Account testAccount = new Account();        
        List<Opportunity> testOpportunity = new List<Opportunity>();
        User userRecordTest = M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount ;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert testOpportunity ;
            M2O_SalesOrderOppUpdateDAO.updateOpportunity(testOpportunity);
            test.stoptest(); 
            testOpportunity[0].name=null;
            M2O_SalesOrderOppUpdateDAO.updateOpportunity(testOpportunity);
        }
        
   }
   public static testMethod void test_getOpportunityData() {
       Account testAccount = new Account(); 
       List<Opportunity> testOpportunity = new List<Opportunity>();
       set<Id> opptyId = new set<Id>();
        User userRecordTest = M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount ;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert testOpportunity ;            
            opptyId.add(testOpportunity[0].Id);
            M2O_SalesOrderOppUpdateDAO.getOpportunityData(opptyId);
            test.stoptest(); 
        }
   } 
   public static testMethod void test_getOpportunitySalesOrderData() {
       Account testAccount = new Account(); 
       List<Opportunity> testOpportunity = new List<Opportunity>();
       set<Id> opptyId = new set<Id>();
        User userRecordTest = M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount ;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert testOpportunity ;            
            opptyId.add(testOpportunity[0].Id);
            M2O_SalesOrderOppUpdateDAO.getOpportunitySalesOrderData(opptyId);
            test.stoptest(); 
        }
   }  
    
}