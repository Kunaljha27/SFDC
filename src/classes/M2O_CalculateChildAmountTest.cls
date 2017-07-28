@isTest
public without sharing class M2O_CalculateChildAmountTest {
    public static testMethod void test_Campaign(){
        test.startTest();
        RecordType masterRecType = [Select Id from RecordType where Name = 'M2O Parent Campaign'];
        RecordType channelRecType = [Select Id from RecordType where Name = 'M2O Channel Campaign'];
        try{
        Campaign Camp1 = new Campaign(Name='Test',Division__c='EMS',Status = 'Cancelled',Type='BRC',
                            Type__c='Inbound',CNumber__c=1000,Country_ISO_Code__c='WW - WorldWide', 
                            Business_Group__c='IS – Imaging Systems', RecordTypeId = masterRecType.Id, Market_Group__c = 'EMEA',
                            Campaign_Type__c = 'Digital Marketing', Campaign_Goal__c = 'Brand Awareness',
                            BudgetedCost = 490, Reason_For_Cancellation__c = 'No budget');
        Insert Camp1;
        system.debug('Camp1@@@@@@2 '+Camp1);
        Campaign Camp2 = new Campaign(Name='Test',Division__c='EMS',Status='Planned',Type='BRC',
                            Type__c='Inbound',CNumber__c=1000,Country_ISO_Code__c='WW - WorldWide', 
                            Business_Group__c='IS – Imaging Systems', RecordTypeId = channelRecType.Id, Market_Group__c = 'EMEA',
                            Campaign_Type__c = 'Digital Marketing', Campaign_Goal__c = 'Brand Awareness',
                            BudgetedCost = 500, ParentId = Camp1.Id);
        Insert Camp2;
        }catch(Exception e){
        }
        test.stopTest();
    }
}