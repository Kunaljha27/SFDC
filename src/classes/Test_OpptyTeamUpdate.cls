@isTest
public class Test_OpptyTeamUpdate
{
    @istest static void triggerAttachmentTestMethod()
    {        
        Profile p = [select id from profile where name='System Administrator']; 
        
        User testUser1 = new User(alias = 'u1', email='u1@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u1@testorg123.com'); 
        insert testUser1;
        
        User testUser2 = new User(alias = 'u2', email='u2@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing2', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u2@testorg1234.com'); 
        insert testUser2;
       
        User testUser3 = new User(alias = 'u3', email='u3@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing3', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u3@testorg12345.com'); 
        insert testUser3;
    
        Account acc = new Account(name = 'testaccount',billingState = 'West Bengal',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA');
        insert acc;       
        Opportunity opp = new Opportunity(name='testopportunity', CloseDate=date.today(),
        Accountid=acc.id,StageName='P1',Vendor_of_Choice__c='Won',
        Funding_Status__c='Confident', Secondary_Rep__c=testUser1.id,
        Working_Rep__c = testUser2.id);
        insert opp;
        opp.Primary_Rep__c = testUser1.id;
        opp.Secondary_Rep__c = testUser2.id;
        opp.Working_Rep__c = testUser3.id;
        update opp;
    }
}