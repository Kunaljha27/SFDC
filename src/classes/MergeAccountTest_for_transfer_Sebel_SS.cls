@isTest(SeeAllData=false)
private class MergeAccountTest_for_transfer_Sebel_SS
{

  static testMethod void myUnitTest()
  {
    DateTime dt1 = DateTime.valueOf('2007-01-01 2:35:21'); //datetime start variable
    DateTime dt2 = DateTime.valueOf('2007-01-02 3:56:45'); //datetime end variable
    Account acc = new Account(Name='sneha',Archived_Record__c=FALSE,billingState = 'CA',BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',BillingPostalCode= '700061',BillingCountry='CA',Siebel_ID__c='abc',Account_Alias__c='sne',Phone='9898989898',Phone_Book_Account__c=FALSE,Class_of_Account__c='Partner',Expertise__c='Surgery',Facility_Type__c='Clinic',Short_Term_Beds__c=123,Total_Beds__c=123,TIMS_ID__c='ABC',SMG_ID__c='DEF',Fax='12332',Website='abc@wipro.com',Competitive_Buying_Information__c='GHI',Licensed_Bed_Count__c=123,SourceSystem__c='Siebel',Employee_Here__c=23,ICUs__c=45,Goldmine_Account__c='abc',gmx_Custom_API_1__c='custom api',gmx_Custom_API_5__c='customapi5',gmx_Custom_API_2__c='customapi 2',gmx_Custom_API_3__c='customapi3',Urgent_Care_Facility__c='Cath Lab',gmx_Custom_API_4__c='customapi4',gmx_Web_Viewer__c='webviewer',gmx_Archive_VNA__c='archivevna',gmx_RIS_Version__c='risversion',gmx_CustStatus__c='status',gmx_PACS_Gear__c='pacsgear',gmx_OrthoView__c='orthoview',gmx_ClinApps_WF_Solution__c='wfsolution',Marketing_programs__c='Loyalty Program');
    acc.Phone_Book_Account__c=True;
    Insert acc;
   
    Account acc1 = new Account(Name='Sneha Chail',Archived_Record__c=FALSE,
    billingState = 'CA',BillingStreet='Bombai Bagan Road',BillingCity = 'CA',BillingPostalCode= '700061', BillingCountry='CA');
    Insert acc1;
   
    Profile pf1= [select id from Profile where name = 'System Administrator'];
    User u1 = new User(LastName = 'Test Usser',Username = 'tuu1@test.com',
    Email = 'testuser@test.com',Alias = 'tu1' ,CommunityNickname= 'tu1' ,TimeZoneSidKey = 'America/Los_Angeles',LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',ProfileId = pf1.Id, LanguageLocaleKey = 'en_US');
    insert u1;
       
    Contact con = new Contact(LastName ='Chail' ,AccountId=acc.id);
    insert con;
  
    Product2 prod  = new Product2(Name='TEST',Description='Test',Family='Intellispace');
    insert prod;

    Asset Ast = new Asset(Name ='Chail' ,AccountId=acc.id,Product2= prod,
    Department__c='Anesthesiology',IsCompetitorProduct=true,Medical_Services__c = 'Angio',Status='INSTALL',InstallDate=System.today());
    insert Ast;
    
    Opportunity opp = new Opportunity(Name ='SnehaChail',AccountId=acc.id,closedate=system.today(),StageName='Quatation',Primary_Rep__c=u1.id);
    Insert opp;
   
    Task tk = new Task(Subject ='Chail' ,WhatId=acc.id,Status='In progress',Priority='High');
    Insert tk;
  
    Event evt = new Event(Subject ='Chail' ,WhatId=acc.id,StartDateTime=dt1,EndDateTime=dt2);
    Insert evt;
  
    Department__c dep = new Department__c(Department_Name__c='Cardiology',PMS_Account_Medical_Services__c='Angio',Account_Department__c=acc.id);
    Insert dep;
  
    AccountContactRole opptm=new AccountContactRole(ContactId=con.id,AccountId=acc.id,Role='Sneha');
    insert opptm;
    
    Account_affiliation__c AffAcc=new Account_affiliation__c(Affiliated_Account__c=acc.id,Customer_Prospect__c=acc.id,Relationship_Type__c='3D Vendor');
    insert AffAcc;
  
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
    test.startTest();    
    m1.transfer(); 
    //m1.Merge1(); 
    m1.Cancel();
    test.stopTest();
    
 }
 static testMethod void myUnitTest_Exception()  
 {
    Account acc = new Account(Name='sneha',Archived_Record__c=FALSE,type='customer',billingState = 'West Bengal',BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',BillingPostalCode= '700061', BillingCountry='CA');
    Insert acc;
    Account acc1 = new Account(Name='Sneha Chail',Archived_Record__c=True,Destination_Account_Name__c=acc.id,type='prospect',
    billingState = 'West Bengal',BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',BillingPostalCode= '700061', BillingCountry='CA');
    Insert acc1;
   
    Product2 prod  = new Product2(Name='TEST',Description='Test',Family='Intellispace');
    insert prod;

    Asset Ast = new Asset(Name ='Chail' ,AccountId=acc.id,Product2= prod,Department__c='Anesthesiology',IsCompetitorProduct=true,Medical_Services__c = 'Angio',Status='INSTALL',InstallDate=System.today());
    insert Ast;
   
    apexpages.currentpage().getparameters().put('id' , acc.id);
    MergeAccount m1 = new MergeAccount(new ApexPages.StandardController(acc));
    m1.Acc.Destination_Account_Name__c=acc.id;
    m1.transfer(); 
 } 
}