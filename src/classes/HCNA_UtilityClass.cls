/**
* @ClassName         : HCNA_UtilityClass
* @Description       : This is utility class for storing the test data of HCNA.
* @Author            : Ramita Dutta 
* @Last Modified     : 24/03/2014
* @Discussion points : No Information
*/
public class HCNA_UtilityClass{
    /**
    * @Description : This method creates Profile record.
    * @param       : None
    * @return      : Profile records.
    **/ 
    public static profile getHCNAProfileId() {      
        Profile liprofile  = [select id,name from Profile where name = 'System Administrator'];     
        return liprofile;    
    }
    /**
    * @Description : This method creates Profile record.
    * @param       : None
    * @return      : Profile records.
    **/     
    public static profile getHCNAProfileId1() {      
        Profile liprofile1  = [select id,name from Profile where name = 'M2O System Administrator'];     
        return liprofile1;    
    }
    /**
    * @Description : This method creates Profile record.
    * @param       : None
    * @return      : Profile records.
    **/     
    public static profile getHCNAProfileId2() {      
        Profile liprofile2  = [select id,name from Profile where name = 'System Administrator'];     
        return liprofile2;    
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
        ProfileId = profileId.id, LanguageLocaleKey = 'en_US', Permission_For_Data_Loader__c=true,EscapeValidationRule__c =True,isActive=true);      
        return testUserRecord;   
    }
    /**
    * @Description : This method creates User record.
    * @param       : Profile 
    * @return      : User records.
    **/                             
    public static User getUserRecord1(Profile profileId) {
        User testUserRecord1 = new User(LastName = 'User1',Username = 'test.user2.philips@philips.com',
        Email = 'test.user@philips.com', Alias = 'tu1', CommunityNickname= 'tu11234562', 
        TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1', 
        ProfileId = profileId.id, LanguageLocaleKey = 'en_US', Permission_For_Data_Loader__c=true,IsActive=true);      
        return testUserRecord1;   
    }                
        /**
    * @Description : This method creates User record.
    * @param       : Profile 
    * @return      : User records.
    **/                             
    public static User getUserRecord2(Profile profileId2) {
        User testUserRecord2 = new User(LastName = 'User1',Username = 'test.user3.philips@philips.com',
        Email = 'test.user@philips.com', Alias = 'tu1', CommunityNickname= 'tu11234562', 
        TimeZoneSidKey = 'America/Los_Angeles', LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1', 
        ProfileId = profileId2.id, LanguageLocaleKey = 'en_US', Permission_For_Data_Loader__c=true);      
        return testUserRecord2; 
    }
    /**
    * @Description : This method creates priceBook record.
    * @param       : None
    * @return      : priceBook records.
    **/     
    public static Pricebook2 getPriceBookData() {      
        Pricebook2 priceBookRecord = [Select id from Pricebook2  where IsStandard = true];
        return priceBookRecord;    
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
    public static Account getAccountRecord2(Account apexAcc) {
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
    * @Description : This method creates Account(child) record.
    * @param       : Account(apex),Account(parent)
    * @return      : Account records.
    **/
    public static Account getChildAccountRecord(Account apexAcc,Account parentAcc) {
        Account childAcc;
        Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        childAcc= new Account(name='Child_Asc_Child_Acc_Test_1', Apex_Account_Identifier__c='Acc_jan',
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
           Housenumber_Local__c='203', Associated_IDN__c= apexAcc.Id,
        Parent_IDN_of_Associated_IDN__c=parentAcc.id);
        return childAcc;
    }
    /**
    * @Description : This method creates List of Account records.
    * @param       : Apex Account, Parent Account
    * @return      : List of Account records.
    **/
     public static List<Account> getListOfAccountRecord(Account apexAcc,Account parentAcc) {
        List<Account> accountList = new List<Account>();
        Account childAcc;
        Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        for(Integer i=0;i<=3;i++){
        childAcc= new Account(name='Child_Asc_Child_Acc_Test_1'+i, Apex_Account_Identifier__c='Acc_jan',
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
           Housenumber_Local__c='203',Associated_IDN__c= apexAcc.Id,
        Parent_IDN_of_Associated_IDN__c=parentAcc.id);
        accountList.add(childAcc);
        }
        return accountList;
    }
    /**
    * @Description : This method creates List of child Account records.
    * @param       : None
    * @return      : List of child Records.
    **/
     public static List<Account> getListOfAccountRecord2() {
        List<Account> accountList = new List<Account>();
        Account childAcc;
        Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        for(Integer i=0;i<=3;i++){
        childAcc= new Account(name='Child_Asc_Child_Acc_Test_1'+i,Apex_Account_Identifier__c='Acc_jan',
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
        accountList.add(childAcc);
        }
        return accountList;
    }
    /**
    * @Description : This method creates Contact record for parent account.
    * @param       : Account(parent)
    * @return      : Contact records.
    **/
    public static list<Contact> getContactRecord(Account acc) {
        list<Contact> conlist = new list<Contact>();
        Contact con;
        RecordType RecType = [Select Id From RecordType  Where SobjectType = 'Contact' And DeveloperName = 'M2O_Contact'];       
        for(Integer i=0;i<100;i++) {
            con = new Contact (AccountId = acc.Id,Phone='983029888',FirstName = 'Test'+i, LastName = 'User', 
            Salutation = 'Mr.',Work_Email__c = 'test.user@philips.com', Language__c = 'German', RecordTypeId = RecType.id);
            conlist.add(con);
        }
        return conlist;
    }
    
    /**
    * @Description : This method creates Contact record.
    * @param       : Account(parent)
    * @return      : Contact record.
    **/
    public static Contact getContactRec(Account acc) {
        Contact contactRecord = new Contact();
        RecordType RecType = [Select Id From RecordType  Where SobjectType = 'Contact' And DeveloperName = 'M2O_Contact'];
        contactRecord  = new Contact (AccountId = acc.Id,Phone='983029888',FirstName = 'Test', LastName = 'User', 
        Salutation = 'Mr.',Work_Email__c = 'test.user@philips.com', Language__c = 'German', RecordTypeId = RecType.id);
        return contactRecord ;
    }
    
    /**
    * @Description : This method creates Contact record for child account.
    * @param       : Account(child)
    * @return      : Contact records.
    **/
    public static list<Contact> getChildContactRecord(Account acc) {
        list<Contact> childConlist = new list<Contact>();
        Contact childCon;
        RecordType RecType = [Select Id From RecordType  Where SobjectType = 'Contact' And DeveloperName = 'M2O_Contact'];
        for(Integer i=0;i<3;i++) {
            childCon = new Contact (AccountId = acc.Id,Phone='7878788888',FirstName = 'ChidTest'+i, LastName = 'ChildUser', 
            Salutation = 'Ms.',Work_Email__c = 'childtest.user@philips.com', Language__c = 'German', RecordTypeId =RecType.id);
            childConlist.add(childCon);
        }
        return childConlist;
    }
    /**
    * @Description : This method creates Opportunity record for parent account.
    * @param       : Account(parent)
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
        opp.StageName='Develop';
        opp.recordTypeId =devRecordTypeId;
        opp.CurrencyIsoCode='USD';
        opp.ForecastCategoryName = 'Omitted';
        opp.Strategic_Marketing__c='Strategic';
        opp.Vendor_of_Choice__c='Philips';
        opp.Funding_Status__c='Neutral';
        opp.Must_Win_flag__c= true;
        return opp;
    }
    
    /**
    * @Description : This method creates Opportunity record for parent account.
    * @param       : Account(parent)
    * @return      : Opportunity records.
    **/
    public static list<Opportunity> getListOfOpportunityRecord(Account acc) {
        Opportunity opp;
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('PCMS Opportunity').getRecordTypeId();
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=3;i++) {
            opp = new Opportunity();
            opp.Name ='Test Master Opty'+i;
            opp.AccountId = acc.Id;
            opp.closedate = system.today();
            opp.StageName='Develop';
            opp.recordTypeId =devRecordTypeId;
            opp.CurrencyIsoCode='USD';
            opp.ForecastCategoryName = 'Omitted';
            opp.Strategic_Marketing__c='Strategic';
            opp.Vendor_of_Choice__c='Philips';
            opp.Funding_Status__c='Neutral';
            opp.Must_Win_flag__c= true;
            listOpportunity.add(opp);
        }
        return listOpportunity ;
    }
    /**
    * @Description : This method creates Opportunity record for child account.
    * @param       : Account(child)
    * @return      : Opportunity records.
    **/
    public static list<Opportunity> getListOfChildOpportunityRecord(Account acc) {
        Opportunity childOpp;
        Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('PCMS Opportunity').getRecordTypeId();
        list<Opportunity> listChildOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=3;i++) {
            childOpp = new Opportunity();
            childOpp .Name ='Test Child Opty'+i;
            childOpp .AccountId = acc.Id;
            childOpp .closedate = system.today();
            childOpp .StageName='Order Lost';
            childOpp .recordTypeId =devRecordTypeId ;
            childOpp .CurrencyIsoCode='USD';
            childOpp .ForecastCategoryName = 'Omitted';
            childOpp .Strategic_Marketing__c='Strategic';
            childOpp .Vendor_of_Choice__c='Philips';
            childOpp .Funding_Status__c='Neutral';
            childOpp .Must_Win_flag__c= true;
            listChildOpportunity.add(childOpp);
        }
        return listChildOpportunity ;
    }
    /**
    * @Description : This method creates Asset record for parent account.
    * @param       : Account(parent)
    * @return      : Asset records.
    **/
    public static List<Asset> getListOfAssetRecord(Account acc){
        Asset assetData;
        List<Asset> listParentAsset = new List<Asset>();
        for(Integer i=0;i<=3;i++) {
            assetData = new Asset();
            assetData.Department__c='Radiology';
            assetData.Medical_Services__c='Angio';
            assetData.Status='INSTALL';
            assetData.Lease_Expiration_Date__c=system.today();        
            assetData.UsageEndDate=system.today()+5;        
            assetData.Booking_Date__c=system.today();        
            assetData.Ship_Date__c=system.today()+3;
            assetData.AccountId=acc.Id;
            assetData.name='testParentAsset'+i;
            assetData.InstallDate=system.today();
            listParentAsset.add(assetData);
        }
        return listParentAsset ;
    }
    /**
    * @Description : This method creates Asset record for child account.
    * @param       : Account(child)
    * @return      : Asset records.
    **/
    public static List<Asset> getListOfChildAssetRecord(Account acc){
        Asset childAssetData;
        List<Asset> listChildAsset = new List<Asset>();
        for(Integer i=0;i<=3;i++) {
            childAssetData = new Asset();
            childAssetData.Department__c='Radiology';
            childAssetData.Medical_Services__c='Angio';
            childAssetData.Status='INSTALL';
            childAssetData.Lease_Expiration_Date__c=system.today();        
            childAssetData.UsageEndDate=system.today()+5;        
            childAssetData.Booking_Date__c=system.today();        
            childAssetData.Ship_Date__c=system.today()+3;
            childAssetData.AccountId=acc.Id;
            childAssetData.name='testChildAsset'+i;
            childAssetData.InstallDate=system.today();
            listChildAsset.add(childAssetData);
        }
        return listChildAsset;
    }
    /**
    * @Description : This method creates Contract record.
    * @param       : Account
    * @return      : Contract records.
    **/
    public static Contract getListOfContractRecord(Account acc) {
        Contract con;
            con = new Contract();
            con.AccountId=acc.id;
            con.Status='Processing';
            con.StartDate=system.today();
            con.ContractTerm = 1;
         
        return con;
    }
    /**
    * @Description : This method creates ContractAccountLink record.
    * @param       : Account,Contract
    * @return      : ContractAccountLink records.
    **/
    public static list<Contract_Account_Link__c> getListOfContractAccountLinkRecord(Account acc,Contract contr) {
        list<Contract_Account_Link__c> accLinklist = new list<Contract_Account_Link__c>();
        Contract_Account_Link__c accLink;
        for(Integer i=0;i<3;i++) {
            accLink= new Contract_Account_Link__c();
            accLink.Account_Name__c = acc.Id;
            accLink.Contract_Name__c=contr.id;
            accLinklist .add(accLink);
        }
        return accLinklist ;
    }
    /**
    * @Description : This method creates ContractAccountLink record.
    * @param       : ContractAccountLink, Account
    * @return      : ContractAccountLink records.
    **/
    public static list<Contract_Account_Link__c> getListOfUpdatedContactAccountLinkRecord(List<Contract_Account_Link__c> contList,Account pAcc){
        list<Contract_Account_Link__c> updatedLinklist = new list<Contract_Account_Link__c>();
        Contract_Account_Link__c accLink;
        for(Contract_Account_Link__c linkRecords : contList){
            accLink= new Contract_Account_Link__c();
            accLink.Account_Name__c =pAcc.id;
            accLink.Contract_Name__c=linkRecords.Contract_Name__c;
            updatedLinklist .add(accLink);
        }      
        return updatedLinklist;
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
        return testStrategicAccountPlanRecord;
    } 
    /**
    * @Description : This method creates list of Strategic Account Plan records.
    * @param       : Account record.
    * @return      : list of Strategic Account Plan Records.
    **/
     public static List<Strategic_Account_Plan__c> getListOfStrategicAccountPlanRecord(Account acc) {
        List<Strategic_Account_Plan__c> testStrategicAccountPlanRecord=new List<Strategic_Account_Plan__c>();
        Strategic_Account_Plan__c testStrategicAccountPlan=new Strategic_Account_Plan__c();
        for(Integer i=0;i<3;i++) {
        testStrategicAccountPlanRecord=new List<Strategic_Account_Plan__c>();
        testStrategicAccountPlan.name='Test'+i;
        testStrategicAccountPlan.Account__c =acc.Id;
        testStrategicAccountPlanRecord.add(testStrategicAccountPlan);
         }
        return testStrategicAccountPlanRecord;
    
    }
    /**
    * @Description : This method creates List of Competitive Landscape Records.
    * @param       : Strategic Account Plan record.
    * @return      : List of Competitive Landscape records.
    **/
     public static List<Competitive_Landscape__c> getListOfCompetitiveLandscapeRecord(Strategic_Account_Plan__c sap) {
        List<Competitive_Landscape__c> competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
        Competitive_Landscape__c testCompetitiveLandscape=new Competitive_Landscape__c();
        for(Integer i=0;i<3;i++) {
        competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
        testCompetitiveLandscape.name='Test'+i;
        testCompetitiveLandscape.Strategic_account_plan__c=sap.id;
        testCompetitiveLandscape.AccountId_lookup__c =sap.Account__c;
        competitiveLandscapePlanRecord.add(testCompetitiveLandscape);
        }
        return competitiveLandscapePlanRecord;    
    }
    /**
    * @Description : This method creates List of FinancialObjPerformanceMgmtProfit Records.
    * @param       : Strategic Account Plan record.
    * @return      : List of FinancialObjPerformanceMgmtProfit records.
    **/
     public static List<Financial_Obj_Performance_Mgmt_Profit__c> getListOfFinancialObjPerformanceMgmtProfitRecord(Strategic_Account_Plan__c sap) {
        List<Financial_Obj_Performance_Mgmt_Profit__c> financialObjPerformanceMgmtProfitRecordsList= new List<Financial_Obj_Performance_Mgmt_Profit__c>();
        Financial_Obj_Performance_Mgmt_Profit__c testFinancialObjPerformanceMgmtProfit = new Financial_Obj_Performance_Mgmt_Profit__c();
        for(Integer i=0;i<3;i++) {
        financialObjPerformanceMgmtProfitRecordsList= new List<Financial_Obj_Performance_Mgmt_Profit__c>();
        testFinancialObjPerformanceMgmtProfit.name='Test'+i;
        testFinancialObjPerformanceMgmtProfit.Strategic_account_plan__c=sap.id;        
        financialObjPerformanceMgmtProfitRecordsList.add(testFinancialObjPerformanceMgmtProfit);
        }
        return financialObjPerformanceMgmtProfitRecordsList;    
    }
    /**
    * @Description : This method creates Key transformational win record.
    * @param       : Competitive Landscape
    * @return      : Key transformational win records.
    **/
    public static list<Key_Transformational_Win__c> getKeytransformationalWinRecord(Competitive_Landscape__c CompetitiveLandscape){
        Key_Transformational_Win__c testKeytransformationalWinRecord;
        list<Key_Transformational_Win__c> listKeytransformationalWinRecord=new list<Key_Transformational_Win__c>();
        for(Integer i=0;i<=3;i++) {
            testKeytransformationalWinRecord = new Key_Transformational_Win__c();
            testKeytransformationalWinRecord.Competitive_Landscape__c =CompetitiveLandscape.Id;
            listKeytransformationalWinRecord.add(testKeytransformationalWinRecord);
        }
        return listKeytransformationalWinRecord;
    }
    /**
    * @Description : This method creates Key transformational Loss record.
    * @param       : CompetitiveLandscape
    * @return      : Key transformational Loss records.
    **/
    public static list<Key_Transformational_Loss__c> getKeytransformationalLossRecord(Competitive_Landscape__c CompetitiveLandscape){
        Key_Transformational_Loss__c testKeytransformationalLossRecord;
        list<Key_Transformational_Loss__c> listKeytransformationalLossRecord=new list<Key_Transformational_Loss__c>();
        for(Integer i=0;i<=3;i++) {
            testKeytransformationalLossRecord = new Key_Transformational_Loss__c();            
            testKeytransformationalLossRecord.Competitive_Landscape__c =CompetitiveLandscape.Id;
            listKeytransformationalLossRecord.add(testKeytransformationalLossRecord);
        }
        return listKeytransformationalLossRecord;
    }
    /**
    * @Description : This method creates People and Relationship Records.
    * @param       : Strategic Account Plan
    * @return      : People and Relationship Records.
    **/
    public static list<People_and_Relationship__c> getPeopleAndRelationshipRecord(Strategic_Account_Plan__c sap){
        list<People_and_Relationship__c> peopleAndRelationshipList = new list<People_and_Relationship__c>();            
        People_and_Relationship__c peopleAndRelationshipRecord;
        for(Integer i=0;i<=3;i++){
            peopleAndRelationshipRecord = new People_and_Relationship__c
                (Strategic_account_plan__c= sap.id);
            peopleAndRelationshipList.add(peopleAndRelationshipRecord);
        }
        return peopleAndRelationshipList;
    }
    /**
    * @Description : This method creates Hospital Location Records.
    * @param       : Strategic Account Plan
    * @return      : Hospital Location Records.
    **/
    public static list<Hospital_Locations__c> getHospitalLocationRecord(Strategic_Account_Plan__c sap){
        list<Hospital_Locations__c> hospitalLocationList = new list<Hospital_Locations__c>();            
        Hospital_Locations__c hospitalLocationRecord;
        for(Integer i=0;i<=3;i++){
            hospitalLocationRecord = new Hospital_Locations__c(Strategic_account_plan__c= sap.id);
            hospitalLocationList.add(hospitalLocationRecord);
        }
        return hospitalLocationList;
    }
    /**
    * @Description : This method creates Asset Records.
    * @param       : Strategic Account Plan
    * @return      : Asset Records.
    **/
    public static list<Asset__c> getAssetRecord(Strategic_Account_Plan__c sap){
        list<Asset__c> assetList = new list<Asset__c>();            
        Asset__c assetRecord;
        for(Integer i=0;i<=3;i++){
            assetRecord = new Asset__c(Strategic_account_plan__c= sap.id);
            assetList.add(assetRecord);
        }
        return assetList;
    }
    /**
    * @Description : This method creates Contract Detail Records.
    * @param       : Strategic Account Plan
    * @return      : Contract Detail  Records.
    **/
    public static list<Contract_Detail__c> getContractDetailRecord(Strategic_Account_Plan__c sap){
        list<Contract_Detail__c> contractDetailList = new list<Contract_Detail__c>();            
        Contract_Detail__c contractDetailRecord;
        for(Integer i=0;i<=3;i++){
            contractDetailRecord= new Contract_Detail__c(Strategic_account_plan__c= sap.id);
            contractDetailList.add(contractDetailRecord);
        }
        return contractDetailList;
    }
    /**
    * @Description : This method creates Top Opportunities Records.
    * @param       : Strategic Account Plan
    * @return      : Top Opportunities Records.
    **/
    public static list<Top_Opportunities__c> getTopOpportunitiesRecord(Strategic_Account_Plan__c sap){
        list<Top_Opportunities__c> topOpportunitiesList = new list<Top_Opportunities__c>();            
        Top_Opportunities__c topOpportunitiesRecord;
        for(Integer i=0;i<=3;i++){
            topOpportunitiesRecord = new Top_Opportunities__c(Strategic_account_plan__c= sap.id);
            topOpportunitiesList.add(topOpportunitiesRecord);
        }
        return topOpportunitiesList;
    }
    /**
    * @Description : This method creates Account Team Records.
    * @param       : Strategic Account Plan
    * @return      : Account Team Records.
    **/
    public static list<Account_Team__c> getAccountTeamRecord(Strategic_Account_Plan__c sap){
        list<Account_Team__c> accountTeamList = new list<Account_Team__c>();            
        Account_Team__c accountTeamRecord;
        for(Integer i=0;i<=3;i++){
            accountTeamRecord = new Account_Team__c(Strategic_account_plan__c= sap.id);
            accountTeamList.add(accountTeamRecord);
        }
        return accountTeamList;
    }  
    /**
    * @Description : This method creates Account Team Member Records.
    * @param       : Strategic Account Plan
    * @return      : Account Team Records.
    **/
    public static AccountTeamMember getAccountTeamMemberRecord(Account accountRecord,User userRecord){
        AccountTeamMember accountTeamRecord = new AccountTeamMember();
        accountTeamRecord.userId = userRecord.id;
        accountTeamRecord.AccountId = accountRecord.id;
        accountTeamRecord.TeamMemberRole  = 'CL - Sales support';
        return accountTeamRecord;
    }
    /**
    * @Description : This method creates Deal Support Request.
    * @param       : Account,Opportunity
    * @return      : Deal Support Request Records.
    **/
    public static list<Deal_Support_Request_del__c> getDealSupportRecord(Account accountRecord,Opportunity opportunityRecord){
        list<Deal_Support_Request_del__c> dealSpprtRequestList = new list<Deal_Support_Request_del__c>();            
        Deal_Support_Request_del__c dealSupportRecord;
        for(Integer i=0;i<=3;i++){
            dealSupportRecord = new Deal_Support_Request_del__c();
            dealSupportRecord.Name = 'test' + i;
            dealSupportRecord.Related_Opportunity_del__c = opportunityRecord.id;
            dealSupportRecord.Account__c = accountRecord.id;
            dealSupportRecord.PROP_Competitor_1__c = 'GE';
            dealSupportRecord.GTM_Region__c = 'CHE';
            dealSupportRecord.Product_Family__c = 'CHMV';
            dealSupportRecord.Prop_List_Price_Opportunity_Amount__c = 200;
            //dealSupportRecord.Justification_Comments_Executive_Summary__c = 'test';
            dealSupportRecord.DAR_PCMS_Request__c = 'test';
            dealSpprtRequestList .add(dealSupportRecord);
        }
        return dealSpprtRequestList;
    }
    
    /**
    * @Description : This method creates DSR User Mapping.
    * @param       : User
    * @return      : DSR User Mapping Records.
    **/
    public static DSR_User_Mapping__c getDSRMappingRecord(User user){
        DSR_User_Mapping__c dsrMappingRecord;
        dsrMappingRecord= new DSR_User_Mapping__c();
        dsrMappingRecord.Name = 'test';
        dsrMappingRecord.Finance_Director__c = user.id;
        dsrMappingRecord.Forecast_Manager_Owner__c   = user.id;
        dsrMappingRecord.Market_Leader__c = user.id;
        dsrMappingRecord.Sales_Market_Specialist__c = user.id;
        dsrMappingRecord.Senior_Finance_Director__c = user.id;
        dsrMappingRecord.Region__c = 'CHE';
        dsrMappingRecord.Product_Family__c = 'CHMV';
        return dsrMappingRecord;
    }
    
    /**
    * @Description : This method creates DSR User Mapping.
    * @param       : User
    * @return      : DSR User Mapping Records.
    **/
    public static DSR_User_Mapping__c getDSRMappingRecord2(User user){
        DSR_User_Mapping__c dsrMappingRecord;
        dsrMappingRecord= new DSR_User_Mapping__c();
        dsrMappingRecord.Name = 'test';
        dsrMappingRecord.Finance_Director__c = user.id;
        dsrMappingRecord.Forecast_Manager_Owner__c   = user.id;
        dsrMappingRecord.Market_Leader__c = user.id;
        dsrMappingRecord.Sales_Market_Specialist__c = user.id;
        dsrMappingRecord.Senior_Finance_Director__c = user.id;
        dsrMappingRecord.Region__c = 'CHI';
        dsrMappingRecord.Product_Family__c = 'ECR';
        return dsrMappingRecord;
    } 
    
    /**
    * @Description : This method creates Case;
    * @param       : User,Account
    * @return      : Case record.
    **/
    public static Case getCaseRecord(Account acc,User user,Contact contact){
        case caseRecord;
        caseRecord = new Case();
        caseRecord.AccountId = acc.id;
        caseRecord.Status = 'New';
        caseRecord.Origin = 'Email';
        caseRecord.Type = 'Problem';
        caseRecord.Minutes_Spent_on_Case__c = 45;
        caseRecord.ContactID = contact.id;
        caseRecord.OwnerId = user.id;
        return caseRecord;
    }
    /**
    * @Description : This method creates CaseShare;
    * @param       : Case , User
    * @return      : Case record.
    **/    
    public static CaseShare getCaseRecord(Case caseRecord, User userRecord) {    
        CaseShare caseShareRecord = new caseShare(
        caseAccessLevel = 'Read',
        caseId = caseRecord.id,
        userOrGroupId = userRecord.id 
        );
        return caseShareRecord;
    }
    /**
    * @Description : This method creates CaseShare;
    * @param       : Case , User
    * @return      : Case record.
    **/    
    public static CaseShare getCaseShareRecord(Case caseRecord, User userRecord) {    
        CaseShare caseShareRecord = new caseShare(
        caseAccessLevel = 'Read',
        caseId = caseRecord.id,
        userOrGroupId = userRecord.id 
        );
        return caseShareRecord;
    }
    /**
    * @Description : This method creates Opportunity Team Member record for parent account.
    * @param       : Account(parent) , User
    * @return      : Opportunity Team Member record.
    **/
    public static OpportunityTeamMember getOppTeamMember(Opportunity opp, User user) {
        OpportunityTeamMember oppTeamMemRecord = new OpportunityTeamMember();
        oppTeamMemRecord.OpportunityId = opp.Id;
        oppTeamMemRecord.UserId = user.id;
        oppTeamMemRecord.User__c = user.id;
        oppTeamMemRecord.TeamMemberRole = 'CL - Sales support';
        return oppTeamMemRecord;
    }
    
    /**
    * @Description : This method creates CaseTeamMember;
    * @param       : Case , User ,Case
    * @return      : CaseTeamMember record.
    **/    
    public static CaseTeamMember getCaseTeamRecord(Case caseRecord, User userRecord,CaseTeamRole caseTeamRoleRecord) {    
        CaseTeamMember caseTeamRecord = new CaseTeamMember(
        MemberId = userRecord.id,
        ParentId = caseRecord.id,
        TeamRoleId = caseTeamRoleRecord.id
        );
        return caseTeamRecord;
    }
    /**
    * @Description : This method creates Case Team Role;
    * @param       : 
    * @return      : CaseTeamRole record.
    **/    
    public static CaseTeamRole getCaseTeamRoleRecord() {    
        CaseTeamRole caseTeamRecord = new CaseTeamRole(
        AccessLevel = 'Edit',
        Name = 'test',
        PreferencesVisibleInCSP = true
        );
        return caseTeamRecord;
    }
    /**
    * @Description : This method creates OpportunityShare  record for parent account.
    * @param       : Account(parent) , User
    * @return      : OpportunityShare record.
    **/
    public static OpportunityShare getOppShare(Opportunity opp, User user) {
        OpportunityShare oppShareRecord = new OpportunityShare();
        oppShareRecord.OpportunityId = opp.Id;
        oppShareRecord.UserOrGroupId = user.id;
        oppShareRecord.OpportunityAccessLevel = 'Edit';
        return oppShareRecord;
    }
}