@isTest
public without sharing class M2O_AdcodeGenerationTest{
    public static testMethod void test_Campaign(){
        test.startTest();
        RecordType masterRecType = [Select Id from RecordType where Name = 'M2O Parent Campaign'];
        RecordType channelRecType = [Select Id from RecordType where Name = 'M2O Channel Campaign'];
        
        Campaign Camp1 = new Campaign(Name='Test',Division__c='EMS',Status='Planned',Type='BRC',
                            Type__c='Inbound',CNumber__c=1000,Country_ISO_Code__c='WW - WorldWide', 
                            Business_Group__c='IS – Imaging Systems', RecordTypeId = masterRecType.Id, Market_Group__c = 'EMEA',
                            Campaign_Type__c = 'Digital Marketing', Campaign_Goal__c = 'Brand Awareness',
                            BudgetedCost = 0);
        Insert Camp1;
        
        Campaign Camp2 = new Campaign(Name='Test',Division__c='EMS',Status='Planned',Type='BRC',
                            Type__c='Inbound',CNumber__c=1000,Country_ISO_Code__c='WW - WorldWide', 
                            Business_Group__c='IS – Imaging Systems', RecordTypeId = channelRecType.Id, Market_Group__c = 'EMEA',
                            Campaign_Type__c = 'Digital Marketing', Campaign_Goal__c = 'Brand Awareness',
                            BudgetedCost = 0, ParentId = Camp1.Id);
        Insert Camp2;
        test.stopTest();
    }
}