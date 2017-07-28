@istest
Public class TestCampaignMemUpdtae
{
 Public static testMethod void LeadTest()
 {
    Campaign Camp1 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',
                            RecordTypeId='012d0000000hJRh',BudgetedCost=0);
    Insert Camp1;
    
    Campaign Camp2 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',Parentid=Camp1.id,BudgetedCost=0);
    Insert Camp2;
    Campaign Camp3 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',Parentid=Camp1.id,BudgetedCost=0);
    Insert Camp3;
    Lead Lead1 = new Lead(LastName='Test',FirstName='TestWW',Business_Group__c='Ultrasound',Country__c='India',Campaign_del__c=Camp2.id,Status='Pending',Sector__c='Healthcare',Company='Wipro',Rating='Cold',Email='avik@kiva.com' );
    Insert Lead1;
    
    Lead Lead2 = new Lead(LastName='Tes2t',FirstName='TestWW22',Business_Group__c='Ultrasound',Country__c='India',Campaign_del__c=Camp2.id,Status='Pending',Sector__c='Healthcare',Company='Wipro',Rating='Cold',Email='avik@kivwea.com' );
    Insert Lead2;
    
    Lead1.Campaign_del__c=Camp3.id;
    Update Lead1;
    
    campaignmember testCM = new campaignmember();
    testCM.LeadID = Lead2.ID;
    testCM.CampaignID = camp3.ID;
    
    insert testCM;
    
    Delete testCM;
     
    
 }
 }