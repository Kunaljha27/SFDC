@isTest(SeeAllData=true)
private class Primary_Secondary_Rep_Test {

    static testMethod void runTest() {
    
      Profile pf1= [select id from Profile where name = 'System Administrator'];
      User u1 = new User(LastName = 'Test User',Username = 'testUser1234567@test.com',
      Email = 'testuser@test.com',Alias = 'tu1' ,
      CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
      LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
      ProfileId = pf1.Id, LanguageLocaleKey = 'en_US', Market__c='North America', Philips_Sector_Name__c='HC');
      insert u1;
    
        Pricebook2 stndPb = [Select Name, IsStandard, Id From Pricebook2 where IsStandard =: true];
        PricebookEntry pbEntry = [Select Id, currencyisocode, Name from PricebookEntry where isActive = true and currencyisocode = 'USD' and Pricebook2Id =: stndPb.Id Limit 1 ];
        /*Account a = new Account(name = 'Acme434'
                          , BillingStreet = '12345'
                          , billingcity = 'San Francisco'
                          , BillingState = 'CA'
                          , BillingCountry = 'US'
                          , BillingPostalCode = '12345',City_Local__c ='test',Street1_Local__c='test'
                            );
       insert a;  */
       Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
          Account a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                              HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                              Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                              Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
          insert a;
                
                //Opportunity opp1 = new Opportunity(Name = 'TestOppty1', CloseDate = System.today() + 7, StageName = 'Qualifier',AccountId=a.ID);
               // insert opp1;
        
        Opportunity opp = new Opportunity(Name = 'TestOppty1',Primary_Rep__c = u1.id ,  CloseDate = System.today() + 7, StageName = 'Qualifier',AccountId=a.ID,CurrencyIsoCode = 'USD');
        opp.Pricebook2Id = stndPb.Id;
        
        // For validation rule
        //opp.Government__c='ABC';
        //opp.New_or_Existing__c='ABC';
        //opp.International_or_Domestic__c='ABC';
        //opp.Solution_Type__c='ABC'; 
       // opp.Scope_of_Work__c='ABC'; 
       // opp.Response_Type__c='ABC'; 
       // opp.Deal_Structure__c='ABC'; 
       // opp.Terms_and_Conditions__c='ABC'; 
        //opp.Deal_Size__c='ABC';
        //opp.Perception_of_GE_offering__c = 'ABC';
       // opp.Requirements_vs_GE_lead_times__c='ABC';
       // opp.Key_Stakeholders_Analysis__c='ABC';
        //opp.Perception_of_GE_value_proposition__c='ABC';
        //opp.Perception_of_GE_vs_competition__c='ABC';
       // opp.Ability_to_purchase_GE_s_offering__c='ABC';
       // opp.RFP_issued__c ='ABC';
       // opp.Understanding_of_market_region__c='ABC';
       // opp.GE_s_solution_vs_competition__c='ABC';
      //  opp.GE_s_solution_vs_MGPP__c='ABC';
       // opp.GE_s_solution_vs_requirements__c='ABC';
      //  opp.Standardization_of_GE_solution__c='ABC';
      //  opp.Ability_to_enter_market__c='ABC';
       // opp.Strategic_or_Growth_Opportunity__c='ABC';
//opp.Solution_meet_P_L_CM_targets__c='ABC';
      //  opp.Proposal_Need_Date__c = System.today();
        
        
        insert opp;
        
       //Customer_Milestone__c cm = new Customer_Milestone__c(Opportunity__c=opp.id);
       
      // cm.Comments__c='Test';
       
       //insert cm;
        
        OpportunityLineItem oppLi = new OpportunityLineItem();          
        oppLi.OpportunityId = opp.Id;
        oppLi.PricebookEntryId = pbEntry.Id;
        oppLi.Quantity = 1;
        oppLi.UnitPrice = 0;
        //oppLi.Walk_Away_Price__c = 10;
        //oppLi.Customer_Target_Price__c = 20;
       // oppLi.Go_in_Price__c = 30;
        //oppLi.Final_Contract_Price__c = 0;
        insert oppLi;
        
        //ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
       
       // CloneOpportunityCtl ctl = new CloneOpportunityCtl(stdController);
        //ctl.NewName = 'test-test-test';
        //ctl.save();
        
        
    }
}