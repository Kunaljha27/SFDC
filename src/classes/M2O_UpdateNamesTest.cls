/**
@Classname :       M2O_UpdateNamesTest
@Description :     This test class is written to test the trigger M2O_UpdateNames. 
@Author:           Vishal Kashyap
@Last Modified:    14/11/2014
**/

@isTest(SeeAllData=false)
public class M2O_UpdateNamesTest{
    /**
    @Description:  This test Method is used to cover the M2O_UpdateNames Trigger
    @Return:       Void   
    **/  
    
    static testMethod void test_M2O_UpdateNames() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Product_Adjustment_ID__c custAdj = new Product_Adjustment_ID__c();
            custAdj.Name = 'cust1';
            custAdj .Corresponding_Name__c='text1';
            custAdj.Type__c='text2';
            insert custAdj;
            Product_Hierarchy__c prodHierRecord = new Product_Hierarchy__c();
            prodHierRecord.Name='hier1';
            prodHierRecord.Article_Group_ID__c ='tst1';
            prodHierRecord.Article_Group_Name__c ='tst2';
            prodHierRecord.Business_Group_ID__c ='tst3';
            prodHierRecord.Business_Group_Name__c ='est4';
            prodHierRecord.Business_Unit_ID__c ='tst5';
            prodHierRecord.Lifecycle_Status__c ='1 - Draft';
            prodHierRecord.Business_Unit_Name__c ='tst7';
            prodHierRecord.Main_Article_Group_ID__c ='te8';
            prodHierRecord.Main_Article_Group_Name__c ='tst9';
            prodHierRecord.Sector_ID__c ='te10';
            insert prodHierRecord;
        }
    }
}