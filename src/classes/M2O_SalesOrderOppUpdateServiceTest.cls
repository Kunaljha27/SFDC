/**
* @ClassName : M2O_SalesOrderOppUpdateServiceTest
* @Description : 
* @Author : Vishal Kashyap
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_SalesOrderOppUpdateServiceTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_opportunityStatusToOrderBookedForLI() {
        Account testAccount = new Account();        
        Opportunity testOpportunity = new Opportunity();
        list<sales_order__c> testSalesOrder = new list<sales_order__c>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecord(testAccount.ID);
            insert testOpportunity;
            testSalesOrder = M2O_CaptureDeleteTestDataUtility.getSalesOrder(testOpportunity.ID);
            //insert testSalesOrder;
            M2O_SalesOrderOppUpdateService.opportunityStatusToOrderBookedForLI(testSalesOrder);
            test.stoptest(); 
        }
   }  
   public static testMethod void test_opportunityStatusToOrderBookedForHC() {
        Account testAccount = new Account();        
        Opportunity testOpportunity = new Opportunity();
        list<sales_order__c> testSalesOrder = new list<sales_order__c>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecord(testAccount.ID);
            insert testOpportunity;
            testSalesOrder = M2O_CaptureDeleteTestDataUtility.getSalesOrder(testOpportunity.ID);
            insert testSalesOrder;
            M2O_SalesOrderOppUpdateService.opportunityStatusToOrderBookedForHC(testSalesOrder);
            test.stoptest(); 
        }
   }  
}