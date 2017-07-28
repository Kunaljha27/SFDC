@isTest

public without sharing class M2O_RollupPaidAmountOnCommitmentTest{
   static testMethod void test_createAccounts(){
   
        Account parentAccount = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        insert parentAccount;
        Commercial_Policy__c cp = new Commercial_Policy__c();
        cp.account__c = parentAccount.id;
        insert cp;
   
        commitment__c testCommitment = new commitment__c();
        testCommitment.Name = 'Test1';
        testCommitment.Commitment_Type__c = 'test1';
        testCommitment.Investment_Type__c = 'test1';
        testCommitment.Activity_Short_Description__c = 'test1';
        testCommitment.Activity_Description__c = 'test1';
        testCommitment.Category__c = 'test1';
        testCommitment.Acitivity_start_date__c= system.today();
        testCommitment.Activity_Completion_Date__c=system.today();
        testCommitment.Activity_Amount__c =1234;
        testCommitment.Commitment_Status__c='Draft1';
        testCommitment.Commercial_Policy__c = cp.id;
        testCommitment.Approve__c = true;
        testCommitment.Entitled_Amount__c = 300;
        testCommitment.Paid_Amount__c =150;
        insert testCommitment;
        
        commitment__c testCommitment2 = new commitment__c();
        testCommitment2.Name = 'Test';
        testCommitment2.parent_commitment__c = testCommitment.Id;
        testCommitment2.Commitment_Type__c = 'test2';
        testCommitment2.Investment_Type__c = 'test2';
        testCommitment2.Activity_Short_Description__c = 'test2';
        testCommitment2.Activity_Description__c = 'test2';
        testCommitment2.Category__c = 'test2';
        testCommitment2.Acitivity_start_date__c= system.today();
        testCommitment2.Activity_Completion_Date__c=system.today();
        testCommitment2.Activity_Amount__c =1234;
        testCommitment2.Commitment_Status__c='Draft2';
        testCommitment2.Commercial_Policy__c = cp.id;
        testCommitment2.Approve__c = true;
        testCommitment2.Entitled_Amount__c = 300;
        testCommitment2.Paid_Amount__c =150;
        insert testCommitment2;       
   }
}