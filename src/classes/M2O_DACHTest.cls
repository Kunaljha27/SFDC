/**
* @ClassName : M2O_DACHTest
* @Description : 
* @Author : Navaneet Pujar
* @Last Modified :
* @Discussionpoints : No Information 
*/
@isTest(seeAllData=true)
public with sharing class M2O_DACHTest {
    public static testMethod void insertSalesOrderLine() {
        Account testAccount = new Account();        
        List<Opportunity> testOpportunity = new List<Opportunity>();
        Product2 prod = new Product2();
        PricebookEntry pbe = new PricebookEntry();
        List<OpportunityLineItem> testOpptyLineItem = new List<OpportunityLineItem>();
        List<sales_order__c> testSalesOrder = new List<sales_order__c>();
        list<Sales_Order_Line__c> testSalesOrderLine = new list<Sales_Order_Line__c>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        userRecordTest.FederationIdentifier = '757875';
        insert userRecordTest;

        System.runAs(userRecordTest) { 
            test.starttest();
            testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            testOpportunity = M2O_CaptureDeleteTestDataUtility.getOpportunityRecord1(testAccount.ID);
            insert testOpportunity;
            
            prod = M2O_CaptureDeleteTestDataUtility.getProductRecord();
            insert prod; 
            
            pbe = M2O_CaptureDeleteTestDataUtility.getPBEntryRecord(prod.Id ,testOpportunity[0].currencyisocode);
            insert pbe;
            
            testOpptyLineItem = M2O_CaptureDeleteTestDataUtility.getListOfOppLineItemRecord(testOpportunity,pbe.id);
            insert testOpptyLineItem;
            
            testSalesOrder = M2O_CaptureDeleteTestDataUtility.getSalesOrder(testOpportunity[0].id);
            insert testSalesOrder;

            testSalesOrderLine = M2O_CaptureDeleteTestDataUtility.getSalesOrderLine(testSalesOrder[0]);
            insert testSalesOrderLine;

            testSalesOrderLine[0].Higher_Level_Item__c = 6;
            update testSalesOrderLine;
            
            test.stoptest(); 
        }
    }
}