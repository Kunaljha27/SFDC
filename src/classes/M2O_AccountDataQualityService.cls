/**
* @ClassName     : M2O_AccountDataQualityService
* @Description   : This class includes the business logic for update Has Account team, and Has Contact Checkbox for 
                   Account whenever Account has any account team member or Contact associated with it  . 
* @Author        : Srutadeba Chanda
* @Last Modified : 16/12/2013
* @Discussionpoints : No Information
**/
public class M2O_AccountDataQualityService{
   
   /**
    * @Description : This method update the check box Account Has Account Team in Account if the account has any account team member
    * @param       : List of Account team Member records
    * @return      : None
    **/ 
    public static void updateHasAccTeamMemberOnAccount(List<AccountTeamMember> aggreagtedAccountTeamMemberList ){
        set<Id> setAccountId= new Set<Id>();
        Account accountObject;
        List<Account> updateAccountList=new List<Account>();
        try{
            for(AccountTeamMember accountTeamMemberObj: aggreagtedAccountTeamMemberList){
                setAccountId.add(accountTeamMemberObj.AccountId);
            }
            if(setAccountId!=null && !setAccountId.isEmpty()){
            system.debug('Account Id'+setAccountId);
                for(Id accountId: setAccountId){
                   accountObject=new Account(Id=accountId, Account_Has_Account_Team__c=true);
                   updateAccountList.add(accountObject);
                }
            } 
            system.debug('@@@@'+updateAccountList);
            if(updateAccountList!=null && !updateAccountList.isEmpty()){
                //M2O_AccountContactDataQualityDAO.updateAccount(updateAccountList);
                M2O_AccountContactDAO.updateAccount(updateAccountList);
            }
       }catch(Exception ex){
           system.debug('Error in update ' +ex.getMessage());       
       }
    }
    
    /**
    * @Description : This method checks for the deleted Account Team members associated to particular Account and then update it using helper object  
    * @param       : List of Delete Account Team records 
    * @return      : None
    **/ 
    public static void checkAccountForTeammember(List<Delete_Account_Team__c> deleteAcountTeamList){
     set<ID> setAccountId;
     set<ID> setM2OAccountId;
     List<Account> retriveAccountForM2OList;
     List<AggregateResult> aggreagtedAccountTeamMemberList;
     Map<Id,Integer> teamMemberCountMap;
     List<Account> accountsToUpdateList;
     Account updateAccount ;
     try{
         setAccountId= new set<ID>();
         if(deleteAcountTeamList!=null && !deleteAcountTeamList.isEmpty()){
             for(Delete_Account_Team__c deleteAccountTeamObj : deleteAcountTeamList){
                setAccountId.add(deleteAccountTeamObj.Account__c);
            }
         }
         
       /*
       *@ Description : The getM2OAccount method queries the list of Account records
       */
         
         if(setAccountId!=null && !setAccountId.isEmpty()){
            retriveAccountForM2OList=M2O_AccountContactDAO.getM2OAccount(setAccountId);
         }
         setM2OAccountId= new set<Id>();
         if(retriveAccountForM2OList!=null && !retriveAccountForM2OList.isEmpty()){
             for(Account accountObject:retriveAccountForM2OList){
                    setM2OAccountId.add(accountObject.id);
             }
         }
         
       /*
       *@ Description : The getAccountTeamCount method queries the aggregated list of Account team count
       */ 
         
         if(setM2OAccountId!=null && !setM2OAccountId.isEmpty()){
             aggreagtedAccountTeamMemberList= M2O_AccountContactDAO.getAccountTeamCount(setM2OAccountId);
         }  
         teamMemberCountMap= new Map<Id,Integer>(); 
         if(aggreagtedAccountTeamMemberList!=null && !aggreagtedAccountTeamMemberList.isEmpty()){
             for (AggregateResult aggregate : aggreagtedAccountTeamMemberList) {
                 teamMemberCountMap.put(string.valueOf(aggregate.get('AccountId')),Integer.valueOf(aggregate.get('AccountteamMemberCount')));
             }
         } 
         accountsToUpdateList=new List<Account>();
         for(Id accountId : setM2OAccountId){
             if (teamMemberCountMap.get(accountId)==null) {
                     updateAccount = new Account(id=accountId);
                      updateAccount.Account_Has_Account_Team__c =false;
             }
             accountsToUpdateList.add(updateAccount);
         } 
       /*
       *@ Description : The updateAccount method updates the Account with the new account team members 
       */      
         if(accountsToUpdateList!=null && !accountsToUpdateList.isEmpty()){
             M2O_AccountContactDAO.updateAccount(accountsToUpdateList);
         }   
      }catch(Exception ex){
          system.debug('ERROR --> '+ex.getMessage());
      }
    }
      
    /**
    * @Description : This method updates the parent Account of associated team member and populate the field 'Account has Contact Person' value on Account 
    * @param       : Account Id of the parent Account
    * @return      : None
    **/
  
    public static void updateParentAccount(set<ID> setAccountId){
         Account newAccount ;
         List<AggregateResult> aggregateResultsList;
         List<Account> accountsToUpdateList;
         Map<Id,Integer> contactCountMap;     
         try{
             contactCountMap = new Map<Id,Integer>();  
             if(setAccountId!=Null && !setAccountId.isEmpty()){
             aggregateResultsList= M2O_AccountContactDAO.retrieveAssociatedContacts(setAccountId);  
             for (AggregateResult aggregate : aggregateResultsList) {
                 contactCountMap.put(string.valueOf(aggregate.get('AccountId')),Integer.valueOf(aggregate.get('ContactCount')));
             } 
             accountsToUpdateList = new  List<Account>();
             for(Id accountId : setAccountId){
                 newAccount = new Account(id=accountId);
                 newAccount.No_of_Contacts__c = contactCountMap.get(accountId);  
                   if (newAccount.No_of_Contacts__c > 0) {
                      newAccount.Account_has_Contact_Person__c =TRUE;
                      }
                   else {
                      newAccount.Account_has_Contact_Person__c =FALSE;
                      }
                 accountsToUpdateList.add(newAccount);
             } 
             //M2O_AccountContactDAO.updateAccount(accountsToUpdateList ); 
             M2O_AccountContactDataQualityDAO.updateAccount(accountsToUpdateList);
            }
         }catch(Exception ex){
            system.debug('Error in updaitng parent account '+ex.getMessage());
          }
    }
}