/**
* @ClassName         : HCNA_InsOrDelOrUpdatRelateRcdOnAssetTest
* @Description       : This class is the test class which is covering the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnAssets Trigger.
* @Author            : Noor Ali Khan
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public class HCNA_InsOrDelOrUpdatRelateRcdOnAssetTest{
    /* 
    * @Description : This test method covers the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnAssets Trigger
    */
    static testMethod void  test_InsretOrDeleteOrUpdateRelatedRecordOnAssetTrigger() {
        Profile profileId = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser =HCNA_UtilityClass.getUserRecord(profileId);
        insert runAsUser;
        System.runAs(runAsUser){        
            test.startTest();
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
            insert childAccount; 
            List<Asset> asset = HCNA_UtilityClass.getListOfAssetRecord(parentAccount);        
            Insert asset;
            asset[0].AccountId=childAccount.id;
            Update asset[0];
            test.stopTest();
        }
    }
}