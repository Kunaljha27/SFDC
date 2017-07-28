/**
@Classname :       M2O_SAPCloneControllerTest
@Description :     This test class is written to test the Apex class M2O_SAPCloneController. 
@Author:           Ramita
@Last Modified:    2/4/2015
**/
@isTest(SeeAllData=false)
public class M2O_SAPCloneControllerTest{

    /** @Description : This test method is used cover the getCreatedById method of M2O_SAPCloneController class
        @Return type: void 
    **/
     static TestMethod void Test_getCreatedById(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Id recordId;
            String whereParam = 'Id';
            String queryObject = 'Strategic_Account_Plan__c';
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            recordId = strategicAccountPlanTest.Id;
            M2O_SAPCloneController.getCreatedById(recordId,queryObject,whereParam);
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the getCurrentUserId method of M2O_SAPCloneController class
        @Return type: void 
    **/
     static TestMethod void Test_getCurrentUserId(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            test.startTest();
            M2O_SAPCloneController.getCurrentUserId();
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the getCreatableFieldsSOQL method of M2O_SAPCloneController class
        @Return type: void 
    **/
     static TestMethod void Test_getCreatableFieldsSOQL(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Id recordId;
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            recordId = strategicAccountPlanTest.Id;
            String whereClause = 'Strategic_Account_Plan__c = :recordId';
            String queryObject = 'Strategic_Account_Plan__c';
            List<String> fieldsToBeExcluded = new List<String>();
            M2O_SAPCloneController.getCreatableFieldsSOQL(queryObject,whereClause,fieldsToBeExcluded);
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the cloneAndRedirect method of M2O_SAPCloneController class
        @Return type: void 
    **/
     static TestMethod void Test_cloneAndRedirect(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Id recordId;
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            recordId = strategicAccountPlanTest.Id;
            M2O_SAPCloneController.cloneAndRedirect(recordId);
            test.stopTest();
        }
    }
}