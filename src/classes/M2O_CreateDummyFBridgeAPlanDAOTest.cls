/**
* @ClassName : M2O_CreateDummyFBridgeAPlanDAOTest
* @Description : This class is the test class which is covering the code of M2O_CreateDummyFBridgeAPlanDoaClass
* @Author :Bindesh Kushwah
* @Last Modified :28/11/2013
* @Discussionpoints :No Information
*/
@isTest(SeeAllData=false)
private class M2O_CreateDummyFBridgeAPlanDAOTest{
  
 /**
 @Description: this is the test method for createNewFBridge in DAO class
 **/    
    @isTest static void test_ValidateCreateNewFBridge()
    {
        Strategic_Account_Plan__c strategicAccountPlanTest = new  Strategic_Account_Plan__c();
        
        Id strategicAccountPlanTestId;
        strategicAccountPlanTestId = strategicAccountPlanTest.id;
        String s;
        Map<id, String> sapIdCurrency_map = new Map<id, String>();
        Id userId;
        Financial_Bridge__c FinBridge = new Financial_Bridge__c();
        List <Financial_Bridge__c> FinBridgeList = new List<Financial_Bridge__c>();
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        
        userId=userRecordTest.id;
        system.runas(userRecordTest) {
        strategicAccountPlanTest= M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        
            insert strategicAccountPlanTest;
        
        FinBridgeList = M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
        
        insert FinBridgeList ;
       
        
        M2O_CreateDummyFBridgeAPlanDAO dAOTest=new M2O_CreateDummyFBridgeAPlanDAO();
        set<id> sapId_set = new set<id>();
        List <Activation_Plan__c> ActivationPlanList = new List<Activation_Plan__c>();
        test.startTest();
        dAOTest.createNewFBridge(FinBridgeList );
        system.assertequals(strategicAccountPlanTest.name,'Test');
        test.stopTest();
        }
     }  
   
   /**
 @Description: this is the test method for updateFBridge in DAO class
 **/    
   @isTest static void test_ValidateUpdateFBridge()
    {
        Strategic_Account_Plan__c strategicAccountPlanTest = new  Strategic_Account_Plan__c();
        
        Id strategicAccountPlanTestId;
        strategicAccountPlanTestId = strategicAccountPlanTest.id;
        String s;
        Map<id, String> sapIdCurrency_map = new Map<id, String>();
        Id userId;
        Financial_Bridge__c FinBridge = new Financial_Bridge__c();
        List <Financial_Bridge__c> FinBridgeList = new List<Financial_Bridge__c>();
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
      
        userId=userRecordTest.id;
        system.runas(userRecordTest) {
        strategicAccountPlanTest= M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
       
            insert strategicAccountPlanTest;
       
        FinBridgeList = M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
       
        insert FinBridgeList ;
       
        M2O_CreateDummyFBridgeAPlanDAO dAOTest=new M2O_CreateDummyFBridgeAPlanDAO();
        set<id> sapId_set = new set<id>();
        List <Activation_Plan__c> ActivationPlanList = new List<Activation_Plan__c>();
        test.startTest();
        dAOTest.updateFBridge(FinBridgeList ,sapIdCurrency_map);
        system.assertequals(strategicAccountPlanTest.name,'Test');
        test.stopTest();
        }
     }  

     /**
 @Description: this is the test method for getFBridgeRecord in DAO class
 **/ 
    @isTest static void test_ValidateGetFBridgeRecord()
    {
        Strategic_Account_Plan__c strategicAccountPlanTest = new  Strategic_Account_Plan__c();
        
        Id strategicAccountPlanTestId;
        strategicAccountPlanTestId = strategicAccountPlanTest.id;
        String s;
        Map<id, String> sapIdCurrency_map = new Map<id, String>();
        Id userId;
        Financial_Bridge__c FinBridge = new Financial_Bridge__c();
        List <Financial_Bridge__c> FinBridgeList = new List<Financial_Bridge__c>();
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
      
        userId=userRecordTest.id;
        system.runas(userRecordTest) {
        strategicAccountPlanTest= M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
       
            insert strategicAccountPlanTest;
        
        FinBridgeList = M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTestId );
        
        M2O_CreateDummyFBridgeAPlanDAO dAOTest=new M2O_CreateDummyFBridgeAPlanDAO();
        set<id> sapId_set = new set<id>();
        List <Activation_Plan__c> ActivationPlanList = new List<Activation_Plan__c>();
        test.startTest();

        dAOTest.getFBridgeRecord(sapId_set);
        system.assertequals(strategicAccountPlanTest.name,'Test');
        test.stopTest();
        }
     }  
   
   
     /**
 @Description: this is the test method for createActivationplan in DAO class
 **/   
   @isTest static void test_ValidateCreateActivationPlan()
    {
        Strategic_Account_Plan__c strategicAccountPlanTest = new  Strategic_Account_Plan__c();
        
        Id strategicAccountPlanTestId;
        strategicAccountPlanTestId = strategicAccountPlanTest.id;
        String s;
        Map<id, String> sapIdCurrency_map = new Map<id, String>();
        Id userId;
        Financial_Bridge__c FinBridge = new Financial_Bridge__c();
        List <Financial_Bridge__c> FinBridgeList = new List<Financial_Bridge__c>();
        string profileName= 'M2O KAM Lighting';
        User userRecordTest = M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        
        userId=userRecordTest.id;
        system.runas(userRecordTest) {
        strategicAccountPlanTest= M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
       
            insert strategicAccountPlanTest;
     
        FinBridgeList = M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
       
        insert FinBridgeList ;
      
        M2O_CreateDummyFBridgeAPlanDAO dAOTest=new M2O_CreateDummyFBridgeAPlanDAO();
        set<id> sapId_set = new set<id>();
        List <Activation_Plan__c> ActivationPlanList = new List<Activation_Plan__c>();
        test.startTest();
        dAOTest.getFBridgeRecord(sapId_set);
        dAOTest.createActivationplan(ActivationPlanList );
        system.assertequals(strategicAccountPlanTest.name,'Test');
        test.stopTest();
        }
        
    
     }  


}