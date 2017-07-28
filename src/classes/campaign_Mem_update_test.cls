@isTest(SeeAllData=true)
Public class campaign_Mem_update_test{
    Public static testMethod void campaign_Mem_updatetest(){
    Profile prof =[Select Id from Profile where Name = 'MDB IT Administrator' Limit 1];
    User u =  M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
    u.EscapeValidationRule__c = True;
    insert u;
    Region__c r = M2O_OpportunityTestDataUtility.getRegionData();
    insert r;
    Account acc =M2O_OpportunityTestDataUtility.getAccountRecord(r);
    insert acc;
    
    Campaign camp =new Campaign(Name='Test',Status='Planned',Type='BRC',Market_Group__c='EMEA',Business_Group__c='Ultrasound',Sector__c='HC',Campaign_Type__c='Digital Marketing',
                            RecordTypeId='012d0000000hJRh',BudgetedCost=0);
        Insert camp;
    system.runas(u){
    Lead l = new Lead(Salutation='MR',FirstName='test', LastName = 'test',Company='test',Status='Open',Contact_Required__c='CMR - Presentation',Product_of_Interest__c = 'test',Sector__c='Healthcare',
                       LeadSource='BRC',Campaign_del__c=camp.Id,Products_services_or_segments_Interest__c='CAI',Lead_Value__c=12343,Account__c=acc.Id,Email='Abc@abc.com',City__C = 'test',Country__c = 'India',Source_System__c='Eloqua',
                       SIC__c='Dental',Business_Group__c='LI-Other',Budget__c='Confident',Need__c='Strong',Timing__c='Urgent',Authority__c='Direct',Who_is_the_Campaign_MgrHome_SR_for__c=u.Id,Lead_Receive_date__c=system.today(),MobilePhone='9876543212');
    test.startTest();                   
    insert l;
    l.Company='ted';
    update l;
    test.stopTest();
    }
    }
    }