/*** 
*@ClassName : HCNA_AccountTeamRealignmentDAOClass 
*@Description : DAO class for HCNA_AccountTeamRealignment page.
*@Author : Noor
*@Last Modified : 23/06/2014
*@Discussionpoints : No Information
***/
public with sharing class HCNA_AccountTeamRealignmentDAOClass {
    /**    
    * @Description : This method retrieve List Of Account   
    * @param       : Id userId  
    * @return      : List<Account>  
    **/
    public List<Account> retrieveAccounts(Id userId) {       
        if(userId != null) {
            return [select Id, Name,Site, Phone, Owner.Alias,BillingState,Type from Account where Id In (select AccountId from AccountTeamMember where UserId =: userId) LIMIT 1000];            
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve AccountTeamMembers for selected Accounts  
    * @param       : Id transferFromId, List<Account> selectedAccounts  
    * @return      : list<AccountTeamMember>
    **/
    public list<AccountTeamMember>  retrieveAccountTeamMembers(Id transferFromId, List<Account> selectedAccounts) {
        try{
            if(transferFromId != null && (!selectedAccounts.isEmpty())) {
                return [select Id, userId, AccountId, AccountAccessLevel, TeamMemberRole from AccountTeamMember where userid =:transferFromId and AccountId In: selectedAccounts];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    } 
    /**    
    * @Description : This method retrieve AccountTeamMembers for selected Accounts  
    * @param       : Id transferFromId, List<Account> selectedAccounts  
    * @return      : list<AccountTeamMember>
    **/
    public list<AccountTeamMember>  retrieveAccountId(Id transferToUserId, List<Account> selectedAccounts) {
        try{
            if(transferToUserId != null && (!selectedAccounts.isEmpty())) {
                return [select AccountId from AccountTeamMember where userid =:transferToUserId and AccountId In: selectedAccounts];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrieve AccountShare for selected Accounts   
    * @param       : Id transferFromId, List<Account> selectedAccounts   
    * @return      : list<AccountShare>  
    **/
    public list<AccountShare>  retrieveAccountShare(Id transferFromId, List<Account> selectedAccounts) {
        try{
            if(transferFromId != null && (!selectedAccounts.isEmpty())) {
                return [select Id, UserOrGroupId, RowCause, AccountId, AccountAccessLevel, OpportunityAccessLevel, ContactAccessLevel, CaseAccessLevel from AccountShare where UserOrGroupId =:transferFromId and AccountId In: selectedAccounts];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }       
    /**    
    * @Description : This method delete AccountTeamMember  
    * @param       : list<AccountTeamMember> accountTeamMembersList   
    * @return      : void   
    **/
    public void deleteAccountTeamMember(list<AccountTeamMember> accountTeamMembersList) {
        try{
            if(accountTeamMembersList!= null && (!accountTeamMembersList.isEmpty())) {
                Database.delete(accountTeamMembersList,false);
            }
        }                                    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }
    } 
    /**    
    * @Description : This method insert List Of AccountShare  
    * @param       : List<AccountShare> lstAccShare   
    * @return      : void   
    **/
    public void insertAccountShare(List<AccountShare> lstAccShare){       
        if(lstAccShare != null){
            Database.insert(lstAccShare,false);
        }               
    }
    /**    
    * @Description : This method insert List Of AccountTeamMember
    * @param       : list<AccountTeamMember> accTeamList   
    * @return      : void   
    **/
    public void insertAccountTeamMember(list<AccountTeamMember> accTeamList){        
        if(accTeamList != null){
            Database.insert(accTeamList,false);
        }        
    }   
    /**    
    * @Description : This method retrieve List Of Opportunity for Open and Close Stage for selected Accounts 
    * @param       : List<Account> selectedAccounts  
    * @return      : list<opportunity>
    **/
    public list<opportunity>  retrieveOpportunityOpenAndClose(List<Account> selectedAccounts) {        
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,name,ownerId from opportunity where (ForecastCategoryName = 'Pipeline' or ForecastCategoryName = 'Commit' or ForecastCategoryName = 'Best Case' or ForecastCategoryName = 'Closed') and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve List Of Opportunity for Open Stage and selected Accounts   
    * @param       : List<Account> selectedAccounts  
    * @return      : list<opportunity>
    **/
    public list<opportunity>  retrieveOpportunityOpen(List<Account> selectedAccounts) {      
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,name,ownerId from opportunity where (ForecastCategoryName = 'Pipeline' or ForecastCategoryName = 'Commit' or ForecastCategoryName = 'Best Case') and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve List Of Opportunity for Open Stage and selected Accounts  
    * @param       : List<Account> selectedAccounts  
    * @return      : list<opportunity>
    **/
    public list<opportunity>  retrieveOpportunityClose(List<Account> selectedAccounts) {        
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,name,ownerId from opportunity where ForecastCategoryName = 'Closed' and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve List Of Cases for New and Closed Status for selected Accounts  
    * @param       : List<Account> selectedAccounts  
    * @return      : list<case>
    **/
    public list<case>  retrieveCasesOpenAndClose(List<Account> selectedAccounts) {        
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,ownerId from case where (Status = 'New' or Status = 'Closed') and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve List Of Cases for New Status for selected Accounts   
    * @param       : List<Account> selectedAccounts  
    * @return      : list<case>
    **/
    public list<case>  retrieveCasesOpen(List<Account> selectedAccounts) {        
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,ownerId from case where Status = 'New' and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve List Of Cases for Closed Status for selected Accounts     
    * @param       : List<Account> selectedAccounts 
    * @return      : list<case>
    **/
    public list<case>  retrieveCasesClose(List<Account> selectedAccounts) {        
        if(selectedAccounts != null && (!selectedAccounts.isEmpty())) {
            return [select Id,ownerId from case where Status = 'Closed' and AccountId In: selectedAccounts];
        } else {
            return null;
        }        
    }
    /**    
    * @Description : This method retrieve OpportunityTeamMember for selected opportunity
    * @param       : Id transferFromId, List<opportunity>  
    * @return      : list<OpportunityTeamMember>
    **/
    public list<OpportunityTeamMember>  retrieveOpportunityTeamMember(Id transferFromId, List<opportunity> opportunityList) {
        try{
            if(transferFromId != null && opportunityList != null && (!opportunityList.isEmpty())) {
                return [select Id, UserId,Sent_to_siebel__c,Quoting_System__c,Email_Address__c,Functional_Role__c, OpportunityId, OpportunityAccessLevel, TeamMemberRole from OpportunityTeamMember where UserId =:transferFromId and OpportunityId In: opportunityList];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrieve OpportunityTeamMember for selected opportunity and user id is transferToUserId
    * @param       : Id transferToUserId, List<opportunity>  
    * @return      : list<OpportunityTeamMember>
    **/
    public list<OpportunityTeamMember>  retrieveOpportunityId(Id transferToUserId, List<opportunity> opportunityList) {
        try{
            if(transferToUserId != null && opportunityList != null && (!opportunityList.isEmpty())) {
                return [select OpportunityId from OpportunityTeamMember where UserId =:transferToUserId and OpportunityId In: opportunityList];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrieve OpportunityShare for selected opportunity  
    * @param       : Id transferFromId, List<opportunity> opportunityList   
    * @return      : list<OpportunityShare>   
    **/
    public list<OpportunityShare>  retrieveOpportunityShare(Id transferFromId, List<opportunity> opportunityList) {        
        try{
            if(transferFromId != null && opportunityList != null && (!opportunityList.isEmpty())) {
                return [select Id, UserOrGroupId, RowCause, OpportunityId, OpportunityAccessLevel from OpportunityShare where UserOrGroupId =:transferFromId and OpportunityId In: opportunityList];
            } else {
                return null;
            } 
        }    
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }               
    }
    /**    
    * @Description : This method retrieve CaseTeamMember for selected Cases
    * @param       : Id transferFromId, List<Case> casesList  
    * @return      : list<CaseTeamMember>
    **/
    public list<CaseTeamMember>  retrieveCaseTeamMember(Id transferFromId, List<Case> casesList) {
        try{
            if(transferFromId != null && casesList != null && (!casesList.isEmpty())) {
                return [select Id, ParentId, MemberId,TeamRoleId,TeamTemplateMemberId from CaseTeamMember where MemberId =:transferFromId and ParentId In: casesList];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrieve CaseTeamMember for selected Cases and user id is transferToUserId
    * @param       : Id transferToUserId, List<Case> casesList  
    * @return      : list<CaseTeamMember>
    **/
    public list<CaseTeamMember>  retrieveCaseId(Id transferToUserId, List<Case> casesList) {
        try{
            if(transferToUserId != null && casesList != null && (!casesList.isEmpty())) {
                return [select ParentId from CaseTeamMember where MemberId =:transferToUserId and ParentId In: casesList];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrieve CaseShare for selected Cases
    * @param       : Id transferFromId, List<Case> casesList   
    * @return      : list<CaseShare>   
    **/
    public list<CaseShare>  retrieveCaseShare(Id transferFromId, List<Case> casesList) {
        try{
            if(transferFromId != null && casesList != null && (!casesList.isEmpty())) {
                return [select Id, UserOrGroupId, RowCause, CaseId, CaseAccessLevel from CaseShare where UserOrGroupId =:transferFromId and CaseId In: casesList];
            } else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method delete OpportunityTeamMember  
    * @param       : list<OpportunityTeamMember> opportunityTeamMemberList   
    * @return      : void   
    **/
    public void deleteOpportunityTeamMember(list<OpportunityTeamMember> opportunityTeamMemberList) {
        try{
            if(!opportunityTeamMemberList.isEmpty() && opportunityTeamMemberList != null) {
                Database.delete(opportunityTeamMemberList,false);
            }
        }                                    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }
    }
    /**    
    * @Description : This method delete CaseTeamMember  
    * @param       : list<CaseTeamMember> caseTeamMemberList   
    * @return      : void   
    **/
    public void deleteCaseTeamMember(list<CaseTeamMember> caseTeamMemberList) {
        try{
            if(!caseTeamMemberList.isEmpty() && caseTeamMemberList != null) {
                Database.delete(caseTeamMemberList,false);
            }
        }                                    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }
    }
    /**    
    * @Description : This method insert List Of OpportunityShare
    * @param       : list<OpportunityShare> insertOpportunityShareList   
    * @return      : void   
    **/
    public void insertOpportunityShare(list<OpportunityShare> insertOpportunityShareList){        
        if(insertOpportunityShareList != null){
            Database.insert(insertOpportunityShareList,false);
        }              
    }
    /**    
    * @Description : This method insert List Of OpportunityTeamMember
    * @param       : list<OpportunityTeamMember> insertOpportunityTeamMemberList  
    * @return      : void   
    **/
    public void insertOpportunityTeamMember(list<OpportunityTeamMember> insertOpportunityTeamMemberList){       
        if(insertOpportunityTeamMemberList != null){
            Database.insert(insertOpportunityTeamMemberList,false);
        }                                                 
    } 
    /**    
    * @Description : This method insert List Of CaseShare
    * @param       : list<CaseShare> insertCaseShareList   
    * @return      : void   
    **/
    public void insertCaseShare(list<CaseShare> insertCaseShareList){
        if(insertCaseShareList != null){
            Database.insert(insertCaseShareList,false);
        }                
    }
    /**    
    * @Description : This method insert List Of CaseTeamMember
    * @param       : list<CaseTeamMember> insertCaseTeamMemberList   
    * @return      : void   
    **/
    public void insertCaseTeamMember(list<CaseTeamMember> insertCaseTeamMemberList){        
        if(insertCaseTeamMemberList != null){
            Database.insert(insertCaseTeamMemberList,false);
        }                                                  
    }
    /**    
    * @Description : This method update List Of opportunity
    * @param       : List<opportunity> opportunityUpdateList   
    * @return      : void   
    **/
    public void updateOpptyOwner(List<opportunity> opportunityUpdateList){       
        if(opportunityUpdateList != null){
            Database.update(opportunityUpdateList,false);
        }               
    }
    /**    
    * @Description : This method update List Of case
    * @param       : List<case> caseUpdateList   
    * @return      : void   
    **/
    public void updateCaseOwner(List<case> caseUpdateList){       
        if(caseUpdateList != null){
            Database.update(caseUpdateList,false);
        }               
    }
}