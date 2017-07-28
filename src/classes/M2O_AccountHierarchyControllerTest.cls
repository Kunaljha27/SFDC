/**
@Classname :       M2O_AccountHierarchyControllerTest
@Description :     This test class is written to test the Apex class M2O_AccountHierarchyController. 
@Author:           Ruchika Patil
@Last Modified:    04/07/2014
**/
@isTest(SeeAllData=false)
public Class M2O_AccountHierarchyControllerTest {

    /**
    @Description: Here in this test method the generateTreeStructureForAccounts method of the M2O_AccountHierarchyController is tested.
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
        ApexPages.StandardController stdController = new ApexPages.StandardController(parentAccount);
        System.currentPageReference().getParameters().put('id', parentAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController);         
        System.runAs(runAsUser) { 
            List<Account> accList = [Select id, Name from Account where (Id =: parentAccount.Id OR Level_1_Parent__c =: parentAccount.Id)
                                     AND Inactive_Flag__c = False];
            system.debug('>>>>>>>>>>> accList  >>>>>>>>>> '+ accList );
            test.startTest();            
            accountHierarchyController.generateTreeStructureForAccounts();  
            test.stopTest();
        }
    }
     /**
    @Description: Here in this test method the createParentChildMapmethod of the M2O_AccountHierarchyController is tested.
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
        string CurrentAccountTopParentId = string.valueOf(parentAccount.id);
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;
        system.debug('childAccount'+childAccount);
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('id', childAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController);         
        System.runAs(runAsUser) {      
            List<account> accountParentChildList = new List<account>();
            accountParentChildList.add(parentAccount);
            accountParentChildList.add(childAccount);           
            accountHierarchyController.accountListChildrenMap = new Map<id,List<Account>>(); 
          //  accountHierarchyController.accountListChildrenMap.put(parentAccount.id,accountParentChildList);
            test.startTest();
            accountHierarchyController.createParentChildMap(accountParentChildList);
            accountHierarchyController.createParentChildMap(accountParentChildList);       
            test.stopTest();
        }
     }
     /**
    @Description: Here in this test method the createTreeStructure of the M2O_AccountHierarchyController is tested.
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
        System.currentPageReference().getParameters().put('id', childAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController);
        System.runAs(runAsUser) {      
            List<account> accountParentChildList = new List<account>();
            accountParentChildList.add(childAccount);
            accountHierarchyController.accountListChildrenMap = new Map<id,List<Account>>();            
            accountHierarchyController.accountListChildrenMap.put(parentAccount.id,accountParentChildList);
            test.startTest();
            accountHierarchyController.createTreeStructure(parentAccount);      
            test.stopTest();
        }
     }
      /**
    @Description: Here in this test method the convertNodeToJSON of the M2O_AccountHierarchyController is tested.
    @Return: null 
    **/
     static testMethod void  test_convertNodeToJSON() { 
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount;
        Account childAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        string CurrentAccountTopParentId = string.valueOf(parentAccount.id);
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('id', childAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController); 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser; 
        M2O_AccountHierarchyController.accountWrapper accountWrapper = new M2O_AccountHierarchyController.accountWrapper();
        accountWrapper.hasChildren = true;
        accountWrapper.accWrap = childAccount;   
        system.debug('accountWrapper >>>>>>>>>> '+ accountWrapper); 
        List<M2O_AccountHierarchyController.accountWrapper> accountWrapperList = new List<M2O_AccountHierarchyController.accountWrapper>();   
        accountWrapperList.add(accountWrapper);
        system.debug('accountWrapperList  >>>>>>>>>> '+ accountWrapperList); 
        System.runAs(runAsUser) {      
            test.startTest();
            JSONGenerator json = M2O_AccountHierarchyController.JSONGeneratorObj;
            accountHierarchyController.convertNodeToJSON(accountWrapperList);      
            test.stopTest();
        }
     }
     /**
    @Description: Here in this test method the convertNodeToJSONChild of the M2O_AccountHierarchyController is tested.
    @Return: null 
    **/
     static testMethod void  test_convertNodeToJSONChild() { 
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount;
        Account childAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        string CurrentAccountTopParentId = string.valueOf(parentAccount.id);
        childAccount = M2O_AccountContactTestDataUtility.getAccountTest2Records(regionData,parentAccount.id);
        insert childAccount;
        ApexPages.StandardController stdController = new ApexPages.StandardController(childAccount);
        System.currentPageReference().getParameters().put('id', childAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController); 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser; 
        M2O_AccountHierarchyController.accountWrapper accountWrapper = new M2O_AccountHierarchyController.accountWrapper();
        accountWrapper.hasChildren = true;
        accountWrapper.accWrap = childAccount;       
        System.runAs(runAsUser) {      
        test.startTest();
        accountHierarchyController.convertNodeToJSONChild(accountWrapper);      
        test.stopTest();
        }
    }
    
      /**
    @Description: Here in this test method the getHierarchy of the M2O_AccountHierarchyController is tested.
    @Return: null 
    **/
     static testMethod void  test_getHierarchy() { 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        ApexPages.StandardController stdController = new ApexPages.StandardController(parentAccount);
        System.currentPageReference().getParameters().put('id', parentAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController);
        System.runAs(runAsUser) {  
            test.startTest();
            accountHierarchyController.getHierarchy();      
            test.stopTest();
        }
     }
       /**
    @Description: Here in this test method the ExportToExcel of the M2O_AccountHierarchyController is tested.
    @Return: null 
    **/
     static testMethod void  test_ExportToExcel() { 
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account parentAccount;
        parentAccount = M2O_AccountContactTestDataUtility.getAccountTest1Records(regionData);
        insert parentAccount;
        ApexPages.StandardController stdController = new ApexPages.StandardController(parentAccount);
        System.currentPageReference().getParameters().put('id', parentAccount.id);
        M2O_AccountHierarchyController accountHierarchyController = new M2O_AccountHierarchyController(stdController); 
        System.runAs(runAsUser) {  
            PageReference exportToExcel;
            test.startTest();
            exportToExcel = accountHierarchyController.ExportToExcel();      
            test.stopTest();
        }
    }
}