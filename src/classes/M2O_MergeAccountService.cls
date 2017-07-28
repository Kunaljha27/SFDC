/**
@Classname :       M2O_MergeAccountService
@Description :     Service class for M2O_MergeSearchAccountController
@Author:           Rupsa  Hore
@Last Modified:    01/04/2014
**/

public with sharing class M2O_MergeAccountService {
       
    /**Description: Retrieve queriable fields for account
       Return: String
    **/
    public static Account getAccountQueriableFields(String sourceAccountQuery){
       Account accountQueriableFields;
       if(sourceAccountQuery != Null){
           accountQueriableFields = M2O_AccountContactDAO.getAccountQueriableFields(sourceAccountQuery);
       }
       if(accountQueriableFields != Null){
           return accountQueriableFields;
       }
       return null;
    }
     /**Description: Retrieve queriable fields for account market sector attributes
       Return: String
    **/
    public static Account_Market_Sector_Attribute__c getAccountAttributeQueriableFields(String accountAttributesQuery){
       Account_Market_Sector_Attribute__c accountAttributesQueriableFields;
       if(accountAttributesQuery != Null){
           accountAttributesQueriableFields = M2O_AccountContactDAO.getAccountAttributesQueriableFields(accountAttributesQuery);
       }
       if(accountAttributesQueriableFields != Null){
           return accountAttributesQueriableFields;
       }
       return null;
    }
    
    /**Description: Query Destination  Account
       Return:      List of account
    **/
    public static List<Account> getDestinationAccount(Set<Id> setAccRecordTypeId, String destinationAccountList){        
        List<Account> listDestinationAccountRecords = new List<Account>();
        if(destinationAccountList != Null){
          listDestinationAccountRecords = M2O_AccountContactDAO.getDestinationAccount(setAccRecordTypeId ,destinationAccountList);
        }
        if(listDestinationAccountRecords != Null && !listDestinationAccountRecords.isEmpty()){
           return listDestinationAccountRecords ;
        }
        return null;
    }
    
    /**Description: insert child object values
       Return: boolean
    **/
    public static Boolean setAccountRelatedObject(String mergeHistoryTracking, Account destinationAcc, Boolean isCustomerAccount, Boolean error, String sourceAccountID, String selectedAccountID, Map<String, String> mapObjFieldAPI,Account_Market_Sector_Attribute__c attribObj){
        List<Sobject> sObjList = new List<Sobject>();
        List<Sobject> activityList = new List<Sobject>();
        List<AccountTeamMember> insertAccTeamList = new List<AccountTeamMember>();
        List<AccountShare> insertAccShareList = new List<AccountShare>();
        List<Attachment> attachmentsList = new List<Attachment>();
        List<Note> notesList = new List<Note>();
        List<Account_Organization_Information__c> accOrgInfoList = new List<Account_Organization_Information__c>();
        List<Account_affiliation__c> accAffiliationList = new List<Account_affiliation__c>();
        List<Retail_Contract__c> retailContractsList = new List<Retail_Contract__c>();
        List<Asset> assetsList = new List<Asset>();
        List<Account> lkpAccountList = new List<Account>();
        List<FeedItem> feedItemsList = new List<FeedItem>();
        List<FeedComment> feedCommentList = new List<FeedComment>();
        List<EntitySubscription> entitySubscriptionList = new List<EntitySubscription>();
        List<Contract> completedContractsList = new List<Contract>();
        List<Contract> clonedCompletedContractsList = new List<Contract>();
        List<Contract> activatedContractsList = new List<Contract>();
        Map<Id,Id> feedItemsIdMap = new Map<Id,Id>();
        List<FeedItem> newFeedItemsList = new List<FeedItem>();
        List<Contract> contractsList = new List<Contract>();
        List<Account_Organization_Information__c> deleteAccOrgList = new List<Account_Organization_Information__c>();

        List<Id> oldFeedItemsIdList = new List<Id>();
        List<FeedItem> oldFeedItemsList = M2O_AccountContactDAO.getFeedItemsList(sourceAccountID);
        
        if(oldFeedItemsList!=null && !oldFeedItemsList.isEmpty()) {
            for(integer i=0;i<oldFeedItemsList.size();i++) {
                oldFeedItemsIdList.add(oldFeedItemsList[i].id);
            }
        }
        accOrgInfoList = setAccountOrgInfo(sourceAccountID, selectedAccountID);
        if(accOrgInfoList!= Null && !accOrgInfoList.isEmpty()){
            error = M2O_AccountContactDAO.insertAccountOrganizationInformation(accOrgInfoList);
        }
        deleteAccOrgList = deleteAccountOrg(sourceAccountID, selectedAccountId);
        if(deleteAccOrgList != Null && !deleteAccOrgList.isEmpty()){
            error = M2O_AccountContactDAO.deleteAccountOrg(deleteAccOrgList);
        }
        

        feedItemsList = setFeedItem(sourceAccountID, selectedAccountID);
        if(feedItemsList != Null && !feedItemsList.isEmpty()){
            newFeedItemsList = M2O_AccountContactDAO.setFeedItem(feedItemsList);
            if(newFeedItemsList != Null && !newFeedItemsList.isEmpty()){
                error=false;
                for(integer i=0;i<feedItemsList.size();i++) {
                    feedItemsIdMap.put(oldFeedItemsIdList[i],newFeedItemsList[i].id);
                }
            }
        }
        feedCommentList = setFeedComment(sourceAccountID, selectedAccountID,feedItemsIdMap);
        if(feedCommentList != Null && !feedCommentList.isEmpty()){
            error = M2O_AccountContactDAO.setFeedComment(feedCommentList);
        }
        entitySubscriptionList = setEntitySubscription(sourceAccountID, selectedAccountID);
        if(entitySubscriptionList != Null && !entitySubscriptionList.isEmpty()){
            error = M2O_AccountContactDAO.setEntitySubscription(entitySubscriptionList);
        }
        assetsList = setAssets(sourceAccountID, selectedAccountID);
        if(assetsList != Null && !assetsList.isEmpty()){
            set<Asset> assetsSet = new set<asset>();
            assetsSet.addall(assetsList);
            assetsList.clear();
            assetsList.addall(assetsSet);
            error = M2O_AccountContactDAO.setAssets(assetsList);
        }
        
        lkpAccountList = setLkpAccount(sourceAccountID, selectedAccountID);
        if(lkpAccountList != Null && !lkpAccountList.isEmpty()){
            set<Account> lkpAccountsSet = new set<Account>();
            lkpAccountsSet.addall(lkpAccountList);
            lkpAccountList.clear();
            lkpAccountList.addall(lkpAccountsSet);
            error = M2O_AccountContactDAO.setlkpAccount(lkpAccountList);
        }
        
        
        Account sourceAcc = new Account();
        sourceAcc.id = sourceAccountID;
        M2O_AccountContactDAO.deleteSourceAccount(mergeHistoryTracking, sourceAcc, destinationAcc, isCustomerAccount,attribObj);
        merge destinationAcc sourceAcc;
        return error;
    }
    
   
    
    
    /**Description: get Account Organization Information values for insertion
       Return: list
    **/
    @testvisible private static List<Account_Organization_Information__c> setAccountOrgInfo(String sourceAccountID, String selectedAccountID){
        Boolean compareFlag;
        List<Account_Organization_Information__c> insertAccountOrgInfoList = new List<Account_Organization_Information__c>();
        List<Account_Organization_Information__c> sourceAccountOrgList = new List<Account_Organization_Information__c>();
        List<Account_Organization_Information__c> destAccountOrgList = new List<Account_Organization_Information__c>();
        sourceAccountOrgList = M2O_AccountContactDAO.getAccountOrganizationList(sourceAccountID);
        destAccountOrgList = M2O_AccountContactDAO.getAccountOrganizationList(selectedAccountID);
           if((destAccountOrgList!=null && !(destAccountOrgList.isEmpty())) && (sourceAccountOrgList!=null && !(sourceAccountOrgList.isEmpty()))) {
               for(Account_Organization_Information__c aoiSource:sourceAccountOrgList) {                   
                   compareFlag=false;
                   for(Account_Organization_Information__c aoiDest: destAccountOrgList) {
                       if(aoiDest.sector__c==aoiSource.sector__c) {
                           compareFlag=true;
                           break;
                       }
                   }
                   if(!compareFlag) {
                      Account_Organization_Information__c newOrgInfo = new Account_Organization_Information__c();  
                      newOrgInfo.account__c=selectedAccountId;
                      newOrgInfo.Market__c= aoisource.Market__c;
                      newOrgInfo.Sector__c=aoisource.Sector__c;
                      newOrgInfo.Sub_Territory__c=aoisource.Sub_Territory__c;
                      newOrgInfo.Territory__c=aoisource.Territory__c;
                      insertAccountOrgInfoList.add(newOrgInfo);
                   }
               }
            }
            else if((destAccountOrgList==null || (destAccountOrgList.isEmpty()))&& (sourceAccountOrgList!=null && !(sourceAccountOrgList.isEmpty()))) {
                for(Account_Organization_Information__c aoiSource:sourceAccountOrgList) {
                    Account_Organization_Information__c newOrgInfo = new Account_Organization_Information__c();  
                    newOrgInfo.account__c=selectedAccountId;
                    newOrgInfo.Market__c= aoisource.Market__c;
                    newOrgInfo.Sector__c=aoisource.Sector__c;
                    newOrgInfo.Sub_Territory__c=aoisource.Sub_Territory__c;
                    newOrgInfo.Territory__c=aoisource.Territory__c;
                    insertAccountOrgInfoList.add(newOrgInfo);
                }
            }
            
            if(insertAccountOrgInfoList!=null && !insertAccountOrgInfoList.isEmpty()) {
                return insertAccountOrgInfoList;
            }
            return null;
    }
    /**Description: get account team values for deletion
       Return: list
    **/
    @testvisible private static List<Account_Organization_Information__c> deleteAccountOrg(String sourceAccountID, String selectedAccountID){        
        List<Account_Organization_Information__c> deleteAccOrgList = M2O_AccountContactDAO.getAllAccountOrg(sourceAccountID);
        if(deleteAccOrgList != Null && !deleteAccOrgList .isEmpty()){
            return deleteAccOrgList;
        }
        return null;
    }
    
   
    /**Description: get Asset values for updation
       Return: list
    **/
    @testvisible private static List<Asset> setAssets(String sourceAccountID, String selectedAccountID){
        List<Asset> assetsList = M2O_AccountContactDAO.getAssetsList(sourceAccountID);
        List<Asset> updateAssetsList = new List<Asset>();
        if(assetsList!= Null && !assetsList.isEmpty()){
            for(Asset assetObj: assetsList){
                if(assetObj.Ship_to_Account__c == sourceAccountID) {
                    assetObj.Ship_to_Account__c = selectedAccountID;
                    updateAssetsList.add(assetObj);
                }
                if(assetObj.Phone_Book_Account__c == sourceAccountId) {
                    assetObj.Phone_Book_Account__c = selectedAccountID;
                    updateAssetsList.add(assetObj);
                }
                
            }
        }
        if(updateAssetsList != Null && !updateAssetsList.isEmpty()) {
            return updateAssetsList;
        }
        return null;
    }
    
    /**Description: get Account(Lookup) values for updation
       Return: list
    **/
    @testvisible private static List<Account> setLkpAccount(String sourceAccountID, String selectedAccountID){
        List<Account> lkpAccountList = M2O_AccountContactDAO.getLkpAccountList(sourceAccountID);
        List<Account> updateLkpAccountsList = new List<Account>();
        if(lkpAccountList!= Null && !lkpAccountList.isEmpty()){
            for(Account accObj: lkpAccountList){
                if(accObj.RelatedApexAccount__c == sourceAccountID) {
                    accObj.RelatedApexAccount__c = selectedAccountID;
                    updateLkpAccountsList.add(accObj);
                }
                if(accObj.RelatedCoreAccount__c == sourceAccountId) {
                    accObj.RelatedCoreAccount__c = selectedAccountID;
                    updateLkpAccountsList.add(accObj);
                }
        if(accObj.Associated_IDN__c == sourceAccountId) {
                    accObj.Associated_IDN__c = selectedAccountID;
                    updateLkpAccountsList.add(accObj);
                }
            }
        }
        if(updateLkpAccountsList != Null && !updateLkpAccountsList.isEmpty()) {
            return updateLkpAccountsList;
        }
        return null;
    }
    /**Description: get FeedItem values for insertion
       Return: list
    **/
    @testvisible private static List<FeedItem> setFeedItem(String sourceAccountID, String selectedAccountID){
        List<FeedItem> feedItemsList = M2O_AccountContactDAO.getFeedItemsList(sourceAccountID);
        List<FeedItem> insertFeedItemsList = new List<FeedItem>();
        FeedItem fItem;
        if(feedItemsList != Null && !feedItemsList.isEmpty()){
            for(FeedItem itemObj : feedItemsList){
                fItem = new FeedItem(Body=itemObj.Body,createdbyid = itemObj.createdById, createddate = itemObj.createddate, ContentData=itemObj.ContentData, ContentDescription=itemObj.ContentDescription,
                                     ContentFileName=itemObj.ContentFileName, LinkUrl=itemObj.LinkUrl, NetworkScope=itemObj.NetworkScope, ParentId=selectedAccountId,
                                     Title=itemObj.Title, Visibility=itemObj.Visibility);
                insertFeedItemsList.add(fItem);
            }
        }
        if(insertFeedItemsList != Null && !insertFeedItemsList.isEmpty()){
            return insertFeedItemsList;
        }
        return null;
    }
    /**Description: get FeedComment values for insertion
       Return: list
    **/
    @testvisible private static List<FeedComment> setFeedComment(String sourceAccountID, String selectedAccountID, Map<Id,Id> feedItemsIdMap){
        List<FeedComment> feedCommentsList = M2O_AccountContactDAO.getFeedCommentList(sourceAccountID);
        List<FeedComment> insertFeedCommentsList = new List<FeedComment>();
        FeedComment fComment;
        if(feedCommentsList != Null && !feedCommentsList.isEmpty()){
            for(FeedComment fCommObj : feedCommentsList){
                fComment = new FeedComment(createddate = fCommObj.createddate, createdbyid = fCommObj.createdbyId, CommentBody=fCommObj.CommentBody,CommentType=fCommObj.CommentType,FeedItemId=feedItemsIdMap.get(fCommObj.FeedItemId),RelatedRecordId=fCommObj.RelatedRecordId);
                insertFeedCommentsList.add(fComment);
            }
        }
        if(insertFeedCommentsList != Null && !insertFeedCommentsList.isEmpty()){
            return insertFeedCommentsList;
        }
        return null;
    }
     /**Description: get EntitySubscription values for insertion
       Return: list
    **/
    @testvisible private static List<EntitySubscription> setEntitySubscription(String sourceAccountID, String selectedAccountID){
        List<EntitySubscription> entitySubscriptionList = M2O_AccountContactDAO.getEntitySubscriptionList(sourceAccountID);
        List<EntitySubscription> destEntitySubscriptionList = M2O_AccountContactDAO.getEntitySubscriptionList(selectedAccountID);
        List<EntitySubscription> insertEntitySubscriptionList = new List<EntitySubscription>();
        Boolean compareFlag;
        EntitySubscription enSub;
        
        if((destEntitySubscriptionList!=null && !(destEntitySubscriptionList.isEmpty())) && (entitySubscriptionList!=null && !(entitySubscriptionList.isEmpty()))) {
               for(EntitySubscription enSubObj : entitySubscriptionList) {                   
                   compareFlag=false;
                   for(EntitySubscription enSubDest: destEntitySubscriptionList) {
                       if(enSubDest.SubscriberId==enSubObj.SubscriberId) {
                           compareFlag=true;
                           break;
                       }
                   }
                   if(!compareFlag) {
                        enSub = new EntitySubscription(SubscriberId=enSubObj.SubscriberId,ParentId=selectedAccountId,NetworkId=enSubObj.NetworkId);
                        insertEntitySubscriptionList.add(enSub);
                   }
               }
        }
        else if((destEntitySubscriptionList==null || (destEntitySubscriptionList.isEmpty()))&& (entitySubscriptionList!=null && !(entitySubscriptionList.isEmpty()))) {
            for(EntitySubscription enSubObj : entitySubscriptionList) {
                enSub = new EntitySubscription(SubscriberId=enSubObj.SubscriberId,ParentId=selectedAccountId,NetworkId=enSubObj.NetworkId);
                insertEntitySubscriptionList.add(enSub);
            }
        }
        if(insertEntitySubscriptionList != Null && !insertEntitySubscriptionList.isEmpty()){
            return insertEntitySubscriptionList;
        }
        return null;
    }
   
   
    /**Description: Retrieve Account Attribute records for merge
       Return: map
    **/
    public static Map<id, Account_Market_Sector_Attribute__c> getAttributeRecords(Set<Id> accountsIdSet){
        Map<id, Account_Market_Sector_Attribute__c> attributeAccountMap = new Map<id, Account_Market_Sector_Attribute__c>();
        List<Account_Market_Sector_Attribute__c> accAttributeList = new List<Account_Market_Sector_Attribute__c>();
        if(accountsIdSet != null && !accountsIdSet.isEmpty()) {
            accAttributeList = M2O_AccountContactDAO.getAccountAttribute(accountsIdSet);
        }
        if(accAttributeList != null && !accAttributeList.isEmpty()) {
            for(Account_Market_Sector_Attribute__c accAttribute : accAttributeList) {
                attributeAccountMap.put(accAttribute.AccountId__c, accAttribute);
            }
        }
        return attributeAccountMap;
    }
}