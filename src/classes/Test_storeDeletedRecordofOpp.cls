@isTest(SeeAllData=True) 
  public class Test_storeDeletedRecordofOpp  {


@isTest static void storeDeletedRecordofOpp_TestMethod () 
{
 Opportunity opp=new Opportunity();
Delete_Opportunity__c dc = new Delete_Opportunity__c();
 Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert acc;
opp.Name='Test2';
opp.AccountId=acc.id;
opp.CloseDate=System.today();
opp.Vendor_of_Choice__c='Unknown';
opp.Funding_Status__c='Unknown';
opp.StageName='P1';
insert opp;

dc.Name='Test3';
insert dc; 
delete opp;
}
}