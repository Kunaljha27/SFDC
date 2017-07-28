/**
@Classname :       M2O_SalesTeamVisibilityToRelatedObjTest
@Description :     This test class is written to test the trigger M2O_SalesTeamVisibilityToRelatedObj. 
@Author:           Meeta Pramanik
@Last Modified:    10/12/2013
**/

@isTest(SeeAllData=false)
public class M2O_SalesTeamVisibilityToRelatedObjTest {
    /**
    @Description:  This test Method is used to insert Account , Opportunity and Sales Team Member by inserting two different users 
                   and using those users to insert records and by that triggering the M2O_SalesTeamVisibilityToRelatedObj trigger.
    @Return:       Void   
    **/  

    static testMethod void test_triggerMethod() {
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Validate_M2O_Profiles__c cs1 = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(hcProfileId.id);
        insert cs1;
        Region__C regionData;
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
            List <OpportunityTeamMember> listOtm = new List<OpportunityTeamMember >();
            listOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert listOtm;
            delete listOtm;
       }  
   }
}