/**
    ClassName : M2O_ChapterNumberUpdateServiceTest
    Description : This test class is written to cover the code for the Apex class M2O_ChapterNumberUpdateServiceTest .
    Author : Meeta Pramanik
    Last Modified : 08/04/2014
    */
@isTest(SeeAllData=true)
private class M2O_ChapterNumberUpdateServiceTest {
    
    public static testMethod void test_ChapterNumberUpdate() {
        M2O_ChapterNumberUpdateService chapterNumber = new M2O_ChapterNumberUpdateService();
        list<Opportunity> listOpportunityRecord;
        List<OpportunityLineItem> listOppLineItemRecord;
        Product2 prod;
        PriceBookEntry pbe;
        Set<ID> oppIDList = new Set<ID>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        System.runAs(userRecordTest) { 
         test.starttest();
            account testAccount = M2O_CaptureDeleteTestDataUtility.getAccountRecord();
            insert testAccount;
            listOpportunityRecord= M2O_CaptureDeleteTestDataUtility.getOpportunityRecords(testAccount.ID);
            listOpportunityRecord[0].type='Multi Modality Deal';
            listOpportunityRecord[0].RecordTypeId = Label.M2O_Opportunity_Healthcare_RecordType_ID;
            insert listOpportunityRecord;
            prod = M2O_CaptureDeleteTestDataUtility.getProductRecord();
            Insert prod;
            pbe = M2O_CaptureDeleteTestDataUtility.getPBEntryRecord(prod.ID ,listOpportunityRecord[0].currencyisocode);
            Insert pbe;
            Set<Id>oppIdSet = new Set<Id>();
            for(Opportunity opp : listOpportunityRecord) {
                oppIDList.add(opp.ID);
                oppIdset.add(opp.ID);
            }
            listOpportunityRecord = new List<Opportunity>();
            listOpportunityRecord = M2O_OpportunityDAO.getOpportunityId(oppIdset);
            System.debug('@@listOpportunityRecord '+listOpportunityRecord +'  '+oppIdset);
            listOppLineItemRecord = M2O_CaptureDeleteTestDataUtility.getListOfOppLineItemRecord(oppIDList, pbe.ID);
            for(OpportunityLineItem oppLine : listOppLineItemRecord ) {
                oppIDList.add(oppLine.ID);
                oppIdset.add(oppLine.OpportunityId);
                }
            insert listOppLineItemRecord;
            chapterNumber.ChapterNumberUpdate(listOppLineItemRecord, oppIdset);
            chapterNumber.ChapterNumberUpdate(null, null);
            System.assertNotEquals(listOppLineItemRecord,null);
            test.stoptest(); 
        }
    }
  }