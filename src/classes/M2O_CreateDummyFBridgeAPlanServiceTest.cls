/**
* @ClassName :M2O_CreateDummyFBridgeAPlanServiceTest
* @Description This class is the test class which is covering the code of class M2O_CreateDummyFBridgeAPlanService
* @Author Bindesh K
* @Last Modified 04/12/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_CreateDummyFBridgeAPlanServiceTest{
     
 /**
 @Description: this is the test method for createActivationPlan in Service class
 **/      
    @isTest static void test_ValidateUpdateActivationPlan(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
        List<Strategic_Account_Plan__c> SAP = new List <Strategic_Account_Plan__c>();
        List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
        Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
        List<Financial_Bridge__c> financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
       
            test.starttest();
            Map<id, String> mapProductEntity = new Map<id, String>();
            Set<id> sapIdSet = new Set<id>();
            M2O_CreateDummyFBridgeAPlanService DummyFBridge_ServiceClass = new M2O_CreateDummyFBridgeAPlanService();
            DummyFBridge_ServiceClass.createActivationPlan(SAP);
            system.assertequals(strategicAccountPlanTest.name,'Test');
                      
            test.stoptest();
        }        
    }

 /**
 @Description: this is the test method for updateFinancialBridgeCurrency in Service class
 **/    
    @isTest static void test_ValidateFinancialBridgeCurrency(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
        List<Strategic_Account_Plan__c> SAP = new List <Strategic_Account_Plan__c>();
        List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
        Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
        List<Financial_Bridge__c> financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
        
        
            test.starttest();
            Map<id, String> mapProductEntity = new Map<id, String>();
            Set<id> sapIdSet = new Set<id>();
            M2O_CreateDummyFBridgeAPlanService DummyFBridge_ServiceClass = new M2O_CreateDummyFBridgeAPlanService();
            DummyFBridge_ServiceClass.updateFinancialBridgeCurrency( sapIdSet ,mapProductEntity );
            system.assertequals(strategicAccountPlanTest.name,'Test');
            test.stoptest();
        }    
    }
    
 /**
 @Description: this is the test method for createFinancialBridgeForNewSap in Service class
 **/   
   @isTest static void test_ValidateCreateFinancialBridgeForNewSap(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
        List<Strategic_Account_Plan__c> SAP = new List <Strategic_Account_Plan__c>();
        List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
        Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
        List<Financial_Bridge__c> financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
        
        
            test.starttest();
            Map<id, String> mapProductEntity = new Map<id, String>();
            Set<id> sapIdSet = new Set<id>();
            M2O_CreateDummyFBridgeAPlanService DummyFBridge_ServiceClass = new M2O_CreateDummyFBridgeAPlanService();
            DummyFBridge_ServiceClass.createFinancialBridgeForNewSap(SAP);
            system.assertequals(strategicAccountPlanTest.name,'Test');          
            test.stoptest();
        }        
    }
}