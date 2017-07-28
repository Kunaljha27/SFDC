/**
* @ClassName         : HCNA_InsetDelUpdateOnContAccLinkTest 
* @Description       : This class is the test class which is covering the code of HCNA_InsertOrDeleteOrUpdateRelatedAccountLinkRecordOnContractDetail Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_InsetDelUpdateOnContAccLinkTest {
    /* 
    * @Description : This test method covers the code of HCNA_InsertOrDeleteOrUpdateRelatedAccountLinkRecordOnContractDetail Trigger
    */
    static testMethod void  test_InsertOrDeleteOrUpdateRelatedAccountLinkRecordOnContractDetailTrigger() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){ 
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
            insert childAccount;
            Contract contract= HCNA_UtilityClass.getListOfContractRecord(parentAccount);
            Insert contract;
            List<Contract_Account_Link__c> contractLink=HCNA_UtilityClass.getListOfContractAccountLinkRecord(parentAccount,contract);
            Insert contractLink;
            test.startTest();
            contractLink[0].Account_Name__c = childAccount.Id;
            Update contractLink[0];
            Delete contractLink;
            test.stopTest();
        }
    } 
}