/**
@Classname :       HCNA_AccountTeamRealignmentDAOClass_test
@Description :     This test class is written to test the Apex class HCNA_AccountTeamRealignmentDAOClass
@Author:           Harmeet
@Last Modified:    6/20/2014
**/

@isTest
class HCNA_AccountTeamRealignmentDAOClass_Test {
    
    /**    
    * @Description : This method to test retrieving List Of Account.
    **/
    static testMethod void test_retrieveAccounts(){
          
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        Profile hcProfileId1 = HCNA_UtilityClass.getHCNAProfileId1();
        User userRecord = HCNA_UtilityClass.getUserRecord1(hcProfileId1);
        insert userRecord;
        List<Account> tMAccount = new  List<Account>();
        tMAccount = atrObj.retrieveAccounts(userRecord.id);
        Account accountRecord = new Account();
        accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        AccountTeamMember memberRecord = new AccountTeamMember();
        memberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, userRecord);
        tMAccount = atrObj.retrieveAccounts(userRecord.id);
        tMAccount = atrObj.retrieveAccounts(null);
        test.stopTest();
    } 

    /**    
    * @Description : This method to test retrieving List Of Account Team Member  
    **/
    static testMethod void test_retrieveAccountTeamMembers(){
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        List<Account> selectedAccountsList = new List<Account>();
        list<AccountTeamMember> memberRecordList = new list<AccountTeamMember>();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        selectedAccountsList.add(accountRecord);
        AccountTeamMember teamMemberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, transferFromUser);
        insert teamMemberRecord;
        Id transferFromId = transferFromUser.id;
        memberRecordList = atrObj.retrieveAccountTeamMembers(transferFromId, selectedAccountsList);
        atrObj.retrieveAccountId(transferFromId, selectedAccountsList);
        transferFromId = null;
        memberRecordList = atrObj.retrieveAccountTeamMembers(transferFromId, selectedAccountsList);
        atrObj.retrieveAccountId(transferFromId, selectedAccountsList);
        list<opportunity> opptyList= new  list<opportunity>();
        opptyList = atrObj.retrieveOpportunityOpenAndClose(selectedAccountsList);
        opptyList = atrObj.retrieveOpportunityOpenAndClose(new List<Account>());
        opptyList = atrObj.retrieveOpportunityOpen(new List<Account>());
        opptyList = atrObj.retrieveOpportunityOpen(selectedAccountsList);
        opptyList = atrObj.retrieveOpportunityClose(new List<Account>());
        opptyList = atrObj.retrieveOpportunityClose(selectedAccountsList);
        Contact contactRecord = new Contact();
        contactRecord = HCNA_UtilityClass.getContactRec(accountRecord);
        insert contactRecord;
        list<case> caseList= new  list<case>();
        case caseRecord ;
        caseRecord = HCNA_UtilityClass.getCaseRecord(accountRecord,transferFromUser,contactRecord);
        insert caseRecord;
        caseList = atrObj.retrieveCasesOpenAndClose(new List<Account>());
        caseList = atrObj.retrieveCasesOpenAndClose(selectedAccountsList);
        caseList = atrObj.retrieveCasesOpen(new List<Account>());
        caseList = atrObj.retrieveCasesOpen(selectedAccountsList);
        caseList = atrObj.retrieveCasesClose(new List<Account>());
        caseList = atrObj.retrieveCasesClose(selectedAccountsList);
        test.stopTest();
    }  

    /**    
    * @Description : This method to test retrieving List Of Account Share  
    **/
    static testMethod void test_retrieveAccountShare(){ 
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        List<Account> selectedAccountsList = new List<Account>();
        List<AccountShare> accountShareList = new list<AccountShare>();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        selectedAccountsList.add(accountRecord);
        AccountTeamMember teamMemberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, transferFromUser);
        insert teamMemberRecord;
        Id transferFromId = transferFromUser.id;
        accountShareList = atrObj.retrieveAccountShare(transferFromId, selectedAccountsList);
        atrObj.insertAccountShare(accountShareList);
        transferFromId = null;
        accountShareList = atrObj.retrieveAccountShare(transferFromId, selectedAccountsList);
        test.stopTest();
        }
        
    /**    
    * @Description : This method to test Insert of List Of Account Team Member.  
    **/
    static testMethod void test_AccountTeamMember(){ 
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        List<Account> selectedAccountsList = new List<Account>();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        selectedAccountsList.add(accountRecord) ;
        List<AccountTeamMember> teamMemberRecord = new list<AccountTeamMember>();
        AccountTeamMember memberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, transferFromUser);
        insert memberRecord;
        teamMemberRecord.add(memberRecord);
        atrObj.insertAccountTeamMember(teamMemberRecord);
        atrObj.deleteAccountTeamMember(teamMemberRecord);
        test.stopTest();
    }   
    /**    
    * @Description : This method to test retrieveOpportunityTeamMember method.
    **/
    static testMethod void test_retrieveOpportunityTeamMember(){ 
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        List<Account> selectedAccountsList = new List<Account>();
        selectedAccountsList.add(accountRecord);
        Opportunity opportunityRecord = new Opportunity();
        opportunityRecord = HCNA_UtilityClass.getOpportunityRecord(accountRecord, transferFromUser);
        insert opportunityRecord;
        List<opportunity> opportunityRecordList = new List<opportunity>();
        opportunityRecordList.add(opportunityRecord);
        atrObj.updateOpptyOwner(opportunityRecordList);
        Id transferFromId = transferFromUser.id;
        OpportunityTeamMember opptyMemberRecord = new OpportunityTeamMember();
        List<OpportunityTeamMember> opptyMemberList = new List<OpportunityTeamMember>();
        opptyMemberList = 
        atrObj.retrieveOpportunityTeamMember(transferFromId , opportunityRecordList);
        atrObj.retrieveOpportunityId(transferFromId , opportunityRecordList);
        atrObj.insertOpportunityTeamMember(opptyMemberList);
        opptyMemberRecord= HCNA_UtilityClass.getOppTeamMember(opportunityRecord, transferFromUser);
        insert opptyMemberRecord;
        opptyMemberList.add(opptyMemberRecord);
        atrObj.deleteOpportunityTeamMember(opptyMemberList);
        atrObj.retrieveOpportunityTeamMember(null , null);
        atrObj.retrieveOpportunityId(null , null);
        List<OpportunityShare> opptyShareList = new list<OpportunityShare>();
        opptyShareList = atrObj.retrieveOpportunityShare(transferFromId , opportunityRecordList);
        opptyShareList = atrObj.retrieveOpportunityShare(null , null);
        Contact contactRecord = new Contact();
        contactRecord = HCNA_UtilityClass.getContactRec(accountRecord);
        insert contactRecord;
        List<CaseTeamMember> caseTeamMemberList = new list<CaseTeamMember>();
        List<Case> caseRecordList = new list<Case>();
        List<CaseShare> caseShareList = new List<CaseShare>();
        Case caseRecord = new Case();
        caseRecord = HCNA_UtilityClass.getCaseRecord(accountRecord, transferFromUser, contactRecord);
        insert caseRecord;
        caseRecordList.add(caseRecord);
        atrObj.updateCaseOwner(caseRecordList);
        caseTeamMemberList = atrObj.retrieveCaseTeamMember(transferFromId , caseRecordList);
        atrObj.retrieveCaseId(transferFromId , caseRecordList);
        insert caseTeamMemberList;
        atrObj.insertCaseTeamMember(caseTeamMemberList);
        atrObj.deleteCaseTeamMember(caseTeamMemberList);
        caseShareList = atrObj.retrieveCaseShare(transferFromId,caseRecordList);
        atrObj.insertCaseShare(caseShareList);        
        caseTeamMemberList = atrObj.retrieveCaseTeamMember(null , null);
        atrObj.retrieveCaseId(null , null);
        caseShareList = atrObj.retrieveCaseShare(null,null);
        test.stopTest();    
    }
    /**    
    * @Description : This method to test insert of List Of Opportunity Share    
    **/
    static testMethod void test_insertOpportunityShare(){ 
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        atrObj.insertOpportunityShare(new List<OpportunityShare>());
        test.stopTest();    
    }
    /**    
    * @Description : This method for exception coverage.   
    **/
    static testMethod void test_exceptionCoverage(){ 
        test.startTest();
        HCNA_AccountTeamRealignmentDAOClass atrObj = new HCNA_AccountTeamRealignmentDAOClass();
        list<AccountTeamMember> accountTMember;
        List<AccountShare> lstAccShare;
        atrObj.deleteAccountTeamMember(accountTMember);
        atrObj.insertAccountShare(lstAccShare);
        test.stopTest();    
    }        
}