@isTest
    public class Test_BatchDelete_OpportunityTeam{
         static testMethod void testBatchDelete_OpportunityTeam()   {
         BatchDelete_OpportunityTeam bc = new BatchDelete_OpportunityTeam();
         bc.query = 'SELECT Id FROM Delete_Opportunity_Team__c Limit 200';
         
          Profile pf1= [select id from Profile where name = 'System Administrator'];
      
          User u1 = new User(LastName = 'Test User',Username = 'testUser1234567@test.com',
                              Email = 'testuser@test.com',Alias = 'tu1' ,
                              CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                              ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
          insert u1;
          
          Region__c regiondata=M2O_AccountContactTestDataUtility.getRegionData();
        insert regiondata;
        Account acc=M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
         insert acc;   
     
          Opportunity opp = new Opportunity(Name ='Sampletest1',AccountId=acc.id,closedate=system.today(),
                                            StageName='Quatation',Primary_Rep__c=u1.id);
          Insert opp;
          
         Delete_Opportunity_Team__c dc = new Delete_Opportunity_Team__c();
         dc.Opportunity__c = opp.id;
         insert dc;
        
        Test.startTest();
        Database.executeBatch(bc, 200);
        Test.stopTest();
    }
}