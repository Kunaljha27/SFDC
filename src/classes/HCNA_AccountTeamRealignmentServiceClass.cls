/*** 
*@ClassName : HCNA_AccountTeamRealignmentServiceClass  
*@Description : Service class for HCNA_AccountTeamRealignment page.
*@Author : Noor
*@Last Modified : 23/06/2014
*@Discussion points : No Information
***/

public with sharing class HCNA_AccountTeamRealignmentServiceClass {
    public HCNA_AccountTeamRealignmentDAOClass daoClass = New HCNA_AccountTeamRealignmentDAOClass();
    
    /**    
    * @Description : This method retrieve List Of Account   
    * @param       : Id userId  
    * @return      : List<Account>  
    **/
    public List<Account> retrieveAccounts(Id userId) {
        try{
            return daoClass.retrieveAccounts(userId);
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    
    /**    
    * @Description : This method realigns the account team member  
    * @param       : Id transferFromId,Id transferToUserId, List<Account> selectedAccountsList  
    * @return      : void 
    **/
    public void transferTheAccountTeamMember(Id transferFromId,Id transferToUserId, List<Account> selectedAccountsList) {
        if(transferFromId != null && transferToUserId != null && !(selectedAccountsList.isEmpty())) {
            list<AccountTeamMember> accountTeamMembersList = daoClass.retrieveAccountTeamMembers(transferFromId, selectedAccountsList);            
            list<AccountTeamMember> accountIdList = daoClass.retrieveAccountId(transferToUserId, selectedAccountsList);
            set<id> accountIdSet = new set<id>();
            for(AccountTeamMember accountTeamMemberRecord: accountIdList){
                accountIdSet.add(accountTeamMemberRecord.AccountId);
            }
            list<AccountShare> accountShareList = daoClass.retrieveAccountShare(transferFromId, selectedAccountsList);            
            if(accountTeamMembersList != null && accountShareList != null && !(accountTeamMembersList.isEmpty()) && !(accountShareList.isEmpty()) ) {
                list<AccountTeamMember> tempAccountTeamMemberList = new list<AccountTeamMember>();
                tempAccountTeamMemberList.addall(accountTeamMembersList);
                list<AccountShare> tempAccountShareList = new list<AccountShare>();
                tempAccountShareList.addall(accountShareList);
                daoClass.deleteAccountTeamMember(accountTeamMembersList);                
                list<AccountShare> insertAccountShareList = new list<AccountShare>();
                AccountShare insertAccountShareRecord;                                
                for(AccountShare tempAccountShareRecord: tempAccountShareList) {
                    if(accountIdSet.contains(tempAccountShareRecord.AccountId))
                    continue;
                    insertAccountShareRecord = new AccountShare();
                    insertAccountShareRecord.UserOrGroupId = transferToUserId;
                    insertAccountShareRecord.AccountAccessLevel = tempAccountShareRecord.AccountAccessLevel;
                    insertAccountShareRecord.AccountId = tempAccountShareRecord.AccountId;
                    insertAccountShareRecord.CaseAccessLevel = tempAccountShareRecord.CaseAccessLevel;
                    insertAccountShareRecord.OpportunityAccessLevel = tempAccountShareRecord.OpportunityAccessLevel;
                    insertAccountShareList.add(insertAccountShareRecord);                    
                } 
                list<AccountTeamMember> insertAccountTeamMemberList = new list<AccountTeamMember>();                
                AccountTeamMember insertAccountTeamMemberRecord;                                
                for(AccountTeamMember tempAccountTeamMemberRecord: tempAccountTeamMemberList) {
                    if(accountIdSet.contains(tempAccountTeamMemberRecord.AccountId))
                    continue;
                    insertAccountTeamMemberRecord = new AccountTeamMember();
                    insertAccountTeamMemberRecord.userId = transferToUserId;
                    insertAccountTeamMemberRecord.AccountId = tempAccountTeamMemberRecord.AccountId;
                    insertAccountTeamMemberRecord.TeamMemberRole = tempAccountTeamMemberRecord.TeamMemberRole;
                    insertAccountTeamMemberList.add(insertAccountTeamMemberRecord);
                }
                try{
                    daoClass.insertAccountTeamMember(insertAccountTeamMemberList);
                    daoClass.insertAccountShare(insertAccountShareList);
                }
                catch(DMLException exceptionMessage) {
                    system.debug(exceptionMessage.getmessage());
                }
            }
        }
    }
    
    /**    
    * @Description : This method realigns the opportunity and case team member  
    * @param       : Boolean openedOppty,Boolean closedOppty,Boolean openedCases,Boolean closedCases,Id transferFromId,Id transferToUserId, List<Account> selectedAccountsList
    * @return      : void 
    **/
    public void transferOpptyAndCasesTeamMember(Boolean openedOppty,Boolean closedOppty,Boolean openedCases,Boolean closedCases,Id transferFromId,Id transferToUserId, List<Account> selectedAccountsList){
        List<opportunity> opportunityUpdateList = new List<opportunity>();
        List<case> caseUpdateList = new List<case>();        
        if(transferFromId != null && transferToUserId != null && !(selectedAccountsList.isEmpty())) {
            list<opportunity> opportunityList = new list<opportunity>();
            list<case> casesList = new list<case>();
            try{
                if(openedOppty == true && closedOppty == true) {  
                    opportunityList = daoClass.retrieveOpportunityOpenAndClose(selectedAccountsList);                     
                }else if(openedOppty == true){
                    opportunityList = daoClass.retrieveOpportunityOpen(selectedAccountsList);                                     
                }else if(closedOppty == true){
                    opportunityList = daoClass.retrieveOpportunityClose(selectedAccountsList);                     
                }
                if(openedCases == true && closedCases == true) {  
                    casesList = daoClass.retrieveCasesOpenAndClose(selectedAccountsList);                     
                }else if(openedCases == true){
                    casesList = daoClass.retrieveCasesOpen(selectedAccountsList);                                     
                }else if(closedCases == true){
                    casesList = daoClass.retrieveCasesClose(selectedAccountsList);                     
                }                                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }            
                    
            if(!(opportunityList.isEmpty())) {
                for(Opportunity opptyRecord : opportunityList){
                    if(opptyRecord.ownerId ==  transferFromId){
                        opptyRecord.ownerId = transferToUserId;
                        opportunityUpdateList.add(opptyRecord);
                    }
                }    
                try{            
                    if(!opportunityUpdateList.isEmpty()){
                        daoClass.updateOpptyOwner(opportunityUpdateList);    
                    } 
                }    
                catch(DMLException exceptionMessage) {
                    system.debug(exceptionMessage.getmessage());
                }           
                list<OpportunityTeamMember> opportunityTeamMemberList = daoClass.retrieveOpportunityTeamMember(transferFromId,opportunityList);                          
                list<OpportunityTeamMember> opportunityIdList = daoClass.retrieveOpportunityId(transferToUserId,opportunityList);
                set<id> opportunityIdSet = new set<id>();
                for(OpportunityTeamMember opportunityTeamMemberRecord: opportunityIdList){
                    opportunityIdSet.add(opportunityTeamMemberRecord.OpportunityId);
                }
                list<OpportunityShare> OpportunityShareList = daoClass.retrieveOpportunityShare(transferFromId,opportunityList);                                      
                if(opportunityTeamMemberList != null && OpportunityShareList != null && !(opportunityTeamMemberList.isEmpty()) && !(OpportunityShareList.isEmpty()) ) {
                    list<OpportunityTeamMember> tempOpportunityTeamMemberList = new list<OpportunityTeamMember>();
                    tempOpportunityTeamMemberList.addall(opportunityTeamMemberList);
                    list<OpportunityShare> tempOpportunityShareList = new list<OpportunityShare>();
                    tempOpportunityShareList.addall(OpportunityShareList);
                    daoClass.deleteOpportunityTeamMember(opportunityTeamMemberList);
                    list<OpportunityShare> insertOpportunityShareList = new list<OpportunityShare>();
                    OpportunityShare insertOpportunityShareRecord;                                
                    for(OpportunityShare tempOpportunityShareRecord: tempOpportunityShareList) {
                        if(opportunityIdSet.contains(tempOpportunityShareRecord.OpportunityId))
                        continue;
                        insertOpportunityShareRecord = new OpportunityShare();
                        insertOpportunityShareRecord.UserOrGroupId = transferToUserId;
                        insertOpportunityShareRecord.OpportunityId = tempOpportunityShareRecord.OpportunityId;
                        insertOpportunityShareRecord.OpportunityAccessLevel = tempOpportunityShareRecord.OpportunityAccessLevel;
                        insertOpportunityShareList.add(insertOpportunityShareRecord);
                    }
                    list<OpportunityTeamMember> insertOpportunityTeamMemberList = new list<OpportunityTeamMember>();                
                    OpportunityTeamMember insertOpportunityTeamMemberRecord;                                
                    for(OpportunityTeamMember tempOpportunityTeamMemberRecord: tempOpportunityTeamMemberList) {
                        if(opportunityIdSet.contains(tempOpportunityTeamMemberRecord.OpportunityId))
                        continue;
                        insertOpportunityTeamMemberRecord= new OpportunityTeamMember();
                        insertOpportunityTeamMemberRecord.UserId = transferToUserId;
                        insertOpportunityTeamMemberRecord.Functional_Role__c = tempOpportunityTeamMemberRecord.Functional_Role__c;
                        insertOpportunityTeamMemberRecord.OpportunityId = tempOpportunityTeamMemberRecord.OpportunityId;
                        insertOpportunityTeamMemberRecord.TeamMemberRole = tempOpportunityTeamMemberRecord.TeamMemberRole;
                        insertOpportunityTeamMemberRecord.Sent_to_siebel__c = tempOpportunityTeamMemberRecord.Sent_to_siebel__c;
                        insertOpportunityTeamMemberRecord.Quoting_System__c = tempOpportunityTeamMemberRecord.Quoting_System__c;
                        insertOpportunityTeamMemberRecord.Email_Address__c = tempOpportunityTeamMemberRecord.Email_Address__c;
                        insertOpportunityTeamMemberList.add(insertOpportunityTeamMemberRecord);
                    }  
                    try{
                        if(insertOpportunityTeamMemberList != null && insertOpportunityShareList != null){
                            daoClass.insertOpportunityTeamMember(insertOpportunityTeamMemberList);                                
                            daoClass.insertOpportunityShare(insertOpportunityShareList);
                        }
                    }
                    catch(DMLException exceptionMessage) {
                        system.debug(exceptionMessage.getmessage());
                    }                        
                }
            }
            if(!(casesList.isEmpty())) {  
                for(Case caseRecord : casesList){
                    if(caseRecord.ownerId ==  transferFromId){
                        caseRecord.ownerId = transferToUserId;
                        caseUpdateList.add(caseRecord);
                    }
                }  
                try{              
                    if(!caseUpdateList.isEmpty()){
                        daoClass.updateCaseOwner(caseUpdateList);    
                    } 
                }    
                catch(DMLException exceptionMessage) {
                    system.debug(exceptionMessage.getmessage());
                }         
                list<CaseTeamMember> caseTeamMemberList = daoClass.retrieveCaseTeamMember(transferFromId,casesList);                          
                list<CaseTeamMember> caseIdList = daoClass.retrieveCaseId(transferToUserId,casesList);
                set<id> caseIdSet = new set<id>();
                for(CaseTeamMember caseTeamMemberRecord: caseIdList){
                    caseIdSet.add(caseTeamMemberRecord.ParentId);
                }
                list<CaseShare> caseShareList = daoClass.retrieveCaseShare(transferFromId,casesList);                                      
                if(caseTeamMemberList != null && caseShareList != null && !(caseTeamMemberList.isEmpty()) && !(caseShareList.isEmpty()) ) {
                    list<CaseTeamMember> tempCaseTeamMemberList = new list<CaseTeamMember>();
                    tempCaseTeamMemberList.addall(caseTeamMemberList);
                    list<CaseShare> tempCaseShareList = new list<CaseShare>();
                    tempCaseShareList.addall(caseShareList);
                    daoClass.deleteCaseTeamMember(caseTeamMemberList);
                    list<CaseShare> insertCaseShareList = new list<CaseShare>();
                    CaseShare insertCaseShareRecord;                                
                    for(CaseShare tempCaseShareRecord: tempCaseShareList) {
                        if(caseIdSet.contains(tempCaseShareRecord.CaseId))
                        continue;
                        insertCaseShareRecord = new CaseShare();
                        insertCaseShareRecord.UserOrGroupId = transferToUserId;
                        insertCaseShareRecord.CaseId = tempCaseShareRecord.CaseId;
                        insertCaseShareRecord.CaseAccessLevel = tempCaseShareRecord.CaseAccessLevel;
                        insertCaseShareList.add(insertCaseShareRecord);
                    }
                    list<CaseTeamMember> insertCaseTeamMemberList = new list<CaseTeamMember>();                
                    CaseTeamMember insertCaseTeamMemberRecord;                                
                    for(CaseTeamMember tempCaseTeamMemberRecord: tempCaseTeamMemberList) {
                        if(caseIdSet.contains(tempCaseTeamMemberRecord.ParentId))
                        continue;
                        insertCaseTeamMemberRecord= new CaseTeamMember();
                        insertCaseTeamMemberRecord.MemberId = transferToUserId;
                        insertCaseTeamMemberRecord.ParentId = tempCaseTeamMemberRecord.ParentId;
                        insertCaseTeamMemberRecord.TeamRoleId = tempCaseTeamMemberRecord.TeamRoleId;
                        insertCaseTeamMemberList.add(insertCaseTeamMemberRecord);
                    }  
                    try{
                        if(insertCaseShareList != null && insertCaseTeamMemberList != null){
                            daoClass.insertCaseTeamMember(insertCaseTeamMemberList);                                
                            daoClass.insertCaseShare(insertCaseShareList);
                        }
                    }    
                    catch(DMLException exceptionMessage) {
                        system.debug(exceptionMessage.getmessage());
                    }
                }
            }
        }  
    }           
}