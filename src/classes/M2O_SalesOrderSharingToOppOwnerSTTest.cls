/**
@Classname :       M2O_SalesOrderSharingToOppOwnerSTTest 
@Description :     This test class is written to test the trigger M2O_SalesOrderSharingToOppOwnerSalesTeam. 
@Author:           Meeta Pramanik
@Last Modified:    13/11/2013
**/
@isTest(SeeAllData=false)
public class M2O_SalesOrderSharingToOppOwnerSTTest {

    /**
    @Description : This test Method is used to insert Account , Opportunity , Sales order record by inserting two different users 
                   and using those users to insert records and by that triggering the M2O_SalesOrderSharingToOptyOwnerAndSalesTeam trigger.
    @Return Type : Void. 
    **/
                  
  static testMethod void test_SalesOrder() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(hcProfileId.id);
        insert validateM2OProfile;
        List<M2O_ST_Visibility_Objects__c> listCustomSettingsalesOrder = new List<M2O_ST_Visibility_Objects__c>();
        listCustomSettingsalesOrder = M2O_OpportunityTestDataUtility.getSTVisibilityObjects();
        insert listCustomSettingsalesOrder;      
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
            List <Sales_Order__c> listSalesOrder = new list<Sales_Order__c> ();
            listSalesOrder = M2O_OpportunityTestDataUtility.getListOfSalesOrderRecord(opp.id);
            insert listSalesOrder;
            System.assertEquals(listSalesOrder[0].CurrencyIsoCode,listSalesOrder[1].CurrencyIsoCode);
            test.stoptest();
        }
    }
}