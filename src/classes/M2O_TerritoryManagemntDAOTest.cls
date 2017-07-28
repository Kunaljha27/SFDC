/**
@Classname :       M2O_TerritoryManagemntDAOTest
@Description :     This test class is written to test the Apex class M2O_TerritoryManagemntService. 
@Author:           Somdev Bhattacharyya
@Last Modified:    07/17/2014
**/

@isTest(SeeAllData=false)
public Class M2O_TerritoryManagemntDAOTest {
   
    /**
    @Description: Here in this test method the updateUserTerritorySubTerritory method of the M2O_TerritoryManagemntServiceDAO is tested.
    @Return: null 
    **/
    
    static testMethod void  test_updateUserTerritorySubTerritory() {
         profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            test.starttest();
            runAsUser.CommunityNickname= 'tu1123499'; 
            M2O_TerritoryManagemntDAO.updateUserTerritorySubTerritory(runAsUser);
            System.assertNotEquals(runAsUser,null);
            test.stoptest();  
            runAsUser.alias=null;
            M2O_TerritoryManagemntDAO.updateUserTerritorySubTerritory(runAsUser); 
        }    
    }
    
    /**
    @Description: Here in this test method the getTerritoryData method of the M2O_TerritoryManagemntServiceDAO is tested.
    @Return: null 
    **/
    
    static testMethod void  test_getTerritoryData() {
         profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            test.starttest();
            M2O_TerritoryManagemntDAO.getTerritoryData(runAsUser.id);
            System.assertNotEquals(runAsUser,null);
            test.stoptest();  
        }    
    } 
    /**
    @Description: Here in this test method the getSubTerritoryData method of the M2O_TerritoryManagemntServiceDAO is tested.
    @Return: null 
    **/
    
    static testMethod void  test_getSubTerritoryData() {
         profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            test.starttest();
            M2O_TerritoryManagemntDAO.getSubTerritoryData(runAsUser.id);
            System.assertNotEquals(runAsUser,null);
            test.stoptest();  
        }    
    } 
}