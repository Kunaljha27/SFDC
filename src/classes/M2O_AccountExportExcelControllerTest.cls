/**
@Classname :       M2O_AccountExportExcelControllerTest
@Description :     This test class is written to test the Apex class M2O_AccountExportExcelController. 
@Author:           Ruchika Patil
@Last Modified:    04/07/2014
**/
@isTest(SeeAllData=false)
public Class M2O_AccountExportExcelControllerTest {

    /**
    @Description: Here in this test method the generateTreeStructureForAccounts method of the M2O_AccountExportExcelController is tested.
    @Return: null 
    **/
    static testMethod void test_generateTreeStructureForAccounts() { 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();        
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount, childAccount;  
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;   
        system.debug('>>>>>>>>>>> childAccount '+ childAccount + '    '+  parentAccount);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('AccountID', childAccount.id);
        M2O_AccountExportExcelController accountController = new M2O_AccountExportExcelController(stdController);
        accountController.currentAccountId = childAccount.id;         
        System.runAs(runAsUser) { 
            List<Account> accList = [Select id, Name from Account where (Id =: parentAccount.Id OR Level_1_Parent__c =: parentAccount.Id)
                                     AND Inactive_Flag__c = False];
            system.debug('>>>>>>>>>>> accList  >>>>>>>>>> '+ accList );
            test.startTest();            
            accountController.generateTreeStructureForAccounts();  
            test.stopTest();
        }
    }
     /**
    @Description: Here in this test method the createParentChildMapmethod of the M2O_AccountExportExcelController is tested.
    @Return: null 
    **/
     static testMethod void  test_createParentChildMap() { 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount;
        Account childAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;
        system.debug('childAccount'+childAccount);
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('AccountID', childAccount.id);
        M2O_AccountExportExcelController accountController = new M2O_AccountExportExcelController(stdController);         
        System.runAs(runAsUser) {      
            List<account> accountParentChildList = new List<account>();
            accountParentChildList.add(parentAccount);
            accountParentChildList.add(childAccount);           
            accountController.accountListChildrenMap = new Map<id,List<Account>>(); 
          //  accountController.accountListChildrenMap.put(parentAccount.id,accountParentChildList);
            test.startTest();
            accountController.createParentChildMap(accountParentChildList);
            accountController.createParentChildMap(accountParentChildList);       
            test.stopTest();
        }
     }
     /**
    @Description: Here in this test method the createTreeStructure of the M2O_AccountExportExcelController is tested.
    @Return: null 
    **/
     static testMethod void  test_createTreeStructure() { 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount, childAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('AccountID', childAccount.id);
        M2O_AccountExportExcelController accountController = new M2O_AccountExportExcelController(stdController);
        System.runAs(runAsUser) {      
            List<account> accountParentChildList = new List<account>();
            accountParentChildList.add(childAccount);
            accountController.accountListChildrenMap = new Map<id,List<Account>>();            
            accountController.accountListChildrenMap.put(parentAccount.id,accountParentChildList);
            test.startTest();
            accountController.createTreeStructure(parentAccount);      
            test.stopTest();
        }
     } 
}