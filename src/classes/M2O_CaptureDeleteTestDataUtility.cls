/**
@Classname :       M2O_CaptureDeleteTestDataUtility
@Description :     This test class is written to store all the data related to cover Test Class for Capture Delete Trigger.
@Author:           Vishal Kashyap
@Last Modified:    13/1/2013
**/

@isTest(seeAllData=true)
public class M2O_CaptureDeleteTestDataUtility {
    
    /**
    @Description: gets region data.
    @Return:      region Data.
    **/ 
    
    public static Region__c getRegionData(){
        Region__c rediondata=new Region__c();
        rediondata.name='Test Region';
        rediondata.Country__c='India';
        rediondata.Region_Code__c='AA-113';
        return rediondata;
    
    }
    
    /**
    @Description: gets the M2O Lighting profile.
    @Return:      M2O Lighting profile
    **/ 
    
    public static ID getM2OSalesLIProfileId() {
    
        Profile liprofile  = [select id from Profile where name = 'M2O System Administrator'];
        return liprofile.ID;
    }

    
    /**
    @Description: Insert a user.
    @Param1:      Name of profile as a string.
    @Return:      User record.
    **/
    
    public static User getUserRecord(ID profileId) {
    
       User testUserRecord = new User(LastName = 'User',Username = 'test.user1.philips@philips.com', Email = 'test.user@philips.com',
                            Alias = 'tu1', CommunityNickname= 'tu11234561', TimeZoneSidKey = 'America/Los_Angeles', 
                            LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1', ProfileId = profileId, LanguageLocaleKey = 'en_US',
                            Permission_For_Data_Loader__c=true, Market__c = 'DACH',Philips_Sector_Name__c = 'HC');
       return testUserRecord;
    }
    
    /**
    @Description: Insert data to Validate M2O Profile Custom Setting.
    @Param:      Id of the profile.
    @Return:     Validate M2O Profile Data.
    **/     
    public static Validate_M2O_Profiles__c getValidateM2OData(ID profileId) {
       Validate_M2O_Profiles__c addM2O = new Validate_M2O_Profiles__c();
       addM2O.SetupOwnerId = profileId;
       addM2O.Validate_Profiles__c = true;
       return addM2O;
    }
    public static M2O_CDH_Applicable_Countries__c getM2OCDHApplicablecountries() {
       M2O_CDH_Applicable_Countries__c addCountry = new M2O_CDH_Applicable_Countries__c();
       addCountry.Is_Applicable__c = false;
       return addCountry;
    }
    
    public static M2O_CDH_Profiles_Not_Interfaced__c getM2OCDHProfilesnotinterfaced() {
        M2O_CDH_Profiles_Not_Interfaced__c addProf = new M2O_CDH_Profiles_Not_Interfaced__c();
        addProf.Not_Applicable__c = false;
        return addProf;
    }
    
    /**
    @Description: Insert a list of Lead.
    @Param1:      Integer count of user.
    @Param2:      Id of the profile.
    @Return:      list of Leads.
    **/ 
    
   
    public static list<Lead> getLeadRecords( ) {
    Integer j;
    List<Lead> testLeadlist= new List<Lead>();
        for (j=0; j<=10; j++){
            Lead testLead = new Lead(Salutation='Mr.',Country__c='India',Status='Open - Marketing Inquiry',Sector__c='Healthcare', FirstName='testLead', LastName='testLastName', Company='NA' ,Country='India', Phone='9823454376', MobilePhone='9874343346', Email='abc@xyz.com', Business_Phone__c='9876124345',Business_Group__c='HC-PCCI');
            testLeadlist.add(testLead);
        }
        return testLeadlist;
    }
    
    /**
    @Description: Create Account record.
    @Return:      Account data    
    **/  
 
    public static Account getAccountRecord() {
        Account acc;
        acc = new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=getRegionData().id, Zip_Postal_Code_Local__c = '2345');
        return acc;
    }
    
    /**
    @Description: Create Account record.
    @Return:      Account data    
    **/  
 
    public static Account getAccountRecordCD(region__c region) {
        Account acc;
        acc = new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=region.id);
        return acc;
    }
    
    /*
    @Description: Updated account record
    @Return:      Updated Account record 
    **/
    public static Account updateAccountRecord(Id userID, Id accountId) {
        Account accountToUpdate = new Account(name = 'Update' , Region__c=getRegionData().id , id = accountId, ownerId = userID,  BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA');
        return accountToUpdate;
    }
    
    public static list<Account> getListAccountRecord() {
        list<Account> acclist = new list<Account>();
        Account acc;
        for(Integer i=0;i<10;i++) {
        acc = new Account(name='Test'+i,BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=getRegionData().id);
        acclist.add(acc);
        }
    return acclist;
    }
    
    public static list<Account> getListAccountRecordCD(region__c region) {
        list<Account> acclist = new list<Account>();
        Account acc;
        for(Integer i=0;i<10;i++) {
        acc = new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=region.id);
        acclist.add(acc);
        }
    return acclist;
    }
    
    /**
    @Description: Create Master Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static Opportunity getOpportunityRecord(id accId) {
        RecordType recType = [SELECT Id FROM RecordType WHERE Id = '012d0000000hAvN']; //name = 'M2O Healthcare Opportunity'];
        Opportunity opp = new Opportunity();
        opp = new Opportunity();
        opp.Name ='Test Master Opty';
        opp.RecordType = recType;
        opp.closedate = system.today();
        opp.StageName='Best Case';
        opp.AccountId = accId;
        opp.CurrencyIsoCode='USD';
        opp.Sub_Opportunities_Total_Amounts__c = 0.0;
        opp.ForecastCategoryName = 'Omitted';
        opp.City__c='test';
        return opp;    
    }
    /**
    @Description: Create Master Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static List<Opportunity> getOpportunityRecord1(id accId) {
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=0; i<5; i++){
            Opportunity opp = new Opportunity();
            opp.Name ='Test HealthCareOpty';
            opp.RecordTypeId = '012d0000000hAvN';
            opp.Market__c = 'DACH';
            opp.closedate = system.today();
            opp.StageName='Best Case';
            opp.AccountId = accId;
            opp.CurrencyIsoCode='USD';
            opp.Sub_Opportunities_Total_Amounts__c = 0.0;
            opp.ForecastCategoryName = 'Omitted';
            opp.City__c='test';
            oppList.add(opp);
        }
        return oppList;    
    }
    
    /**
    @Description: Create Master Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static list<Opportunity> getOpportunityRecords(id accId) {
        Opportunity opp;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=10;i++) {
            opp = new Opportunity();
            opp.Name ='Test Master Opty'+i;
            opp.closedate = system.today();
            opp.StageName='Best Case';
            opp.AccountId = accId;
            opp.CurrencyIsoCode='USD';
            opp.Sub_Opportunities_Total_Amounts__c = 0.0;
            opp.ForecastCategoryName = 'Omitted';
            opp.City__c='test';
            listOpportunity.add(opp);
        }
        return listOpportunity ;    
    }
    
    /**
    @Description: Create SalesOrder data
    @Return:      SalesOrder data List
    **/
    
    public static List<sales_order__c> getSalesOrder(Id opp) {
        List<sales_order__c> salesRecordList = new List<sales_order__c>();
        for(integer i=0;i<5;i++){
            sales_order__c salesRecord = new sales_order__c();
            salesRecord = new Sales_Order__c();
            salesRecord.Opportunity__c = opp;
            salesRecord.Sales_Order_External_ID__c = 'testDACHRecord'+i;
            salesRecord.CurrencyIsoCode = 'USD';
            salesRecordList.add(salesRecord);
        }
        return salesRecordList;
    }
    
    public static list<Sales_Order_Line__c> getSalesOrderLine(sales_order__c salesOrder) {
        Sales_Order_Line__c salesLineRecord = new Sales_Order_Line__c();
        list<Sales_Order_Line__c> listSOrderLine = new list<Sales_Order_Line__c>();
        for(Integer i=0; i<=5;i++) {
            salesLineRecord = new Sales_Order_Line__c();
            salesLineRecord.Sales_Order__c = salesOrder.ID;
            salesLineRecord.Sales_Order_Line_External_ID__c = 'Test'+i;
            salesLineRecord.Chapter_SAP_Number_MMD__c = '678971';
            salesLineRecord.Item_ID__c = 8;
            listSOrderLine.add(salesLineRecord);
        }
        return listSOrderLine;
    }
    /**
    @Description: Create List of Delete Notifications records
    @Return:     collection of Delete Notifications records
    **/
    public static list<Delete_Notifications__c> getListOfDeleteNotification() {
        List<Delete_Notifications__c> listDeleteNotification = new List<Delete_Notifications__c>();
        Delete_Notifications__c deleteNotifyRecord;
        for(integer i = 0; i<10; i++) {
            deleteNotifyRecord = new Delete_Notifications__c();
            deleteNotifyRecord.Record_Id__c = 'LeadId' ;
            deleteNotifyRecord.CurrencyIsoCode = 'USD';
            deleteNotifyRecord.Error__c = 'Displays the Error Message';
            listDeleteNotification.add(deleteNotifyRecord);
           }               
        return listDeleteNotification;    
    }

     /**
    @Description: Create List of OpportunityLine Item records
    @Return:     collection of OpportunityLine Item records
    **/ 
    public static List<OpportunityLineItem> getListOfOppLineItemRecord(List<Opportunity> oppList, id priceBookEntryId) {       
        List<OpportunityLineItem> listOpportunityLineItem = new List<OpportunityLineItem>();
        for(Opportunity opp : oppList) {
            listOpportunityLineItem.add(new OpportunityLineItem(PricebookEntryId = priceBookEntryId,Sales_Recognition_Date_2__c=date.Today(), Quantity = 3,
                                                                ServiceDate = system.today(), OpportunityId = opp.Id, 
                                                                TotalPrice = 300));
        }
        return listOpportunityLineItem;
    }
    
    /**

    /**
    @Description: Create collection of Opportunity Ecosystem records
    @Return:      Collection of Opportunity Ecosystem records
    **/
    
    public static list<Opportunity_Ecosystem__c> getListOfOptyEcosystem(List<Opportunity> opp, list<account> acc) {
        List <Opportunity_Ecosystem__c> oppEcosystemList = new List<Opportunity_Ecosystem__c>();
        Opportunity_Ecosystem__c oppEcoRecord;
        for(integer i = 0; i<10; i++) {              
            oppEcoRecord = new Opportunity_Ecosystem__c();
            oppEcoRecord.Account_Role__c = 'Competitor';            
            oppEcoRecord.Account__c = acc[i].id;
            oppEcoRecord.Opportunity__c = opp[0].Id;
            oppEcosystemList.add(oppEcoRecord);
        }
        return oppEcosystemList;
    }
    
    /*##########################*/
     /**
    @Description: Create product
    @Return:      product record
    **/
    public static Product2 getProductRecord() {
       Product2 prod = new Product2(productCode = '9890828A', Name = 'Test Product', isActive = true, Family = 'IXR');
       return prod;       
    }
    
    /**
    @Description: Create PricebookEntry record
    @Return:      PricebookEntry record
    **/ 
    public static PricebookEntry getPBEntryRecord(id prodId , String currencyISO) {
        ID pb = getPriceBookRecord().ID;
        PricebookEntry pbEntry = new PricebookEntry(Product2Id = prodId, Pricebook2Id = pb, isActive = true, UnitPrice = 1.0,
                                                    CurrencyIsoCode = currencyISO, UseStandardPrice = false);
        return pbEntry;        
    }
    
    /**
    @Description: Create OpportunityLineItem record
    @Return:      OpportunityLineItem record
    **/ 
    public static OpportunityLineItem getOppLineItemRecord(id oppId, id pbeId) {       
        OpportunityLineItem oppLineItem = new OpportunityLineItem(PricebookEntryId = pbeId,Sales_Recognition_Date_2__c=date.Today(), Quantity = 3,
                                                                  ServiceDate = system.today(), OpportunityId = oppId, TotalPrice = 300);
        return oppLineItem;
    }
    
    /**
    @Description: Create List of OpportunityLine Item records
    @Return:     collection of OpportunityLine Item records
    **/ 
    public static List<OpportunityLineItem> getListOfOppLineItemRecord(Set<id> setOppId, id priceBookEntryId) {       
        List<OpportunityLineItem> listOpportunityLineItem = new List<OpportunityLineItem>();
        for(Id oppId : setOppId) {
            listOpportunityLineItem.add(new OpportunityLineItem(PricebookEntryId = priceBookEntryId,Sales_Recognition_Date_2__c=date.Today(), Quantity = 3,
                                                                ServiceDate = system.today(), OpportunityId = oppId, 
                                                                TotalPrice = 300));
        }
        return listOpportunityLineItem;
    }
    
    
    public static PriceBook2 getPriceBookRecord() {
       Pricebook2 priceBook = [SELECT Id FROM Pricebook2 where isstandard = true limit 1];
       return  priceBook;
    } 
    
}