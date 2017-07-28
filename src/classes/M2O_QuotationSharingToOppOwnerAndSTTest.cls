/**
@Classname :        M2O_QuotationSharingToOppOwnerAndSTTest
@Description :      This test class is written to test the trigger M2O_QuotationSharingToOppOwnerAndSalesTeam . 
@Author:            Meeta Pramanik
@Last Modified:     13/11/2013
**/
@isTest(SeeAllData=false)
public class M2O_QuotationSharingToOppOwnerAndSTTest{

    /**
    @Description : This test Method is used to insert Account , Opportunity , Quotation records by inserting two different users 
                   and using those users to insert records and by that triggering the M2O_QuotationSharingToOptyOwnerAndSalesTeam .
    @Return Type : Void. 
    **/ 
  
    static testMethod void test_quotation() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(hcProfileId.id);
        insert validateM2OProfile;
        List<M2O_ST_Visibility_Objects__c> listCustomSettingQuotation = new List<M2O_ST_Visibility_Objects__c>();
        listCustomSettingQuotation = M2O_OpportunityTestDataUtility.getSTVisibilityObjects();
        insert listCustomSettingQuotation;
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
            test.starttest();
            List <Quotation__c> listQuotation = new list<Quotation__c> ();
            listQuotation = M2O_OpportunityTestDataUtility.getListOfQuotationRecord(opp.id);
            insert listQuotation;
            System.assertEquals(listQuotation[0].CurrencyIsoCode,listQuotation[1].CurrencyIsoCode);
            test.stoptest();
        }
    }
}