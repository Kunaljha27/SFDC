/**
@Classname :       M2O_SAPCloneDAOTest
@Description :     This test class is written to test the Apex class M2O_SAPCloneDAO. 
@Author:           Ramita
@Last Modified:    2/4/2015
**/
@isTest(SeeAllData=false)
public class M2O_SAPCloneDAOTest{

    /** @Description : This test method is used cover the getCreatedById method of M2O_SAPCloneDAO
        @Return type: void 
    **/
     static TestMethod void Test_getCreatedByUser(){
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
            String query = 'Select id,OwnerID from ' + queryobject + ' where ' +whereParam +' =:recordID limit 1';
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            recordId = strategicAccountPlanTest.Id;
            M2O_SAPCloneDAO daoClass= new M2O_SAPCloneDAO();
            daoClass.getCreatedByUser(query,recordId,queryObject,whereParam);
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the insertClonedSAP method of M2O_SAPCloneDAO
        @Return type: void 
    **/
     static TestMethod void Test_insertClonedSAP(){
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
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            M2O_SAPCloneDAO daoClass = new M2O_SAPCloneDAO();
            daoClass.insertClonedSAP(strategicAccountPlanTest);
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the getChildRecords method of M2O_SAPCloneDAO
        @Return type: void 
    **/
     static TestMethod void Test_getChildRecords(){
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
            String objectName = 'Strategic_Account_Plan__c';
            String selects='Name,Id,Aproved__c';
            String childQuery = 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
            M2O_SAPCloneDAO daoClass= new M2O_SAPCloneDAO();
            daoClass.getChildRecords(childQuery,recordId);
            test.stopTest();
        }
    }
    
    /** @Description : This test method is used cover the insertClonedChild method of M2O_SAPCloneDAO
        @Return type: void 
    **/
     static TestMethod void Test_insertClonedChild(){
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
            strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            M2O_SAPCloneDAO daoClass = new M2O_SAPCloneDAO();
            daoClass.insertClonedChild(strategicAccountPlanTest);
            test.stopTest();
        }
    }
}