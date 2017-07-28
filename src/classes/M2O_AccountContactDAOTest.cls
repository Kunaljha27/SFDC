/**
@Classname :       M2O_AccountContactDAOTest
@Description :     This test class is written to test the Apex class M2O_AccountContactDAO. 
@Author:           Meeta Pramanik/srutadeba 
@Last Modified:    2/12/2013
**/
@isTest(SeeAllData=false)
public class M2O_AccountContactDAOTest {

/** @Description : This test method is used cover the updateMarketSector method of M2O_AccountContactDAO class
    @Return type: void **/
    
    static TestMethod void Test_MarketAttribute(){
   
       User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
       M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
        System.runAs(runAsUser) {  
        Region__c regionData = New Region__c ();
        regionData= M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
  
        List<Account> listUpdateAccount = New List<Account>();
        listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
        insert listUpdateAccount;
  
        dAOHelper.updateMarketSector(listUpdateAccount);
        System.assertNotEquals(listUpdateAccount,null);
        listUpdateAccount[0].id=null;
        dAOHelper.updateMarketSector(listUpdateAccount);
       } 
    }

  /** @Description : This test method is used cover the updateMarketSectorContact method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void  Test_updateMarketSectorContact() {
    Test.startTest();
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
    M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Contact> listContact = new List<Contact>();
    listContact = M2O_AccountContactTestDataUtility.getContactRecord(); 
    insert listContact ;

    dAOHelper.updateMarketSectorContact(listContact);
    Test.stopTest();
    System.assertNotEquals(listContact,null);
    listContact[0].id=null;
    dAOHelper.updateMarketSectorContact(listContact);
    } 
 }

/** @Description : This test method is used cover the contactRecords method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void  Test_ContactMarketAttribute() {  
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
    M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Contact> listContact = new List<Contact>();
    listContact = M2O_AccountContactTestDataUtility.getContactRecord(); 
    insert listContact ;
  
    Set<Id> setContactId=new Set<Id>();
    setContactId.add(listContact[0].id);
    List<Contact> contactList = new List<Contact>();
    contactList = dAOHelper.getContactRecords(setContactId);
    System.assertNotEquals(listContact,null);
    //dAOHelper.getContactRecords(null);
    }      
  }
  
    /** @Description : This test method is used cover the accountRecords method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void  Test_AccountMarketAttribute() {  
    
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
    M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account> listAccount = New List<Account>();
    listAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert listAccount;
  
    Set<Id> setAccountId=new Set<Id>();
    setAccountId.add(listAccount[0].id);
    List<Account> accountList = new List<Account>();
    accountList = dAOHelper.getAccountRecords(setAccountId);
    System.assertNotEquals(listAccount,null);
    //dAOHelper.getAccountRecords(null);
    }  
  }
 
 
  /** @Description : This test method is used cover the insrtaccMrktSectrAttribute method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void  TestInsertAccountMarketAttribute () {
    
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
    M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account_Market_Sector_Attribute__c> listAccountMarket= new List<Account_Market_Sector_Attribute__c>();
    listAccountMarket= M2O_AccountContactTestDataUtility.getAccMarktAttrRecord(regionData);
    insert listAccountMarket;
    M2O_AccountContactDAO.updateAccountAttribute(listAccountMarket);
    dAOHelper.insrtAccMrktSectrAttribute(listAccountMarket);
    System.assertNotEquals(listAccountMarket,null);
    listAccountMarket[0].id=null;
    M2O_AccountContactDAO.updateAccountAttribute(listAccountMarket);
    }  
 }
  
  /** @Description : This test method is used cover the insrtcntctMarktSctrAttribute method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void  Test_InsertContactMarketAttribute () {
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
    M2O_AccountContactDAO dAOHelper = new M2O_AccountContactDAO();   
   
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List <Contact_Market_Sector_Attributes__c> listContactMarket= new List <Contact_Market_Sector_Attributes__c>();
    listContactMarket= M2O_AccountContactTestDataUtility.getConMarktAttrRecord();
    insert listContactMarket;
    List<Contact_Market_Sector_Attributes__c> listContactMarketSector= new List <Contact_Market_Sector_Attributes__c>();
    listContactMarketSector = dAOHelper.insrtcntctMarktSctrAttribute(listContactMarket);
    System.assertNotEquals(listContactMarket,null);
  }
 }     
 
 /** @Description : This test method is used cover the updateAccount method of M2O_AccountContactDAO class
    @Return type: void **/
    static testMethod void test_UpdateAccount(){
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account> listUpdateAccount = New List<Account>();
    listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert listUpdateAccount;
   
    M2O_AccountContactDAO.updateAccount(listUpdateAccount); 
    System.assertNotEquals(listUpdateAccount,null);
    listUpdateAccount[0].id=null;
    M2O_AccountContactDAO.updateAccount(listUpdateAccount); 
   }
  }
     
 /** @Description : This test method is used cover the getM2OAccount method of M2O_AccountContactDAO class
    @Return type: void **/
    static testmethod void test_GetM2OAccount(){
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account> listUpdateAccount = New List<Account>();
    listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert listUpdateAccount;
   
    Set<Id> setAccountId=new Set<Id>();
    setAccountId.add(listUpdateAccount[0].id);
    List<Account> accountList = new List<Account>();
    accountList = M2O_AccountContactDAO.getM2OAccount(setAccountId); 

    System.assertNotEquals(listUpdateAccount,null);
    M2O_AccountContactDAO.getM2OAccount(null);
  
   }
  } 
 
  /** @Description : This test method is used cover the getAccountTeamCount method of M2O_AccountContactDAO class
    @Return type: void **/
    static testmethod  void test_GetAccountTeamCount(){
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account> listUpdateAccount = New List<Account>();
    listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert listUpdateAccount;
   
    Set<Id> setAccountId=new Set<Id>();
    setAccountId.add(listUpdateAccount[0].id);
    List<AggregateResult> aggregateResultList = new List<AggregateResult>();
    aggregateResultList = M2O_AccountContactDAO.getAccountTeamCount(setAccountId); 

    System.assertNotEquals(listUpdateAccount,null);
    M2O_AccountContactDAO.getAccountTeamCount(null);
    }
  }  
  
    /* @Description : This test method covers the retriveAssociatedContacts() method of Dao class
  */ 
    static testmethod  void test_RetriveAssociatedContacts(){
    User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
  
    List<Account> listUpdateAccount = New List<Account>();
    listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert listUpdateAccount;
   
    Set<Id> setAccountId=new Set<Id>();
    Set<Id> setAccountIdNull;
    setAccountId.add(listUpdateAccount[0].id);
    List<AggregateResult>  aggregateResultList = new List<AggregateResult>();
    aggregateResultList = M2O_AccountContactDAO.retrieveAssociatedContacts(setAccountId); 
    System.assertNotEquals(listUpdateAccount,null);
    M2O_AccountContactDAO.retrieveAssociatedContacts(setAccountIdNull);
    setAccountIdNull = new Set<Id>();
    M2O_AccountContactDAO.retrieveAssociatedContacts(setAccountIdNull);
    M2O_AccountContactDAO.retrieveAssociatedContacts(null);
    }
  } 
    /* @Description : This test method covers the getAccountQueriableFields() method of Dao class
  */ 
  
      static testmethod  void test_GetAccountQueriableFields(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {  
      Region__c regionData = New Region__c ();
      regionData= M2O_AccountContactTestDataUtility.getRegionData();
      insert regionData;
      Account accountData;
      accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
      insert accountData;
      List<Account_Market_Sector_Attribute__c> actAtribList;
      actAtribList = M2O_AccountContactTestDataUtility.getAccMarktAttrRecord(regionData);
      insert actAtribList;
      String sourceAccountQuery = 'Select name,BillingState,recordtypeid From Account Limit 1';
      Account accountTestData =  M2O_AccountContactDAO.getAccountQueriableFields(sourceAccountQuery); 
      System.assertNotEquals(accountTestData ,null);
      String sourceAccountQuery1 = 'Select name FROM Account_Market_Sector_Attribute__c LIMIT 1';
      M2O_AccountContactDAO.getAccountAttributesQueriableFields(sourceAccountQuery1);
      //String sourceAccountQueryNull='';
      //M2O_AccountContactDAO.getAccountQueriableFields(sourceAccountQueryNull);
      //M2O_AccountContactDAO.getAccountAttributesQueriableFields(sourceAccountQueryNull);
      }    
    }  
  
         /* @Description : This test method covers the getDestinationAccount() method of Dao class
  */ 
  
    static testmethod  void test_getDestinationAccount(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
    List<Account> accountList = new List<Account>();
    set<Id> accountSetId = new set<Id>();
    set<Id> nullAccountSetId;
    accountList = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
    insert accountList;
    accountSetId = M2O_AccountContactTestDataUtility.getAccountRecordTypeId(accountList);
    String destinationAccountQuery = 'Select name,BillingState,recordtypeid From Account Limit 1';
    List<Account> ListAccountTest =  M2O_AccountContactDAO.getDestinationAccount(accountSetId, destinationAccountQuery); 
    System.assertNotEquals(ListAccountTest,null);
    //String destinationAccountQueryNull='';
    M2O_AccountContactDAO.getDestinationAccount(null,destinationAccountQuery);  
   }    
  } 

         /* @Description : This test method covers the getAccountRelatedObject() method of Dao class
  
  
    static testmethod  void test_getAccountRelatedObject(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
    Account accountData;
    accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
    insert accountData;
    String relatedObjectQuery = 'Select name,BillingState,recordtypeid From Account Limit 1';
    sObject accountTestData = M2O_AccountContactDAO.getAccountRelatedObject(relatedObjectQuery); 
    System.assertNotEquals(accountTestData ,null);  
   }    
  }  */ 
     /* @Description : This test method covers the getAllActiveAccountTeamMember() method of Dao class
  */ 
  
    static testmethod  void test_getAllActiveAccountTeamMember(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {  
        Region__c regionData = New Region__c ();
        regionData= M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account accountData;
        accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
        insert accountData;
        string sourceAccountID = accountData.id;
        List<Account_Organization_Information__c> accOrgList = new List<Account_Organization_Information__c>();
        Account_Organization_Information__c accOrgRec = M2O_AccountContactTestDataUtility.getAccountOrgInfo(accountData);
        Insert accOrgRec;
        accOrgList.add(accOrgRec);
        String nullSourceAccountID='';
        M2O_AccountContactDAO.getAllActiveAccountTeamMember(sourceAccountID); 
        M2O_AccountContactDAO.getAllActiveAccountTeamMember(nullSourceAccountID);
        M2O_AccountContactDAO.getAllActiveAccountTeamMember('null');
        System.assertNotEquals(sourceAccountID,null);
        List<Account_Organization_Information__c> accOrgInfo = M2O_AccountContactDAO.getAllAccountOrg(sourceAccountID);
        System.assertNotEquals(accOrgInfo,null);
        String nullSourceAccountId1;
        M2O_AccountContactDAO.getAllAccountOrg(nullSourceAccountId1);
        List<EntitySubscription> entitySub = M2O_AccountContactDAO.getEntitySubscriptionList(sourceAccountID);
        List<FeedComment> commentList = M2O_AccountContactDAO.getFeedCommentList(sourceAccountID);
        List<FeedItem> feedItemList = M2O_AccountContactDAO.getFeedItemsList(sourceAccountID);
        List<Account> actList = M2O_AccountContactDAO.getLkpAccountList(sourceAccountID);
        List<Asset> assetList = M2O_AccountContactDAO.getAssetsList(sourceAccountID);
        Boolean flag = M2O_AccountContactDAO.deleteAccountOrg(accOrgList);
        //accOrgList[0].id=null;
        //M2O_AccountContactDAO.deleteAccountOrg(accOrgList);
        Asset assetRecord = M2O_AccountContactTestDataUtility.getListOfAssetRecord(accountData);
        List<Asset> assetList1 =new List<Asset>();
        assetList1.add(assetRecord);
        M2O_AccountContactDAO.setAssets(assetList1);
        FeedItem feedItemRec = M2O_AccountContactTestDataUtility.getFeedItem(accountData.Id);
        Insert feedItemRec;
        List<FeedItem> feedList= new List<FeedItem>();
        feedList.add(feedItemRec);
        M2O_AccountContactDAO.setFeedItem(feedList);
     }    
  }  
     /* @Description : This test method covers the getAccountShareList() method of Dao class
  
  
      static testmethod  void test_getAccountShareList(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
     
      System.runAs(runAsUser) {  
      Region__c regionData = New Region__c ();
      regionData= M2O_AccountContactTestDataUtility.getRegionData();
      insert regionData;
      Account accountData;
      accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
      insert accountData;
      string sourceAccountID = accountData.id;
      M2O_AccountContactDAO.getAccountShareList(sourceAccountID); 
      System.assertNotEquals(sourceAccountID,null);  
   }    
  } */
       /* @Description : This test method covers the setEntitySubscription() method of Dao class
       */
  
      static testmethod  void test_setFeedComment(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
     
      System.runAs(runAsUser) {  
      Region__c regionData = New Region__c ();
      regionData= M2O_AccountContactTestDataUtility.getRegionData();
      insert regionData;
      Account accountData;
      accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
      insert accountData;
      List<EntitySubscription> entityList= new List<EntitySubscription >();
      EntitySubscription subObjSub = new EntitySubscription(parentId = accountData.id, SubscriberId = UserInfo.getUserId(), networkId=null);
      insert subObjSub;
      entityList.add(subObjSub);
      List<FeedComment> feedCommentList = new List<FeedComment>();
      FeedItem itemRec = M2O_AccountContactTestDataUtility.getFeedItem(accountData.id);
      insert itemRec;
      FeedComment commentObj = new FeedComment();
      commentObj.commentbody = 'comment';
      commentObj.feedItemId = itemRec.Id;
      insert commentObj;
      feedCommentList.add(commentObj); 
      M2O_AccountContactDAO.setFeedComment(feedCommentList);
      M2O_AccountContactDAO.setEntitySubscription(entityList);  
     }    
   }   
     /* @Description : This test method covers the setAccountShare() method of Dao class
   
  
    static testmethod  void test_setAccountShare(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {  
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
    Account accountData;
    accountData = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
    insert accountData;
    List<AccountShare> accountShareList = new List<AccountShare>();
    accountShareList = M2O_AccountContactTestDataUtility.getAccountShare(accountData.id,runAsUser.id);
    Boolean error;
    error =  M2O_AccountContactDAO.setAccountShare(accountShareList); 
    System.assertNotEquals(accountShareList,null);  
   }    
  } */
      /* @Description : This test method covers the setRelatdObj() method of Dao class
   
  
    static testmethod  void test_setRelatdObj(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
     System.runAs(runAsUser) {      
     List<SObject> testSObjectlist= new List<SObject>();
     Region__c regiondata;
     regiondata = M2O_AccountContactTestDataUtility.getRegionData();
     insert regiondata;
     testSObjectlist = M2O_AccountContactTestDataUtility.getSObjectRecord(regiondata);
     insert testSObjectlist;
     M2O_AccountContactDAO.setRelatdObj(testSObjectlist); 
     System.assertNotEquals(testSObjectlist,null);  
   }    
  } */ 
      /* @Description : This test method covers the deleteSourceAccount() method of Dao class
  */ 
  
    static testmethod  void test_deleteSourceAccount(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {      
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
    Account sourceAcc;
    Account destinationAcc;
    sourceAcc = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
    insert sourceAcc;
    destinationAcc = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
    insert destinationAcc;
    string mergeHistoryTracking = 'test';
    Boolean isCustomer = true;
    Account_Market_Sector_Attribute__c attribObj = new Account_Market_Sector_Attribute__c();
    try {
                attribObj = [select id, name from Account_Market_Sector_Attribute__c where AccountId__c =:sourceAcc.id];
    }
    catch(Exception ex) {
        system.debug('exception'+ex);
    }
    Set<Id> setOfAcc = new Set<Id>();
    Set<Id> setOfNullAcc;
    setOfAcc.add(sourceAcc.id);
    setOfAcc.add(destinationAcc.id);
    String sourceAccId = sourceAcc.id;
    List<Account> actList =new List<Account>();
    actList.add(sourceAcc);
    actList.add(destinationAcc);
    String destinationAccId = destinationAcc.id;
    String exceptionSourceAccId;
    M2O_AccountContactDAO.deleteSourceAccount(mergeHistoryTracking,sourceAcc,destinationAcc,isCustomer,attribObj); 
    System.assertNotEquals(sourceAcc,null);  
    System.assertNotEquals(destinationAcc,null);
    //M2O_AccountContactDAO.getParentLevelAccount(setOfAcc);
    //M2O_AccountContactDAO.getParentLevelAccount(setOfNullAcc);
    //M2O_AccountContactDAO.getParentChildAccountList(sourceAccId,destinationAccId);
    //M2O_AccountContactDAO.getParentChildAccountMoreRecords(sourceAccId);
    //M2O_AccountContactDAO.getParentChildAccountMoreRecords(exceptionSourceAccId);
    M2O_AccountContactDAO.getAccountAttribute(setOfAcc);
    M2O_AccountContactDAO.setLkpAccount(actList);
    actList[0].id=null;
    M2O_AccountContactDAO.setLkpAccount(actList);
   }    
  } 
     /* @Description : This test method covers the getCurrentAccount() method of Dao class
  */ 
  
    static testmethod  void test_getCurrentAccount(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {      
    Region__c regionData = New Region__c ();
    regionData= M2O_AccountContactTestDataUtility.getRegionData();
    insert regionData;
    Account sourceAcc;
    sourceAcc = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
    insert sourceAcc;
    //M2O_AccountContactDAO.getCurrentAccount(sourceAcc.id);
    Id nullSource;
    //M2O_AccountContactDAO.getCurrentAccount(nullSource); 
    System.assertNotEquals(sourceAcc,null);  
   }    
  }  
     /* @Description : This test method covers the insertAccountOrganizationInformation() method of Dao class
  */ 
  
      static testmethod  void test_insertAccountOrganizationInformation(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
     
      System.runAs(runAsUser) {      
      List<SObject> testSObjectlist= new List<SObject>();
      Region__c regiondata;
      regiondata = M2O_AccountContactTestDataUtility.getRegionData();
      insert regiondata;
      Account sourceAcc;
      sourceAcc = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
      insert sourceAcc;
      Account_Organization_Information__c AccountOrgInfo = new Account_Organization_Information__c();
      AccountOrgInfo = M2O_AccountContactTestDataUtility.getAccountOrganisationInfo(sourceAcc);
      insert AccountOrgInfo;
      List<Account_Organization_Information__c> accOrgInfoList = new List<Account_Organization_Information__c>();
      accOrgInfoList.add(AccountOrgInfo);    
      Boolean error;
      error = M2O_AccountContactDAO.insertAccountOrganizationInformation(accOrgInfoList); 
      System.assertNotEquals(accOrgInfoList,null);  
    }    
  }
    /* @Description : This test method covers the getAccountOrganizationList() method of Dao class
  */ 
  
    static testmethod  void test_getAccountOrganizationList(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
    UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
    User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
    insert runAsUser;
     
    System.runAs(runAsUser) {      
    List<SObject> testSObjectlist= new List<SObject>();
    Region__c regiondata;
    regiondata = M2O_AccountContactTestDataUtility.getRegionData();
    insert regiondata;
    Account sourceAcc;
    sourceAcc = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
    insert sourceAcc;
    Account_Organization_Information__c AccountOrgInfo = new Account_Organization_Information__c();
    AccountOrgInfo = M2O_AccountContactTestDataUtility.getAccountOrganisationInfo(sourceAcc);
    insert AccountOrgInfo;
    List<Account_Organization_Information__c> accOrgInfoList = new List<Account_Organization_Information__c>(); 
    string sourceAccIdString = string.valueof(sourceAcc.id);
    accOrgInfoList = M2O_AccountContactDAO.getAccountOrganizationList(sourceAccIdString); 
    System.assertNotEquals(accOrgInfoList,null);
    String nullSource; 
    M2O_AccountContactDAO.getAccountOrganizationList(nullSource);
    //M2O_AccountContactDAO.getAccountOrganizationList('null'); 
   }    
  }
   /* @Description : This test method covers the getAffiliatedAccountList() method of Dao class
  
      static testmethod  void test_getAffiliatedAccountList(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
     
     System.runAs(runAsUser) {      
     List<SObject> testSObjectlist= new List<SObject>();
     Region__c regiondata;
     regiondata = M2O_AccountContactTestDataUtility.getRegionData();
     insert regiondata;
     Account sourceAcc;
     sourceAcc = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
     insert sourceAcc;
     Account_affiliation__c AccountAffiliation = new Account_affiliation__c();
     AccountAffiliation = M2O_AccountContactTestDataUtility.getAccountAffiliation(sourceAcc);
     insert AccountAffiliation;
     List<Account_affiliation__c> accAffiliationList = new List<Account_affiliation__c>(); 
     string sourceAccIdString = string.valueof(sourceAcc.id);
     accAffiliationList = M2O_AccountContactDAO.getAffiliatedAccountList(sourceAccIdString); 
     System.assertNotEquals(accAffiliationList,null);  
     }    
  }*/
  /* @Description : This test method covers the getOwnerForSelectedObject() method of Dao class
  
  
      static testmethod  void test_getOwnerForSelectedObject(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
     
      System.runAs(runAsUser) {      
      User userRecord = M2O_UserTestDataUtility.getHCUserRecord(profileTest.id);
      userRecord.isActive = false;
      insert userRecord;
      Set<id> userIdSet = new Set<id>();
      userIdSet.add(userRecord.id);
      List<User> userList = new List<User>(); 
      userList = M2O_AccountContactDAO.getOwnerForSelectedObject(userIdSet); 
      System.assertNotEquals(userIdSet,null);  
     }    
  }*/ 
}