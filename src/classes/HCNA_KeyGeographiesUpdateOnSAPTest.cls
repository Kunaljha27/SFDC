/**
* @ClassName         : HCNA_KeyGeographiesUpdateOnSAPTest
* @Description       : This class is the test class which is covering the code of HCNA_KeyGeographiesUpdateOnSAP Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_KeyGeographiesUpdateOnSAPTest {
    /* 
    * @Description : This test method covers the code of HCNA_KeyGeographiesUpdateOnSAP Trigger
    */
    static testMethod void  Test_KeyGeographiesUpdateOnSAP() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        Account apexAccount = HCNA_UtilityClass.getAccountRecord();
        insert apexAccount;
        Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
        insert parentAccount;
        Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
        insert childAccount;
        Strategic_Account_plan__c strategicAccountPlan = new Strategic_Account_plan__c();
        strategicAccountPlan.Account__c = parentAccount.Id;
        Insert strategicAccountPlan;
    }
}