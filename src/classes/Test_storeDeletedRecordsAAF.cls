@isTest
  public class Test_storeDeletedRecordsAAF  {


 @istest static void storeDeletedRecordsAAF_TestMethod  () 
{

Account_affiliation__c acct=new Account_affiliation__c(); 
Delete_Affiliated_Account__c dc = new Delete_Affiliated_Account__c();
 Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert acc;     
acct.Affiliated_Account__c=acc.id;
insert acct;
 
dc.Record_ID__c ='Test1';
dc.Name ='Test';
            
            
dc.Affiliated_Account__C = acc.id;            
           
dc.Customer_Prospect__c = acc.id;            
dc.Relationship_Type__c ='3D Vendor';            
dc.Role__c ='Competitor'  ;            
dc.UniqueRelationshipID__c ='AFFialated';
insert dc;
delete acct;


}
}