/**
@Classname :       M2O_DocumentManagementControllerTest
@Description :     This test class is written to test the Apex class M2O_DocumentManagementController. 
@Author:           Ramita
@Last Modified:    9/25/2013
**/
@isTest(SeeAllData=false)
public class M2O_DocumentManagementControllerTest {
    
    static TestMethod void test_M2O_DocumentManagementConstructor(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            test.startTest();
            ApexPages.StandardController controller=new ApexPages.StandardController(opp);
            M2O_DocumentManagementController obj = new M2O_DocumentManagementController(controller);
            test.stopTest();
        }
    }

}