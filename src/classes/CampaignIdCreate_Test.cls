@istest(SeeAllData=True)
Public class CampaignIdCreate_Test{
    Public static testMethod void CmpIDC(){
        Campaign Camp1 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',
                            RecordTypeId='012d0000000hJRh',BudgetedCost=0);
        Insert Camp1;
        
        Campaign Camp2 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',
                            RecordTypeId='012d0000000hJRh',BudgetedCost=0);
        Insert Camp2;
    
        Campaign Camp3 = new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',Parentid=Camp2.id,BudgetedCost=0);
        Insert Camp3;             
    }
}