/**
* @ClassName         : HCNA_ChartUtilityClass
* @Description       : This is utility class for storing the test data of HCNA.
* @Author            : Noor Ali Khan
* @Last Modified     : 26/06/2014
* @Discussion points : No Information
*/
public class HCNA_ChartUtilityClass{
    /**
    * @Description : This method creates Profile record.
    * @param       : None
    * @return      : Profile records.
    **/ 
    public static profile getHCNAProfileId() {      
        Profile liprofile  = [select id from Profile where name = 'System Administrator'];     
        return liprofile;    
    }
    
    /**
    * @Description : This method creates User record.
    * @param       : Profile 
    * @return      : User records.
    **/
    public static User getUserRecord(Profile profileId) {
        User testUserRecord = new User(LastName = 'User',Username = 'test.user1.philips@philips.com',
        Email = 'test.user@philips.com', Alias = 'tu1', CommunityNickname= 'tu11234561', 
        TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1', 
        ProfileId = profileId.id, LanguageLocaleKey = 'en_US', Permission_For_Data_Loader__c=true,EscapeValidationRule__c =True);      
        return testUserRecord;   
    }
    
    /**
    * @Description : This method creates Account(apex) record.
    * @param       : None
    * @return      : Account records.
    **/
    public static Account getAccountRecord() {
        Account acc;
        Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        acc = new Account(name = 'Asc_Apex_Acc_Test', Apex_Account_Identifier__c='Acc_jan',
           BillingStreet='test',
           BillingCountry='CA',
           Zip_Postal_Code_Local__c= '20016',
           BillingState='test',
           BillingCity='Test' ,
           Country__c = 'United States',
           Region__c=Rgn.id,
           Street1_Local__c='test',
           City_Local__c='test',        
           BillingPostalCode='20016',
           Housenumber_Local__c='203');                  
        return acc;
    }
    /**
    * @Description : This method creates Account(parent) record.
    * @param       : Account(apex)
    * @return      : Account records.
    **/
    public static Account getAssociatedAccountRecord(Account apexAcc) {
        Account acc;
        Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        acc = new Account(name = 'Asc_Parent_Acc_Test',Apex_Account_Identifier__c='Acc_jan',
           BillingStreet='test',
           BillingCountry='CA',
           Zip_Postal_Code_Local__c= '20016',
           BillingState='test',
           BillingCity='Test' ,
           Country__c = 'United States',
           Region__c=Rgn.id,
           Street1_Local__c='test',
           City_Local__c='test',        
           BillingPostalCode='20016',
           Housenumber_Local__c='203',
           Associated_IDN__c = apexAcc.Id);                   
        return acc;
    }
    
    
    /**
    * @Description : This method creates Opportunity record for parent account.
    * @param       : Account(parent)
    * @return      : Opportunity records.
    **/    
    public static list<OpportunityLineItem> getOpportunityLineItemList(list<Opportunity> opportunityList) {        
        Product2 product = new Product2();        
        product.Name = 'ProductXYZ';
        product.Family = 'testXYZ';
        insert product;         
                   
        Pricebook2 pb = new Pricebook2();
        pb =  [Select id from Pricebook2  where IsStandard = true];
        PricebookEntry pbEntry = New PricebookEntry();
        pbEntry.Pricebook2Id = pb.Id;
        pbEntry.Product2Id = product.id;
        pbEntry.UnitPrice = 100;
        pbEntry.UseStandardPrice = false;
        pbEntry.IsActive = true;
        pbEntry.CurrencyIsoCode = 'USD';
        insert pbEntry;                                             
            
        OpportunityLineItem oppLineItem;
        list<OpportunityLineItem> listOpportunityLineItem = new list<OpportunityLineItem>();
        for(Integer i=0; i<5;i++) {
            oppLineItem = new OpportunityLineItem();
            oppLineItem.OpportunityId = opportunityList[i].Id;
            oppLineItem.PricebookEntryId = pbEntry.id;
            oppLineItem.ServiceDate = system.Today(); 
            oppLineItem.TotalPrice=100;
            listOpportunityLineItem.add(oppLineItem);
        }
        return listOpportunityLineItem;
    }
    
    /**
    * @Description : This method creates StrategicAccountPlan record.
    * @param       : Account
    * @return      : StrategicAccountPlan records.
    **/
    public static Strategic_Account_Plan__c getStrategicAccountPlanRecord(Account acc) {
        Strategic_Account_Plan__c testStrategicAccountPlanRecord=new Strategic_Account_Plan__c();
        testStrategicAccountPlanRecord.name='Test';
        testStrategicAccountPlanRecord.Account__c =acc.Id;
        testStrategicAccountPlanRecord.Recommenadtion__c = 10;
        testStrategicAccountPlanRecord.Room_Quiet__c = 20;
        testStrategicAccountPlanRecord.Cost_of_Care__c = 30;
        testStrategicAccountPlanRecord.C_Diff__c = 11;
        testStrategicAccountPlanRecord.CLABSI__c = 12;
        testStrategicAccountPlanRecord.CAUTI__c = 13;
        testStrategicAccountPlanRecord.SSI_Colon__c = 14;
        testStrategicAccountPlanRecord.SSI_Hysterectomy__c = 15;
        testStrategicAccountPlanRecord.Readmissions__c = 21;
        testStrategicAccountPlanRecord.Hip_Knee_Readmissions__c = 22;
        testStrategicAccountPlanRecord.Heart_Faliure_Readmissions__c = 23;
        testStrategicAccountPlanRecord.Heart_Attack_Readmissions__c = 24;
        testStrategicAccountPlanRecord.Pneumonnia_Readmissions__c = 25;
        testStrategicAccountPlanRecord.Heart_Attack_Deaths__c = 31;
        testStrategicAccountPlanRecord.Heart_Failure_Deaths__c = 32;
        testStrategicAccountPlanRecord.Hip_Knee_Deaths__c = 33;
        testStrategicAccountPlanRecord.Pneumonia_Deaths__c = 34;
        return testStrategicAccountPlanRecord;
    }
    
    /**
    * @Description : This method creates Philips_Order_Value record.
    * @param       : StrategicAccountPlan 
    * @return      : Philips_Order_Value__c records.
    **/
    public static Philips_Order_Value__c getPhilipsOrderValueRecord(Strategic_Account_Plan__c sap) {
        Philips_Order_Value__c povRecord=new Philips_Order_Value__c();
        povRecord.HISS__c = 1000;
        povRecord.I_S__c = 1500;
        povRecord.PCMS__c = 2000;
        povRecord.POS__c = 1500;
        povRecord.U_S__c = 1200;
        povRecord.Year__c = '2008';
        povRecord.Strategic_account_plan__c = sap.id;
        povRecord.Total_M__c= 7200;
        return povRecord;
    }
    
    /**
    * @Description : This method creates Opportunity record for account.
    * @param       : Account, User
    * @return      : Opportunity record.
    **/
    public static Opportunity getOpportunityRecord(Account acc, User user) {
        Opportunity opp = new Opportunity();
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('PCMS Opportunity').getRecordTypeId();
        opp = new Opportunity();
        opp.Name ='Test';
        opp.OwnerId = user.id;
        opp.AccountId = acc.Id;
        opp.closedate = system.today();
        opp.StageName='Lost';
        opp.recordTypeId =devRecordTypeId;
        opp.CurrencyIsoCode='USD';
        opp.ForecastCategoryName = 'Pipeline';
        opp.Strategic_Marketing__c='Strategic';
        opp.Vendor_of_Choice__c='Philips';
        opp.Funding_Status__c='Neutral';
        opp.Must_Win_flag__c= true;
        opp.Business_Group_HCNA__c='US';
        opp.Amount = 1000.00;
        return opp;
    }
    
    /**
    * @Description : This method creates customer financial detail for the SAP.
    * @param       : ID sapID
    * @return      : Customer_Financial_Detail__c record.
    **/
    public static Customer_Financial_Detail__c getFinancialDetailRecord(ID sapId) {
        Customer_Financial_Detail__c financialDetailRecord = new Customer_Financial_Detail__c();
        financialDetailRecord.Net_patient_revenue__c = 1000.0;            
        financialDetailRecord.Operating_Expenses__c = 750.0;        
        financialDetailRecord.Cash_on_Hand__c = 450.0;        
        financialDetailRecord.Temporary_Investments__c = 200.0;
        financialDetailRecord.Total_Operating_Expenses__c = 800.0;
        financialDetailRecord.Depreciation_Expense__c = 500.0;
        financialDetailRecord.Current_Assets__c = 150.0;
        financialDetailRecord.Current_Liabilities__c = 50.0;
        financialDetailRecord.Payor_Mix_Medicaid__c = 250.0;
        financialDetailRecord.Payor_Mix_Medicare__c = 45.0;
        financialDetailRecord.Year__c = '2014';
        financialDetailRecord.Strategic_account_plan__c = sapId; 
        return financialDetailRecord;
    }
    
    /**
    * @Description : This method creates Opportunity record for parent account.
    * @param       : Account(parent)
    * @return      : Opportunity records.
    **/    
    public static OpportunityLineItem getOpportunityLineItem(Opportunity opportunityRecord) {        
        Product2 product = new Product2();        
        product.Name = 'ProductXYZ';
        product.Family = 'testXYZ';
        insert product;         
                   
        Pricebook2 pb = new Pricebook2();
        pb =  [Select id from Pricebook2  where IsStandard = true];
        PricebookEntry pbEntry = New PricebookEntry();
        pbEntry.Pricebook2Id = pb.Id;
        pbEntry.Product2Id = product.id;
        pbEntry.UnitPrice = 100;
        pbEntry.UseStandardPrice = false;
        pbEntry.IsActive = true;
        pbEntry.CurrencyIsoCode = 'USD';
        insert pbEntry;                                   
            
        OpportunityLineItem oppLineItem = new OpportunityLineItem();
        oppLineItem.OpportunityId = opportunityRecord.Id;
        oppLineItem.PricebookEntryId = pbEntry.id;
        oppLineItem.ServiceDate = system.Today(); 
        oppLineItem.TotalPrice=100;
        return oppLineItem;
    }
}