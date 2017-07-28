@isTest
private class preventDeleteAsset_Test 
{
    static testMethod void createasset() 
    {
         Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert a;     
         
        Product2 prod  = new Product2(Name='TEST',Description='Test',Family='Intellispace');
        insert prod; 
        
        Asset Ast = new Asset(Name ='New asset' ,AccountId=a.id,Product2= prod,Department__c='Anesthesiology',IsCompetitorProduct=false ,Medical_Services__c = 'Angio',Status='INSTALL',InstallDate=System.today());
        insert Ast;
       
        try
        {
            delete Ast;
        }
        catch(System.DMLException e)
        {
            //System.assert(e.getMessage().contains('Duplicate Contact'));
        }
     
    }
}