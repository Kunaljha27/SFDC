@isTest
  public class Test_UpdateSeibleAccTeam
  {
@isTest static void UpdateSeibleAccTeam_TestMethod()
 { 
user u;
Account a;
User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
 System.runAs (thisUser) {
        
        Profile m2oSysAdminProfileId=[Select id from Profile where Name='System Administrator'];
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.id);
            
        
        system.runAs(m2oSystemAdminUser){
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
                        
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            
            Account newAcc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert newAcc ;
          
          AccountTeamMember  act=new AccountTeamMember ();
           act.UserId=thisUser.id;
           act.AccountId=acc.id;
          insert act;
          
          Account_affiliation__c aff=new Account_affiliation__c(); 
          aff.Affiliated_Account__c=acc.id;
          insert aff;
       
           acc.SourceSystem__c = 'Siebel';
           newAcc.SourceSystem__c = 'Siebel';
           
           update acc;
           update newAcc;
       }
   
    }
   }
 }