@isTest
public class M2O_OppotunityTriggerTest{

    static testMethod void test_dcaTrigger() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        Region__C regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            Set<id> setOpportunityID = new Set<id>();
            List<Opportunity> listMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.id);
            listMasterOpportunity[0].Philips_target_value__c = 100000000;
            insert listMasterOpportunity;
            List<Opportunity> listSubOpportunity = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id, listMasterOpportunity);
            insert listSubOpportunity;
            listSubOpportunity[0].Amount = 4000000;
            update listSubOpportunity[0];
        }
    }
}