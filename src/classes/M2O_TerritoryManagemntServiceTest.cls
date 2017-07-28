/**
@Classname :       M2O_TerritoryManagemntServiceTest
@Description :     This test class is written to test the Apex class M2O_TerritoryManagemntService. 
@Author:           Somdev Bhattacharyya
@Last Modified:    07/17/2014
**/

@isTest(SeeAllData=false)
public Class M2O_TerritoryManagemntServiceTest {
   
    /**
    @Description: Here in this test method the subTerritoryAddition method of the M2O_TerritoryManagemntService is tested.
    @Return: null 
    **/
    
    static testMethod void  test_subTerritoryAddition() {  
        profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            M2O_TerritoryManagemntService testHelper = new M2O_TerritoryManagemntService ();
            testHelper.userId= runAsUser.Id;
            list <SelectOption> itemsTest= testHelper.getitems ();
            list <SelectOption> itemsSubTest= testHelper.getitemsSub ();
            test.startTest();
               System.assertNotEquals(testHelper.userId,null);
               testHelper.subTerritoryAddition();
            test.stopTest();
        }
    }
    
    /**
    @Description: Here in this test method the getitems method of the M2O_TerritoryManagemntService is tested.
    @Return: null 
    **/
    
    static testMethod void  test_getitems() {  
        profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            M2O_TerritoryManagemntService testHelper = new M2O_TerritoryManagemntService ();
            testHelper.userId= runAsUser.Id;
            test.startTest();
               System.assertNotEquals(testHelper.userId,null);
               list <SelectOption> itemsTest= testHelper.getitems ();
            test.stopTest();
        }
    }
    
    /**
    @Description: Here in this test method the getitemsSub method of the M2O_TerritoryManagemntService is tested.
    @Return: null 
    **/
    static testMethod void  test_getitemsSub() {  
        profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            M2O_TerritoryManagemntService testHelper = new M2O_TerritoryManagemntService ();
            testHelper.userId= runAsUser.Id;
            test.startTest();
               System.assertNotEquals(testHelper.userId,null);
               list <SelectOption> itemsTest= testHelper.getitemsSub ();
            test.stopTest();
        }
    }
}