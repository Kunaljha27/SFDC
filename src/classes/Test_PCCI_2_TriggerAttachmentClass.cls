@isTest
public class Test_PCCI_2_TriggerAttachmentClass
{
    @istest static void triggerAttachmentTestMethod()
    {        
        Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
 Account acc= new Account(name='Acme',Housenumber_Local__c='111',Street1_Local__c='Street',City_Local__c='City',Region__c=regionData.id, Country__c='India',Zip_Postal_Code_Local__c='12345',BillingCity ='PUNE',BillingCountry='CA',BillingPostalCode='51554',BillingState='AB',BillingStreet='14/54');
   insert acc;
        Opportunity opp = new Opportunity(name='testopportunity', CloseDate=date.today(),Accountid=acc.id,StageName='P1',Vendor_of_Choice__c='Won',Funding_Status__c='Confident');
        insert opp;
        Opportunity_Notes_and_Attachments__c ONA1 = new Opportunity_Notes_and_Attachments__c(Related_Opportunity_Name__c =opp.id );
        insert ONA1;
        Opportunity_Notes_and_Attachments__c ONA2 = new Opportunity_Notes_and_Attachments__c(Related_Opportunity_Name__c =opp.id );
        insert ONA2;        
        Attachment att1 =new Attachment(Name='Test Attachment1',body =Blob.valueOf('Test Attachment Body1'),parentId=ONA1.id,IsPrivate=true);                 
        insert att1; 
        Attachment att2 =new Attachment(Name='Test Attachment2',body =Blob.valueOf('Test Attachment Body2'),parentId=ONA2.id,IsPrivate=true);                 
        insert att2; 
        Attachment att3 =new Attachment(Name='Test Attachment3',body =Blob.valueOf('Test Attachment Body3'),parentId=ONA2.id,IsPrivate=true);                 
        insert att3;  
        System.assert(att1!=null);   
        System.assert(att2!=null); 
        System.assert(att3!=null);                 
        delete att1;
        delete att2;
    }
}