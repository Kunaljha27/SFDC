/**
@Classname :       M2O_AccountContactDAO
@Description :     This class is written to query/DML operation on  Account, Contact, Account Team Member Account market sector attribute and 
                   Contact market sector attribute. Also it performs DML opertation for Account, Contact, Account market 
                   sector attribute and Contact market sector attribute.
@Author:           Somdev Bhattacharyya/ Piyali Saha/Srutadeba Chanda
@Last Modified:    25/12/2013
**/

public with sharing class M2O_AccountContactDAO {
    
    /**
    @Description: Inserts Account market sector attribute records intot he database.
    @Param :      List of Account market sector attibute
    @Return:      List of inserted Account market sector attribute records.
    **/
    
    public List <Account_Market_Sector_Attribute__c> insrtAccMrktSectrAttribute(List <Account_Market_Sector_Attribute__c> listAccountMarketAttribute) {
    
        try {
            if(listAccountMarketAttribute != null) {
                database.insert(listAccountMarketAttribute);
            }
                return listAccountMarketAttribute;
        }catch(DMLException ex) {
            system.debug('Insertion failed ' + ex);
            return null;
        }
    }
    
    /**
    @Description: Update Account records into the database.
    @Param :      List of Accounts
    @Return:      Void
    **/
    
    public void updateMarketSector (List<Account> listAccount) {
    
        try {
            if(listAccount != null) {
                 update listAccount;
            }        
        }catch(DMLException ex) {
             system.debug('Update failed ' + ex);
        }
    }
    
    /**
    @Description: Update the contact record into the databse.
    @Param :      List of Contacts
    @Return:      Null
    **/
    
    public void updateMarketSectorContact (List<Contact> listContact) {
    
        try {
            if (listContact != null) {
                update listContact;
            }
        }catch(DMLException ex) {
            system.debug('Update failed ' + ex);          
        }
    }
        
    /**
    @Description: Inserts the Contact market sector attribute record into the databse.
    @Param :      List of Contact market sector attibute
    @Return:      List of inserted Contact market sector attribute records.
    **/    
    
    public List <Contact_Market_Sector_Attributes__c>  insrtcntctMarktSctrAttribute(List<Contact_Market_Sector_Attributes__c> listContactsMarketAttribute) {
    
        try {
            if(listContactsMarketAttribute != null) {
                insert listContactsMarketAttribute;
            }
                return listContactsMarketAttribute;
        }
        catch(DMLException ex) {
            system.debug('Insertion failed ' + ex);
            return null;
        }
    }
    
    /**
    @Description: Queries the Account records from the database
    @Param :      Set of Account Id's
    @Return:      List of Account records.
    **/ 
    
    public List<Account> getAccountRecords(Set<id> setAccountId) {
    
        String query ;
        try {
            query = 'SELECT id, Name, ownerId, Market_Sector_Attributes__c From Account where id in :setAccountId';
            return (Database.query(query));
        }
        catch(QueryException ex) {
            system.debug('Query failed ' + ex);
            return null;
        }
    }
    
    
    /**
    @Description: Queries the Contact records from the database
    @Param :      Set of Contact Id's
    @Return:      List of Contact records.
    **/      
           
    public List<Contact> getContactRecords(Set<id> setContactId) {
    
        String query ;
        try {
            query = 'SELECT id, ownerID, Name, Market_Sector_Attribute__c From Contact where id in :setContactId';
            return (Database.query(query));
        }
        catch(QueryException ex) {
            system.debug('Query failed ' + ex);
            return null;
        }
    }
    
    
    
     /**
       * @Description : This method update the Account's Account Has Account Team checkbox as checked 
       * @param       : List of Accounts
       * @return      : None
     **/ 
     
    public static void updateAccount(List<Account> listUpdateAccount){
        try{
            if(listUpdateAccount!=null && !listUpdateAccount.isEmpty()){
                update listUpdateAccount;
             }   
        }
        catch(System.DmlException e){
            system.debug(e.getmessage());
        }    
    }
    
    /**
    * @Description : This method checks for the M2O accounts for which  Account Team Member got deleted
    * @param       : set of M2O Account Id
    * @return      : List of Account Record 
    **/ 
    
    public static List<Account> getM2OAccount(set<ID> setAccountId){
    
        List<Account> listRetriveAccountForM2O=new List<Account>();
        try{
            if(setAccountId!=null && !setAccountId.isEmpty()){
                listRetriveAccountForM2O=[select id from Account where id in:setAccountId and Account_template_sharing__c='M2O'];
                }
           return listRetriveAccountForM2O;     
        }
        catch(Exception e){
            system.debug(e.getMessage());
            return null;
        }    
    }
    
    /**
       * @Description : This method takes the count for the Account Team Member for each M2O Account
       * @param       : set of M2O Account Id
       * @return      : List of AggregateResult
    **/   
     
    public static List<AggregateResult> getAccountTeamCount(set<ID> setM2OAccountId){
    
         List<AggregateResult> listAccountTeamMember=new List<AggregateResult>();
         try{
             if(setM2OAccountId!=null && !setM2OAccountId.isEmpty()){
                 listAccountTeamMember=[select Accountid,count(ID) AccountteamMemberCount from AccountTeamMember where AccountId in:setM2OAccountId Group By AccountId];
                }
            return listAccountTeamMember;       
         }     
        catch(Exception e){
            system.debug(e.getMessage());
            return null;
        }       
    }
    
    /**
        * @Description : This method retrieves the Contacts associated to the Account
        * @param       : Set of Account Ids
        * @return      : List of Aggregate Result
    **/
    
     public static List<AggregateResult> retrieveAssociatedContacts(Set<Id> setAccountId){
     
        List<AggregateResult> listAggregateResults;
        try {
            if(setAccountId!= null && !setAccountId.isEmpty()) {
               listAggregateResults= [select AccountId, count(ID) ContactCount from Contact where AccountId in :setAccountId Group By AccountId];
               return listAggregateResults;
            }   
            else {
               return null;
            }
         }
        catch(System.DmlException e){
        system.debug(e.getmessage());
        return null;
        }
    } 
    
    /**Description: Retrieve queriable fields for account
       Return: String
    **/
    public static Account getAccountQueriableFields(String sourceAccountQuery){
        Account accountQueriableFields = Database.query(sourceAccountQuery);
        try{
            if(accountQueriableFields != Null){
                return accountQueriableFields;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getAccountQueriableFields failed -----> '+ex.getmessage());
            return null;
        }
    }
    /**Description: Retrieve queriable fields for account market sector attributes
       Return: String
    **/
    public static Account_Market_Sector_Attribute__c getAccountAttributesQueriableFields(String sourceAccountQuery){
        Account_Market_Sector_Attribute__c accountAttributesQueriableFields;
        if(!String.isBlank(sourceAccountQuery)) {
            accountAttributesQueriableFields = Database.query(sourceAccountQuery);
        }
        try{
            if(accountAttributesQueriableFields != Null){
                return accountAttributesQueriableFields;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getAccountAttributesQueriableFields failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    /**Description: Query Destination  Account
       Return:      List of account
    **/
    public static List<Account> getDestinationAccount(Set<Id> setAccRecordTypeId, String destinationAccountQuery){
        List<Account> listDestinationAccountRecords = Database.query(destinationAccountQuery);
        try{
            if(listDestinationAccountRecords != Null && !listDestinationAccountRecords.isEmpty()){
                return listDestinationAccountRecords;        
            }
            return null;
        }catch(DMLException ex){
            system.debug('getDestinationAccount failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    
    /**Description: get account team values for insertion
       Return: list
    **/
    public static List<AccountTeamMember> getAllActiveAccountTeamMember(String sourceAccountID) {
        List<AccountTeamMember> listAccTeamMember = new List<AccountTeamMember>();
        try{
            if(sourceAccountID != Null){
                listAccTeamMember = [SELECT UserId, User.Id, User.IsActive, AccountId, TeamMemberRole
                                                            FROM AccountTeamMember 
                                                            WHERE AccountId =:sourceAccountID AND User.IsActive = true];
            }
            if(listAccTeamMember != Null && !listAccTeamMember.isEmpty()){
                return listAccTeamMember;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getAllActiveAccountTeamMember failed -----> '+ex.getmessage());
            return null;
        }
    }
    
   
    /**Description: get account organization information values for deletion
       Return: list
    **/
    public static List<Account_Organization_Information__c> getAllAccountOrg(String sourceAccountID) {
        List<Account_Organization_Information__c> listAccOrg = new List<Account_Organization_Information__c>();
        try{
            if(sourceAccountID != Null){
                listAccOrg = [SELECT Id FROM Account_Organization_Information__c 
                                                            WHERE Account__c =:sourceAccountID];
            }
            if(listAccOrg != Null && !listAccOrg.isEmpty()){
                return listAccOrg ;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getAllAccountOrg failed -----> '+ex.getmessage());
            return null;
        }
    }
    

   
   
    /**Description: delete account org values
       Return: list
    **/
    public static Boolean deleteAccountOrg(List<Account_Organization_Information__c> lstDeleteAccOrg){
        Boolean error;
        Savepoint sp = Database.setSavepoint();
        try{            
            if(lstDeleteAccOrg!= Null && !lstDeleteAccOrg.isEmpty()){
                Database.delete(lstDeleteAccOrg);
                error = false;
            }
        }catch(DMLException ex){
            Database.rollback(sp);     
            error = true;
            system.debug('Account Org deletion failed -> '+ ex);
        }
        return error;
    }

    
    
    /**Description: delete source account if prospect / influencer. Mark inactive if customer
       Return: list
    **/
    public static void deleteSourceAccount(String mergeHistoryTracking, Account sourceAcc, Account destinationAcc, Boolean isCustomer, Account_Market_Sector_Attribute__c attribObj){
        try{
            if(destinationAcc != Null){
                update destinationAcc;
            }
            if(attribObj!= Null){
                update attribObj;
            }
        }catch(DMLException ex){ 
            system.debug('Source delete failed -> '+ ex);
        }
    }
    
    /**Description: Query to fetch list of Account Organization Information
       Return:      List
    **/
    public static List<Account_Organization_Information__c> getAccountOrganizationList(string accountId) {
        List<Account_Organization_Information__c>  accountOrgList = new List<Account_Organization_Information__c>();
        List<Account> accountRecordList = new List<Account>();
        try {
            if(accountId!=null) {
               accountRecordList = [select (select id, sector__c,Market__c,Sub_Territory__c,Territory__c from Account_Organization_Informations__r) from Account where id=:accountId];
               system.debug('@@@@accountRecord'+accountRecordList );
               if(accountRecordList !=null && accountRecordList.Size()>0){
                   for(account accountRecord: accountRecordList){
                       accountOrgList = accountRecord.Account_organization_informations__r;
                   }
               }
            }
            if(accountOrgList!= Null && !accountOrgList.isEmpty()){    
                return accountOrgList;
            }
            return null;
        }    
        catch(DMLException ex){
        system.debug('getAccountOrganizationList failed -----> '+ex.getmessage());
        return null;
        }
    }
    
     /**Description: insert Account Organization Information values
       Return: list
    **/
    public static Boolean insertAccountOrganizationInformation(List<Account_Organization_Information__c> accOrgInfoList){
        Boolean error;
        try{
            if(accOrgInfoList!= Null && !accOrgInfoList.isEmpty()){
                insert accOrgInfoList;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Account Organization Information insert failed -> '+ex);
        }
        return error;
    }
   
    
    
    
    public static Map<id, Account> getParentLevelAccount(Set<Id> parentIdSet) {
        Map<id, Account> accountParentLevelMap;
        try {
            if(parentIdSet != null && !parentIdSet.isEmpty()) {
                accountParentLevelMap = new Map<id, Account>([Select Id, Name, parentId, Level_1_Parent__c, Level_2_Parent__c, Level_3_Parent__c, 
                                                              Level_4_Parent__c, Level_5_Parent__c, Level_6_Parent__c, Level_7_Parent__c, Level_01_Parent_Id__c,
                                                              Level_02_Parent_Id__c, Level_03_Parent_Id__c, Level_04_Parent_Id__c, Level_05_Parent_Id__c, 
                                                              Level_06_Parent_Id__c from Account where Id IN: parentIdSet]);
           }
            if(accountParentLevelMap != null) {
                return accountParentLevelMap;
            }
            return null;
        }
        catch(DMLException ex){
            system.debug('error'+ex.getmessage());
            return null;
        }
    }
    
    public static Account getCurrentAccount(String CurrentAccountId){
        Account accRecord;
        try{
            if(CurrentAccountId != Null){
                List<Account> lstAccount = [select id, Name, ParentId,Level1_Parent_Report__c, PO_Postal_Code_Local__c,Associated_IDN__c, Level_1_Parent__c, Level_2_Parent__c, Level_3_Parent__c, Level_4_Parent__c, Level_5_Parent__c, Level_6_Parent__c, Inactive_Flag__c  FROM Account WHERE Id =: CurrentAccountId ];
                if (lstAccount.size() > 0)
                    {
                        accRecord = lstAccount.get(0);
                    }    
            }
            if(accRecord != Null){
                return accRecord;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getCurrentAccount failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    /**Description: Query Account
       Return:      List of account
    **/
    public static List<Account> getParentChildAccountList(String CurrentAccountTopLevelId, String currentAccountId){
        List<Account> accountParentChildList = new List<Account>();
        List<Account> accountParentsChildrenList = new List<Account>();
        Account accRecord;
        try {
            if(currentAccountId!=null) {
                accRecord = getCurrentAccount(currentAccountId);
            }
        }
        catch(Exception ex) {
            system.debug('Exception occured'+ex);
        }
        try {
            if(accRecord != null) {
                accountParentsChildrenList = [select id, Name, Associated_IDN__c,Zip_Postal_Code_Local__c, Account_Name_Global__c, Street1_Local__c, Organization_Level__c, 
                                                City_Local__c, Housenumber_Local__c, Golden_Record_Key__c, ParentId, Parent.Name, Level_1_Parent__c, Level_2_Parent__c, 
                                                Level_3_Parent__c, Level_4_Parent__c, Level_5_Parent__c, Level_6_Parent__c,Level1_Parent_Report__c from Account where id= :accRecord.Level_1_Parent__c or 
                                                id=:accRecord.Level_2_Parent__c or id=:accRecord.Level_3_Parent__c or id=:accRecord.Level_4_Parent__c or id=:accRecord.Level_5_Parent__c 
                                                or id=:accRecord.Level_6_Parent__c or id=:accRecord.Id limit 7];
            }
        }
        catch(Exception e) {
            system.debug('Exception occured'+e);
        }
        
        try{
            if(CurrentAccountTopLevelId != Null){
                accountParentChildList = [select id, Name,Zip_Postal_Code_Local__c,Account_Name_Global__c, Street1_Local__c, Organization_Level__c, City_Local__c, Housenumber_Local__c, 
                                            Golden_Record_Key__c, ParentId, Parent.Name,Level1_Parent_Report__c, Level_1_Parent__c, Level_2_Parent__c, Level_3_Parent__c, Level_4_Parent__c, Level_5_Parent__c, 
                                            Level_6_Parent__c from Account where (Level_1_Parent__c =: CurrentAccountTopLevelId OR Id  =: CurrentAccountTopLevelId) 
                                            AND Inactive_Flag__c = False AND ID NOT in :accountParentsChildrenList LIMIT 1001];
            }
            if(accountParentsChildrenList != null && !accountParentsChildrenList.isEmpty()) {
                    accountParentChildList.addAll(accountParentsChildrenList);
            }
            if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
                return accountParentChildList;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getParentChildAccountList failed -----> '+ex.getmessage());
            return null;
        }
    }
    
   
    /**Description: Query Account
       Return:      List of account
    **/
    public static List<Account> getParentChildAccountMoreRecords(String CurrentAccountTopLevelId){
        List<Account> accountParentChildList = new List<Account>();
        try{
            if(CurrentAccountTopLevelId != Null){
                accountParentChildList  = [select id, Name,Zip_Postal_Code_Local__c,Level1_Parent_Report__c,Account_Name_Global__c, Street1_Local__c, Organization_Level__c, City_Local__c, Housenumber_Local__c, Golden_Record_Key__c, ParentId, Level_1_Parent__c, Level_2_Parent__c, Level_3_Parent__c, Level_4_Parent__c, Level_5_Parent__c, Level_6_Parent__c from Account where (Level_1_Parent__c =: CurrentAccountTopLevelId OR Id  =: CurrentAccountTopLevelId) AND Inactive_Flag__c = False LIMIT 50000];
            }
            if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
                return accountParentChildList;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getParentChildAccountMoreRecords failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    
    public static List<Account_Market_Sector_Attribute__c> getAccountAttribute(Set<Id> accountsIdSet) {
        List<Account_Market_Sector_Attribute__c> attributeList;
        try {
            attributeList = [SELECT Id, AccountId__c, Name FROM Account_Market_Sector_Attribute__c WHERE AccountId__c in: accountsIdSet];
        }
        catch(Exception ex) {
            System.debug('Error while querying attribute records'+attributeList);
        }
        return attributeList;
    }
    
    public static void updateAccountAttribute(List<Account_Market_Sector_Attribute__c> accountAttributeList){
        try{
            if(accountAttributeList!=null && !accountAttributeList.isEmpty()){
                update accountAttributeList;
             }   
        }
        catch(System.DmlException e){
            system.debug(e.getmessage());
        }    
    }
    

    /**Description: get Assets values
       Return: list
    **/
    public static List<Asset> getAssetsList(String sourceAccountID) {
        List<Asset> assetsList = new List<Asset>();
        if(sourceAccountID != Null){
            assetsList = [Select  Id, Phone_Book_Account__c,Ship_to_Account__c
                                   from Asset where Phone_Book_Account__c =:sourceAccountID OR Ship_to_Account__c =:sourceAccountId];
        }
        if(assetsList != Null && !assetsList.isEmpty()){
            return assetsList;
        }
        return null;
    }
    
    /**Description: update Assets values
       Return: list
    **/
    public static Boolean setAssets(List<Asset> assetsList){
        Boolean error;
        try{
            if(assetsList != Null && !assetsList.isEmpty()){
                update assetsList;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Asset update failed -> '+ex);
        }
        return error;
    }
    /**Description: get Accounts lookup values
       Return: list
    **/
    public static List<Account> getLkpAccountList(String sourceAccountID) {
        List<Account> lkpAccountList = new List<Account>();
        if(sourceAccountID != Null){
            lkpAccountList = [Select  Id, RelatedCoreAccount__c,RelatedApexAccount__c,Associated_IDN__c
                                   from Account where RelatedCoreAccount__c =:sourceAccountID OR RelatedApexAccount__c =:sourceAccountId OR Associated_IDN__c =:sourceAccountId];
        }
        if(lkpAccountList != Null && !lkpAccountList.isEmpty()){
            return lkpAccountList;
        }
        return null;
    }
    
    /**Description: update Accounts lookup values
       Return: list
    **/
    public static Boolean setLkpAccount(List<Account> lkpAccountList){
        Boolean error;
        try{
            if(lkpAccountList != Null && !lkpAccountList.isEmpty()){
                update lkpAccountList;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Account lookup update failed -> '+ex);
        }
        return error;
    }
    
    
    
    /**Description: get chatter FeedItem values
       Return: list
    **/
    public static List<FeedItem> getFeedItemsList(String sourceAccountID) {
        List<FeedItem> feedItemList = new List<FeedItem>();
        if(sourceAccountID != Null){
            feedItemList = [SELECT Body,CommentCount,ContentData,ContentDescription,ContentFileName,ContentSize,ContentType,CreatedById,CreatedDate,Id,InsertedById,IsDeleted,LastModifiedDate,LikeCount,LinkUrl,NetworkScope,ParentId,RelatedRecordId,SystemModstamp,Title,Type,Visibility
                                   FROM FeedItem where ParentId =:sourceAccountID and type in ('ContentPost', 'LinkPost', 'TextPost') ];
        system.debug('Feed Item List'+feedItemList);
        System.debug('Inside DAO'+Limits.getHeapSize());
        }
        if(feedItemList != Null && !feedItemList.isEmpty()){
            return feedItemList;
        }
        return null;
    }
    
    /**Description: insert chatter AccountFeed values
       Return: list
    **/
    public static List<FeedItem> setFeedItem(List<FeedItem> feedItemList){
        Boolean error;
        try{
            if(feedItemList != Null && !feedItemList.isEmpty()){
                insert feedItemList;
                error = false;
                return feedItemList;
            }
        } catch(DMLException ex){
            error = true;
            system.debug('Feed Item insert failed -> '+ex);
      }
        return null;
    }
    /**Description: get chatter FeedComment values
       Return: list
    **/
    public static List<FeedComment> getFeedCommentList(String sourceAccountID) {
        List<FeedComment> feedCommentList = new List<FeedComment>();
        if(sourceAccountID != Null){
            feedCommentList = [SELECT createdbyid, createddate, CommentBody,CommentType,FeedItemId,Id,ParentId,RelatedRecordId 
                            FROM FeedComment where ParentId =:sourceAccountID];
        }
        if(feedCommentList != Null && !feedCommentList.isEmpty()){
            return feedCommentList;
        }
        return null;
    }
    
    /**Description: insert chatter FeedComment values
       Return: list
    **/
    public static Boolean setFeedComment(List<FeedComment> feedCommentList){
        Boolean error;
        try{
            if(feedCommentList!= Null && !feedCommentList.isEmpty()){
                insert feedCommentList;
                error = false;
            }
        } catch(DMLException ex){
            error = true;
            system.debug('Feed Comment insert failed -> '+ex);
      }
        return error;
    }
    /**Description: get EntitySubscription values
       Return: list
    **/
    public static List<EntitySubscription> getEntitySubscriptionList(String sourceAccountID) {
        List<EntitySubscription> entitySubscriptionList = new List<EntitySubscription>();
        if(sourceAccountID != Null){
            entitySubscriptionList = [SELECT NetworkId,ParentId,SubscriberId 
                                      FROM EntitySubscription where ParentId =:sourceAccountID];
        }
        if(entitySubscriptionList != Null && !entitySubscriptionList.isEmpty()){
            return entitySubscriptionList;
        }
        return null;
    }
    
    /**Description: insert Entity Subscription values
       Return: list
    **/
    public static Boolean setEntitySubscription(List<EntitySubscription> entitySubscriptionList){
        Boolean error;
        try{
            if(entitySubscriptionList!= Null && !entitySubscriptionList.isEmpty()){
                insert entitySubscriptionList;
                error = false;
            }
        } catch(DMLException ex){
            error = true;
            system.debug('Entity Subscription insert failed -> '+ex);
      }
        return error;
    }
}