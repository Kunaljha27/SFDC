@isTest(SeeAllData=false)
public class M2O_DSRCloningControllerTest {

    /**
    @Description:  To test the method OpportunityClone of M2O_DSRCloningController class. 
    **/
    
    static testMethod void test_DSRCloningPresenter() {
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
        Deal_Support_Request_del__c dSR = new Deal_Support_Request_del__c ();
        dSR = M2O_OpportunityTestDataUtility.getDSRRecord();
        dSR.Related_Opportunity_del__c = opp.Id;
        insert dSR;
        //M2O_DSRCloningController contrlTest = new M2O_DSRCloningController ();
        Test.startTest();
        M2O_DSRCloningController.DSRCloningPresenter (dSR.Id);
        System.assertNotEquals(dSR.Id,null);
        Test.stopTest();
        }
    }        
}