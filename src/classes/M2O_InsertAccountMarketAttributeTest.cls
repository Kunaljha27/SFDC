/**
@Classname :       M2O_InsertAccountMarketAttributeTest
@Description :     This test class is written to test the Apex Trigger  M2O_InsertAccountMarketAttribute. 
@Author:           Somdev Bhattacharyya
@Last Modified:    29/11/2013
**/
@isTest(SeeAllData=false)
public Class M2O_InsertAccountMarketAttributeTest {
    
    /**@Description :     This test method is written to test the Apex Trigger M2O_InsertAccountMarketAttribute.
       @return:           Void 
    **/    
   
    static testMethod void  Test_triggerMethod () {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.id);
        insert validateM2OProfile;
        Region__c regionData;
        System.runAs(runAsUser) {
            test.starttest();
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData; 
            list<Account> accounts = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert accounts;
            
            System.assertNotEquals(accounts,null);
            test.stoptest();
       }
   }
}