/**
* @ClassName : 
* @Description : M2O_SalesOrderOppUpdateTest
* @Author : Vishal Kashyap
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
private class M2O_SalesOrderOppUpdateTriggerTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_salesOrderOppUpdateTrigger() {
        List<M2O_ST_Visibility_Objects__c> soCustomSet= new List<M2O_ST_Visibility_Objects__c> ();
        Account testAccount = new Account();        
        Opportunity testOpportunity = new Opportunity();
        list<sales_order__c> testSalesOrder = new list<sales_order__c>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        System.runAs(userRecordTest) { 
            test.starttest();
            soCustomSet = M2O_OpportunityTestDataUtility.getSTVisibilityObjects();
            insert soCustomSet;
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecord(testAccount.ID);
            insert testOpportunity;
            testSalesOrder = M2O_CaptureDeleteTestDataUtility.getSalesOrder(testOpportunity.ID);
            Database.insert(testSalesOrder);
            test.stoptest(); 
        }
   }  
}