/**
@Classname :        M2O_SelectDeselectCategoryService 
@Description :     This test class is written to test the Apex class  M2O_SelectDeselectCategoryService
@Author:           Dipali Vijapure
@Last Modified:    04/29/2014
**/
@isTest(SeeAllData=false)
public Class  M2O_SelectDeselectCategoryServiceTest {
   
    /**
    @Description: Here in this test method the 'updateCategoryFlag' method of the M2O_SelectDeselectCategoryService is tested.
    @Return: null 
    **/
    
     static testMethod void  test_updateCategoryFlag() { 
      
        M2O_SelectDeselectCategoryService categoryService = new M2O_SelectDeselectCategoryService();  
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        List<Retail_Contract__c>contractsList= new List<Retail_Contract__c>();
        List<Retail_Contract__c>contractsListFalse= new List<Retail_Contract__c>();
        List<Retail_Contract__c>contractsListReset= new List<Retail_Contract__c>();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);  
        insert validateM2OProfile; 
        System.runAs(runAsUser) { 
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account accountData = M2O_AccountContactTestDataUtility.getSingleCustomerAccountRecord(regionData);
        insert accountData;
        contractsList = M2O_AccountContactTestDataUtility.getContractRecord(accountData);
        contractsListFalse = M2O_AccountContactTestDataUtility.getContractRecordFlase(accountData);
        contractsListReset = M2O_AccountContactTestDataUtility.getContractRecordReset(accountData);
        insert contractsList;
        insert contractsListFalse;
        insert contractsListReset;
        test.startTest();
        M2O_SelectDeselectCategoryService.updateCategoryFlag(contractsList);
        System.assertNotEquals(contractsList,null);
        M2O_SelectDeselectCategoryService.updateCategoryFlag(contractsListFalse);
        System.assertNotEquals(contractsListFalse,null);
        M2O_SelectDeselectCategoryService.updateCategoryFlag(contractsListReset);
        System.assertNotEquals(contractsListReset,null);
        test.stopTest();
        }
     }
     
   

    
}