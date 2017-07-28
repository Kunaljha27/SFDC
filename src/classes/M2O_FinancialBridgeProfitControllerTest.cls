/**
* @ClassName : M2O_FinancialBridgeProfitControllerTest 
* @Description : This test class of M2O_FinancialBridgeProfit_Controller 
* @Author : Srutadeba Chanda
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialBridgeProfitControllerTest{ 

/* 
  * @Description : This test method covers the editGrid() method of M2O_FinancialBridgeProfitController class 
  */
    @isTest static void test_EditGrid(){
       Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();

            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeList;

            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
          
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_FinancialBridgeProfitController  controllerClassTest= new M2O_FinancialBridgeProfitController(controller);
             test.starttest();
             controllerClassTest.editGrid();
             system.assertEquals(strategicAccountPlanTest.name,'Test');
             test.stoptest();
        }
   
    }
    
       
     /* 
      * @Description : This test method covers the CancelGrid() method of M2O_FinancialBridgeProfitController class 
     */
    @isTest static void test_CancelGrid(){
       Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName = 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
            strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;

            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeList;

            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
           
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_FinancialBridgeProfitController  controllerClassTest= new M2O_FinancialBridgeProfitController(controller);
            test.starttest();
            controllerClassTest.cancelGrid();
            system.assertEquals(strategicAccountPlanTest.name,'Test');
            test.stoptest();
        }
   
    }
    
     /* 
      * @Description : This test method covers the SaveGrid() method of M2O_FinancialBridgeProfitController class 
     */      
      
    
      @isTest static void test_SaveData(){
       Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordTest;
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeList;

            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
            
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_FinancialBridgeProfitController  controllerClassTest= new M2O_FinancialBridgeProfitController(controller);
            test.starttest();
            controllerClassTest.saveData();
            system.assertEquals(finBridgeList[0].Quarter__c,'AOP');
            test.stoptest();
        }
    }
}