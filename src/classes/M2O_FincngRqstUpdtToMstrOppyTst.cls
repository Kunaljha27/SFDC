/**
@Classname :       M2O_FincngRqstUpdtToMstrOppyTst
@Description :     This class is written to cover the code of M2O_FinancingRequestUpdateToMasterOppy trigger.
@Author:           Somdev Bhattacharyya
@Last Modified:    03/04/2015
**/

@isTest(SeeAllData=true)
public class  M2O_FincngRqstUpdtToMstrOppyTst {
    
    
    /**
    @Description:  To test the method M2O_FinancingRequestUpdateToMasterOppy . 
    **/ 
    
    static testMethod void test_M2O_FincngRqstUpdtToMstrOppyTst() {
        
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        User user = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
        Region__c regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;   
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            Deal_Support_Request_del__c dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
            dsr.Related_Opportunity_del__c=opp.id;
            dsr.Project_Support_Request_Type__c='Legal Request';
            dsr.RecordTypeId=label.M2O_Healthcare_DSR_RecordTypeId;
            insert dsr;
            Test.startTest();
            dsr.Project_Support_Request_Type__c='Financing Request';
            update dsr;
            dsr.Project_Support_Request_Type__c='Legal Request';
            update dsr;
            Test.stopTest();          
        } 
    }
}