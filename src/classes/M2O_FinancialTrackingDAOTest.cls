/**
* @ClassName     : M2O_FinancialTrackingDAOTest
* @Description   : This class is the test class which is covering the code of  M2O_FinancialTrackingDAO
* @Author        : Vishal Kashyap
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_FinancialTrackingDAOTest {
  /* 
  * @Description : This test method covers the querySAPRecord() method of M2O_FinancialTrackingDAO class
  */
    @isTest static void test_QuerySAPRecord() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);        
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){       
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);     
            insert finTest;
            test.starttest();
            M2O_FinancialTrackingDAO.querySAPRecord(strategicAccountPlanTestId);
            M2O_FinancialTrackingDAO.querySAPRecord(exceptionID);
            system.assertEquals(strategicAccountPlanTest.name,'Test');
            test.stoptest();
        }
    }

  /* 
  * @Description : This test method covers the RecordAccess() method of M2O_FinancialTrackingDAO class
  */    
     @isTest static void test_RecordAccess() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){      
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);     
            insert finTest;
            test.starttest();
            M2O_FinancialTrackingDAO.recordAccess(UserID , strategicAccountPlanTestId);
            M2O_FinancialTrackingDAO.recordAccess(exceptionID , exceptionID);
            system.assertEquals(userRecordKAM.lastname,'User');
            test.stoptest();
        }
    }
    
  /* 
  * @Description : This test method covers the Save() method of M2O_FinancialTrackingDAO class
  */    
    @isTest static void test_Save() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);     
            insert finTest;
            test.starttest();
            M2O_FinancialTrackingDAO.save(strategicAccountPlanTest, finTest );
            strategicAccountPlanTest.ID = null;
            fintest[0].Strategic_Account_Plan__c = null;
            M2O_FinancialTrackingDAO.save(strategicAccountPlanTest, finTest );
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the GetFTRecords() method of M2O_FinancialTrackingDAO class
  */      
     @isTest static void test_GetFTRecords() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        List<Financial_Tracking__c> finTest = new List<Financial_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            finTest = M2O_FinancialTrackingTestDataUtility.createFinTrack(strategicAccountPlanTest.id);     
            insert finTest;
            test.starttest();
            M2O_FinancialTrackingDAO.getFTRecords(strategicAccountPlanTestId);
            M2O_FinancialTrackingDAO.getFTRecords(exceptionID );
            system.assertEquals(finTest[0].To_Be_Considered_For_Total__C,true);
            test.stoptest();
        }    
    }
}