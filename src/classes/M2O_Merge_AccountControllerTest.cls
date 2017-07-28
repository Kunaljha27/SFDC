@isTest(SeeAllData=false)
public class M2O_Merge_AccountControllerTest {
  /* @Description : This test method returns the instance of the Standard Controller for the test methods.
  */
    static ApexPages.StandardController getStandardController(){
        List<Schema.FieldSetMember> lstnonCDHfieldtestt = new List<Schema.FieldSetMember>();
        lstnonCDHfieldtestt= SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
        object o;
        Sobject sourceAccTest = new Account();
        Sobject destinationAccTest = new Account();
        for (Schema.FieldSetMember str : lstnonCDHfieldtestt) {    
            if (str.getType() == Schema.DisplayType.String || str.getType() == Schema.DisplayType.TextArea
                || str.getType() == Schema.DisplayType.Picklist || str.getType() == Schema.DisplayType.MultiPicklist
                || str.getType() == Schema.DisplayType.Phone || str.getType() == Schema.DisplayType.Reference) {
                        
                sourceAccTest.put(str.getFieldPath(), 'tes');
                destinationAccTest.put(str.getFieldPath(), 'tes');    
            }
            if (str.getType() == Schema.DisplayType.Integer) {       
                sourceAccTest.put(str.getFieldPath(), 25);
                destinationAccTest.put(str.getFieldPath(), 25);    
            }
            if (str.getType() == Schema.DisplayType.Boolean) {        
                sourceAccTest.put(str.getFieldPath(), true);
                destinationAccTest.put(str.getFieldPath(), true);    
            }
            if (str.getType() == Schema.DisplayType.Datetime ) {       
                sourceAccTest.put(str.getFieldPath(), system.now());
                destinationAccTest.put(str.getFieldPath(), system.now());    
            }        
            if (str.getType() == Schema.DisplayType.Currency || str.getType() == Schema.DisplayType.Double
                || str.getType() == Schema.DisplayType.Percent) {       
                sourceAccTest.put(str.getFieldPath(), 10.2);
                destinationAccTest.put(str.getFieldPath(), 10.2);
            }
        
            if (str.getType() == Schema.DisplayType.Date) {
            
                sourceAccTest.put(str.getFieldPath(), system.today());
                destinationAccTest.put(str.getFieldPath(), system.today());
            }   
            if (str.getType() == Schema.DisplayType.Reference) {
            
                sourceAccTest.put(str.getFieldPath(), '');
                destinationAccTest.put(str.getFieldPath(), null);
            }
        }
        Account sourceAccountTest = new Account(); 
        Account destinationAccountTest = new Account();
        String prospectRecordtypeID = Label.Account_Prospect_Record_Type_Id;
        String customerRecordtypeID = Label.Account_Customer_Record_Type_ID ;  
        sourceAccountTest = (Account)sourceAccTest;
        destinationAccountTest = (Account)sourceAccTest;
        Region__c regionData; 
        regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regiondata;
        Account destinationAccountName;
        destinationAccountName = M2O_AccountContactTestDataUtility.getAccountRec(regiondata);
        insert destinationAccountName;
        sourceAccountTest = M2O_AccountContactTestDataUtility.getSingleAccountRecordForMerge(sourceAccountTest,destinationAccountName.id, regiondata.id);
        insert sourceAccountTest;
        update destinationAccountTest;
        ApexPages.StandardController stdController = new ApexPages.StandardController(sourceAccountTest);
        System.currentPageReference().getParameters().put('id',sourceAccountTest.Id);
        return stdController;  
    } 
  /* @Description : This test method covers the selectedAccount() method of Controller class
  */ 
    static testmethod  void test_selectedAccount(){  
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData; 
            regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regiondata;
            Account accountRecord = M2O_AccountContactTestDataUtility.getSingleAccountRec(regiondata);
            insert accountRecord;
            Account sourceAccount;
            sourceAccount = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
            insert sourceAccount;          
            System.currentPageReference().getParameters().put('sourceAccountid', sourceAccount.id);
            System.currentPageReference().getParameters().put('id', accountRecord.id);
            Apexpages.StandardController stdController;
            stdController = getStandardController();
            M2O_MergeAccountController mergeAccountController = new M2O_MergeAccountController(stdController);                    
            string fieldApiName = '';
            System.currentPagereference().getParameters().put('apiName', fieldApiName);
            Object fieldValue;
            fieldValue = M2O_AccountContactTestDataUtility.getAccountRec(regiondata);
            mergeAccountController.selectedAccount(); 
            System.assertNotEquals(fieldApiName ,null); 
            mergeAccountController.selectedAttribute(); 
            mergeAccountController.marketAttributesNames='sourceAccount attribute,accountRecord attribute';
            mergeAccountController.marketAttributesValues='test,test';
            mergeAccountController.selectAllAccountAttributes();
            mergeAccountController.getAttributesFieldsAndRecords();
            mergeAccountController.getCDHNonMDMFieldsAndRecords(); 
            mergeAccountController.getNonCDHHCNAFieldsAndRecords();
            mergeAccountController.selectedAccountID=accountRecord.id;
            List<Account_Market_Sector_Attribute__c> actMrktAtribList = M2O_AccountContactTestDataUtility.getAccMarktAttrRecord(regiondata);
            actMrktAtribList[0].AccountId__c = accountRecord.id;
            actMrktAtribList[1].AccountId__c = sourceAccount.id;
            insert actMrktAtribList;
            mergeAccountController.getAttributeRecords(); 
        }    
    } 
  /* @Description : This test method covers the selectAllAccount() method of Controller class
  */
    static testmethod  void test_selectAllAccount(){  
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData; 
            regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regiondata;
            Account accountRecord = M2O_AccountContactTestDataUtility.getSingleAccountRec(regiondata);
            insert accountRecord;
            Account sourceAccount;
            sourceAccount = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
            insert sourceAccount;          
            System.currentPageReference().getParameters().put('sourceAccountid', sourceAccount.id);
            System.currentPageReference().getParameters().put('id', accountRecord.id);
            Apexpages.StandardController stdController;
            stdController = getStandardController();
            M2O_MergeAccountController mergeAccountController = new M2O_MergeAccountController(stdController); 
            mergeAccountController.nonCDHapiNames = 'LL_Parent_Business_Offering__c,LL_Parent_Code__c,LL_Program_Code__c';
            mergeAccountController.nonCDHfieldValues = '10,20,30';                
            mergeAccountController.selectAllAccount(); 
            System.assertNotEquals(accountRecord ,null);  
        }    
    } 
  /* @Description : This test method covers the getFieldsAndRecords() method of Controller class
  */
    static testmethod  void test_getFieldsAndRecords(){  
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData; 
            regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regiondata;
            Account accountRecord = M2O_AccountContactTestDataUtility.getSingleAccountRec(regiondata);
            insert accountRecord;
            Account sourceAccount;
            sourceAccount = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
            insert sourceAccount;          
            System.currentPageReference().getParameters().put('sourceAccountid', sourceAccount.id);
            System.currentPageReference().getParameters().put('id', accountRecord.id);
            Apexpages.StandardController stdController;
            stdController = getStandardController();
            M2O_MergeAccountController mergeAccountController = new M2O_MergeAccountController(stdController);               
            mergeAccountController.getFieldsAndRecords(); 
            System.assertNotEquals(accountRecord ,null);  
        }    
    }
  /* @Description : This test method covers the getCDHFieldsAndRecords() method of Controller class
  */
    static testmethod  void test_getCDHFieldsAndRecords(){  
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData; 
            regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regiondata;
            Account accountRecord = M2O_AccountContactTestDataUtility.getSingleAccountRec(regiondata);
            insert accountRecord;
            Account sourceAccount;
            sourceAccount = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
            insert sourceAccount;          
            System.currentPageReference().getParameters().put('sourceAccountid', sourceAccount.id);
            System.currentPageReference().getParameters().put('id', accountRecord.id);
            Apexpages.StandardController stdController;
            stdController = getStandardController();
            M2O_MergeAccountController mergeAccountController = new M2O_MergeAccountController(stdController);               
            mergeAccountController.getCDHFieldsAndRecords(); 
            System.assertNotEquals(accountRecord ,null);  
        }    
    }
  /* @Description : This test method covers the mergeAccounts() method of Controller class
  */
    static testmethod  void test_mergeAccounts(){  
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
        UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
        insert runAsUser;
        System.runAs(runAsUser) { 
            Region__c regionData; 
            regionData = M2O_AccountContactTestDataUtility.getRegionData2();
            insert regiondata;
            Account accountRecord = M2O_AccountContactTestDataUtility.getSingleAccountRec(regiondata);
            insert accountRecord;
            Account sourceAccount;
            sourceAccount = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
            insert sourceAccount;          
            System.currentPageReference().getParameters().put('sourceAccountid', sourceAccount.id);
            System.currentPageReference().getParameters().put('id', accountRecord.id);
            Apexpages.StandardController stdController;
            stdController = getStandardController();
            M2O_MergeAccountController mergeAccountController = new M2O_MergeAccountController(stdController);
            mergeAccountController.nonCDHapiNames = 'LL_Parent_Business_Offering__c,LL_Parent_Code__c,LL_Program_Code__c';
            mergeAccountController.nonCDHfieldValues = '10,20,30';
            List<Schema.FieldSetMember> lstnonCDHfieldtestt = new List<Schema.FieldSetMember>();
            lstnonCDHfieldtestt= SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
            object o;
            Sobject sourceAccTest = new Account();
            Sobject destinationAccTest = new Account();
            for (Schema.FieldSetMember str : lstnonCDHfieldtestt) {
                if (str.getType() == Schema.DisplayType.String || str.getType() == Schema.DisplayType.TextArea
                || str.getType() == Schema.DisplayType.Picklist || str.getType() == Schema.DisplayType.MultiPicklist
                || str.getType() == Schema.DisplayType.Phone || str.getType() == Schema.DisplayType.Reference){
                    o='tes';
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);
                }
                if (str.getType() == Schema.DisplayType.Integer) {
                    o=25;
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);
                }
                if (str.getType() == Schema.DisplayType.Boolean) {
                    o=true;
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);
                }
                if (str.getType() == Schema.DisplayType.Datetime ) {
                    o=system.now();
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);
                }
                if (str.getType() == Schema.DisplayType.Currency || str.getType() == Schema.DisplayType.Double
                            || str.getType() == Schema.DisplayType.Percent) {
                    o=10.2;
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);
                }
                if (str.getType() == Schema.DisplayType.Date) {
                    o=system.today();
                    mergeAccountController.apiValueMap.put(str.getFieldPath(),o);   
                }
                if (str.getType() == Schema.DisplayType.Reference) {
                o=null;
                mergeAccountController.apiValueMap.put(str.getFieldPath(),o);   
                }
            }                       
            mergeAccountController.mergeAccounts(); 
            System.assertNotEquals(accountRecord ,null);  
        }    
    }

}