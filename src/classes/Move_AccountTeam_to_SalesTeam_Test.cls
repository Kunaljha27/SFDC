@istest

class Move_AccountTeam_to_SalesTeam_Test{
    static testMethod void MoveAccountTeamSalesTeam(){
      Account acc = new Account(Name='SampleTest',Archived_Record__c=FALSE,
      billingState = 'West Bengal',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA');
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
      
      Opportunity opp2 = new Opportunity(Name ='Sampletest2',AccountId=acc.id,closedate=system.today(),StageName='Quatation',Primary_Rep__c=u1.id);
      Insert opp2;
      
      sales_Team__c SampleSalesTeamMember = new Sales_Team__c(User__c = u2.id,opportunity__c = opp.id); 
      insert SampleSalesTeamMember;
      
      system.debug('@@@@@@@@@Opp.Id@@@@@@@@@'+Opp.Id);
      Move_AccountTeam_to_SalesTeam.Move_ATM(Opp.Id);
      Move_AccountTeam_to_SalesTeam.Move_ATM(Opp2.Id);      
      
    }
}