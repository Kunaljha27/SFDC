/*** 
*@ClassName : HCNA_GSPSalesFunnelController_test 
*@Description : Test class for HCNA_GSPSalesFunnelController.
*@Author : Noor Ali Khan
*@Last Modified : 26/06/2014
***/
@isTest(SeeAllData=true)
public class HCNA_GSPSalesFunnelControllerTest {
    /**    
    * @Description : Test method to invoke method of HCNA_GSPSalesFunnelController class
    **/
    public static testMethod void test_HCNA_GSPSalesFunnelController() {
        Profile hcProfileId = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest = HCNA_ChartUtilityClass.getUserRecord(hcProfileId);           
        insert userRecordTest;
        System.runAs(userRecordTest){        
            Account accountRecord = new Account();
            accountRecord = HCNA_ChartUtilityClass.getAccountRecord();
            insert accountRecord;
            
            Id AccountId = accountRecord.id;
            
            Account ascAccountRecord = HCNA_ChartUtilityClass.getAssociatedAccountRecord(accountRecord);
            insert ascAccountRecord;
            system.assertNotEquals(ascAccountRecord,null);
            List<Opportunity> opportunityList = new List<Opportunity>();
            Opportunity opptyRecordUS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordUS.Business_Group_HCNA__c='US';
            opportunityList.add(opptyRecordUS);
                       
            Opportunity opptyRecordPCMS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordPCMS.Business_Group_HCNA__c='PCMS';
            opportunityList.add(opptyRecordPCMS);
            
            Opportunity opptyRecordIS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordIS.Business_Group_HCNA__c='IS';
            opportunityList.add(opptyRecordIS);
            
            Opportunity opptyRecordHISS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordHISS.Business_Group_HCNA__c='HISS';
            opportunityList.add(opptyRecordHISS);                        
            
            Opportunity opptyRecordPOS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordPOS.Business_Group_HCNA__c='POS';
            opportunityList.add(opptyRecordPOS); 
            
            insert opportunityList;
            system.assertNotEquals(opportunityList, null);
            list<OpportunityLineItem> listOpportunityLineItem = HCNA_ChartUtilityClass.getOpportunityLineItemList(opportunityList);                        
            OpportunityLineItem opportunityLineItemRecord1 =  HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordUS);
            OpportunityLineItem opportunityLineItemRecord2 =  HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordPCMS);
            OpportunityLineItem opportunityLineItemRecord3 =  HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordIS);
            OpportunityLineItem opportunityLineItemRecord4 =  HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordHISS);
            OpportunityLineItem opportunityLineItemRecord5 =  HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordPOS);
            listOpportunityLineItem.add(opportunityLineItemRecord1);
            listOpportunityLineItem.add(opportunityLineItemRecord2);
            listOpportunityLineItem.add(opportunityLineItemRecord3);
            listOpportunityLineItem.add(opportunityLineItemRecord4);
            listOpportunityLineItem.add(opportunityLineItemRecord5);
            insert listOpportunityLineItem;
            system.assertNotEquals(listOpportunityLineItem, null);
            test.starttest();                      
            PageReference pageRef = Page.HCNA_GSPSalesFunnel;
            Test.setCurrentPage(pageRef);
            HCNA_GSPSalesFunnelController gspSalesFunnelObject = new HCNA_GSPSalesFunnelController();         
            ApexPages.currentPage().getParameters().put('AccountId',AccountId);
            HCNA_GSPSalesFunnelController.loadImagingSystemsData(AccountId);
            System.assertNotEquals(HCNA_GSPSalesFunnelController.loadUltrasoundData(AccountId),null);
            HCNA_GSPSalesFunnelController.loadUltrasoundData(AccountId);
            System.assertNotEquals(HCNA_GSPSalesFunnelController.loadPCMSData(AccountId),null);
            HCNA_GSPSalesFunnelController.loadPCMSData(AccountId);        
            System.assertNotEquals(HCNA_GSPSalesFunnelController.loadHISSData(AccountId),null);
            HCNA_GSPSalesFunnelController.loadHISSData(AccountId);        
            System.assertNotEquals(HCNA_GSPSalesFunnelController.loadPOSData(AccountId),null);
            HCNA_GSPSalesFunnelController.loadPOSData(AccountId);
            System.assertNotEquals(gspSalesFunnelObject.getImagingSystemsTableData(),null);   
            System.assertNotEquals(gspSalesFunnelObject.getUltrasoundTableData(),null);   
            System.assertNotEquals(gspSalesFunnelObject.getPCMSTableData(),null);   
            System.assertNotEquals(gspSalesFunnelObject.getHISSTableData(),null);   
            System.assertNotEquals(gspSalesFunnelObject.getPOSTableData(),null);   
            test.stoptest(); 
        }
    }
}