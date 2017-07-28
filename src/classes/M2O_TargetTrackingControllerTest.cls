/*
* @ClassName : M2O_TargetTrackingTest
* @Description : This class is the test class for M2O_TargetTrackingController class
* @Author : Bindesh Kushwah
* @Last Modified : 3/12/2013
* @Discussion points : No Information
*/
@isTest(SeeAllData=false) 
private class M2O_TargetTrackingControllerTest {

  /* 
  * @Description : This test method covers the Showdata() method of M2O_TargetTrackingController class
  */
    @isTest static void test_Showdata()
    {
        M2O_TargetTrackingController testTargetTrackingExecute;
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);  
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){     
        strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(strategicAccountPlanTestId);
        insert targetTrackingTest;
        ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
        System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            test.starttest();
            testTargetTrackingExecute = new M2O_TargetTrackingController(controller);
            testTargetTrackingExecute.showdata();
            system.assertEquals(targetTrackingTest[0].Strategic_Account_Plan__c,strategicAccountPlanTestId);
            test.stoptest();
            
       } 
    }
  
  /* 
  * @Description : This test method covers the EnableEditing() method of M2O_TargetTrackingController class
  */    
    @isTest static void test_EnableEditing()
    {
        M2O_TargetTrackingController testTargetTrackingExecute;
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){     
        strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(strategicAccountPlanTestId);
        insert targetTrackingTest;
        ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
        System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            test.starttest();
            testTargetTrackingExecute = new M2O_TargetTrackingController(controller);
            testTargetTrackingExecute.enableEditing();
            test.stoptest();
       } 
    }
    
  /* 
  * @Description : This test method covers the getrelatedtargetTrack() method of M2O_TargetTrackingController class
  */    
   @isTest static void test_getRelatedTargetTrackWithTT()
    {
        M2O_TargetTrackingController testTargetTrackingExecute;
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        List<Target_Tracking__C> changedRelatedTargetTracking;
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){     
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(strategicAccountPlanTestId);
            insert targetTrackingTest;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            
            test.starttest();
            testTargetTrackingExecute = new M2O_TargetTrackingController(controller);
            testTargetTrackingExecute.getrelatedtargetTrack(changedRelatedTargetTracking);
            test.stoptest();
            
       } 
    }
    
  /* 
  * @Description : This test method covers the getrelatedtargetTrack() method of M2O_TargetTrackingController class
  */      
   @isTest static void test_getRelatedTargetTrack()
    {
        M2O_TargetTrackingController testTargetTrackingExecute;
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){     
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(strategicAccountPlanTestId);
            insert targetTrackingTest;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            
            test.starttest();
            testTargetTrackingExecute = new M2O_TargetTrackingController(controller);
            testTargetTrackingExecute.getrelatedtargetTrack();
            test.stoptest();
            
       } 
    }
    
  /* 
  * @Description : This test method covers the Save() method of M2O_TargetTrackingController class
  */       
   @isTest static void test_Save()
    {
        M2O_TargetTrackingController testTargetTrackingExecute;
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        List<Target_Tracking__c> targetTrackingTest = new List<Target_Tracking__c>();
        Id userId;
        Id strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordKAM;
        userId=userRecordKAM.Id;
        system.runas(userRecordKAM){     
            strategicAccountPlanTest=M2O_TargetTrackingTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            targetTrackingTest =M2O_TargetTrackingTestDataUtility.getTargetTrackingRecord(strategicAccountPlanTestId);
            insert targetTrackingTest;
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            System.currentPageReference().getParameters().put('ID',strategicAccountPlanTestId);
            test.starttest();
            testTargetTrackingExecute = new M2O_TargetTrackingController(controller);
            testTargetTrackingExecute.relatedtargetTrack=targetTrackingTest ;
            testTargetTrackingExecute.save();
            test.stoptest();
       } 
    }
}