/**
* @ClassName         : HCNA_FinancialObjPerfMgmtProfit_Test
* @Description       : This class is the test class which is covering the code of HCNA_FinancialObjPerformanceMgmtProfit Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public class HCNA_FinancialObjPerfMgmtProfit_Test {
    /* 
    * @Description : This test method covers the code of HCNA_FinancialObjPerformanceMgmtProfit Trigger
    */
    static testMethod void test_FinancialObjPerformanceMgmtProfitTrigger(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        Account apexAccount = HCNA_UtilityClass.getAccountRecord();
        insert apexAccount;
        Account account = HCNA_UtilityClass.getAccountRecord2(apexAccount);
        insert account;
        Strategic_Account_plan__c strategicAccountPlan = new Strategic_Account_plan__c();
        strategicAccountPlan.Account__c = account.Id;
        Insert strategicAccountPlan;
        Financial_Obj_Performance_Mgmt_Profit__c financialObjective = new Financial_Obj_Performance_Mgmt_Profit__c();
        financialObjective.Name='testFPP';
        financialObjective.Strategic_Account_Plan__c = strategicAccountPlan.Id;
        StaticVariableClass.firstRun = true;
        Insert financialObjective;
        StaticVariableClass.firstRun = true;
        Delete financialObjective;
    }  
}