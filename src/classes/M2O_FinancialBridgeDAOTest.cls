/**
* @ClassName : M20_FinancialBridgeDAOTest
* @Description : This test class of M2O_FinancialBridgeDAO
* @Author : Srutadeba Chanda
* @Last Modified : 29/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=true)
private class M2O_FinancialBridgeDAOTest{ 

     /* 
      * @Description : This test method covers the querySapRecord() method of M2O_FinancialBridgeRevenueDAO class 
     */      
      
    @isTest static void test_QuerySapRecord(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        ID exceptionID='00aB0000000Cd8q';
        //string profileName= 'M2O KAM Lighting';
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
      
            test.starttest();
            M2O_FinancialBridgeDao.querySapRecord(strategicAccountPlanTestId);
            M2O_FinancialBridgeDao.querySAPRecord(exceptionID);
            system.assertEquals(strategicAccountPlanTest.name,'Test');    
            test.stoptest();
            
        }
    
    }
     
     /* 
      * @Description : This test method covers the queryUserAccess() method of M2O_FinancialBridgeRevenueDAO class 
     */      
    
     @isTest static void test_QueryUserAccess(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        ID exceptionID='00aB0000000Cd8q';
        //string profileName= 'M2O KAM Lighting';
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
  User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        //insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
    
            test.starttest();
            M2O_FinancialBridgeDao.queryUserAccess(userId,strategicAccountPlanTestId);
            M2O_FinancialBridgeDao.queryUserAccess(exceptionID,exceptionID);
            system.assertNotEquals(runAsUser ,null);
            test.stoptest();
                
        }
    
    }
    
     /* 
      * @Description : This test method covers the getFields() method of M2O_FinancialBridgeRevenueDAO class 
     */      
      
     @isTest static void test_GetFields(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        //string profileName= 'M2O KAM Lighting';
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            test.starttest();
             M2O_FinancialBridgeDao.getFieldsRevenue();
             M2O_FinancialBridgeDao.getFieldsProfit();
             test.stoptest();
            
        }
    }
    
    /* 
      * @Description : This test method covers the getFinancialData() method of M2O_FinancialBridgeRevenueDAO class 
     */ 
     @isTest static void test_GetFinancialData(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        ID exceptionID='00aB0000000Cd8q';
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
  User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser)  {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;
            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;

            List<M2O_CurrencySymbol__c> currencySymbol=M2O_FinancialBridgeTestDataUtility.getCurrencyRecord();
            //insert currencySymbol;

            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;

            id finBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
            id finBridgeRecordtypeProfit=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Profit').RecordTypeId;
            string quarter='(\'AOP\',\'End of Q1\')';
            
            test.starttest();
            M2O_FinancialBridgeDao.getFinancialData(quarter,strategicAccountPlanTestId,finBridgeRecordtype);
            M2O_FinancialBridgeDao.getFinancialData(quarter,strategicAccountPlanTestId,finBridgeRecordtypeProfit);
            quarter = 'test';
            M2O_FinancialBridgeDao.getFinancialData(quarter,exceptionID,finBridgeRecordtype);
            M2O_FinancialBridgeDao.getFinancialData(quarter,exceptionID,finBridgeRecordtypeProfit);
            system.assertEquals(finBridgeListProfit[0].Quarter__c,'AOP');
            test.stoptest();
                
        }
    
    }
    
     /* 
      * @Description : This test method covers the saveFinancialData() method of M2O_FinancialBridgeRevenueDAO class 
     */ 
     @isTest static void test_SaveFinancialData(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
  User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser)  {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
            List<Financial_Bridge__c> finBridgeList=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeRevenueRecord(strategicAccountPlanTest.id);
            insert finBridgeList;
 
            List<Financial_Bridge__c> finBridgeListProfit=M2O_FinancialBridgeTestDataUtility.getFinancialBridgeProfitRecord(strategicAccountPlanTest.id);
            insert finBridgeListProfit;
            id finBridgeRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
            id finBridgeRecordtypeProfit=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Profit').RecordTypeId;             
            test.starttest();
            M2O_FinancialBridgeDao.saveFinancialData(finBridgeList,finBridgeRecordtype);
            M2O_FinancialBridgeDao.saveFinancialData(finBridgeListProfit,finBridgeRecordtypeProfit);
            strategicAccountPlanTest.ID = null;
            finBridgeList[0].Strategic_Account_Plan__c = null;
            finBridgeListProfit[0].Strategic_Account_Plan__c = null;
            M2O_FinancialBridgeDao.saveFinancialData(finBridgeList,finBridgeRecordtype);
            M2O_FinancialBridgeDao.saveFinancialData(finBridgeListProfit,finBridgeRecordtypeProfit);
            system.assertEquals(finBridgeListProfit[0].Quarter__c,'AOP');
            test.stoptest();
        }
    }
}