@isTest
  public class Test_UpdatePhoneBookAsset
  {
    @isTest static void UpdatePhoneBookAsset_TestMethod()
     { 
            Profile m2oSysAdminProfileId=[Select id from Profile where Name='System Administrator'];
            User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.id);
            
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            
            system.runAs(m2oSystemAdminUser ){
                
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
        
                Account a= M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert a;   
                a.Phone_Book_Parent__c=acc.id;
                update a;  
            
                Asset ass;
                ass=new Asset(Accountid=a.id,name='test asset',Department__c='Anesthesiology',Medical_Services__c='Angio',Status='INSTALL',InstallDate=system.today());
                insert ass;
            }
     
     }
 }