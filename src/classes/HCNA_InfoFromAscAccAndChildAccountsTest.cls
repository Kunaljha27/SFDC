/**
* @ClassName         : HCNA_InfoFromAscAccAndChildAccountsTest 
* @Description       : This class is the test class which is covering the code of HCNA_InformationFromAssociatedAccountAndChildAccounts Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_InfoFromAscAccAndChildAccountsTest {
    /* 
    * @Description : This test method covers the code of HCNA_InformationFromAssociatedAccountAndChildAccounts Trigger
    */
    static testMethod void  test_InformationFromAssociatedAccountAndChildAccountsTrigger() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        System.runAs(runAsUser){ 
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount);
            insert childAccount;
            List<Contact> contact = HCNA_UtilityClass.getContactRecord(parentAccount);
            insert contact;
            List<Opportunity> opportunity= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
            insert opportunity;
            List<Opportunity> childopportunity= HCNA_UtilityClass.getListOfChildOpportunityRecord(childAccount);
            insert childopportunity;
            List<Asset> asset = HCNA_UtilityClass.getListOfAssetRecord(parentAccount);
            Insert asset;
            Contract contract = HCNA_UtilityClass.getListOfContractRecord(parentAccount);
            Insert contract;
            test.startTest();
            List<Contract_Account_Link__c> contractLink=HCNA_UtilityClass.getListOfContractAccountLinkRecord(parentAccount,contract);
            Insert contractLink;
            List<Strategic_Account_plan__c> strategicAccountPlan=HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlan;
            List<Strategic_Account_plan__c> strategicAccountPlanList= new  List<Strategic_Account_plan__c>();
            for(Strategic_Account_Plan__c sap: strategicAccountPlan){
                sap.Account__c = childAccount.Id;
                strategicAccountPlanList.add(sap);
            }
            update strategicAccountPlanList;
            test.stopTest();    
        }
    }
}