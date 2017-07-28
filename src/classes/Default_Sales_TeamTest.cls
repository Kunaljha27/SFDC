@istest
class Default_Sales_TeamTest{
/*
    static testMethod void DefaultSalesTeam(){
    
      Account acc = new Account(Name='SampleTest',Archived_Record__c=FALSE,
       billingState = 'West Bengal',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA'
     );
    Insert acc;      
        
      Profile pf1= [select id from Profile where name = 'System Administrator'];
      User u1 = new User(LastName = 'Test User',Username = 'testUser1234567@test.com',
      Email = 'testuser@test.com',Alias = 'tu1' ,
      CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
      LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
      ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
      insert u1;
     
      User u2 = new User(LastName = 'Test User33333',Username = 'testUs447@test.com',
      Email = 'testuse444@test.com',Alias = 'T234' ,
      CommunityNickname= 'tu1126' ,TimeZoneSidKey = 'America/Los_Angeles',
      LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
      ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
      insert u2;
      
    
      Account_Team_Member__c SampleAccountTeamMember = new Account_Team_Member__c(Account__c = acc.id, User__c = u1.id);  
      insert  SampleAccountTeamMember;       
      
      Opportunity opp = new Opportunity(Name ='Sampletest1',AccountId=acc.id,closedate=system.today(),StageName='Quatation',Primary_Rep__c=u1.id);
      Insert opp;
      
        OpportunityTeamMember otm = new OpportunityTeamMember();
        otm.Opportunityid= opp.id;
        otm.UserId=u2.id;
        otm.TeamMemberRole='Account Manager Central CI';
        //otm.ownerid = u1.id;
      
        insert otm;
   
      Default_Sales_Team.Defaultteam('005d0000001TK08',opp.id);    
      
    }*/
}