/**
* @ClassName         : HCNA_InsDelUpdateRelRcdOnTopOpporTest
* @Description       : This class is the test class which is covering the code of HCNA_InsretOrDeleteOrUpdateRelatedRecordOnTopOpportunity Trigger.
* @Author            : Noor Ali Khan
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public class HCNA_InsDelUpdateRelRcdOnTopOpporTest{
    /* 
    * @Description : This test method covers the code of HCNA_InsretOrDeleteOrUpdateRelatedRecordOnTopOpportunity Trigger
    */
    static testMethod void  test_InsretOrDeleteOrUpdateRelatedRecordOnTopOpportunityTrigger() {
        Profile profileId = HCNA_UtilityClass.getHCNAProfileId2();
        User runAsUser =HCNA_UtilityClass.getUserRecord(profileId);
        insert runAsUser;        
        test.startTest();
        Account apexAccount = HCNA_UtilityClass.getAccountRecord();
        insert apexAccount;
        Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
        insert parentAccount;
        Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
        insert childAccount; 
        List<Opportunity> opportunityList= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
        StaticVariableClass.firstRun = true;
        insert opportunityList;
        StaticVariableClass.firstRun = true;
        opportunityList[0].AccountId=childAccount.id;
        opportunityList[1].StageName='Develop';
        opportunityList[2].Must_Win_flag__c = false;
        update opportunityList;              
        StaticVariableClass.firstRun = true;
        opportunityList[1].StageName='Order Booked';
        update opportunityList;    
        StaticVariableClass.firstRun = true;
        delete opportunityList;
        test.stopTest();        
    }
}