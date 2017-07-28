/**
@Classname :      M2O_OptyOwnerAccessToRelatedObjTest
@Description :    This test class is written to cover the code of the trigger M2O_OptyOwnerAccessToRelatedObj. 
@Author:          Meeta Pramanik
@Last Modified:   10/12/2013
**/

@isTest(SeeAllData=false)
public class M2O_OppOwnerAccessToRelatedObjTest {
    /**
    @Description:  This test Method is used to insert Account , Opportunity , sales Order, Quotation, Deal Support Request records by inserting two different users 
                   and using those users to insert records and by that triggering the M2O_OptyOwnerAccessToRelatedObj trigger.
    @Return:       Void   
    **/ 
       
  static testMethod void test_sharingForOptyOwner() {
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        //Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile hcProfileId = [select id from Profile where name = 'M2O Data Integration'];
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        User newOwner = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
        insert newOwner;
        System.runAs(m2oSystemAdminUser) {            
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);            
            Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);
            insert validateM2OProfile;           
            List<M2O_ST_Visibility_Objects__c> sTeamVisibilityObject = M2O_OpportunityTestDataUtility.getSTVisibilityObjects();
            insert sTeamVisibilityObject;
        }
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
        List <Opportunity> listOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id, runAsUser.id);
        insert listOpportunity;
        list<Sales_Order__c> listOfSalesOrder = new list<Sales_Order__c>();
        list<Quotation__c> listOfQuotationRecords = new list<Quotation__c>();
        list<Deal_Support_Request_del__c> listOfDSRRecords = new list<Deal_Support_Request_del__c>();
        for(Opportunity opp : listOpportunity) {
            listOfSalesOrder.add(M2O_OpportunityTestDataUtility.getSalesOrderRecord(opp.id));
        }
        insert listOfSalesOrder;
        for(Opportunity opp : listOpportunity) {
            opp.ownerid = newOwner.id;
        }
        update listOpportunity;     
        test.starttest();
        system.assertNotEquals(listOpportunity.size(), null);
        test.stoptest();
        }
    }
}