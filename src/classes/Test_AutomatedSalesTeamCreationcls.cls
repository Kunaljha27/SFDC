@isTest(SeeAllData=True) 
  public class Test_AutomatedSalesTeamCreationcls  {


@isTest static void AutomatedSalesTeamCreationcls_TestMethod () 
{
User u;
profile p = [Select id from Profile where name = 'System Administrator' limit 1];

 u = new User(alias = 'u1', email='u1@testorg.com',
      emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
      localesidkey='en_US', profileid = p.Id, country='United States', FederationIdentifier = '8621987',
      timezonesidkey='America/Los_Angeles', username='testuser@abc.com.abc',Market__c='North America', Philips_Sector_Name__c='HC');
 
   insert u;
System.runAs (u) {
Opportunity opp=new Opportunity();
/*
Account acc=new Account();

acc.Name='Test1';
acc.BillingStreet='43';
acc.BillingCity='Pune';
acc.BillingState='Maharashtra';
acc.BillingPostalCode='456006';
acc.BillingCountry='CA';
insert acc;
*/
Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
          Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                              HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                              Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                              Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
          insert acc;

/*Opportunity_Routing_Table__c r=new Opportunity_Routing_Table__c();
r.Routing_Active__c = true;
r.Routing_Department__c = 'Cardiology';
r.Routing_Functional_Role__c = 'Primary';
r.Routing_Medical_Services__c = 'ElectroPhysiology';
r.Routing_Roles__c = 'CIA';
insert r;
*/
AccountTeamMember atm = New AccountTeamMember();
atm.AccountId = acc.id;
atm.TeamMemberRole = 'CIA';
atm.UserId = u.id;
insert atm;

opp.Name='Test2';
opp.AccountId=acc.id;
opp.CloseDate=System.today();
opp.Vendor_of_Choice__c='Philips';
opp.Funding_Status__c='Confident';
opp.StageName='P1';
opp.Department__c='Cardiology';
opp.Medical_Services__c='ElectroPhysiology';
insert opp;

string dept;
dept=opp.Department__c;

string medical;
medical=opp.Medical_Services__c;
 id AccId;
AccId=opp.AccountId;
id Oppid;
Oppid=opp.Id;

AutomatedSalesTeamCreationcls auto=new AutomatedSalesTeamCreationcls();
system.debug('@@@@'+dept+medical+AccId+Oppid);
AutomatedSalesTeamCreationcls.AddsalesTeam(dept,medical, AccId, Oppid);
}

}
}