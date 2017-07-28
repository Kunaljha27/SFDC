@isTest(SeeAllData=True) 
  public class Test_preventDeleteAsset  {


@isTest static void preventDeleteAsset_TestMethod () 
{
 Account acc=new Account();


acc.Name='Test1';
acc.BillingStreet='43';
acc.BillingCity='Pune';
acc.BillingState='AB';
acc.BillingPostalCode='456006';
acc.BillingCountry='CA';
acc.Facility_Type__c='Manufacturer';
acc.Street1_Local__c='test';
acc.City_Local__c='Kolkata';
acc.Zip_Postal_Code_Local__c ='00123444';
insert acc;


Asset a=new Asset();
a.AccountId=acc.id;
a.Name='Test';
a.Status='Purchased';
a.Department__c='Anesthesiology';
a.IsCompetitorProduct=true;
a.InstallDate=System.today();
a.Medical_Services__c='Ultrasound';
insert a;
delete a;
}
}