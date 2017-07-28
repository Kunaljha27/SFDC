/**
* @ClassName : M2O_FinancialTrackingServiceTest
* @Description : This class is the test class which is covering the code of M2O_FinancialTrackingService
* @Author : Vishal Kashyap
* @Last Modified : 3/12/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialTrackingServiceTest {

  /* 
  * @Description : This test method covers the GetThousandScaleDB() method of M2O_FinancialTrackingService class
  */
    @isTest static void test_GetThousandScaleDB() {
    
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId;
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Financial_Tracking__c fin1Test = new Financial_Tracking__c();
        List<M2O_Financial_Tracking_Category__c> csValues = new List<M2O_Financial_Tracking_Category__c>();
        csValues = M2O_FinancialTrackingTestDataUtility.createFT_CS();
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        ID userID=userRecordKAM.Id;
        system.runas(userRecordKAM){   
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();  

            insert strategicAccountPlanTest;     
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;        
            List<Financial_Tracking__c> finTrackingList=M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);         

            insert finTrackingList;     
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);
 
            insert finTest;
            test.starttest();
            csValues[0].Sector__c= strategicAccountPlanTest.Philips_Sector__c;
            fin1Test = finTest[0];
            M2O_FinancialTrackingService.getThousandScaleDB(M2O_FinancialTrackingService.getThousandScaleUI(finTest));
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the GetThousandScaleUI() method of M2O_FinancialTrackingService class
  */    
     @isTest static void test_GetThousandScaleUI() {
    
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId;
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Financial_Tracking__c fin1Test = new Financial_Tracking__c();
        List<M2O_Financial_Tracking_Category__c> csValues = new List<M2O_Financial_Tracking_Category__c>();
        csValues = M2O_FinancialTrackingTestDataUtility.createFT_CS();
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        ID userID=userRecordKAM.Id;
        system.runas(userRecordKAM){  
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();  

            insert strategicAccountPlanTest;     
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;        
            List<Financial_Tracking__c> finTrackingList=M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);         
 
            insert finTrackingList;     
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);

            insert finTest;
            test.starttest();
            csValues[0].Sector__c= strategicAccountPlanTest.Philips_Sector__c;
            fin1Test = finTest[0];
            M2O_FinancialTrackingService.getThousandScaleUI(fin1Test);
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
         }   
    }
    
  /* 
  * @Description : This test method covers the GetFindTotal() method of M2O_FinancialTrackingService class
  */     
      @isTest static void test_GetFindTotal() {
    
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId;
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Financial_Tracking__c fin1Test = new Financial_Tracking__c();
        List<M2O_Financial_Tracking_Category__c> csValues = new List<M2O_Financial_Tracking_Category__c>();
        csValues = M2O_FinancialTrackingTestDataUtility.createFT_CS();
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        ID userID=userRecordKAM.Id;
        system.runas(userRecordKAM){  
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();  

            insert strategicAccountPlanTest;     
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;        
            List<Financial_Tracking__c> finTrackingList=M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);         
            insert finTrackingList;     
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);
            insert finTest;

            test.starttest();
            csValues[0].Sector__c= strategicAccountPlanTest.Philips_Sector__c;
            fin1Test = finTest[0];
            M2O_FinancialTrackingService.getFindTotal(finTest);
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }   
    }
    
  /* 
  * @Description : This test method covers the GetFirstRunFT() method of M2O_FinancialTrackingService class
  */     
     @isTest static void test_GetFirstRunFT() {
    
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId;
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Financial_Tracking__c fin1Test = new Financial_Tracking__c();
        List<M2O_Financial_Tracking_Category__c> csValues = new List<M2O_Financial_Tracking_Category__c>();
        csValues = M2O_FinancialTrackingTestDataUtility.createFT_CS();
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        ID userID=userRecordKAM.Id;
        system.runas(userRecordKAM){  
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();  

            insert strategicAccountPlanTest;     

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;        
            List<Financial_Tracking__c> finTrackingList=M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);         
            insert finTrackingList;     
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTestId);
            insert finTest;
 
            test.starttest();
            csValues[0].Sector__c= strategicAccountPlanTest.Philips_Sector__c;
            fin1Test = finTest[0];
            M2O_FinancialTrackingService.getFirstRunFT(csValues ,strategicAccountPlanTest);
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
         }   
    }
}