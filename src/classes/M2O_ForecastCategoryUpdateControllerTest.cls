/**
@Classname :       M2O_ForecastCategoryUpdateControllerTest
@Description :     This test class is written to test the Apex class M2O_ForecastCategoryUpdateController. 
@Author:           Ramita
@Last Modified:    9/17/2013
**/
@isTest(SeeAllData=false)
public class M2O_ForecastCategoryUpdateControllerTest {
    
    
    static TestMethod void test_forecastCategoryAddition(){
        User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            M2O_ForecastCategoryUpdateController controllerObj = new M2O_ForecastCategoryUpdateController();
            controllerObj.flag = false;
            controllerObj.forecastCategoryAddition();
            ApexPages.StandardController controller=new ApexPages.StandardController(opp);
            M2O_ForecastCategoryUpdateController controllerObject = new M2O_ForecastCategoryUpdateController(controller);
            test.stopTest();
        }
    }
    
    static TestMethod void test_getitems(){
        User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            M2O_ForecastCategoryUpdateController controllerObj = new M2O_ForecastCategoryUpdateController();
            controllerObj.opportunityStage = opp;
            controllerObj.getitems();
            test.stopTest();
        }
    }
}