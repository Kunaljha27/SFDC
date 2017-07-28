@isTest
    public class Test_BatchDelete_AffiliatedAccount{
         static testMethod void testBatchDelete_AffiliatedAccount() {
         BatchDelete_AffiliatedAccount bc = new  BatchDelete_AffiliatedAccount();
         
        /*Account a = new Account(name='Acme',BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',
                                 BillingState='AB',BillingStreet='14/54');
        insert a;*/
         Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        Account a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert a;
        
        /*Account a1 = new Account(name='Acme1',BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',
                                 BillingState='AB1',BillingStreet='14/541');
        insert a1;*/
        Account a1 = new Account(name = 'test acc1', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
      insert a1;
        
        bc.query = 'SELECT Id FROM Delete_Affiliated_Account__c Limit 200';
        
        Delete_Affiliated_Account__c dc = new Delete_Affiliated_Account__c();
        dc.Affiliated_Account__c = a.id;
        dc.Customer_Prospect__c = a1.id;
        insert dc;
        
        Test.startTest();
        Database.executeBatch(bc, 200);
        Test.stopTest();
    }
}