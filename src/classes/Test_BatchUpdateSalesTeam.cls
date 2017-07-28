@isTest
    public class Test_BatchUpdateSalesTeam{
    static testMethod void testBatchUpdateSalesTeam()   {
        BatchUpdateSalesTeam bu = new BatchUpdateSalesTeam ();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
     
    User u1 = new User(LastName = 'Test User',Username = 'testUser1234567@test.com',
                              Email = 'testuser@test.com',Alias = 'tu1' ,
                              CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                              ProfileId = p.Id, LanguageLocaleKey = 'en_US');
          insert u1;
          Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
 Account acc= new Account(name='Acme',Housenumber_Local__c='111',Street1_Local__c='Street',City_Local__c='City',Region__c=regionData.id, Country__c='India',Zip_Postal_Code_Local__c='12345',BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',BillingState='AB',BillingStreet='14/54');
   insert acc;
        
        Opportunity opp=new Opportunity(); 
    opp.Name='Test2';
    opp.AccountId=acc.id;
    opp.Strategic_Marketing__c = 'Strategic';
    opp.CurrencyIsoCode='USD';
    opp.Funnel__c='Pipeline';
    opp.CloseDate=System.today();
    opp.Vendor_of_Choice__c = 'Philips';
    opp.Funding_Status__c='Confident';
    opp.StageName='P1';
    opp.ownerId=u1.id;
    insert opp;
    datetime dt = datetime.now();
    dt.addminutes(-1);
    OpportunityTeamMember otm = new OpportunityTeamMember();
    //otm.OpportunityAccessLevel ='Read Only';
    otm.TeamMemberRole = 'Testrole';
    otm.Functional_Role__c ='Working Rep';
    otm.Sent_to_siebel__c = false;
    otm.userId = u1.Id;
    otm.OpportunityId = opp.Id;
    insert otm;
             
        Test.startTest();
        Database.executeBatch(bu, 200);
        Test.stopTest();
        }
        }