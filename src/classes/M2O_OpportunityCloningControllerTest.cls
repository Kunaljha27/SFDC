/**
@Classname :       M2O_OpportunityCloningControllerTest
@Description :     This class is written to cover the code of M2O_OpportunityCloningController.
@Author:           Meeta Pramanik
@Last Modified:    29/12/2013
**/

@isTest(SeeAllData=false)
public class M2O_OpportunityCloningControllerTest {

    /**
    @Description:  To test the method OpportunityClone of M2O_OpportunityCloningController class. 
    **/
    
    static testMethod void test_opportunityClone() {
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Region__c regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
                Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(runAsUser.id, acc.id);
                update accountToUpdate;
            }
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            List <OpportunityTeamMember> listOptyTeamMember = new List<OpportunityTeamMember>();
            listOptyTeamMember = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert listOptyTeamMember;
            delete listOptyTeamMember;
            Opportunity_Ecosystem__c OppEcosystem = M2O_OpportunityTestDataUtility.getOptyEcosystemRecord(opp.id, acc.id);   
            insert OppEcosystem;
            Test.startTest();
            M2O_OpportunityCloningController testCloneOpp = new M2O_OpportunityCloningController();
            M2O_OpportunityCloningController.OpportunityCloningPresenter (opp.Id);
            System.assertNotEquals(opp.id,null);
            Test.stopTest();
        }
    }
}