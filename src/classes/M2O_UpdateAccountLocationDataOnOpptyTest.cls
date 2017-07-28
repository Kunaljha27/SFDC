/**
@Classname :       M2O_UpdateAccountLocationDataOnOpptyTest
@Description :     This test class is written to to cover the code of class M2O_UpdateAccountLocationDataOnOppty.
@Author:           Navaneet Pujar
@Last Modified:    2 Mar 2016
**/
@isTest(SeeAllData=false)
public class M2O_UpdateAccountLocationDataOnOpptyTest {
    static testMethod void test_insertOpportunityMasterAmount() {
        //Profile systemAdminProfId = [select id from Profile where name = 'System Administrator'];
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        //User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(systemAdminProfId.Id);
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        m2oSystemAdminUser.FederationIdentifier = '213321';
        Set<id> setOpportunityID = new Set<id>();
        
        
        Region__C regionData;
        System.runAs(m2oSystemAdminUser) {
            
            Region__c regiondata1 = new Region__c();
            regiondata1.name ='Test Region1';
            regiondata1.Country__c='India';
            regiondata1.Region_Code__c='AA-113';
            insert regiondata1;
            
            Account acc1;
            acc1 = new Account(name = 'test acc2', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                          BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                          HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                          Philips_Indstry_Clasification_Level1__c = 'Retail',
                                          Philips_Indstry_Clasification_Level2__c='VISN', Account_template_sharing__c='M2O',
                                          Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='TestCity',
                                          Region__c = regiondata1.id);
            insert acc1;
            
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            
            
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;

            List<Opportunity> listMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.id);
            insert listMasterOpportunity;
            
            List<Opportunity> updateListOpportunity = new List<Opportunity>();
            for(opportunity opp:listMasterOpportunity){
                opp.AccountId = acc1.id;
                updateListOpportunity.add(opp);
            }
            update updateListOpportunity;
            
            List<Opportunity> listSubOpportunity = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id, listMasterOpportunity);
            insert listSubOpportunity;
        }
    }
}