/**
@Classname :       M2O_UpdateEODOnOpptyProductTest
@Description :     This test class is written to cover the code of class M2O_UpdateEODOnOpptyProductService & M2O_UpdateEODOnOpptyProduct trigger
@Author:           Navaneet Pujar
@Last Modified:    July 9 2015
**/
@isTest(SeeAllData=true)
public class M2O_UpdateEODOnOpptyProductTest { 

     /**
    @Description:  To test the method insertOpportunityMasterAmount of M2O_CalculateAmountOppRollUpServiceclass. 
    **/
           
    static testMethod void test_insertOpportunityMasterAmount() {
     Test.startTest();
      Profile hcProfileId =  [select id from Profile where name = 'M2O Sales Healthcare'];
        Profile m2oSysAdminProfileId = [select id from Profile where name = 'M2O System Administrator'];
        User runAsUser = new User(LastName = 'User1',Username = 'Atest1.user.philips1@abc.com',
                             Email = 'test.user@philips.com',Alias = 'tu1',
                             CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = hcProfileId.Id, LanguageLocaleKey = 'en_US', Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC', FederationIdentifier = '00011');
        //User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        Set<id> setOpportunityID = new Set<id>();
        M2O_CalculateAmountOppRollUpService calcAmountOptyRollup = new M2O_CalculateAmountOppRollUpService();
        Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.deleteValidateM2OProfiles();
        insert validateM2OProfile;
        Region__C regionData;
        M2O_UpdateEODOnOpptyProductService con = new M2O_UpdateEODOnOpptyProductService();
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc; 
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            setOpportunityID.add(opp.Id);
            con.updateOpptyProduct(setOpportunityID);
            test.stoptest(); 
            
        }
    }
}