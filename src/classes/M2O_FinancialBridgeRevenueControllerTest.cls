/**
* @ClassName : M2O_FinancialBridgeRevenueControllerTest
* @Description : This test class of M2O_FinancialBridgeRevenueController
* @Author : Srutadeba Chanda
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialBridgeRevenueControllerTest{ 

  /* 
  * @Description : This test method covers the editGrid() method of M2O_FinancialBridgeRevenueController class 
  */ 
    @isTest static void test_Editgrid(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName = 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId = userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
  
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
          
             ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
             Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
             M2O_FinancialBridgeRevenueController  controllerClassTest= new M2O_FinancialBridgeRevenueController(controller);
             test.starttest();
             controllerClassTest.editGrid();
             system.assertEquals(strategicAccountPlanTest.name,'Test');
             test.stoptest();
        }
    
      }
      
     /* 
      * @Description : This test method covers the CancelGrid() method of M2O_FinancialBridgeRevenueController class 
     */
      
    @isTest static void test_CancelGrid(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName = 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
  
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_FinancialBridgeRevenueController  controllerClassTest= new M2O_FinancialBridgeRevenueController(controller);
  
            test.starttest();
            controllerClassTest.cancelGrid();
            system.assertEquals(strategicAccountPlanTest.name,'Test');
            test.stoptest();
        }
    }

     /* 
      * @Description : This test method covers the SaveGrid() method of M2O_FinancialBridgeRevenueController class 
     */      
      
    @isTest static void test_SaveGrid(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName = 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId = userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
  
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_FinancialBridgeRevenueController  controllerClassTest= new M2O_FinancialBridgeRevenueController(controller);
  
            test.starttest();
            controllerClassTest.saveData();
            system.assertEquals(finBridgeList[0].Quarter__c,'AOP');
            test.stoptest();
        }
    }
}