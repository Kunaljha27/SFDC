/**
@Classname :       M2O_PopulateB2GCheckOnOppServiceTest
@Description :     This test class is written to test the class M2O_PopulateB2GCheckOnOpportunityService. 
@Author:           Vishal Kashyap
@Last Modified:    14/11/2014
**/

@isTest(SeeAllData=false)
public class M2O_PopulateB2GCheckOnOppServiceTest{
    /**
    @Description:  This test Method is used to cover the methods of updateListTeamMember of service class
    @Return:       Void   
    **/  
    
    static testMethod void test_updateListTeamMember() {
        M2O_PopulateB2GCheckOnOpportunityService serviceClass = new M2O_PopulateB2GCheckOnOpportunityService();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__C regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;                         
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            List <OpportunityTeamMember> listOtm = new List<OpportunityTeamMember>();
            listOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert listOtm;
            set<ID> setRelatedOpportunity = new set<ID>();
            setRelatedOpportunity.add(opp.id);
            serviceClass.updateListTeamMember(setRelatedOpportunity);
            System.assertNotEquals(listOtm,null);
        }
    }
}