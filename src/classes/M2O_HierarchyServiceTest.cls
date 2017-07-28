/**
@Classname :       M2O_HierarchyServiceTest
@Description :     This test class is written to test the Apex class M2O_HierarchyService. 
@Author:           Dipali Vijapure
@Last Modified:    03/26/2014
**/

@isTest(SeeAllData=false)
public Class M2O_HierarchyServiceTest {
   
    /**
    @Description: Here in this test method the getCurrentAccountRecord method of the M2O_HierarchyService is tested.
    @Return: null 
    **/
    
     static testMethod void  test_getCurrentAccountRecord() {       
        M2O_HierarchyService hierarchyService = new M2O_HierarchyService();  
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account accountData = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
            insert accountData;
            test.startTest();
            System.assertNotEquals(accountData.Id,null);
            M2O_HierarchyService.getCurrentAccountRecord(accountData.Id);
            test.stopTest();
        }
     }
     
  /**
    @Description: Here in this test method the getParentChildRecord method of the M2O_HierarchyService with two parameters is tested.
    @Return: null 
    **/
    
     static testMethod void  test_getParentChildRecord() { 
        M2O_HierarchyService hierarchyService = new M2O_HierarchyService();  
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Boolean hasMoreRecord = true;
        System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account accountData = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
            insert accountData;
            hasMoreRecord = true;
            test.startTest();
            System.assertNotEquals(accountData,null);
            M2O_HierarchyService.getParentChildRecord(accountData.Level_1_Parent__c, hasMoreRecord, accountData.Id);
            
            hasMoreRecord = false;
            M2O_HierarchyService.getParentChildRecord(accountData.Level_1_Parent__c, hasMoreRecord, accountData.Id);
            test.stopTest();
        }
     }
}