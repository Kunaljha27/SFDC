@istest(seealldata = true)
public class M2O_StampPriceBookTest {
    public static void triggertest() {
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            Region__c reg = M2O_OpportunityTestDataUtility.getRegionData();
            insert reg ;
            Account account = M2O_OpportunityTestDataUtility.getAccountRecord(reg);
            insert account;
            Opportunity testOpportunity = M2O_OpportunityTestDataUtility.getOpportunityRecord(account.ID);
            insert testOpportunity;
        }
    }
}