//Test Class for Prevent_delete_account

@isTest
private class Prevent_delete_accountTrigger_test  {
public static testmethod void triggertest()
{
//System Administrator
Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
profile p =[select id,name from profile where name='PCCI Super User'] ;
User u= [select name,id from user where profileid=:p.id  and IsActive = true limit 1];
system.runas(u)
{
Region__c regiondata=M2O_AccountContactTestDataUtility.getRegionData();
        insert regiondata;
        Account a=M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
         insert a;
 System.runAs(m2oSystemAdminUser) {
   Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(u.id, a.id);
 update accountToUpdate ;
            }
try{
delete a;

}
catch(Exception e){

}

}
}
}