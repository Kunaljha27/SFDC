/**
* @ClassName     : M2O_TargetTracking_ServiceTest
* @Description   : This class is the test class of M2O_TargetTrackingService class.
* @Author        : Bindesh Kushwah
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_TargetTrackingServiceTest {
  /* 
  * @Description : This test method covers the getFirstRunData() method of M2O_TargetTrackingService class
  */
    @isTest static void test_getFirstRunData() {
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        List<Target_Tracking__c> tarTest = new List<Target_Tracking__c>();
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        string profileName='M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        Id userId=userRecordKAM.Id;
        system.runas(userRecordKAM){
        Strategic_Account_Plan__c SAP = M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
        insert SAP;
        ID SAPID = SAP.ID;
        targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(SAPID);
        insert targetTrackingTest;
        businessType = M2O_TargetTrackingTestDataUtility.getBT_CS();
        Integer driveLines = 5;
        
        test.starttest();
        businessType[0].SAP_Business_Type__c = SAP.recordTypeID;
        tarTest = M2O_TargetTrackingTestDataUtility.getTarTrack(SAPID);
        M2O_TargetTrackingService.getFirstRunData(SAP.recordTypeID , driveLines , businessType , SAP.ID, SAP);
        test.stoptest();
        
        }
    }
}