/**
* @ClassName     : M2O_SchedulerUpdateForAccountTeamTest
* @Description   : This test class is covers the code for M2O_SchedulerUpdateForAccountTeam class
* @Author        : Srutadeba Chanda
* @Last Modified : 16/12/2013
* @Discussionpoints : No Information
*/

@isTest(SeeAllData=false)
private class M2O_SchedulerUpdateForAccountTeamTest{

/**
* @Description: This test method covers the execute method of Scheduler class
   
**/ 
     @isTest static void test_ValidationExecute(){
       List<AccountTeamMember> listAccountTeamMemberRecord;
       List<User> listUser= new List<User>();
        Region__C regionData;
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();    
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();    
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        User user = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
        
        system.RunAs(runAsUser) {
         regionData= M2O_AccountContactTestDataUtility.getRegionData();
         insert regionData;
        Account accountRecord =M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
        insert accountRecord ;
        integer userCounnt = 1;
        string profileName = 'M2O Global Data Management';
        listUser = M2O_AccountContactTestDataUtility.getUserforAccountTeam(userCounnt,profileName);
        insert listUser;
          System.runAs(m2oSystemAdminUser){
          listAccountTeamMemberRecord= M2O_AccountContactTestDataUtility.getAccountTeamMemberRecord(accountRecord.id,listUser);
          insert listAccountTeamMemberRecord;
          }
          system.assertnotequals(listAccountTeamMemberRecord.size(),0);
        test.starttest();
        M2O_SchedulerUpdateForAccountTeam scheduler = new M2O_SchedulerUpdateForAccountTeam();
        String sch = '1 6 23 1 5 ?';  
        system.schedule('Contract Creates1', sch, scheduler );
        system.assertequals(accountRecord.name,'Test');
         test.stoptest();
        }
     
     }
}