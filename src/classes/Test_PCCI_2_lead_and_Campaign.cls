/*
Name : Test_PCCI_2_lead_and_Campaign
Created by:Rudra Nath Makhal
Purpose : It is the test class for the two triggers "campaign_Mem_update" and " Insert_delete_CampaignHistory"
*/
@isTest
public class Test_PCCI_2_lead_and_Campaign
{
    @istest static void triggerAttachmentTestMethod()
    {        
        Campaign Camp2 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',
                            RecordTypeId='012d0000000hJRh',BudgetedCost=0);
        Insert Camp2;
    
        Campaign Camp3 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',Parentid=Camp2.id,BudgetedCost=0);
        Insert Camp3;             
        
        Lead l1= new Lead(FirstName='H',Business_Group__c='Ultrasound',LastName='testLead',Sector__c='Healthcare', Lead_Value__c =15.00,Email='c@e.c',Country__c='India',Status='open',Company='Test',Campaign_del__c=Camp3.id);
        insert l1;
        
     //   CampaignMember cm1 = new CampaignMember(Campaignid=camp1.id ,Leadid =l1.id, Status ='Add-Outbound');
     //   insert cm1;              
        
        Lead l2= new Lead(FirstName='H',LastName='testLead',Business_Group__c='Ultrasound',Sector__c='Healthcare', Lead_Value__c =15.00,Email='c@e.c',Country__c='India',Status='open',Company='Test',Campaign_del__c=Camp3.id);
        insert l2;
        
      //  cm1.Leadid = l1.id;
       
        
       // cm1.Leadid =l1.id;
       // update cm1;
        
       // l1.Campaign_del__c=camp2.id;
        update l1;
        
     //   delete cm1;
    }
}