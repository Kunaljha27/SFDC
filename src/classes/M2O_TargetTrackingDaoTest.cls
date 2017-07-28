/**
* @ClassName : M2O_TargetTracking_DaoTest
* @Description : This class is the test class which is covering the code of M2O_TargetTrackingDAO class.
* @Author : Bindesh Kushwah
* @Last Modified : 3/12/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_TargetTrackingDaoTest {

  /* 
  * @Description : This test method covers the getRecordAccess() method of M2O_TargetTrackingDAO class
  */
    @isTest static void test_getRecordAccess() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        ID SAPID;
        string profileName='M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        Id userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            SAPID = strategicAccountPlanTest.ID;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(SAPID);
            insert targetTrackingTest;
            test.starttest();
            M2O_TargetTrackingDAO.getRecordAccess(exceptionID ,exceptionID);
            M2O_TargetTrackingDAO.getRecordAccess(UserID,SAPID );
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the getRecordType() method of M2O_TargetTrackingDAO class
  */    
    @isTest static void test_getRecordType() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        ID SAPID = strategicAccountPlanTest.ID;
        string profileName='M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        Id userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            SAPID = strategicAccountPlanTest.ID;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(SAPID);
            insert targetTrackingTest;
            test.starttest();
            M2O_TargetTrackingDAO.getRecordType(SAPID);
            M2O_TargetTrackingDAO.getRecordType(exceptionID);
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the getTargetTrackData() method of M2O_TargetTrackingDAO class
  */     
    @isTest static void test_getTargetTrackData() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        ID SAPID = strategicAccountPlanTest.ID;
        string profileName='M2O KAM Healthcare';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        Id userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            SAPID = strategicAccountPlanTest.ID;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(SAPID);
            insert targetTrackingTest;
            test.starttest();
            M2O_TargetTrackingDAO.getTargetTrackData(SAPID);
            test.stoptest();
        }    
    }
    
  /* 
  * @Description : This test method covers the Save() method of M2O_TargetTrackingDAO class
  */      
    @isTest static void test_Save() {
        ID exceptionID='00aB0000000Cd8q';
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        ID SAPID = strategicAccountPlanTest.ID;
        string profileName='M2O KAM Healthcare';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        Id userId=userRecordKAM.Id;
        system.runas(userRecordKAM){    
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            SAPID = strategicAccountPlanTest.ID;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(SAPID);
            insert targetTrackingTest;
            test.starttest();
            M2O_TargetTrackingDAO.save(targetTrackingTest);
            test.stoptest();
        }    
    }
}