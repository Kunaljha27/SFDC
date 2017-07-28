/**
@Classname :       M2O_ExtendedWarrantyValueBatchTest
@Description :     This test class is written to to cover the code of class M2O_ExtendedWarrantyValueBatch.
@Author:           Navaneet Pujar
@Last Modified:    10 Mar 2016
**/
@isTest(SeeAllData=false)
public class M2O_ExtendedWarrantyValueBatchTest{
    static testMethod void test_insertOpportunityMasterAmount() {

        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
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
            
            
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            
            
            Account acc;
            acc = new Account(name = 'test acc2', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                          BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                          HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                          Philips_Indstry_Clasification_Level1__c = 'Retail',
                                          Philips_Indstry_Clasification_Level2__c='VISN', Account_template_sharing__c='M2O',
                                          Housenumber_Local__c='S12345',Zip_Postal_Code_Local__c = '23552', Street1_Local__c='CA', City_Local__c='TestCity',
                                          Region__c = regiondata.id);
            insert acc;

            List<opportunity> listSubOpportunity = new List<opportunity>();
            for(integer i = 0; i <2; i++) {
                listSubOpportunity.add(new Opportunity(Name ='Test Sub Opty', closedate = system.today(), StageName = 'Develop',
                                                       AccountId = acc.Id,  CurrencyIsoCode='INR',
                                                       Amount = 1000, recordTypeId = Label.M2O_Opportunity_Healthcare_RecordType_ID, 
                                                       ForecastCategoryName = 'Pipeline',Extended_Warranty_Value__c = 200, Probability = 40, Vendor_of_Choice__c = 'Philips',
                                                       Funding_Status_Deal_Realization__c = 'Neutral'));
            }
            Insert listSubOpportunity;
            
            
            
            M2O_ExtendedWarrantyValueBatch bat = new M2O_ExtendedWarrantyValueBatch();
            Database.executeBatch(bat);            
        }
    }
}