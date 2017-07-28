@isTest(seeAlldata=false)
  public class Test_AddSalesTeam
  {
@isTest static void AddSalesTeam_TestMethod()
 { 
user u;
Account a;
User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
 System.runAs (thisUser) {
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
            UserRole r = [SELECT Id FROM UserRole WHERE Name='Senior VP PCCI'];
            u = new User(alias = 'jsmtih21', email='jsmith424@acme.com', 
                emailencodingkey='UTF-8', lastname='Smithff', 
                languagelocalekey='en_US', 
                localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                timezonesidkey='America/Los_Angeles',
                QuotingSystem__c = 'Siebel', 
                username='jsmith1232@acme.com');
            insert u;
   a = new Account(name='Acme',BillingStreet='43',
BillingCity='Pune',
BillingState='Maharashtra',
BillingPostalCode='456006',
BillingCountry='CA');

        insert a;
        }
List<opportunity> listopp = new list<opportunity>();
List<opportunity> listopp1 = new list<opportunity>();
Opportunity opp=new Opportunity();
OpportunityTeamMember opt=new OpportunityTeamMember(); 
opp.Name='Test2';
    opp.AccountId=a.id;
    opp.CloseDate=System.today();
    opp.Vendor_of_Choice__c='Philips';
    opp.Funding_Status__c='Confident';
    opp.StageName='P1';
    insert opp;
    opt.OpportunityId=opp.id;
    opt.userId = u.id;
    insert opt;
    listopp.add(opp);
       
    Opportunity opp1=new Opportunity();
    OpportunityTeamMember opt1=new OpportunityTeamMember(); 
    opp1.Name='Test2';
    opp1.AccountId=a.id;
    opp1.CloseDate=System.today();
    opp1.Vendor_of_Choice__c='Philips';
    opp1.Funding_Status__c='Confident';
    opp1.StageName='P1';
    insert opp1;
    opt1.OpportunityId=opp1.id;
    opt1.userId = u.id;
    insert opt1;
    listopp1.add(opp1);
    test.starttest();
    Delay_AddSalesTeam dc = new Delay_AddSalesTeam ();
    //dc.AddSalesTeam(listopp , listopp1);
    test.stoptest();
}
}