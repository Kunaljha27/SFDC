/**
@Classname :       HCNA_AccountTeamRealignmentServiceClass_test
@Description :     This test class is written to test the Apex class HCNA_CustomForecastPageDAOClass
@Author:           Ruchika
@Last Modified:    6/20/2014
**/

@isTest
class HCNA_AccTeamRealignmentServiceClass_Test {
    /**    
    * @Description : This method to test the retrieveAccounts() method.     
    **/
    static testMethod void test_RetrieveAccounts(){
        Test.startTest();
        HCNA_AccountTeamRealignmentServiceClass atrSeviceClass = new HCNA_AccountTeamRealignmentServiceClass();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User userRec = HCNA_UtilityClass.getUserRecord(profileRec);
        insert userRec;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        AccountTeamMember teamMemberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, userRec);
        insert teamMemberRecord;
        List<Account> accountList = atrSeviceClass.retrieveAccounts(userRec.id);
        system.assertnotequals(accountList,null);
        Test.stopTest();
    } 
    /**    
    * @Description : This method to test the transferTheAccountTeamMember() method.     
    **/
    static testMethod void test_transferTheAccountTeamMember(){
        Test.startTest();
        HCNA_AccountTeamRealignmentServiceClass atrSeviceClass = new HCNA_AccountTeamRealignmentServiceClass();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        User transferToUser = HCNA_UtilityClass.getUserRecord1(profileRec);
        insert transferToUser ;
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        List<Account> selectedAccountsList = new List<Account>();
        selectedAccountsList.add(accountRecord);
        AccountTeamMember teamMemberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, transferFromUser);
        insert teamMemberRecord;
        atrSeviceClass.transferTheAccountTeamMember(transferFromUser.id,transferToUser.id,selectedAccountsList);
        system.assertnotequals(selectedAccountsList,null);
        system.assertnotequals(transferFromUser,null);
        system.assertnotequals(transferToUser,null);
        Test.stopTest();
    } 
    /**    
    * @Description : This method to test the transferOpptyAndCasesTeamMember() method     
    **/ 
    static testMethod void test_transferOpptyAndCasesTeamMember(){
        HCNA_AccountTeamRealignmentServiceClass atrSeviceClass = new HCNA_AccountTeamRealignmentServiceClass();
        Profile profileRec = HCNA_UtilityClass.getHCNAProfileId2(); 
        User transferFromUser = HCNA_UtilityClass.getUserRecord(profileRec);
        insert transferFromUser ;
        User transferToUser = HCNA_UtilityClass.getUserRecord1(profileRec);
        insert transferToUser ;
        system.runAs(transferFromUser){
        Account accountRecord = HCNA_UtilityClass.getAccountRecord();
        insert accountRecord;
        List<Account> selectedAccountsList = new List<Account>();
        selectedAccountsList.add(accountRecord);
        AccountTeamMember teamMemberRecord = HCNA_UtilityClass.getAccountTeamMemberRecord(accountRecord, transferFromUser);
        insert teamMemberRecord;
        Opportunity opportunityRecord = HCNA_UtilityClass.getOpportunityRecord(accountRecord,transferFromUser);
        insert opportunityRecord;
        Opportunity oppRecord = HCNA_UtilityClass.getOpportunityRecord(accountRecord, transferFromUser);
        oppRecord.StageName = 'Lost';
        oppRecord.ForecastCategoryName = 'Closed';
        insert oppRecord;
        OpportunityTeamMember oppTeamMemRecord = HCNA_UtilityClass.getOppTeamMember(opportunityRecord, transferFromUser);
        insert oppTeamMemRecord;
        OpportunityTeamMember oppTeamMemRec = HCNA_UtilityClass.getOppTeamMember(oppRecord , transferFromUser);
        insert oppTeamMemRec;           
        Test.startTest();
        Contact contactRecord = HCNA_UtilityClass.getContactRec(accountRecord);
        insert contactRecord;
        Case caseRecord = HCNA_UtilityClass.getCaseRecord(accountRecord, transferFromUser,contactRecord);
        insert caseRecord;    
        Case caseRec = HCNA_UtilityClass.getCaseRecord(accountRecord, transferFromUser,contactRecord);
        caseRec.Status = 'Closed';
        insert caseRec;
        CaseTeamRole caseTeamRoleRecord = HCNA_UtilityClass.getCaseTeamRoleRecord();
        insert caseTeamRoleRecord ;
        CaseTeamMember caseTeamMemRecord = HCNA_UtilityClass.getCaseTeamRecord(caseRecord, transferFromUser,caseTeamRoleRecord);
        insert caseTeamMemRecord ;
        CaseTeamMember caseTeamMemRec = HCNA_UtilityClass.getCaseTeamRecord(caseRec, transferFromUser,caseTeamRoleRecord);
        insert caseTeamMemRec ; 
        atrSeviceClass.transferOpptyAndCasesTeamMember(true,true,true,true,transferFromUser.id,transferToUser.id,selectedAccountsList);
        atrSeviceClass.transferOpptyAndCasesTeamMember(true,false,true,false,transferFromUser.id,transferToUser.id,selectedAccountsList);
        //atrSeviceClass.transferOpptyAndCasesTeamMember(false,true,false,true,transferFromUser.id,transferToUser.id,selectedAccountsList);
        system.assertnotequals(selectedAccountsList,null);
        system.assertnotequals(transferFromUser,null);
        system.assertnotequals(transferToUser,null);
        Test.stopTest();
        }
    }
}