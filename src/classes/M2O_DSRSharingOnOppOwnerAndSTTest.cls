/**
@Classname :        M2O_DSRSharingOnOppOwnerAndSTTest 
@Description :      This test class is written to test the trigger M2O_DSRSharingOnOppOwnerAndSalesTeam. 
@Author:            Meeta Pramanik
@Last Modified:     10/12/2013
**/

@isTest(SeeAllData=false)
public class M2O_DSRSharingOnOppOwnerAndSTTest {

    /**
    @Description:  This test Method is used to insert Account , Opportunity , Deal Support Request records by inserting two different users 
                  and using those users to insert records and by that triggering the M2O_DSRSharingOnOppOwnerAndSalesTeam.
    @Return:       null   
    **/ 
        
    static testMethod void test_dealSupportRequest() {
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);
        insert validateM2OProfile;
        List<M2O_ST_Visibility_Objects__c> listCustomSettingDSR = new List<M2O_ST_Visibility_Objects__c>();
        listCustomSettingDSR = M2O_OpportunityTestDataUtility.getSTVisibilityObjects();
        insert listCustomSettingDSR;
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
            List<Deal_Support_Request_del__c> listDSR = M2O_OpportunityTestDataUtility.getListOfDSRRecord(opp.id);
            insert listDSR;
            Deal_Support_Request_del__c dSRCheck = new Deal_Support_Request_del__c();
            test.starttest();
            dSRCheck = [select Name From Deal_Support_Request_del__c where Id = :listDSR[0].id];
            System.assertEquals(listDSR[0].name, dSRCheck.name);
            test.stoptest();
        }
    }
}