/**
@Classname :       M2O_AccountContactTestDataUtility
@Description :     This test class is written to store all the data of Account, Contact and their related objects.
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/

public class M2O_AccountContactTestDataUtility {
  
    public static Profile insertProfile() {
        Profile pf = [select id from Profile where name = 'System Administrator'];
        return pf;
    }
   
        public static M2O_ST_Visibility_Objects__c getSTVisibilityObjects() {
        M2O_ST_Visibility_Objects__c cs = new M2O_ST_Visibility_Objects__c();
        cs.Obj_API_Name__c = 'Quotation__c';
        cs.Relationship_with_opportunity__c ='Opportunity__c';
        cs.name = 'Quotations__r';
        return cs;
    }
    
    public static Validate_M2O_Profiles__c getValidateM2OProfiles(Id profileId) {
        Id hcProfileId = profileId;
        Validate_M2O_Profiles__c validateM2OProfile = new Validate_M2O_Profiles__c();
        validateM2OProfile.Validate_Profiles__c = true;
        validateM2OProfile.SetupOwnerId = hcProfileId;
        return validateM2OProfile;
    }
    
    public static User getUserRecord() {   
        User  usr = new User(LastName = 'User',Username = 'test.user1.philips@abc.com',
                             Email = 'test.user@philips.com',Alias = 'tu1',
                             CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = insertProfile().Id, LanguageLocaleKey = 'en_US', Market__c = 'Japan', Philips_Sector_Name__c = 'HC');
       
        return usr;
    }
   
    public static list<Account> getAccountRecord(Region__c rediondata) {
        list<Account> acclist = new list<Account>();
        
        Account acc;
        for(Integer i=0;i<1;i++) {
         acc = new Account(name = 'test acc'+i, BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=rediondata.id,Market__c='North America');
         acclist.add(acc);
         }
        return acclist;
    }
    public static list<Account> getChildAccountRecord(Region__c rediondata, Id parentID) {
        list<Account> acclist = new list<Account>();        
        Account acc;
        for(Integer i=0;i<100;i++) {
         acc = new Account(name = 'test acc'+i, BillingState='TE', BillingCity='Test', BillingStreet='Test', ParentId = parentID,
                          BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                          HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                          Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN', 
                          Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', 
                          City_Local__c='City', Region__c=rediondata.id);
         acclist.add(acc);
         }
        return acclist;
    }

    public static set<id> getAccountRecordTypeId(list<Account> acclist){
        set<Id> accountSetId = new set<Id>();
        for(Account acc : acclist){
            accountSetId.add(acc.RecordTypeId);
        }
        return accountSetId;
    }
    public static list<Contact> getContactRecord() {
        
        list<Contact> conlist = new list<Contact>();
        Contact con;
        for(Integer i=0;i<100;i++) {
        con = new Contact (Country__c = 'India',MobilePhone = '983029888',FirstName = 'Test'+i,
                                   LastName = 'User', Salutation = 'Mr.',Work_Email__c = 'test.user@philips.com', Language__c = 'German',
                                   RecordTypeId = label.Contact_M2O_Record_Type_ID);
        conlist.add(con);
        }
        return conlist;
    }
   
    public static list<Account_Market_Sector_Attribute__c> getAccMarktAttrRecord(Region__c rediondata) {
        list<Account> acct = new list<Account> ();
        acct = getAccountRecord(rediondata);
        Account_Market_Sector_Attribute__c accMarktAtt1;
        list<Account_Market_Sector_Attribute__c> accMarkAttrlist = new list<Account_Market_Sector_Attribute__c>();
        for(Integer i=0;i<100;i++) {
        accMarktAtt1 = new Account_Market_Sector_Attribute__c (Name = 'TestAttribute1'+i);
        accMarkAttrlist.add(accMarktAtt1);
        }
        return accMarkAttrlist;
    }
  
    public static list<Contact_Market_Sector_Attributes__c> getConMarktAttrRecord() {
        list<Contact> con = new list<Contact>();
        con = getContactRecord();
        Contact_Market_Sector_Attributes__c conMarktAtt;
        list<Contact_Market_Sector_Attributes__c> conMarktAttlist = new list<Contact_Market_Sector_Attributes__c>();
        for(Integer i=0;i<100;i++) {
        conMarktAtt = new Contact_Market_Sector_Attributes__c (Name = 'TestAttribute1'+i);
        conMarktAttlist.add(conMarktAtt);
        }
        return conMarktAttlist;
    }
   
    public static List<AccountTeamMember> getAccountTeamMemberRecord(Id accountId,List<User> lstUser) {
        List<AccountTeamMember> insertAccountTeamMember= new List<AccountTeamMember>();
         AccountTeamMember objmember;
       for(User usr : lstUser) {
            objmember = new AccountTeamMember ();
            objmember.UserId = usr.id;
            objmember.AccountId =accountId;
            objmember.teammemberrole = 'Account Manager';
            insertAccountTeamMember.add(objmember);
        }    
        return insertAccountTeamMember;
  
      }
      public static List<AccountTeamMember> getSecondAccountTeamMemberRecord(Id accountId,List<User> lstUser) {
        List<AccountTeamMember> insertAccountTeamMember= new List<AccountTeamMember>();
         AccountTeamMember objmember;
       for(User usr : lstUser) {
            objmember = new AccountTeamMember ();
            objmember.UserId = UserInfo.getUserId();
            objmember.AccountId =accountId;
            insertAccountTeamMember.add(objmember);
        }    
        return insertAccountTeamMember;
  
      }
   
     public static List<Delete_Account_Team__c> getDeleteAccountTeam(Id AccountId){
          List<Delete_Account_Team__c> insertDeleteAccountTeam= new List<Delete_Account_Team__c>();
          Delete_Account_Team__c deleteAccountTeamObj= new Delete_Account_Team__c();
          deleteAccountTeamObj.Account__c=AccountId;
          insertDeleteAccountTeam.add(deleteAccountTeamObj);
          return insertDeleteAccountTeam;
      
      }
      
        public static List<User> getUserforAccountTeam(integer userCounnt, string profileName){
        Id profileId= [select Id from profile where name=:profileName].Id;
        List<User> lstUser = new List<User>();
        User usr;
        for(integer i = 0; i<userCounnt; i++) {
            usr = new User(LastName = 'User5',Username = 'test.user'+i+'.philips2@abc.com',
                                 Email = 'test.user@philips5.com', Alias = 'tuser'+i,
                                 CommunityNickname= 'tu8589'+i ,TimeZoneSidKey = 'America/Los_Angeles',
                                 LocaleSidKey='en_US', EmailEncodingKey= 'ISO-8859-1',
                                 ProfileId = profileId, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                                 Philips_Sector_Name__c = 'LI');
                                 
            lstUser.add(usr);
        }      
        return lstUser;
      }
      public static List<User> getUserforAccountTeamMember(id profileId){
        List<User> lstUser = new List<User>();
        User usr;
        for(integer i = 0; i<3; i++) {
            usr = new User(LastName = 'User5',Username = 'test.user'+i+'.philips2@abc.com',
                                 Email = 'test.user@philips5.com', Alias = 'tuser'+i,
                                 CommunityNickname= 'tu8589'+i ,TimeZoneSidKey = 'America/Los_Angeles',
                                 LocaleSidKey='en_US', EmailEncodingKey= 'ISO-8859-1',
                                 ProfileId = profileId, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                                 Philips_Sector_Name__c = 'LI',IsActive = true);
                                 
            lstUser.add(usr);
        }      
        return lstUser;
      }
     
     public static list<Contact> getContactRecord( Id accountId) {
    Integer j;
    List<Contact> testcontactlist= new List<Contact>();
     for (j=0; j<=100; j++){
      
       Contact testcontact = new Contact(AccountId=accountId, Country__c = 'Australia',MobilePhone = '983029888',FirstName = 'Test'+j,
                                   LastName = 'User', Salutation = 'Mr.',Work_Email__c = 'testuser.user@philips.com', Language__c = 'French');
       testcontactlist.add(testcontact);
       
     }
    return testcontactlist;
    }
     
      public static Account getSingleAccountRecord(Region__c rediondata){
      
        id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Influencer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=rediondata.id, recordtypeid=recordtpeid,Market__c='North America',Region_Global__c=null);
       return testAccountRecord;
    }
      public static Account getSingleAccountRec(Region__c rediondata){
      
       id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Influencer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test2',BillingState='TE', BillingCity='Test2', BillingStreet='Test2', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City2', Region__c=rediondata.id, recordtypeid=recordtpeid,Market__c='North America',Region_Global__c=null);
       return testAccountRecord;
    }
    public static Account getAccountRec(Region__c rediondata){
      
       id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Influencer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test3',BillingState='TE', BillingCity='Test3', BillingStreet='Test3', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City3', Region__c=rediondata.id, recordtypeid=recordtpeid,Market__c='North America',Region_Global__c=null);
       return testAccountRecord;
    }
    
    public static Account getAccRecHierarchy(Region__c rediondata,id parentid, string CurrentAccountTopParentId){
      
       id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Influencer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test4',BillingState='TE', BillingCity='Test4', BillingStreet='Test4', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S142345', 
                                             Street1_Local__c='CA', City_Local__c='City4', Region__c=rediondata.id, recordtypeid=recordtpeid, ParentId = parentid,Market__c='North America',Region_Global__c=null);
       return testAccountRecord;
    }
    public static Account getAccountRecTopMostParent(Region__c rediondata, string CurrentAccountTopParentId){
      
       id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Influencer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test3',BillingState='TE', BillingCity='Test3', BillingStreet='Test3', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City3', Region__c=rediondata.id, recordtypeid=recordtpeid,Market__c='North America',Region_Global__c=null);
       return testAccountRecord;
    }
      public static Account getSingleAccountRecordForMerge(Account testAccountRecord,id destinationAccountId,Id regionDataId){
        String customerRecordtypeID = Label.Account_Customer_Record_Type_ID ;       
        testAccountRecord.recordtypeid = customerRecordtypeID;
        testAccountRecord.name = 'Sony';
        testAccountRecord.Account_Group__c='';
        testAccountRecord.Housenumber_Local__c = 'test'; //
        testAccountRecord.Country__c = 'India'; //
        testAccountRecord.Region__c = regionDataId; //
        testAccountRecord.Street1_Local__c='test';
        testAccountRecord.City_Local__c='test';
        testAccountRecord.Destination_Account_Name__c = destinationAccountId; //
        testAccountRecord.Banner_Id__c='abc';
        testAccountRecord.Market__c='North America';
        return testAccountRecord;
    }
    
    public static Region__c getRegionData(){
        Region__c rediondata=new Region__c();
        rediondata.name='Test Region';
        rediondata.Country__c='India';
        rediondata.Region_Code__c='AA-113';
        return rediondata;
    
    }
    
    public static Region__c getRegionData2(){
        Region__c rediondata=new Region__c();
        rediondata.name='Goa';
        rediondata.Country__c='India';
        return rediondata;
    
    }
    
    public static  FeedItem getFeedItem(Id accId) {
         FeedItem testItemRecord = New FeedItem();
         testItemRecord.body= 'test';
         testItemRecord.parentId=accId;
         return testItemRecord;
     }
     
     public static  FeedComment getFeedComment() {
         FeedComment testItemRecord = New FeedComment();
         testItemRecord.CommentBody= 'test';
         //testItemRecord.parentId=accId;
         return testItemRecord;
     }
     
     public static  EntitySubscription getEntitySubscription (Id accId) {
         EntitySubscription testItemRecord = New EntitySubscription ();
         testItemRecord.parentId=accId;
         return testItemRecord;
     }
     
    public static  Note getNoteRecord(Id strategicAccountPlanId) {
         Note testNoteRecord = New Note();
         testNoteRecord.body= 'test';
         testNoteRecord.parentId=strategicAccountPlanId;
         testNoteRecord.Title = 'Sales Manager';
         return testNoteRecord;
     }
    public static Event getEventRecord(Id AccountId) {
         Event testEventRecord = New Event();
         testEventRecord.WhatId= AccountId;
         testEventRecord.DurationInMinutes = 60;
       //  testEventRecord.ActivityDate = Date.today(); 
         testEventRecord.ActivityDateTime = date.today();
         return testEventRecord;
     }
     public static Task getTaskRecord(Id AccountId) {
         Task testTaskRecord = New Task();
         testTaskRecord.WhatId= AccountId;
         return testTaskRecord ;
     }
    public static List<SObject> getSObjectRecord(Region__c rediondata) {
         Integer j;
         List<SObject> testSObjectlist= new List<SObject>();    
         SObject testSObject;     
         for (j=0; j<=10; j++){                
               testSObject = new Account(name='test'+j,BillingState='TE', BillingCity='test'+j, BillingStreet='test'+j, BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=rediondata.id);
             testSObjectlist.add(testSObject);
         }
         return testSObjectlist;
    }
    public static SObject getSObjectSingleRecord(Region__c rediondata) {
         SObject testSObject;    
              testSObject = new Account(name='TestSobject',BillingState='TE', BillingCity='Test2', BillingStreet='Test2', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=rediondata.id);            
         return testSObject;
    }
    public static List<AccountShare> getAccountShare(Id AccountID, ID userID){
        AccountShare accountShareRecord;
        List<AccountShare> accountShareList = new List<AccountShare>();
        accountShareRecord = new AccountShare(AccountAccessLevel = 'Owner',AccountId = AccountID,CaseAccessLevel = 'Edit',OpportunityAccessLevel='None',UserOrGroupId=userID);
        accountShareList.add(accountShareRecord);
        return accountShareList;
    }
    public static Account_Organization_Information__c getAccountOrgInfo(Account AccountRec) {
         Account_Organization_Information__c AccountOrganisationInfo;    
              AccountOrganisationInfo = new Account_Organization_Information__c( Account__c = AccountRec.Id, Market__c = 'North America',Sector__c = 'LI');            
         return AccountOrganisationInfo;
    }
    public static Account_Organization_Information__c getAccountOrganisationInfo(Account AccountRec) {
         Account_Organization_Information__c AccountOrganisationInfo;    
              AccountOrganisationInfo = new Account_Organization_Information__c( Account__c = AccountRec.Id, Market__c = 'North America',Sector__c = 'HC');            
         return AccountOrganisationInfo;
    }
    public static Account_affiliation__c getAccountAffiliation(Account AccountRec) {
         Account_affiliation__c AccountAffiliation;    
              AccountAffiliation = new Account_affiliation__c( Affiliated_Account__c = AccountRec.Id,Distributed_By__c = 'Distributed by',Distributing_to__c = 'Distributing to');            
         return AccountAffiliation;
    }
    
     public static Account getSingleCustomerAccountRecord(Region__c rediondata){
      
        id recordtpeid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Customer').RecordTypeId;
       Account testAccountRecord=new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City', Region__c=rediondata.id, recordtypeid=recordtpeid);
       return testAccountRecord;
    }
    
    
      
    public static list<Retail_Contract__c> getContractRecord(Account accountData) {
        list<Retail_Contract__c> contList= new list<Retail_Contract__c>();
        Date ContractstartDate = Date.newInstance(2014, 5, 1);        
        Retail_Contract__c cont;
        for(Integer i=0;i<100;i++) {
         cont = new Retail_Contract__c(Contract_Account_Name__c = accountData.id, Status__c = 'Created', Contract_Term_months__c = 12, Contract_Start_Date__c = ContractstartDate,Select_Deselect_all_category__c = true,Flag_for_select__c=false);
         contList.add(cont);
         }
        return contList;
    }
    
     public static list<Retail_Contract__c> getContractRecordFlase(Account accountData) {
        list<Retail_Contract__c> contListFalse= new list<Retail_Contract__c>();
        Date ContractstartDate = Date.newInstance(2014, 5, 1);        
        Retail_Contract__c contFalse;
        for(Integer i=0;i<100;i++) {
         contFalse= new Retail_Contract__c(Contract_Account_Name__c = accountData.id, Status__c = 'Created', Contract_Term_months__c = 12, Contract_Start_Date__c = ContractstartDate,Select_Deselect_all_category__c = false,
         Air_PPP__c  = true,Beauty_PPP__c = true, Beverage_Appliance_PPP__c = true, Espresso_Domestic_PPP__c = true, Floor_Care_PPP__c = true, Garment_Care_PPP__c = true,Kitchen_Appliances_PPP__c = true, Male_Grooming_PPP__c = true, Mother_Child_Care_PPP__c = true, Pain_Management_PPP__c = true, Philips_Oral_Healthcare_PPP__c = true);
         contListFalse.add(contFalse);
         }
        return contListFalse;
    }
    
     public static list<Retail_Contract__c> getContractRecordReset(Account accountData) {
        list<Retail_Contract__c> contListReset= new list<Retail_Contract__c>();
        Date ContractstartDate = Date.newInstance(2014, 5, 1);        
        Retail_Contract__c contFalse;
        for(Integer i=0;i<100;i++) {
         contFalse= new Retail_Contract__c(Contract_Account_Name__c = accountData.id, Status__c = 'Created', Contract_Term_months__c = 12, Contract_Start_Date__c = ContractstartDate,Select_Deselect_all_category__c = true,Flag_for_select__c=true,
         Air_PPP__c  = false,Beauty_PPP__c = true, Beverage_Appliance_PPP__c = true, Espresso_Domestic_PPP__c = true, Floor_Care_PPP__c = true, Garment_Care_PPP__c = true,Kitchen_Appliances_PPP__c = true, Male_Grooming_PPP__c = true, Mother_Child_Care_PPP__c = true, Pain_Management_PPP__c = true, Philips_Oral_Healthcare_PPP__c = true);
         contListReset.add(contFalse);
         }
        return contListReset;
    }
    
    public static Account getAccountLevel1Records(Region__c regionData){
        Account acc = new Account(Name = 'L1', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id); 
        return acc;       
    }
    public static Account getAccountLevel2Records(Region__c regionData, String accId){
        Account acc = new Account(Name = 'L2', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = accId, Level_01_Parent_Id__c=accId); 
        return acc;       
    }
    public static Account getAccountLevel3Records(Region__c regionData, String acc1Id, String acc2Id){
        Account acc = new Account(Name = 'L3', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId =acc2Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
               Level_03_Parent_Id__c=Null); 
        
        return acc;       
    }
    public static Account getAccountLevel4Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id){
        Account acc = new Account(Name = 'L4', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc3Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
              Level_03_Parent_Id__c=acc3Id); 
        
        return acc;       
    }
    public static Account getAccountLevel5Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id){
        Account acc = new Account(Name = 'L5', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc4Id, Level_01_Parent_Id__c=acc1Id,Level_02_Parent_Id__c=acc2Id,
              Level_03_Parent_Id__c=acc3Id, Level_04_Parent_Id__c=acc4Id); 
        
        return acc;       
    }
    
    public static Account getAccountLevel6Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id, String acc5Id){
        Account acc = new Account(Name = 'L6', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc5Id, Level_01_Parent_Id__c=acc1Id,Level_02_Parent_Id__c=acc2Id,
              Level_03_Parent_Id__c=acc3Id, Level_04_Parent_Id__c=acc4Id, 
              Level_05_Parent_Id__c=acc5Id); 
        
        return acc;       
    }
    
    public static Account getAccountLevel7Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id, String acc5Id, String acc6Id){
        Account acc = new Account(Name = 'L7', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc6Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
               Level_03_Parent_Id__c=acc3Id,  Level_04_Parent_Id__c=acc4Id, 
              Level_05_Parent_Id__c=acc5Id,  Level_06_Parent_Id__c=acc6Id); 
        
        return acc;       
    }
    
    public static Account getAccountLevel7RecordsDummy(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id){
        Account acc = new Account(Name = 'L7', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc1Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
              Level_03_Parent_Id__c=acc3Id,  Level_04_Parent_Id__c=acc4Id); 
        
        return acc;       
    }
    
    public static Account getAccountTest1Records(Region__c regionData){
        Account acc = new Account(Name = 'Test1', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id); 
        
        return acc;       
    }
    public static Account getAccountTest2Records(Region__c regionData, String acc1Id){
        Account acc = new Account(Name = 'Test2', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc1Id, Level_01_Parent_Id__c=acc1Id, Associated_IDN__c = acc1Id); 
        
        return acc;       
    }
    public static Account getAccountTest3Records(Region__c regionData, String acc1Id, String acc2Id){
        Account acc = new Account(Name = 'Test3', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc2Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id
              ); 
        
        return acc;       
    }
    public static Account getAccountTest4Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id){
        Account acc = new Account(Name = 'Test4', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc3Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
               Level_03_Parent_Id__c=acc3Id); 
        
        return acc;       
    }
    public static Account getAccountTest5Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id){
        Account acc = new Account(Name = 'Test5', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc4Id, Level_01_Parent_Id__c=acc1Id, Level_02_Parent_Id__c=acc2Id,
               Level_03_Parent_Id__c=acc3Id, Level_04_Parent_Id__c=acc4Id); 
        
        return acc;       
    }
    public static Account getAccountTest6Records(Region__c regionData, String acc1Id, String acc2Id, String acc3Id, String acc4Id, String acc5Id){
        Account acc = new Account(Name = 'Test6', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
              BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A', 
              LI_Account_Classification__c='A', Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',
              Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
              Region__c=regionData.id, ParentId = acc5Id, Level_01_Parent_Id__c=acc1Id,  Level_02_Parent_Id__c=acc2Id,
               Level_03_Parent_Id__c=acc3Id, Level_04_Parent_Id__c=acc4Id,
              Level_05_Parent_Id__c=acc5Id); 
        
        return acc;       
    } 
     /**
    * @Description : This method creates Asset record for account.
    * @param       : Account(parent)
    * @return      : Asset records.
    **/
    public static Asset getListOfAssetRecord(Account acc){
        Asset assetData = new Asset(
            Department__c='Radiology',
            Medical_Services__c='Angio',
            Status='INSTALL',
            Lease_Expiration_Date__c=system.today(),        
            UsageEndDate=system.today()+5,      
            Booking_Date__c=system.today(),       
            Ship_Date__c=system.today()+3,
            AccountId=acc.Id,
            name='testParentAsset',
            InstallDate=system.today(),
            Ship_to_Account__c=acc.id,
            Phone_Book_Account__c=acc.id);
        
        return assetData;
    }  
}