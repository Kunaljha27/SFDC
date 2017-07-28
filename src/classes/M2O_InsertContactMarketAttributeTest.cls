/**
@Classname :       M2O_InsertContactMarketAttributeTest
@Description :     This test class is written to test the Apex Trigger M2O_InsertContactMarketAttribute. 
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/
@isTest(SeeAllData=true)
public Class M2O_InsertContactMarketAttributeTest {

    /**
    @Description :     This test method is written to test the Apex Trigger M2O_InsertContactMarketAttribute.
    @Return type : void.
    **/
       
    static testMethod void  Test_triggerMethod () {
        //Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Region__c regionData;
        //User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        //insert runAsUser;
        //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.id);
        //insert validateM2OProfile;
        
        //System.runAs(runAsUser) {
            test.starttest(); 
            regionData=M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            list<Account> accounts = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert accounts;        
            list<Contact> contacts = M2O_AccountContactTestDataUtility.getContactRecord();
            insert contacts;
            //System.assertNotEquals(contacts,null);
           
            test.stoptest(); 
        //}
   }
}