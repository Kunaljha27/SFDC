/**
* @ClassName : M2O_FinancialBridgeServiceTest
* @Description : This is the test class of M2O_FinancialBridgeService
* @Author : Srutadeba Chanda
* @Last Modified : 29/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialBridgeServiceTest{ 

  /* 
  * @Description : This test method covers the getMasterRecordSAP() method of M2O_FinancialBridgeService class 
  */ 
    @isTest static void test_GetMasterRecordSAP(){
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
             test.starttest();
             M2O_FinancialBridgeService.getMasterRecordSAP(strategicAccountPlanTestId);
             system.assertEquals(strategicAccountPlanTest.name,'Test');
             test.stoptest();
        }
        
     }
     
  /* 
  * @Description : This test method covers the getUserAccess() method of M2O_FinancialBridgeService class 
  */ 
     @isTest static void test_GetUserAccess(){
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
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
  
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
  
            Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
              test.starttest();
              M2O_FinancialBridgeService.getUserAccess(userId,strategicAccountPlanTestId);
              system.assertEquals(userRecordTest.LastName ,'User');
              test.stoptest();
        }
        
     }
     
  /* 
  * @Description : This test method covers the getFinancialBridgeList() method of M2O_FinancialBridgeService class 
  */    
     @isTest static void test_GetFinancialBridgeList(){
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
            List<Financial_Bridge__c> finBridgeListRevenue=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeListRevenue;
            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;
            
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
  
            Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
            List<Financial_Bridge__c> financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
            List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
            
             test.starttest();
             financialBridgeListQ1Q2=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(strategicAccountPlanTestId,financialBridgeRecordtype);
             financialBridgeListQ2Q3=M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(strategicAccountPlanTestId,financialBridgeRecordtype);
             system.assertEquals(finBridgeListRevenue[0].Quarter__c,'AOP');
             test.stoptest();
        }
        
     }
     
   /* 
  * @Description : This test method covers the getCurrencyValue() method of M2O_FinancialBridgeService class 
  */     
    @isTest static void test_GetCurrencyValue(){
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
           
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
            test.starttest();
            M2O_FinancialBridgeService.getCurrencyValue(strategicAccountPlanTestId);
            system.assertEquals(currencySymbol[0].name,'EUR');
            test.stoptest();
        }
        
     }
       
  /* 
  * @Description : This test method covers the saveGrid() method of M2O_FinancialBridgeService class 
  */      
     @isTest static void test_SaveGrid(){
        List<Financial_Bridge__c> financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ1Q2Profit=new List<Financial_Bridge__c>();
        List<Financial_Bridge__c> financialBridgeListQ2Q3Profit=new List<Financial_Bridge__c>();
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
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
  
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            insert currencySymbol;
            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;
            
            Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
            Id financialBridgeProfitRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Profit').RecordTypeId;
            
           
                test.starttest();
                financialBridgeListQ1Q2=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(strategicAccountPlanTestId,financialBridgeRecordtype);
                financialBridgeListQ2Q3=M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(strategicAccountPlanTestId,financialBridgeRecordtype);
                M2O_FinancialBridgeService.saveGrid(financialBridgeListQ1Q2,financialBridgeListQ2Q3,financialBridgeRecordtype);
                financialBridgeListQ1Q2Profit=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(strategicAccountPlanTestId,financialBridgeProfitRecordtype);
                financialBridgeListQ2Q3Profit=M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(strategicAccountPlanTestId,financialBridgeProfitRecordtype);
                M2O_FinancialBridgeService.saveGrid(financialBridgeListQ1Q2Profit,financialBridgeListQ2Q3Profit,financialBridgeRecordtype);
                 system.assertEquals(finBridgeList[0].Quarter__c,'AOP');
                test.stoptest();
        }
        
     }
     
  /* 
  * @Description : This test method covers the checkFinDataValidity() method of M2O_FinancialBridgeService class 
  */  
        
    @isTest static void test_CheckFinDataValidity(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;

        List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
        insert finBridgeList;
  
        List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
        insert currencySymbol;
        List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
        insert finBridgeListProfit;
        
        system.RunAs(userRecordTest) {
        test.starttest();
        M2O_FinancialBridgeService.checkValidityOfFinDataProfit(finBridgeListProfit);
        system.assertEquals(finBridgeList[0].Quarter__c,'AOP');
        test.stoptest();
        }
        
     }
     
  /* 
  * @Description : This test method covers the updateFinValue() method of M2O_FinancialBridgeService class 
  */ 
    @isTest static void test_UpdateFinValue(){
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
            List<Financial_Bridge__c> finBridgeListRevenue=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeListRevenue;
 
            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;
            Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
           
            List<Financial_Bridge__c> financialBridgeListQ2Q3=new List<Financial_Bridge__c>();
             test.starttest();
             financialBridgeListQ2Q3=M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(strategicAccountPlanTestId,financialBridgeRecordtype);
             M2O_FinancialBridgeService.updateFinValueRevenue(financialBridgeListQ2Q3);
             M2O_FinancialBridgeService.updateFinValueProfit(finBridgeListProfit);
             system.assertEquals(finBridgeListRevenue[0].Quarter__c,'AOP');
             test.stoptest();
        }
        
     }
     
    /* 
  * @Description : This test method covers the getFinancial() method of M2O_FinancialBridgeService class 
  */      
      @isTest static void test_GetFinancial(){
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
            List<Financial_Bridge__c> finBridgeListRevenue=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeListRevenue;
  
            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;
                        
            Id financialBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
            List<Financial_Bridge__c> financialBridgeListQ2Q3Revenue=new List<Financial_Bridge__c>();
            List<Financial_Bridge__c> financialBridgeListQ2Q3Profit=new List<Financial_Bridge__c>();
            
                test.starttest();
                financialBridgeListQ2Q3Revenue=M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(strategicAccountPlanTestId,financialBridgeRecordtype);
                M2O_FinancialBridgeService.getFinValueRevenue(financialBridgeListQ2Q3Revenue);
                M2O_FinancialBridgeService.getFinValueProfit(finBridgeListProfit);
                system.assertEquals(finBridgeListRevenue[0].Quarter__c,'AOP');
                test.stoptest();
        }
    }
}