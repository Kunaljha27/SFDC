/**
* @ClassName : M2O_ProductHierarchyOnLineItemTest
* @Description : 
* @Author : Ramita Dutta
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=true)
private class M2O_ProductHierarchyOnLineItemTest{

    /* 
    * @Description : This test method covers the  trigger
    */ 
    public static testMethod void test_ProductHierarchyOnLineItem() {
        list<Opportunity> listOpportunityRecord;
        List<OpportunityLineItem> listOppLineItemRecord;
        Product2 prod;
        PriceBookEntry pbe;
        Set<ID> oppIDList = new Set<ID>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
            test.starttest();
            account testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            StaticVariableClass.firstRun = true;
            listOpportunityRecord= M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            insert listOpportunityRecord;
            prod = M2O_CaptureDeleteTestDataUtility.getProductRecord();
            Insert prod;
            pbe = M2O_CaptureDeleteTestDataUtility.getPBEntryRecord(prod.ID ,listOpportunityRecord[0].currencyisocode);
            Insert pbe;
            for(Opportunity opp : listOpportunityRecord) {
                oppIDList.add(opp.ID);
            }
            listOppLineItemRecord = M2O_CaptureDeleteTestDataUtility.getListOfOppLineItemRecord(oppIDList, pbe.ID);
            Insert listOppLineItemRecord;
            delete listOppLineItemRecord[0];
        }
}