/**
@Classname :       M2O_MergeAccountServiceTest
@Description :     This test class is written to test the Apex Class M2O_MergeAccountService. 
@Author:           Ruchika Patil
@Last Modified:    20/03/2014
**/

@isTest(SeeAllData=false)
public class M2O_MergeAccountServiceTest{
  /* @Description : This test method covers the getAccountQueriableFields() method of Service class
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
            String sourceAccountQuery = 'Select name,BillingState,recordtypeid From Account Limit 1';
            Account accountTestData =  M2O_MergeAccountService.getAccountQueriableFields(sourceAccountQuery); 
            System.assertNotEquals(accountTestData ,null);  
        }    
    }  
    /* @Description : This test method covers the getDestinationAccount() method of Service class
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
            accountList = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert accountList;
            accountSetId = M2O_AccountContactTestDataUtility.getAccountRecordTypeId(accountList);
            String destinationAccountQuery = 'Select name,BillingState,recordtypeid From Account Limit 1';
            List<Account> ListAccountTest =  M2O_MergeAccountService.getDestinationAccount(accountSetId, destinationAccountQuery); 
            System.assertNotEquals(ListAccountTest,null);  
        }    
    }
    
    /* @Description : This test method covers the getAccountAttributeQueriableFields() method of Service class
  */   
    static testmethod  void test_GetAccountAttributeQueriableFields(){
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
            Account_Market_Sector_Attribute__c attribObj = new Account_Market_Sector_Attribute__c();
            attribObj.AccountId__c = accountData.Id;
            attribObj.name = accountData.name + 'Attrib';
            insert attribObj;
            String sourceAccountQuery = 'Select name,Id From Account_Market_Sector_Attribute__c Limit 1';
            Account_Market_Sector_Attribute__c accountTestData =  M2O_MergeAccountService.getAccountAttributeQueriableFields(sourceAccountQuery ); 
            System.assertNotEquals(accountTestData ,null);  
        }    
    }  
  
   /* @Description : This test method covers the getRelatedObject() method of Service class
  */   
    static testmethod  void test_getRelatedObject(){
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
            //sObject accountTestData = M2O_MergeAccountService.getRelatedObject(relatedObjectQuery); 
            //System.assertNotEquals(accountTestData ,null);  
        }    
    } 
  /* @Description : This test method covers the setAccountRelatedObject() method of Service class
  */ 
    static testmethod  void test_setAccountRelatedObject(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;   
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            Account destAcc;
            SObject testSObject;
            Account_Market_Sector_Attribute__c attribObj;
            List<Related_Object_of_Account__c> relatedObjectsList = new  List<Related_Object_of_Account__c>();
            relatedObjectsList  = Related_Object_of_Account__c.getall().values();
            String mergeHistoryTracking = 'Test1 is merged with Test2' ;
            Boolean isCustomerAccount = true;
            Boolean error = false;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            destAcc = M2O_AccountContactTestDataUtility.getAccountRec(regionData);
            insert destAcc;
            testSObject = M2O_AccountContactTestDataUtility.getSObjectSingleRecord(regionData);
            insert testSObject;
            Schema.DescribeSObjectResult accontDescribeSobject = Account.sObjectType.getDescribe();
            List<Schema.ChildRelationship> accountChildRelationshipList = accontDescribeSobject.getChildRelationships();
            Map<String, String> objFieldAPIMap = new Map<String, String>();
            for (Schema.ChildRelationship sc : accountChildRelationshipList ) {        
                objFieldAPIMap.put(String.valueOf(sc.getRelationshipName()), String.valueOf(sc.getField()));            
            }
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            try {
                attribObj = [select id, name from Account_Market_Sector_Attribute__c where AccountId__c =:sourceAccountID.id];
            }
            catch(Exception ex) {
                system.debug('exception'+ex);
            }
            error = M2O_MergeAccountService.setAccountRelatedObject(mergeHistoryTracking,destAcc,isCustomerAccount,error,sourceAccountIDstring,selectedAccountIDstring,objFieldAPIMap,attribObj ); 
            System.assertNotEquals(sourceAccountID,null);  
        }    
    }    
  /* @Description : This test method covers the setAccountTeam() method of Service class
  */   
    static testmethod  void test_setAccountTeam(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            List<User> userListTest = new List<User>();
            userListTest = M2O_AccountContactTestDataUtility.getUserforAccountTeamMember(profileTest.id);
            insert userListTest;
            List<AccountTeamMember> testAccountTeamMemberList= new List<AccountTeamMember>();
            List<AccountTeamMember> testAccountTeamMemberSecondList= new List<AccountTeamMember>();
            List<AccountTeamMember> testDestAccountTeamMemberList= new List<AccountTeamMember>();
            testAccountTeamMemberList = M2O_AccountContactTestDataUtility.getAccountTeamMemberRecord(sourceAccountID.id,userListTest);
            insert testAccountTeamMemberList;
            testAccountTeamMemberSecondList= M2O_AccountContactTestDataUtility.getSecondAccountTeamMemberRecord(sourceAccountID.id,userListTest);
            insert testAccountTeamMemberSecondList;
            testDestAccountTeamMemberList = M2O_AccountContactTestDataUtility.getAccountTeamMemberRecord(selectedAccountID.id,userListTest);
            insert testDestAccountTeamMemberList;
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            //testAccountTeamMemberList = M2O_MergeAccountService.setAccountTeam(sourceAccountIDstring,selectedAccountIDstring); 
            //testAccountTeamMemberList = M2O_MergeAccountService.deleteAccountTeam(sourceAccountIDstring,selectedAccountIDstring);
            System.assertNotEquals(sourceAccountID,null);  
        }    
    } 
  /* @Description : This test method covers the setAccountShare() method of Service class
    
    static testmethod  void test_setAccountShare(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            List<User> userListTest = new List<User>();
            userListTest = M2O_AccountContactTestDataUtility.getUserforAccountTeamMember(profileTest.id);
            insert userListTest;
            List<AccountTeamMember> testAccountTeamMemberList= new List<AccountTeamMember>();
            testAccountTeamMemberList = M2O_AccountContactTestDataUtility.getAccountTeamMemberRecord(sourceAccountID.id,userListTest);
            insert testAccountTeamMemberList;
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            List<AccountShare> testAccountShareList = new List<AccountShare>();
            //testAccountShareList = M2O_MergeAccountService.setAccountShare(sourceAccountIDstring,selectedAccountIDstring); 
            System.assertNotEquals(sourceAccountID,null);  
        }    
    }*/
  /* @Description : This test method covers the setActivities() method of Service class
    
    static testmethod  void test_setActivities(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            List<SObject> testSObjectlist= new List<SObject>();
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            SObject testSObject;
            testSObject = M2O_AccountContactTestDataUtility.getSObjectSingleRecord(regiondata);
            testSObjectlist.add(testSObject);
            insert testSObjectlist;
            Task taskRec;
            taskRec = M2O_AccountContactTestDataUtility.getTaskRecord(sourceAccountID.Id);
            insert taskRec;
            Event eventRec;
            eventRec = M2O_AccountContactTestDataUtility.getEventRecord(sourceAccountID.Id);
            insert eventRec; 
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            List<sObject> testAccountList= new List<sObject>();
            testAccountList = M2O_MergeAccountService.setActivities(sourceAccountIDstring,selectedAccountIDstring,testSObjectlist); 
            System.assertNotEquals(sourceAccountID,null);  
        }    
    } */
  /* @Description : This test method covers the setNotes() method of Service class
  */     
    static testmethod  void test_setNotes(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;    
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            Note noteRec;
            noteRec = M2O_AccountContactTestDataUtility.getNoteRecord(sourceAccountID.id);
            insert noteRec;
            FeedItem itemRec = M2O_AccountContactTestDataUtility.getFeedItem(sourceAccountID.id);
            insert itemRec;
            FeedComment commentObj = new FeedComment();
            commentObj.commentbody = 'comment';
            commentObj.feedItemId = itemRec.Id;
            insert commentObj;
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            map<id,id> feedItemMap = new map<id,Id>();
            List<Note> testListNote = new List<Note>();
            //testListNote = M2O_MergeAccountService.setNotes(sourceAccountIDstring,selectedAccountIDstring); 
            List<FeedItem> testItemList = new List<FeedItem>();
            testItemList = M2O_MergeAccountService.setFeedItem(sourceAccountIDstring,selectedAccountIDstring); 
            List<FeedComment> testCommentList = new List<FeedComment>();
            feedItemMap.put(sourceAccountID.id,sourceAccountID.id);
            testCommentList = M2O_MergeAccountService.setFeedComment(sourceAccountIDstring,selectedAccountIDstring,feedItemMap);
            EntitySubscription subObj = new EntitySubscription(parentId = sourceAccountID.id, SubscriberId = UserInfo.getUserId(), networkId=null);
            insert subObj;
            List<EntitySubscription > testSubsList = new List<EntitySubscription >();
            testSubsList = M2O_MergeAccountService.setEntitySubscription(sourceAccountIDstring,selectedAccountIDstring);
            System.assertNotEquals(sourceAccountID,null);
            List<EntitySubscription > testSubsList1 = new List<EntitySubscription >();
            EntitySubscription subObjSub = new EntitySubscription(parentId = selectedAccountID.id, SubscriberId = UserInfo.getUserId(), networkId=null);
            insert subObjSub;
            testSubsList1 = M2O_MergeAccountService.setEntitySubscription(sourceAccountIDstring,selectedAccountIDstring);
            System.assertNotEquals(sourceAccountID,null);
            
            
              
        }    
    } 
  /* @Description : This test method covers the setAttchments() method of Service class
        
    static testmethod  void test_setAttchments(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            Attachment testAttachmentRecord;
            List<Attachment> testListAttachment = new List<Attachment>();
            testAttachmentRecord = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(sourceAccountID.id);
            testListAttachment.add(testAttachmentRecord);
            insert testListAttachment;
            testListAttachment = M2O_MergeAccountService.setAttchments(sourceAccountIDstring,selectedAccountIDstring); 
            System.assertNotEquals(sourceAccountID,null);  
        }    
    } */ 
    /* @Description : This test method covers the setAccountOrgInfo() method of Service class
  */ 
    static testmethod  void test_setAccountOrgInfo(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;   
        System.runAs(runAsUser) {  
            List<Account_Organization_Information__c> accOrgInfoList  = new List<Account_Organization_Information__c>();
            List<Account_Organization_Information__c> accOrgInfoList1  = new List<Account_Organization_Information__c>();
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            Account accountRec;
            SObject testSObject;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;   
            accountRec = M2O_AccountContactTestDataUtility.getAccountRec(regionData); 
            insert accountRec;        
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            string accountRecString = accountRec.id;
            accOrgInfoList = M2O_MergeAccountService.setAccountOrgInfo(accountRecString,accountRecString); 
            Account_Organization_Information__c AccountOrgInfo;
            Account_Organization_Information__c AccountOrgansiationInfo;
            AccountOrgInfo = M2O_AccountContactTestDataUtility.getAccountOrgInfo(sourceAccountID);
            insert AccountOrgInfo;
            accOrgInfoList = M2O_MergeAccountService.setAccountOrgInfo(sourceAccountIDstring,selectedAccountIDstring); 
            System.assertNotEquals(sourceAccountID,null); 
            AccountOrgansiationInfo = M2O_AccountContactTestDataUtility.getAccountOrganisationInfo(selectedAccountID);
            insert AccountOrgansiationInfo;
            accOrgInfoList1 = M2O_MergeAccountService.setAccountOrgInfo(sourceAccountIDstring,selectedAccountIDstring); 
            System.assertNotEquals(sourceAccountID,null); 
             
        }    
    } 
    /* @Description : This test method covers the setAffiliatedAccount() method of Service class
         
    static testmethod  void test_setAffiliatedAccount(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            string sourceAccountIDstring = sourceAccountID.id;
            string selectedAccountIDstring = selectedAccountID.id;
            Account_affiliation__c accountAffiliationRec;
            accountAffiliationRec = M2O_AccountContactTestDataUtility.getAccountAffiliation(sourceAccountID);
            insert accountAffiliationRec;
            List<Account_affiliation__c> accountAffiliationList = new List<Account_affiliation__c>();
            List<sObject> accountAffList = new List<sObject>();
            accountAffiliationList = M2O_MergeAccountService.setAffiliatedAccount(sourceAccountIDstring,selectedAccountIDstring,accountAffList); 
            System.assertNotEquals(sourceAccountID,null);  
        }    
    }*/
    /* @Description : This test method covers the isOwnerActive() method of Service class
     
    static testmethod  void test_isOwnerActive(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            set<id> userIdSet = new set<id>();
            userIdSet.add(sourceAccountID.id);
            userIdSet.add(selectedAccountID.id);
            Boolean isOwnerInactive = M2O_MergeAccountService.isOwnerActive(userIdSet); 
            System.assertNotEquals(userIdSet,null);  
        }    
    } */
      /* @Description : This test method covers the getAttributeRecords() method of Service class
  */   
    static testmethod  void test_GetAttributeRecords(){
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
            Account_Market_Sector_Attribute__c attribObj = new Account_Market_Sector_Attribute__c();
            attribObj.AccountId__c = accountData.Id;
            attribObj.name = accountData.name + 'Attrib';
            insert attribObj;
            Set<Id> accountIdSet = new Set<Id>();
            accountIdSet.add(accountData.Id);
            Map<id, Account_Market_Sector_Attribute__c> attribMap = new Map<id, Account_Market_Sector_Attribute__c>();
            attribMap = M2O_MergeAccountService.getAttributeRecords(accountIdSet);
            System.assertNotEquals(accountData,null);  
        }    
    }
    /* @Description : This test method covers the setLkpAccount() method of Service class
  */   
    static testmethod  void test_setLkpAccount(){
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
            Account selectedAccount = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccount;
            Account relatedAccount= M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            relatedAccount.RelatedApexAccount__c = accountData.id;
            relatedAccount.RelatedCoreAccount__c = accountData.id;
            relatedAccount.Associated_IDN__c= accountData.id;
            insert relatedAccount;
            List<Account> lkpAccountList = M2O_MergeAccountService.setLkpAccount(accountData.id ,selectedAccount.ID);
            System.assertNotEquals(accountData,null);  
        }    
    }
    /* @Description : This test method covers the setAssets() method of Service class
    */ 
    static testmethod  void test_setContracts(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account sourceAccountID;
            Account selectedAccountID;
            sourceAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
            insert sourceAccountID;
            selectedAccountID = M2O_AccountContactTestDataUtility.getSingleAccountRec(regionData);
            insert selectedAccountID;
            Asset assetRecord = new Asset();
            assetRecord= M2O_AccountContactTestDataUtility.getListOfAssetRecord(sourceAccountID);
            insert assetRecord;
            List<Asset> finalListOfAssets = new List<Asset>();
            finalListOfAssets = M2O_MergeAccountService.setAssets(sourceAccountID.id,selectedAccountID.id); 
            System.assertNotEquals(sourceAccountID,null);  
        }   
    } 
}