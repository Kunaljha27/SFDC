/**
@Classname :       M2O_BatchUpdateAccMarketAttributeTest
@Description :     This test class is written to cover the code of Batch class M20_BatchUpdateAccountMarketAttribute. 
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/

@isTest(SeeAllData=false)
public class M2O_BatchUpdateAccMarketAttributeTest {

    /**@Description :     This test method is used to test the M20_BatchUpdateAccMarketAttribute batch class
       @Return type:      void 
    **/ 
    
    static testMethod void test_batchAccountAttribute() {
    
        M2O_BatchUpdateAccountMarketAttribute batchUpdate = new M2O_BatchUpdateAccountMarketAttribute();
        User user = M2O_AccountContactTestDataUtility.getUserRecord();
        insert user;
        System.runAs(user) { 
        Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
                
            list<Account> listAccount= new list<Account>(M2O_AccountContactTestDataUtility.getAccountRecord(regionData));
            
            Test.startTest();
            insert listAccount;
            Database.executeBatch(batchUpdate, 200);
            System.assertNotEquals(listAccount,null);
            Test.stopTest();
        }
    }
}