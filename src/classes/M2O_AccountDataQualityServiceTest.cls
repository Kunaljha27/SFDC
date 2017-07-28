/**
* @ClassName : M2O_AccountDataQualityServiceTest
* @Description : This class is test class for M2O_M2O_AccountDataQualityService
* @Author : Srutadeba Chanda
* @Last Modified : 16/12/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=false)
private class M2O_AccountDataQualityServiceTest{

/**
* @Description: This test method covers the method updateHasAccTeamMemberOnAccount in service class
**/    
     @isTest static void test_UpdateHasAccTeamMemberOnAccount() {
        string profileName= 'M2O Global Data Management';
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Region__c regionData;
        list<Account> listaccountRecord ;
        List<User> listUser;
        List<AccountTeamMember> listAccountTeamMemberRecord;
        system.RunAs(m2oSystemAdminUser) {
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData; 
            listaccountRecord =M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert listaccountRecord ;
            listUser= M2O_AccountContactTestDataUtility.getUserforAccountTeam(50,profileName);
            insert listUser;
            listAccountTeamMemberRecord= M2O_AccountContactTestDataUtility.getAccountTeamMemberRecord(listaccountRecord[0].id,listUser);
            insert listAccountTeamMemberRecord;
            test.starttest();
            M2O_AccountDataQualityService.updateHasAccTeamMemberOnAccount(listAccountTeamMemberRecord);
            system.assertequals(listAccountTeamMemberRecord[0].account.Account_Has_Account_Team__c,false);
            test.stoptest();
        }
    }   
    
  /**
* @Description: This test method covers the method checkAccountForTeammember in service class
**/  
     @isTest static void test_CheckAccountForTeammember() {
        string profileName= 'M2O Global Data Management';
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Region__c regionData;
        List<AccountTeamMember> listAccountTeamMember;
        List<Delete_Account_Team__c> listDeleteAcountTeam;
        List<User> listUser;
        list<Account> listaccountRecord ;
        system.RunAs(m2oSystemAdminUser) {
           regionData= M2O_AccountContactTestDataUtility.getRegionData();
          insert regionData;    
          listaccountRecord =M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
          insert listaccountRecord ;
          listDeleteAcountTeam =M2O_AccountContactTestDataUtility.getDeleteAccountTeam(listaccountRecord[0].id);
          insert listDeleteAcountTeam ;
           test.starttest();
           M2O_AccountDataQualityService.checkAccountForTeammember(listDeleteAcountTeam);
           System.assertNotEquals(listDeleteAcountTeam, null);
           test.stoptest();
        }
    }
    
    /* 
  * @Description : This test method covers the updateParentAccount() method of Service class
  */     
     @isTest static void test_UpdateParentAccount() {
        string profileName= 'M2O Global Data Management';
        set<ID> setAccount= new set<ID>();
        Region__C regionData;
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        User userRecord=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecord;
        Account accountRecord ;
        List<Contact> listCreateContact;
        system.RunAs(userRecord) {  
        regionData= M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;      
        accountRecord =M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
        insert accountRecord ;
         System.runAs(m2oSystemAdminUser) {
             Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(userRecord.id, accountRecord.id);
             update accountToUpdate ;
            }
        setaccount.add(accountRecord.id);
        test.starttest();
        M2O_AccountDataQualityService.updateParentAccount(setAccount);
        system.assertequals(accountRecord.Account_Has_Contact_Person__c,false);
        test.stoptest();
        }
    }   
      
 }