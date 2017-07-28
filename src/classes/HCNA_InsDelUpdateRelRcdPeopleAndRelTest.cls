/**
* @ClassName         : HCNA_InsDelUpdateRelRcdPeopleAndRelTest
* @Description       : This class is the test class which is covering the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnPeopleAndRelationship Trigger.
* @Author            : Noor Ali Khan
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public class HCNA_InsDelUpdateRelRcdPeopleAndRelTest{
    /* 
    * @Description : This test method covers the code of HCNA_InsertOrDeleteOrUpdateRelatedRecordOnPeopleAndRelationship Trigger
    */
    static testMethod void  test_InsertOrDeleteOrUpdateRelatedRecordOnPeopleAndRelationshipTrigger() {
        Profile profileId = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileId);
        insert runAsUser;        
        Account apexAccount = HCNA_UtilityClass.getAccountRecord();
        insert apexAccount;
        Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
        insert parentAccount;
        Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
        insert childAccount; 
        list<Contact> contacts = HCNA_UtilityClass.getContactRecord(parentAccount);
        insert contacts;
        contacts[0].AccountId=childAccount.Id;
        update contacts[0];
        test.startTest();
        list<Contact> childContacts = Hcna_UtilityClass.getChildContactRecord(childAccount);
        insert childContacts;       
        update childContacts;
        delete childContacts;    
        test.stopTest();
    }
}