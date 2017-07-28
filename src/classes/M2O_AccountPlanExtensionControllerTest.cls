/**
* @ClassName     : M2O_AccountPlanExtensionControllerTest
* @Description   : This class is the test class which is covering the code of M2O_ActivationPlanController class.
* @Author        : Albin Deni Arul
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_AccountPlanExtensionControllerTest{ 
  
      @isTest static void test_getCategoryAnalysis(){
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<Category_Analysis__c> insertcategoryAnalysis;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertcategoryAnalysis=M2O_SAPTestDataUtility.getCategoryAnalysis(testStrategicAccountPlanRecord.id);
              insert insertcategoryAnalysis;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
               controllerClassTest.getCategoryAnalysis();
               test.stoptest();
              
          }
      }
      
      @isTest static void test_getBMCAnalysis(){
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<BMC_Analysis__c> insertBMCAnalysis;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertBMCAnalysis=M2O_SAPTestDataUtility.getBMCAnalysis(testStrategicAccountPlanRecord.id);
              insert insertBMCAnalysis;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
              controllerClassTest.getBMCAnalysis();
               test.stoptest();
          }
       } 
      
      @isTest static void test_getComAnalysis(){ 
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<Competitor_Analysis__c> insertCompetitorAnalysis;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertCompetitorAnalysis=M2O_SAPTestDataUtility.getCompetitorAnalysis(testStrategicAccountPlanRecord.id);
              insert insertCompetitorAnalysis;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
              controllerClassTest.getComAnalysis();
               test.stoptest();
           }    
      }
      
       @isTest static void test_getDisAnalysis(){ 
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<Distribution_Analysis__c> insertDistributionAnalysis;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertDistributionAnalysis=M2O_SAPTestDataUtility.getDistributionAnalysis(testStrategicAccountPlanRecord.id);
              insert insertDistributionAnalysis;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
              controllerClassTest.getDisAnalysis();
               test.stoptest();
           }    
       }
         
       @isTest static void test_getSwotAnalysis(){ 
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<SWOT__c> insertSWOTAnalysis;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertSWOTAnalysis=M2O_SAPTestDataUtility.getSWOT(testStrategicAccountPlanRecord.id);
              insert insertSWOTAnalysis;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
              controllerClassTest.getSwotAnalysis();
               test.stoptest();
           }    
       }
       
       @isTest static void test_getObj(){ 
          Strategic_Account_Plan__c testStrategicAccountPlanRecord;
          List<Objective__c> insertObjective;
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
          system.RunAs(userRecordKAM) {
              testStrategicAccountPlanRecord=M2O_SAPTestDataUtility.getStrategicAccountPlanRecord();
              insert testStrategicAccountPlanRecord;
              insertObjective=M2O_SAPTestDataUtility.getObjective(testStrategicAccountPlanRecord.id);
              insert insertObjective;
              ApexPages.StandardController controller = new ApexPages.StandardController(testStrategicAccountPlanRecord);
              M2O_AccountPlanExtensionController controllerClassTest = new M2O_AccountPlanExtensionController(controller);
              test.starttest();
              controllerClassTest.getObj();
               test.stoptest();
           }    
       }
 }