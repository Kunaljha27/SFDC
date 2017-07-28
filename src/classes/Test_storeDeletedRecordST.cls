@isTest(SeeAllData=True) 
  public class Test_storeDeletedRecordST  {

//@future
static void storeDeletedRecordST_TestMethod () 
{
User us=new User();
Profile pf1= [select id from Profile where name = 'System Administrator'];
UserRole rf1= [select id from UserRole where name = 'Account Manager Central CI'];

us.LastName = 'Test User';
us.TimeZoneSidKey = 'America/Los_Angeles';
us.LocaleSidKey='en_US';
us.LanguageLocaleKey = 'en_US';
us.Alias='tahu';
us.Email='taha.millu@gmail.com';
us.Username='testu@two.com';
us.CommunityNickname='tahu.millu';
us.QuotingSystem__c='Siebel';
us.EmailEncodingKey='ISO-8859-1';
us.ProfileId = pf1.Id;
us.UserRoleId=rf1.Id;
insert us;
}
@isTest static void storeDeletedRecordST_TestMethod2 () 
{
Account acc=new Account();
Opportunity opp=new Opportunity();
OpportunityTeamMember opt=new OpportunityTeamMember(); 
Delete_Opportunity_Team__c dc = new Delete_Opportunity_Team__c();
User u;
Account a;
   User thisUser = [SELECT Id, Email FROM User WHERE Id = :UserInfo.getUserId()];
   thisUser.QuotingSystem__c = 'Siebel';
   update thisUser;
    System.runAs (thisUser) {
     Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     UserRole r = [SELECT Id FROM UserRole limit 1];
        /*u = new User(alias = 'jsmtih21', email='jsmith424@acme.com', 
                emailencodingkey='UTF-8', lastname='Smithff', 
                languagelocalekey='en_US', 
                localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                timezonesidkey='America/Los_Angeles', 
                username='jsmith12323@acme.com');
            insert u;*/
            a = new Account(name='Acme',SourceSystem__c ='Siebel', BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',BillingState='AB',BillingStreet='14/54',City_Local__c='test',Street1_Local__c='test');
        insert a;
    opp.Name='Test2';
    opp.AccountId=a.id;
    opp.CloseDate=System.today();
    opp.Vendor_of_Choice__c='Philips';
    opp.Funding_Status__c='Confident';
    opp.StageName='P1';
    insert opp;
    opt.OpportunityId=opp.id;
    opt.userId = thisUser.id;
    insert opt;
    delete opt;
        dc.Record_ID__c ='Test1';
        dc.Name ='Test';
        dc.Email_Address__c =thisUser.email;
        dc.Functional_Role__c ='Primary Sales Rep';
        dc.Opportunity__c  = opp.id;
        dc.Opportunity_Access__c = 'Read Only';
        dc.Quoting_System__c ='Siebel';
        dc.Team_Role__c ='Account Manager CPS AL';
            
   insert dc;
  
    }

/*acc.Name='Test1';
acc.BillingStreet='43';
acc.BillingCity='Pune';
acc.BillingState='Maharashtra';
acc.BillingPostalCode='456006';
acc.BillingCountry='India';
acc.SourceSystem__c ='Siebel';
insert acc;*/


}
}