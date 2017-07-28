@isTest

public without sharing class M2O_CommPolicyHeaderControllerTest{
    static testMethod void test_createAccounts(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Account parentAccount = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        insert parentAccount;
        Commercial_Policy__c cp = new Commercial_Policy__c();
        cp.account__c = parentAccount.id;
        insert cp;
        
        Budget_AOP_View__c bgL2 = new Budget_AOP_View__c();
        bgL2.name = 'XYZ';
        bgL2.Commercial_Policy__c = cp.id;
        bgL2.type__c = 'Budget Latest View';
        bgL2.BG_Code__c='som1';
        bgL2.BG_Name__c='testbgname4';
        bgL2.Category_Code__c='som88';
        bgL2.Category_Name__c='testcategorynamel';
        bgL2.Upselling_Investment__c=1;
        bgL2.Retailer_promotion_STTI__c=2;
        bgL2.Consumer_promotion__c=3;
        bgL2.Brand_investment__c=4;
        bgL2.Cooperative_advertising_KAM__c=5;
        bgL2.Trade_marketing_investments_TSM__c=6;
        bgL2.Other__c=7;
        bgL2.Total_Investments__c=8;
        bgL2.Invoiced_Sales__c=9;
        bgL2.Quarter__c='Q1';
        insert bgL2;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(cp);
        System.currentPageReference().getParameters().put('Id', cp.id);
        M2O_CommercialPolicyHeaderController cpTest = new M2O_CommercialPolicyHeaderController(stdController);
        
        cpTest.getPolicyRecords();
        cpTest.getBudgetrecords();
    }
}