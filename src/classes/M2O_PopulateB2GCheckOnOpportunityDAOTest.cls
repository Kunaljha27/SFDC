/**
@Classname :       M2O_PopulateB2GCheckOnOpportunityDAOTest
@Description :     This test class is written to test the class M2O_PopulateB2GCheckOnOpportunityDAO. 
@Author:           Vishal Kashyap
@Last Modified:    14/11/2014
**/

@isTest(SeeAllData=false)
public class M2O_PopulateB2GCheckOnOpportunityDAOTest{
    
    /**
    @Description:  This test Method is used to cover the methods getListTeamMember of dao class
    @Return:       Void   
    **/  
    
    static testMethod void test_getListTeamMember() {
        M2O_PopulateB2GCheckOnOpportunityDAO daoClass = new M2O_PopulateB2GCheckOnOpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__C regionData;
        ID exceptionID='00aB0000000Cd8q';
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
            set<ID> setExceOpportunity = new set<ID>();
            setRelatedOpportunity.add(opp.id);
            daoClass.getListTeamMember(setRelatedOpportunity);
            setExceOpportunity.add(acc.id);
            daoClass.getListTeamMember(setExceOpportunity);
            System.assertNotEquals(listOtm,null);
        }
    }
    
    /**
    @Description:  This test Method is used to cover the methods updateListTeamMember of dao class
    @Return:       Void   
    **/  
    
    static testMethod void test_updateListTeamMember() {
        M2O_PopulateB2GCheckOnOpportunityDAO daoClass = new M2O_PopulateB2GCheckOnOpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__C regionData;
        System.runAs(runAsUser) {
            ID exceptionID='00aB0000000Cd8q';
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;                         
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            List <OpportunityTeamMember> listOtm = new List<OpportunityTeamMember>();
            listOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert listOtm;
            List<Opportunity> listB2G = new List<Opportunity>();
            listB2G.add(opp);
            daoClass.updateListTeamMember(listB2G);
           // daoClass.updateListTeamMember();
            System.assertNotEquals(listOtm,null);
        }
    }
}