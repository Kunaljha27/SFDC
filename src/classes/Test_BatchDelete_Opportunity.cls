@isTest
    public class Test_BatchDelete_Opportunity{
         static testMethod void testBatchDelete_Opportunity()   {
         BatchDelete_Opportunity bc = new BatchDelete_Opportunity();
      //  bc.query = 'SELECT Id FROM Delete_Opportunity__c Limit 200';
         
        Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
   Account a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert a;

        
        /*Account  a = new Account(name='Acme',BillingStreet='43',
        BillingCity='Pune',
        BillingState='Maharashtra',
        BillingPostalCode='456006',
        BillingCountry='CA');

        insert a;*/
        
        Opportunity opp=new Opportunity();
        
        opp.Name='Test2';
        opp.AccountId=a.id;
        opp.CloseDate=System.today();
        opp.Vendor_of_Choice__c='Unknown';
        opp.Funding_Status__c='Unknown';
        opp.StageName='P1';
        insert opp;
        Delete_Opportunity__c delopp=new Delete_Opportunity__c(name='test del opp',Record_ID__c='opp.id');
        insert delopp;
        Test.startTest();
        Database.executeBatch(bc);
        Test.stopTest();
    }
}