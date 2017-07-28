@isTest

public without sharing class M2O_CommercialPolicyControllerTest{
    static testMethod void test_createAccounts(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        runAsUser.FederationIdentifier='test223';
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
        bg.BG_Code__c='som4';
        bg.BG_Name__c='somd1';
        bg.Category_Code__c='testcategoryl';
        bg.Category_Name__c='testcategorynamel';
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
        bgQ3.name = 'XYZ';
        bgQ3.Commercial_Policy__c = cp.id;
        bgQ3.type__c = 'Budget AOP';
        bgQ3.BG_Code__c='som2';
        bgQ3.BG_Name__c='zzz';
        bgQ3.Category_Code__c='we11';
        bgQ3.Category_Name__c='testcategorynamel';
        bgQ3.Upselling_Investment__c=1;
        bgQ3.Retailer_promotion_STTI__c=2;
        bgQ3.Consumer_promotion__c=3;
        bgQ3.Brand_investment__c=4;
        bgQ3.Cooperative_advertising_KAM__c=5;
        bgQ3.Trade_marketing_investments_TSM__c=6;
        bgQ3.Other__c=7;
        bgQ3.Total_Investments__c=8;
        bgQ3.Invoiced_Sales__c=9;
        bgQ3.Quarter__c='Q3';
        insert bgQ3;
        
        Budget_AOP_View__c bg1 = new Budget_AOP_View__c();
        bg1.name = 'XYZ';
        bg1.Commercial_Policy__c = cp.id;
        bg1.type__c = 'Budget AOP';
        bg1.BG_Code__c='som3';
        bg1.BG_Name__c='testbgname2';
        bg1.Category_Code__c='somd3';
        bg1.Category_Name__c='testcategorynamel';
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
        
        
        Budget_AOP_View__c bgC = new Budget_AOP_View__c();
        bgC.name = 'XYZ';
        bgC.Commercial_Policy__c = cp.id;
        bgC.type__c = 'Accruals';
        bgC.BG_Code__c='somd4';
        bgC.BG_Name__c='testbgname';
        bgC.Category_Code__c='somd4';
        bgC.Category_Name__c='testcategorynamel';
        bgC.Upselling_Investment__c=1;
        bgC.Retailer_promotion_STTI__c=2;
        bgC.Consumer_promotion__c=3;
        bgC.Brand_investment__c=4;
        bgC.Cooperative_advertising_KAM__c=5;
        bgC.Trade_marketing_investments_TSM__c=6;
        bgC.Other__c=7;
        bgC.Total_Investments__c=8;
        bgC.Invoiced_Sales__c=9;
        bgC.Quarter__c='Q3';
        insert bgC;
        
        
        Budget_AOP_View__c bgC1 = new Budget_AOP_View__c();
        bgC1.name = 'XYZ';
        bgC1.Commercial_Policy__c = cp.id;
        bgC1.type__c = 'Accruals';
        bgC1.BG_Code__c='som5';
        bgC1.BG_Name__c='somd5';
        bgC1.Category_Code__c='testcategoryl';
        bgC1.Category_Name__c='testcategorynamel';
        bgC1.Upselling_Investment__c=1;
        bgC1.Retailer_promotion_STTI__c=2;
        bgC1.Consumer_promotion__c=3;
        bgC1.Brand_investment__c=4;
        bgC1.Cooperative_advertising_KAM__c=5;
        bgC1.Trade_marketing_investments_TSM__c=6;
        bgC1.Other__c=7;
        bgC1.Total_Investments__c=8;
        bgC1.Invoiced_Sales__c=9;
        bgC1.Quarter__c='Q3';
        insert bgC1;
        
        Budget_AOP_View__c bgC2 = new Budget_AOP_View__c();
        bgC2.name = 'XYZ';
        bgC2.Commercial_Policy__c = cp.id;
        bgC2.type__c = 'Accruals';
        bgC2.BG_Code__c='som6';
        bgC2.BG_Name__c='testbgname2';
        bgC2.Category_Code__c='somd6';
        bgC2.Category_Name__c='testcategorynamel';
        bgC2.Upselling_Investment__c=1;
        bgC2.Retailer_promotion_STTI__c=2;
        bgC2.Consumer_promotion__c=3;
        bgC2.Brand_investment__c=4;
        bgC2.Cooperative_advertising_KAM__c=5;
        bgC2.Trade_marketing_investments_TSM__c=6;
        bgC2.Other__c=7;
        bgC2.Total_Investments__c=8;
        bgC2.Invoiced_Sales__c=9;
        bgC2.Quarter__c='Q1';
        insert bgC2;        
        
        
        
        Budget_AOP_View__c bg2 = new Budget_AOP_View__c();
        bg2.name = 'XYZ';
        bg2.Commercial_Policy__c = cp.id;
        bg2.type__c = 'Budget Latest View';
        bg2.BG_Code__c='som7';
        bg2.BG_Name__c='testbgname3';
        bg2.Category_Code__c='somd7';
        bg2.Category_Name__c='testcategorynamel';
        bg2.Upselling_Investment__c=1;
        bg2.Retailer_promotion_STTI__c=2;
        bg2.Consumer_promotion__c=3;
        bg2.Brand_investment__c=4;
        bg2.Cooperative_advertising_KAM__c=5;
        bg2.Trade_marketing_investments_TSM__c=6;
        bg2.Other__c=7;
        bg2.Total_Investments__c=8;
        bg2.Invoiced_Sales__c=9;
        bg2.Quarter__c='Q1';
        insert bg2;
        
        Budget_AOP_View__c bgL2 = new Budget_AOP_View__c();
        bgL2.name = 'XYZ';
        bgL2.Commercial_Policy__c = cp.id;
        bgL2.type__c = 'Budget Latest View';
        bgL2.BG_Code__c='som8';
        bgL2.BG_Name__c='testbgname4';
        bgL2.Category_Code__c='somd8';
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
         M2O_CommercialPolicyController cpTest = new M2O_CommercialPolicyController(stdController);
         M2O_CommercialPolicyController cpTest1 = new M2O_CommercialPolicyController();
         cpTest.recordId=cp.id;
        cpTest.filterCriteria='budget1';
        cpTest.getfilterCriteria();
        cpTest.getcheck();
        cpTest.setfilterCriteria('budget1');
        cpTest.editCommitment();
        cpTest.enableEditing();
        cpTest.addRows();
        cpTest.getViewList();
        cpTest.cancel();
        cpTest.cancelCommit();
        cpTest.saveCommitment();
        cpTest.getChangedAOPValue();
        cpTest.getChangedViewValue();
        cpTest.queryResult();
        cpTest.SelectedQuarter='Q1';
        cpTest.getSelectedPeriodRecords();
        cpTest.renderSec='testrendersec';
        cpTest.SelectedQuarterForView='Q1';
        cpTest.SelectedQuarterControl='Q1';
        cpTest.getSelectedControlRecords();
        cpTest.getSelectedPeriodViewRecords();
        cpTest.enableEditingControl();  
        cpTest.EditPay();
        cpTest.EditPayReview();
        cpTest.sumUpsellingControl();
        cpTest.cancelControl();
        cpTest.cancelPay();
        cpTest.cancelPayReview();
        cpTest.savePayReview();
        cpTest.savePay();
        bgQ3.Quarter__c='Q2';
        update bgQ3;
        cpTest.save();
        bgC2.Quarter__c='Q4';
        update bgC2;
        cpTest.saveControl(); 
        
        
        
        commitment__c testCommitment = new commitment__c();
        testCommitment.Name = 'Test';
        testCommitment.Commitment_Type__c = 'test';
        testCommitment.Investment_Type__c = 'test';
        testCommitment.Activity_Short_Description__c = 'test';
        testCommitment.Activity_Description__c = 'test';
        testCommitment.Category__c = 'test';
        testCommitment.Acitivity_start_date__c= system.today();
        testCommitment.Activity_Completion_Date__c=system.today();
        testCommitment.Activity_Amount__c =1234;
        testCommitment.Commitment_Status__c='Draft';
        testCommitment.Commercial_Policy__c = cp.id;
        testCommitment.Approve__c = true;
        testCommitment.Entitled_Amount__c = 300;
        insert testCommitment;
        
        commitment__c childCommitment = new commitment__c();
        childCommitment.Name = 'Test1';
        childCommitment.Commitment_Type__c = 'test';
        childCommitment.Investment_Type__c = 'test';
        childCommitment.Activity_Short_Description__c = 'test';
        childCommitment.Activity_Description__c = 'test';
        childCommitment.Category__c = 'test';
        childCommitment.Acitivity_start_date__c= system.today();
        childCommitment.Activity_Completion_Date__c=system.today();
        childCommitment.Activity_Amount__c =1234;
        childCommitment.Commitment_Status__c='Draft';
        childCommitment.Commercial_Policy__c = cp.id;
        childCommitment.Approve__c = true;
        childCommitment.Entitled_Amount__c = 300;
        childCommitment.Parent_Commitment__c = testCommitment.id;
        childCommitment.Paid_Amount__c =200;
        insert childCommitment;
        cpTest.ParentCheck = testCommitment.id;
        cpTest.addnewChildren();
        cpTest.hideAllChildren();
        cpTest.showAllChildren();
        cpTest.deleteChild = childCommitment.id;
        cpTest.deleteChildren();
        
        commitment__c testCommitment1 = new commitment__c();
        testCommitment1.Name = 'Test';
        testCommitment1.Commitment_Type__c = 'test';
        testCommitment1.Investment_Type__c = 'test';
        testCommitment1.Activity_Short_Description__c = 'test';
        testCommitment1.Activity_Description__c = 'test';
        testCommitment1.Category__c = 'test';
        testCommitment1.Acitivity_start_date__c= system.today();
        testCommitment1.Activity_Completion_Date__c=system.today();
        testCommitment1.Activity_Amount__c =1234;
        testCommitment1.Commitment_Status__c='Draft';
        testCommitment1.Commercial_Policy__c = cpTest.recordId;
        testCommitment1.Approve__c = true;
        testCommitment1.Entitled_Amount__c = 300;
        testCommitment1.Expected_Incremental_3N_Sales__c = 3000;
        insert testCommitment1;
        
        commitment__c childCommitment1 = new commitment__c();
        //childCommitment1.Name = 'Test1';
        childCommitment1.Commitment_Type__c = 'test';
        childCommitment1.Investment_Type__c = 'test';
        childCommitment1.Activity_Short_Description__c = 'test';
        childCommitment1.Activity_Description__c = 'test';
        childCommitment1.Category__c = 'test';
        childCommitment1.Acitivity_start_date__c= system.today();
        childCommitment1.Activity_Completion_Date__c=system.today();
        childCommitment1.Activity_Amount__c =1234;
        childCommitment1.Commitment_Status__c='Approved';
        childCommitment1.Commercial_Policy__c = cp.Id;
        //childCommitment1.Approve__c = true;
        childCommitment1.Entitled_Amount__c = 300;
        childCommitment1.Expected_Incremental_3N_Sales__c = 3000;
        //childCommitment1.Paid_Amount__c =200;
        childCommitment1.Counterperformance_Status__c = 'Delivered'; 
        childCommitment1.Parent_Commitment__c = null; 
        insert childCommitment1;
        
         commitment__c childCommitment2 = new commitment__c();
        //childCommitment1.Name = 'Test1';
        childCommitment2.Commitment_Type__c = 'test';
        childCommitment2.Investment_Type__c = 'test';
        childCommitment2.Activity_Short_Description__c = 'test';
        childCommitment2.Activity_Description__c = 'test';
        childCommitment2.Category__c = 'test';
        childCommitment2.Acitivity_start_date__c= system.today();
        childCommitment2.Activity_Completion_Date__c=system.today();
        childCommitment2.Activity_Amount__c =1234;
        childCommitment2.Commitment_Status__c='Approved';
        childCommitment2.Commercial_Policy__c = cp.Id;
        //childCommitment1.Approve__c = true;
        childCommitment2.Entitled_Amount__c = 300;
        childCommitment2.Expected_Incremental_3N_Sales__c = 3000;
        //childCommitment1.Paid_Amount__c =200;
        childCommitment2.Counterperformance_Status__c = 'None'; 
        childCommitment2.Parent_Commitment__c = null; 
        insert childCommitment2;

        
        
        system.debug('@#cp.id'+ childCommitment1);
        
        List <Commitment__c> ListChild = new List<Commitment__c>();
        
        ListChild.Add(childCommitment1); 
         
    
        cpTest.getPaymentReviewRecords();
        cpTest.getPaymentRecords();

                       
        M2O_CommercialPolicyController.FinalCommitmentRecords finalRecords = new M2O_CommercialPolicyController.FinalCommitmentRecords();
        M2O_CommercialPolicyController.FinalCommitmentRecords finalParentRecords = new M2O_CommercialPolicyController.FinalCommitmentRecords(testCommitment);
        M2O_CommercialPolicyController.FinalCommitmentRecords finalParentRecords1 = new M2O_CommercialPolicyController.FinalCommitmentRecords(testCommitment1,ListChild);
        finalRecords.toggleExpand();
       // FinalCommitmentRecords finalParentRecords = new FinalCommitmentRecords(testCommitment);
    }
    
    
}