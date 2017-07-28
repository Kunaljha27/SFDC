@isTest
public without sharing class M2O_InsertPHOnBudgetTest{
 static testMethod void test_createAccounts(){
 Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Account parentAccount = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        insert parentAccount;
        Commercial_Policy__c cp = new Commercial_Policy__c();
        cp.account__c = parentAccount.id;
        insert cp;
}
}