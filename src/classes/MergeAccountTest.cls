@istest(seeAlldata=false)
private class MergeAccountTest
{

  static testMethod void myUnitTest()
  {
    DateTime dt1 = DateTime.valueOf('2007-01-01 2:35:21'); //datetime start variable
    DateTime dt2 = DateTime.valueOf('2007-01-02 3:56:45'); //datetime end variable
   
    User u = new USer(id = UserInfo.getUserId());

        
    system.runAs(u){
        Region__c regionData = new Region__c();
        regionData.name ='Test Region';
        regionData.Country__c='India';
        regionData.Region_Code__c='AA-113';
        insert regionData;
                
       Account acc;
        acc = new Account(name = 'test acc16666', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c = 'Retail',
                                      Philips_Indstry_Clasification_Level2__c='IDN', Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
                                      Region__c = regionData.id);
        acc.name = 'test01_90';
        acc.Account_Alias__c = 'test_alias';
        acc.Phone = '9876543210';
        acc.fax='90866';
        acc.website = 'yahoo.com';
        acc.Phone_Book_Account__c = true;
        acc.Total_Beds__c = 80;
        acc.Class_of_Account__c = 'Business';
        acc.Facility_Type__c = 'Clinic';
        acc.Expertise__c = 'Neurology';
        acc.Short_Term_Beds__c = 10;
        acc.Goldmine_Account__c ='test';
        acc.Gmx_Custom_API_1__c ='test1';    
        acc.Gmx_Custom_API_5__c ='test2';
        acc.Gmx_Custom_API_2__c ='test3';
        acc.Gmx_Custom_API_3__c ='test4';
        acc.Urgent_Care_Facility__c = 'Cath Lab';
        acc.Gmx_Custom_API_4__c = 'test5';
        acc.Gmx_Web_Viewer__c = 'viewer';
        acc.Gmx_Archive_VNA__c = 'vna';
        acc.Gmx_RIS_Version__c ='testris';
        acc.Gmx_CustStatus__c = '060 - Booked (Ent)';
        acc.Gmx_PACS_Gear__c ='testgear';
        acc.Gmx_OrthoView__c = 'testortho';
        acc.Gmx_ClinApps_WF_Solution__c ='testclininc';
        acc.Marketing_programs__c ='Loyalty Program';
        acc.TIMS_ID__c = 'test122';
        acc.SMG_ID__c ='test_smg';
        acc.ICUs__c =89;
        acc.Competitive_Buying_Information__c = 'testbuy';
        acc.Licensed_Bed_Count__c = 98;
        acc.Employee_Here__c = 89;
        acc.SourceSystem__c ='Siebel';
        
        insert acc;
       
         Account acc1;
        acc1 = new Account(name = 'test acc15555', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c = 'Retail',
                                      Philips_Indstry_Clasification_Level2__c='IDN', Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
                                      Region__c = regionData.id);
      
         acc1.name = 'test01_80';
         
        insert acc1;
       /* Account acc1 = new Account(Name='Sneha Chail',Archived_Record__c=FALSE,Destination_Account_Name__c=acc.id,
        billingState = 'West Bengal',BillingStreet='Bombai Bagan Road',BillingCity = 'CA',BillingPostalCode= '700061', BillingCountry='CA');
        Insert acc1;*/
       
        Profile pf1= [select id from Profile where name = 'System Administrator'];
        User u1 = new User(LastName = 'Test Usser',Username = 'tuu1@test.com',
        Email = 'testuser@test.com',Alias = 'tu1' ,CommunityNickname= 'tu1' ,TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
        insert u1;
           
        Contact con = new Contact(Salutation='Mr.',FirstName='test',LastName ='Chail' ,AccountId=acc.id,Phone='1111',MobilePhone='5555',Email='test.wip@wipro.com');
        insert con;
        //Contact con = [SELECT id FROM Contact limit 1];
        
      
        Product2 prod  = new Product2(Name='TEST',Description='Test',Family='Intellispace');
        insert prod;
    
        Asset Ast = new Asset(Name ='Chail' ,AccountId=acc.id,Product2= prod,
        Department__c='Anesthesiology',IsCompetitorProduct=true,Medical_Services__c = 'Angio',Status='INSTALL',InstallDate=System.today());
        test.starttest();
        insert Ast;
        
        
        //Opportunity opp = new Opportunity(Name ='SnehaChail',AccountId=acc.id,closedate=system.today(),StageName='Quatation',Primary_Rep__c=u1.id);
        //Insert opp;
       
        Task tk = new Task(Subject ='Chail' ,WhatId=acc.id,Status='In progress',Priority='High');
        Insert tk;
      
        Event evt = new Event(Subject ='Chail' ,WhatId=acc.id,StartDateTime=dt1,EndDateTime=dt2);
        Insert evt;
        
        Lead ld = new Lead(FirstName='H', LastName ='NewLead',Email='d@e.c',Company = 'Wipro', Account__c=acc.id,Status='Open',Business_Group__c='Ultrasound',Country__c='India',Sector__c='Healthcare');
        Insert ld;
      
        Department__c dep = new Department__c(Department_Name__c='Cardiology',PMS_Account_Medical_Services__c='Angio',Account_Department__c=acc.id);
        Insert dep;
      
        AccountContactRole opptm=new AccountContactRole(ContactId=con.id,AccountId=acc.id,Role='Sneha');
        insert opptm;
        
        Account_affiliation__c AffAcc=new Account_affiliation__c(Affiliated_Account__c=acc.id,Customer_Prospect__c=acc.id,Relationship_Type__c='3D Vendor');
        //insert AffAcc;
      
        Affiliates__c Afl=new Affiliates__c(Contact__c=con.id,Account__c=acc.id);
        insert Afl;
      
        Attachment att = new Attachment(Name='Chail' ,ParentId=acc.id, Body =Blob.valueOf('Unit Test Attachment Body') );
        insert att;
      
        Note nt = new Note(Title='Test Title' ,ParentId=acc.id, Body ='Unit Test Note Body' );
        insert nt;
     
        Account_Team_Member__c Atm = new Account_Team_Member__c(Account__c=acc.id,User__c=u1.id,Team_Role__c='lead qualifier'); 
        insert Atm;
      
     /* apexpages.currentpage().getparameters().put('id' , acc.id);
        MergeAccount m1 = new MergeAccount(new ApexPages.StandardController(acc));
        //m1.Acc.Destination_Account_Name__c=acc1.id;*/
        System.currentPageReference().getParameters().put('id', acc .id);
        ApexPages.currentPage().getParameters().put('retURL',acc.id);
        ApexPages.StandardController controller=new ApexPages.StandardController(acc);  
        MergeAccount m1 = new MergeAccount(controller);
        m1.accountId = acc1.id;
        try{    
        m1.transfer(); 
        }
        catch(Exception e) {
        }
        //m1.Merge1(); 
        m1.Cancel();
        test.stoptest();
    }
    
 }
 static testMethod void myUnitTest_Exception()  
 {
    User u = new USer(id = UserInfo.getUserId());

    system.runAs(u){
        Region__c regionData = new Region__c();
        regionData.name ='Test Region';
        regionData.Country__c='India';
        regionData.Region_Code__c='AA-113';
        insert regionData;
                
        Account acc;
        acc = new Account(name = 'test acc1333', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c = 'Retail',
                                      Philips_Indstry_Clasification_Level2__c='IDN', Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
                                      Region__c = regionData.id);
        acc.name = 'test01_90';
        acc.Account_Alias__c = 'test_alias';
        acc.Phone = '9876543210';
        acc.fax='90866';
        acc.website = 'yahoo.com';
        acc.Phone_Book_Account__c = true;
        acc.Total_Beds__c = 80;
        acc.Class_of_Account__c = 'Business';
        acc.Facility_Type__c = 'Clinic';
        acc.Expertise__c = 'Neurology';
        acc.Short_Term_Beds__c = 10;
        acc.Goldmine_Account__c ='test';
        acc.Gmx_Custom_API_1__c ='test1';    
        acc.Gmx_Custom_API_5__c ='test2';
        acc.Gmx_Custom_API_2__c ='test3';
        acc.Gmx_Custom_API_3__c ='test4';
        acc.Urgent_Care_Facility__c = 'Cath Lab';
        acc.Gmx_Custom_API_4__c = 'test5';
        acc.Gmx_Web_Viewer__c = 'viewer';
        acc.Gmx_Archive_VNA__c = 'vna';
        acc.Gmx_RIS_Version__c ='testris';
        acc.Gmx_CustStatus__c = '060 - Booked (Ent)';
        acc.Gmx_PACS_Gear__c ='testgear';
        acc.Gmx_OrthoView__c = 'testortho';
        acc.Gmx_ClinApps_WF_Solution__c ='testclininc';
        acc.Marketing_programs__c ='Loyalty Program';
        acc.TIMS_ID__c = 'test122';
        acc.SMG_ID__c ='test_smg';
        acc.ICUs__c =89;
        acc.Competitive_Buying_Information__c = 'testbuy';
        acc.Licensed_Bed_Count__c = 98;
        acc.Employee_Here__c = 89;
        acc.SourceSystem__c ='Siebel';
        
        insert acc;
       
       Account acc1;
        acc1 = new Account(name = 'test acc12222', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c = 'Retail',
                                      Philips_Indstry_Clasification_Level2__c='IDN', Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
                                      Region__c = regionData.id);
      
         acc1.name = 'test01_80';
         
        insert acc1;
        
       // Account acc = new Account(Name='sneha',Archived_Record__c=FALSE,type='customer',billingState = 'West Bengal',BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',BillingPostalCode= '700061', BillingCountry='CA');
       // Insert acc;
       // Account acc1 = new Account(Name='Sneha Chail',Archived_Record__c=True,Destination_Account_Name__c=acc.id,type='prospect',
       //billingState = 'West Bengal',BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',BillingPostalCode= '700061', BillingCountry='CA');
       // Insert acc1;
       
        Product2 prod  = new Product2(Name='TEST',Description='Test',Family='Intellispace');
        insert prod;
    
        Asset Ast = new Asset(Name ='Chail' ,AccountId=acc.id,Product2= prod,Department__c='Anesthesiology',IsCompetitorProduct=true,Medical_Services__c = 'Angio',Status='INSTALL',InstallDate=System.today());
        insert Ast;
       
        apexpages.currentpage().getparameters().put('id' , acc.id);
        MergeAccount m1 = new MergeAccount(new ApexPages.StandardController(acc));
        m1.Acc.Destination_Account_Name__c=acc.id;
        try{    
        m1.transfer(); 
        }
        catch(Exception e) {
        }
    }
 } 
}