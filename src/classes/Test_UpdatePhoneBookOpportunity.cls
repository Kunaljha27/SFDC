@isTest
  public class Test_UpdatePhoneBookOpportunity 
  {
@isTest static void UpdatePhoneBookOpportunity_TestMethod()
 { 
 
 Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert a;
 
 /*Account acc=new Account();
     acc = new Account(name='Test',BillingStreet='43',
    BillingCity='Pune',
    BillingState='Maharashtra',
    BillingPostalCode='456006',
    BillingCountry='CA');
    insert acc;
     Account a=new Account() ;
      a = new Account(name='Acme',BillingStreet='43',
    BillingCity='Pune',
    BillingState='Maharashtra',
    BillingPostalCode='456006',
    BillingCountry='CA',Phone_Book_Account__c=true, Phone_Book_Parent__c=acc.id);

        insert a;*/
        
        Opportunity opp=new Opportunity();
        
        opp.Name='Test2';
        opp.AccountId=a.id;
        opp.CloseDate=System.today();
        opp.Vendor_of_Choice__c='Philips';
        opp.Funding_Status__c='Confident';
        opp.StageName='P1';
        insert opp;
   
        }
        }