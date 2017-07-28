@isTest
    public class Test_BatchUpdateOpportunityOwner{
        static testMethod void testBatchUpdateOpportunityOwner()   {
        BatchUpdateOpportunityOwner bc = new BatchUpdateOpportunityOwner();
        bc.query = 'SELECT OwnerId, Id, Owner_email__c, Owner.Email FROM Opportunity Limit 200';
        //Account acc=new Account();
Opportunity opp=new Opportunity(); 

User u;

   User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
    System.runAs (thisUser) {
     Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
     UserRole r = [SELECT Id FROM UserRole limit 1];
     Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
 Account acc= new Account(name='Acme',Housenumber_Local__c='111',Street1_Local__c='Street',City_Local__c='City',Region__c=regionData.id, Country__c='India',Zip_Postal_Code_Local__c='12345',BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',BillingState='AB',BillingStreet='14/54');
   insert acc;
   
    opp.Name='Test2';
    opp.AccountId=acc.id;
    opp.CloseDate=System.today();
    opp.Vendor_of_Choice__c='Philips';
    opp.Funding_Status__c='Confident';
    opp.StageName='P1';
    opp.ownerId=thisUser.id;
    //opp.Owner_email__c='arwa@gmail.com';

    insert opp;
    opp.Owner_email__c='arwa@gmail.com';
   update opp;
    
    }
        
        Test.startTest();
        Database.executeBatch(bc, 200);
        Test.stopTest();
    }
}