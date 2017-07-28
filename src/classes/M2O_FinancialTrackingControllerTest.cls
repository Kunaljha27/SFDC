/**
* @ClassName   : M2O_FinancialTrackingControllerTest
* @Description : This class is the test class which is covering the code of M2O_FinancialTrackingController class.
* @Author      : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialTrackingControllerTest{
  /* 
  * @Description : This test method covers the Showdata() method of M2O_FinancialTrackingController class
  */
    @isTest static void test_Showdata(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        M2O_FinancialTrackingController testExecute;
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);        
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){
            strategicAccountPlanTest=M2O_FinancialTrackingTestDataUtility.insertStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            insert currencySymbol;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.Id);     
            insert finTest;

            businessType = M2O_FinancialtrackingTestDataUtility.createBT_CS();
            businessType[0].SAP_Business_Type__c = strategicAccountPlanTest.recordTypeID;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);            

            test.starttest();
            M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            testExecute = new M2O_FinancialTrackingController(controller);
            testExecute.showdata();
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }
    }
    
  /* 
  * @Description : This test method covers the EnableEditing() method of M2O_FinancialTrackingController class
  */    
     @isTest static void test_EnableEditing(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        M2O_FinancialTrackingController testExecute;
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);        
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){
            strategicAccountPlanTest=M2O_FinancialTrackingTestDataUtility.insertStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            insert currencySymbol;
            
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.Id);     
            insert finTest;
            businessType = M2O_FinancialTrackingTestDataUtility.createBT_CS();
            businessType[0].SAP_Business_Type__c = strategicAccountPlanTest.recordTypeID;
            
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            test.starttest();
            M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            testExecute = new M2O_FinancialTrackingController(controller);
            testExecute.enableEditing();
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }    
    }

  /* 
  * @Description : This test method covers the Cancel() method of M2O_FinancialTrackingController class
  */       
     @isTest static void test_Cancel(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        M2O_FinancialTrackingController testExecute;
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);        
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){
        
            strategicAccountPlanTest=M2O_FinancialTrackingTestDataUtility.insertStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            insert currencySymbol;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTestId);     
            insert finTest;

            businessType = M2O_FinancialTrackingTestDataUtility.createBT_CS();
            businessType[0].SAP_Business_Type__c = strategicAccountPlanTest.recordTypeID;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
                        
            test.starttest();
            M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            testExecute = new M2O_FinancialTrackingController(controller);
            testExecute.cancel();
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the Save() method of M2O_FinancialTrackingController class
  */      
    @isTest static void test_Save(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        M2O_FinancialTrackingController testExecute;
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);        
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){
        
            strategicAccountPlanTest=M2O_FinancialTrackingTestDataUtility.insertStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            insert currencySymbol;
            finTest = M2O_FinancialtrackingTestDataUtility.createFinTrack(strategicAccountPlanTestId);     
            insert finTest;

            businessType = M2O_FinancialTrackingTestDataUtility.createBT_CS();
            businessType[0].SAP_Business_Type__c = strategicAccountPlanTest.recordTypeID;
            
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            
            test.starttest();
            M2O_FinancialTrackingTestDataUtility.insertCurrencyRecord();
            testExecute = new M2O_FinancialTrackingController(controller);
            testExecute.save();
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
       }     
    }
}