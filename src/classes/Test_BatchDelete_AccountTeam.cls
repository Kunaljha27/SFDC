@isTest
    public class Test_BatchDelete_AccountTeam{
         static testMethod void testBatchDelete_AccountTeam()  {
         
        //bc.query = 'SELECT Id FROM Delete_Account_Team__c Limit 200';
        Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData;
                    
        Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
        insert acc;
        
        Delete_Account_Team__c dc = new Delete_Account_Team__c();
        dc.Account__c = acc.id;
        dc.Account_Team_Member_Name__c = 'test user';
        insert dc;
        
        Test.startTest();
        BatchDelete_AccountTeam bc = new  BatchDelete_AccountTeam();
        system.debug('ppppppp'+bc.query);
        Database.executeBatch(bc);
        Test.stopTest();
    }
}