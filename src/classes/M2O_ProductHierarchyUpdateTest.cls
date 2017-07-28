/**
* @ClassName : M2O_ProductHierarchyUpdateTest
* @Description : 
* @Author : Ramita Dutta
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=true)
private class M2O_ProductHierarchyUpdateTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_ProductHierarchyUpdate() {
        list<Opportunity> listOpportunityRecord;
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
       // System.runAs(userRecordTest) { 
            test.starttest();
            Region__c regiondata = new Region__c();
            regiondata = M2O_OpportunityTestDataUtility.getRegionData();
            account testAccount = M2O_OpportunityTestDataUtility.getAccountRecord(regiondata);
            insert testAccount;
            StaticVariableClass.firstrun = true;
            listOpportunityRecord= M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(testAccount.ID);
            listOpportunityRecord[0].Business_Innovation_Unit__c= 'CS Undivided';
            insert listOpportunityRecord;
        }
    }