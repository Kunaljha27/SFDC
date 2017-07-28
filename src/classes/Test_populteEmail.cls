@istest
class Test_populteEmail{
    static testMethod void populteEmail_test(){
    
      Profile pf1= [select id from Profile where name = 'System Administrator'];
      
      User u1 = new User(LastName = 'Test User',Username = 'testUser1234567@test.com',
                          Email = 'testuser@test.com',Alias = 'tu1' ,
                          CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                          LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                          ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
      insert u1;
      
      Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
      insert regionData;
            
        Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
        insert acc;    
 
      Opportunity opp = new Opportunity(Name ='Sampletest1',AccountId=acc.id,closedate=system.today(),
                                        StageName='Quatation',Primary_Rep__c=u1.id);
      Insert opp;
      
      
    }
}