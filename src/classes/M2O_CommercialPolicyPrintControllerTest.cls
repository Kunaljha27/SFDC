@isTest

public without sharing class M2O_CommercialPolicyPrintControllerTest{
    static testMethod void test_createAccounts(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Account parentAccount = M2O_ActivationPlanTestDataUtility.getAccountRecord();
        insert parentAccount;
        Commercial_Policy__c cp = new Commercial_Policy__c();
        cp.account__c = parentAccount.id;
        insert cp;
        
        Budget_AOP_View__c bg = new Budget_AOP_View__c();
        bg.name = 'XYZ';
        bg.Commercial_Policy__c = cp.id;
        bg.type__c = 'Budget AOP';
        bg.BG_Code__c='tbgl';
        bg.BG_Name__c='tbg';
        bg.Category_Code__c='tccl';
        bg.Category_Name__c='tccnamel';
        bg.Upselling_Investment__c=1;
        bg.Retailer_promotion_STTI__c=2;
        bg.Consumer_promotion__c=3;
        bg.Brand_investment__c=4;
        bg.Cooperative_advertising_KAM__c=5;
        bg.Trade_marketing_investments_TSM__c=6;
        bg.Other__c=7;
        bg.Total_Investments__c=8;
        bg.Invoiced_Sales__c=9;
        bg.Quarter__c='Q3';
        insert bg;
        
        
        Budget_AOP_View__c bgQ3 = new Budget_AOP_View__c();
        bgQ3.name = 'XYZo';
        bgQ3.Commercial_Policy__c = cp.id;
        bgQ3.type__c = 'Budget AOP';
        bgQ3.BG_Code__c='tgl2';
        bgQ3.BG_Name__c='tbg1';
        bgQ3.Category_Code__c='tesgoryl2';
        bgQ3.Category_Name__c='terynamel2';
        bgQ3.Upselling_Investment__c=21;
        bgQ3.Retailer_promotion_STTI__c=22;
        bgQ3.Consumer_promotion__c=23;
        bgQ3.Brand_investment__c=24;
        bgQ3.Cooperative_advertising_KAM__c=25;
        bgQ3.Trade_marketing_investments_TSM__c=26;
        bgQ3.Other__c=27;
        bgQ3.Total_Investments__c=82;
        bgQ3.Invoiced_Sales__c=29;
        bgQ3.Quarter__c='Q3';
        insert bgQ3;
        
        Budget_AOP_View__c bg1 = new Budget_AOP_View__c();
        bg1.name = 'XYZ';
        bg1.Commercial_Policy__c = cp.id;
        bg1.type__c = 'Budget AOP';
        bg1.BG_Code__c='tbgl';
        bg1.BG_Name__c='tbg2';
        bg1.Category_Code__c='tccl';
        bg1.Category_Name__c='tccnamel';
        bg1.Upselling_Investment__c=1;
        bg1.Retailer_promotion_STTI__c=2;
        bg1.Consumer_promotion__c=3;
        bg1.Brand_investment__c=4;
        bg1.Cooperative_advertising_KAM__c=5;
        bg1.Trade_marketing_investments_TSM__c=6;
        bg1.Other__c=7;
        bg1.Total_Investments__c=8;
        bg1.Invoiced_Sales__c=9;
        bg1.Quarter__c='Q1';
        insert bg1;
        
        Budget_AOP_View__c bg2 = new Budget_AOP_View__c();
        bg2.name = 'XYZ';
        bg2.Commercial_Policy__c = cp.id;
        bg2.type__c = 'Budget AOP';
        bg2.BG_Code__c='tbgl';
        bg2.BG_Name__c='tbg3';
        bg2.Category_Code__c='tccl';
        bg2.Category_Name__c='tccnamel';
        bg2.Upselling_Investment__c=1;
        bg2.Retailer_promotion_STTI__c=2;
        bg2.Consumer_promotion__c=3;
        bg2.Brand_investment__c=4;
        bg2.Cooperative_advertising_KAM__c=5;
        bg2.Trade_marketing_investments_TSM__c=6;
        bg2.Other__c=7;
        bg2.Total_Investments__c=8;
        bg2.Invoiced_Sales__c=9;
        bg2.Quarter__c='Q2';
        insert bg2;
        
        Budget_AOP_View__c bgL2 = new Budget_AOP_View__c();
        bgL2.name = 'XYZq';
        bgL2.Commercial_Policy__c = cp.id;
        bgL2.type__c = 'Budget AOP';
        bgL2.BG_Code__c='te12bgl';
        bgL2.BG_Name__c='test12name4';
        bgL2.Category_Code__c='te12catoryl';
        bgL2.Category_Name__c='tes21caynamel';
        bgL2.Upselling_Investment__c=12;
        bgL2.Retailer_promotion_STTI__c=22;
        bgL2.Consumer_promotion__c=32;
        bgL2.Brand_investment__c=42;
        bgL2.Cooperative_advertising_KAM__c=25;
        bgL2.Trade_marketing_investments_TSM__c=26;
        bgL2.Other__c=27;
        bgL2.Total_Investments__c=28;
        bgL2.Invoiced_Sales__c=92;
        bgL2.Quarter__c='Q1';
        insert bgL2;
        
        
         Budget_AOP_View__c bgQ22 = new Budget_AOP_View__c();
        bgQ22.name = 'XYwZ';
        bgQ22.Commercial_Policy__c = cp.id;
        bgQ22.type__c = 'Budget AOP';
        bgQ22.BG_Code__c='teswtl';
        bgQ22.BG_Name__c='tbg';
        bgQ22.Category_Code__c='tccl';
        bgQ22.Category_Name__c='tccnamel';
        bgQ22.Upselling_Investment__c=1;
        bgQ22.Retailer_promotion_STTI__c=2;
        bgQ22.Consumer_promotion__c=3;
        bgQ22.Brand_investment__c=4;
        bgQ22.Cooperative_advertising_KAM__c=5;
        bgQ22.Trade_marketing_investments_TSM__c=6;
        bgQ22.Other__c=7;
        bgQ22.Total_Investments__c=8;
        bgQ22.Invoiced_Sales__c=9;
        bgQ22.Quarter__c='Q2';
        insert bgQ22;
        
        
        Budget_AOP_View__c bgQ33 = new Budget_AOP_View__c();
        bgQ33.name = 'XYrZ';
        bgQ33.Commercial_Policy__c = cp.id;
        bgQ33.type__c = 'Budget AOP';
        bgQ33.BG_Code__c='tesrbgl';
        bgQ33.BG_Name__c='tbg1';
        bgQ33.Category_Code__c='tccl';
        bgQ33.Category_Name__c='tccnamel';
        bgQ33.Upselling_Investment__c=1;
        bgQ33.Retailer_promotion_STTI__c=2;
        bgQ33.Consumer_promotion__c=3;
        bgQ33.Brand_investment__c=4;
        bgQ33.Cooperative_advertising_KAM__c=5;
        bgQ33.Trade_marketing_investments_TSM__c=6;
        bgQ33.Other__c=7;
        bgQ33.Total_Investments__c=8;
        bgQ33.Invoiced_Sales__c=9;
        bgQ33.Quarter__c='Q4';
        insert bgQ33;
        
        Budget_AOP_View__c bg11 = new Budget_AOP_View__c();
        bg11.name = 'XtYZ';
        bg11.Commercial_Policy__c = cp.id;
        bg11.type__c = 'Budget AOP';
        bg11.BG_Code__c='tetgl';
        bg11.BG_Name__c='tbg2';
        bg11.Category_Code__c='tccl';
        bg11.Category_Name__c='tccnamel';
        bg11.Upselling_Investment__c=1;
        bg11.Retailer_promotion_STTI__c=2;
        bg11.Consumer_promotion__c=3;
        bg11.Brand_investment__c=4;
        bg11.Cooperative_advertising_KAM__c=5;
        bg11.Trade_marketing_investments_TSM__c=6;
        bg11.Other__c=7;
        bg11.Total_Investments__c=8;
        bg11.Invoiced_Sales__c=9;
        bg11.Quarter__c='Q4';
        insert bg11;
        
        Budget_AOP_View__c bg32 = new Budget_AOP_View__c();
        bg32.name = 'XYyZ';
        bg32.Commercial_Policy__c = cp.id;
        bg32.type__c = 'Budget AOP';
        bg32.BG_Code__c='tesygl';
        bg32.BG_Name__c='tbg3';
        bg32.Category_Code__c='tccl';
        bg32.Category_Name__c='tccnamel';
        bg32.Upselling_Investment__c=1;
        bg32.Retailer_promotion_STTI__c=2;
        bg32.Consumer_promotion__c=3;
        bg32.Brand_investment__c=4;
        bg32.Cooperative_advertising_KAM__c=5;
        bg32.Trade_marketing_investments_TSM__c=6;
        bg32.Other__c=7;
        bg32.Total_Investments__c=8;
        bg32.Invoiced_Sales__c=9;
        bg32.Quarter__c='Q1';
        insert bg32;
        
        Budget_AOP_View__c bgL52 = new Budget_AOP_View__c();
        bgL52.name = 'XYuZ';
        bgL52.Commercial_Policy__c = cp.id;
        bgL52.type__c = 'Budget AOP';
        bgL52.BG_Code__c='tubgl';
        bgL52.BG_Name__c='tbg4';
        bgL52.Category_Code__c='tccl';
        bgL52.Category_Name__c='tccnamel';
        bgL52.Upselling_Investment__c=1;
        bgL52.Retailer_promotion_STTI__c=2;
        bgL52.Consumer_promotion__c=3;
        bgL52.Brand_investment__c=4;
        bgL52.Cooperative_advertising_KAM__c=5;
        bgL52.Trade_marketing_investments_TSM__c=6;
        bgL52.Other__c=7;
        bgL52.Total_Investments__c=8;
        bgL52.Invoiced_Sales__c=9;
        bgL52.Quarter__c='Q4';
        insert bgL52;
        
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(cp);
         System.currentPageReference().getParameters().put('Id', cp.id);
         M2O_CommercialPolicyPrintController cpTest = new M2O_CommercialPolicyPrintController(stdController);
         M2O_CommercialPolicyPrintController cpTest1 = new M2O_CommercialPolicyPrintController();
         cpTest.recordId=cp.id;
         cpTest.budgetType='Budget AOP';
         cpTest.getSelectedPeriodFYRecords();
         cpTest.getSelectedPeriodQ1Records();
         cpTest.getSelectedPeriodQ2Records();
         cpTest.getSelectedPeriodQ3Records();
         cpTest.getSelectedPeriodQ4Records();
       
        
        
        
    }
    
    
}