/**
@Classname :       M2O_SimpleHierarchyControllerTest
@Description :     This test class is written to test the M2O_SimpleHierarchyController. 
@Author:           Vishal Kashyap
@Last Modified:    07/004/2015
**/
@isTest(SeeAllData=false)
public Class M2O_SimpleHierarchyControllerTest {

    /**
    @Description: Here in this test method the generateTreeStructureForAccounts method of the M2O_AccountHierarchyController is tested.
    @Return: null 
    **/
    static testMethod void test_SimpleHierarchyControllerTest () {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount, childAccount, childAccount1, childAccount2, childAccount3;  
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;     
        childAccount1 = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,childAccount.id);
        insert childAccount1; 
        childAccount2 = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,childAccount1.id);
        insert childAccount2; 
        childAccount3 = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,childAccount2.id);
        insert childAccount3;   
                    System.currentPageReference().getParameters().put('id', childAccount3.id);

        System.runAs(runAsUser) { 
            System.currentPageReference().getParameters().put('id', childAccount3.id);
            ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount3);
            M2O_SimpleHierarchyController accountHierarchyController = new M2O_SimpleHierarchyController(stdController);
            System.currentPageReference().getParameters().put('id', childAccount3.id);
            stdController = new ApexPages.StandardController(childAccount3);
            accountHierarchyController = new M2O_SimpleHierarchyController(stdController);
            System.currentPageReference().getParameters().put('id', childAccount2.id);
            stdController = new ApexPages.StandardController(childAccount2);
            accountHierarchyController = new M2O_SimpleHierarchyController(stdController);
            System.currentPageReference().getParameters().put('id', childAccount1.id);
            stdController = new ApexPages.StandardController(childAccount1);
            accountHierarchyController = new M2O_SimpleHierarchyController(stdController);
            System.currentPageReference().getParameters().put('id', childAccount.id);
            stdController = new ApexPages.StandardController(childAccount);
            accountHierarchyController = new M2O_SimpleHierarchyController(stdController);
            System.currentPageReference().getParameters().put('id', parentAccount.id);
            stdController = new ApexPages.StandardController(parentAccount);
            accountHierarchyController = new M2O_SimpleHierarchyController(stdController);         
        }
    }
}