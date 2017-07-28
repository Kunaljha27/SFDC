/**
* @ClassName         : HCNA_InsDelUpdateRelRcdHospitalLocTest
* @Description       : This class is the test class which is covering the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnHospitalLocation Trigger.
* @Author            : Noor Ali Khan
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public class HCNA_InsDelUpdateRelRcdHospitalLocTest{
    /* 
    * @Description : This test method covers the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnHospitalLocation Trigger
    */
    static testMethod void test_InsertOrDeleteOrUpdateRelatedRecordOnHospitalLocationTrigger() {
        Profile profileId = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileId);
        insert runAsUser;        
        System.runAs(runAsUser){ 
            test.startTest();
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Account testAccount=new Account(Name='Asc_Parent_Acc_Test1.1', BillingState='TE', BillingCity='Test', 
            BillingStreet='Test', BillingCountry='CA', country__c = 'Albania',Associated_IDN__c = parentAccount.Id,
            Contracting_Vendor__c='test1');
            insert testAccount;
            StaticVariableClass.firstRun=true;
            testAccount.Name='test';
            testAccount.Contracting_Vendor__c='test';
            testAccount.Parent_IDN_of_Associated_IDN__c=apexAccount.id;
            update testAccount;
            StaticVariableClass.firstRun=true;
            delete testAccount;
            Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
            insert childAccount;
            test.stopTest();
        }      
    }
}