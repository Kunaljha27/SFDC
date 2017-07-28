/**
@Classname :       M2O_MergeSearchAccountControllerTest
@Description :     This test class is written to test the Apex class M2O_MergeSearchAccountController. 
@Author:           Ruchika Patil
@Last Modified:    18/3/2014
**/
@isTest(SeeAllData=false)
public class M2O_MergeSearchAccountControllerTest {
    static testMethod void searchAcc() {
        List<Schema.FieldSetMember> lstnonCDHfieldtestt = new List<Schema.FieldSetMember>();
        lstnonCDHfieldtestt= SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
        object o;
        Sobject sourceAccTest = new Account();
        Sobject destinationAccTest = new Account();
        for (Schema.FieldSetMember str : lstnonCDHfieldtestt) {    
            if (str.getType() == Schema.DisplayType.String || str.getType() == Schema.DisplayType.TextArea
                || str.getType() == Schema.DisplayType.Picklist || str.getType() == Schema.DisplayType.MultiPicklist
                || str.getType() == Schema.DisplayType.Phone || str.getType() == Schema.DisplayType.Reference) {
        
                sourceAccTest.put(str.getFieldPath(), 'test');
                destinationAccTest.put(str.getFieldPath(), 'test');
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
        }
        Account sourceAccountTest = new Account(); 
        Account destinationAccountTest = new Account();
        String prospectRecordtypeID = Label.Account_Prospect_Record_Type_Id;
        String customerRecordtypeID = Label.Account_Customer_Record_Type_ID ;  
        sourceAccountTest = (Account)sourceAccTest;
        destinationAccountTest = (Account)sourceAccTest;
        Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        sourceAccountTest = M2O_AccountContactTestDataUtility.getSingleAccountRecord(regionData);
        insert sourceAccountTest; 
        Account destinationAccountName;
        destinationAccountName = M2O_AccountContactTestDataUtility.getAccountRec(regiondata);
        insert destinationAccountName;  
        destinationAccountTest = (Account)destinationAccTest;
        destinationAccountTest.Destination_Account_Name__c = destinationAccountName.id;
        destinationAccountTest.EHR_Vendor__c = null;
        destinationAccountTest.IHN__c = null;
        destinationAccountTest.RecordtypeId = prospectRecordtypeID;
        destinationAccountTest.name = 'Sony World';
        destinationAccountTest.Street1_Local__c='test';
        destinationAccountTest.Housenumber_Local__c = 'test1';
        destinationAccountTest.Country__c = 'India';
        destinationAccountTest.Region__c = regionData.id;
        destinationAccountTest.Zip_Postal_Code_Local__c = '234';
        destinationAccountTest.City_Local__c='test';
        destinationAccountTest.Region_global__c=null;
        destinationAccountTest.Banner_Id__c='abc';
        insert destinationAccountTest;
        ApexPages.StandardController controller4=new ApexPages.StandardController(sourceAccountTest);
        System.currentPageReference().getParameters().put('id',sourceAccountTest.Id);
        M2O_MergeSearchAccountController testMergeAccount = new M2O_MergeSearchAccountController(controller4);
        M2O_UserTestDataUtility testUserDataUtility = new M2O_UserTestDataUtility();
        testMergeAccount.getSearchFields();
        testMergeAccount.searchedAccount.name = 'Sony';     
        testMergeAccount.selectedAccountID = '';   
        testMergeAccount.findAccounts();
        testMergeAccount.next();
        testMergeAccount.selectedAccountID = destinationAccountTest.id;  
        testMergeAccount.destinationAccountRecordsMap.put(destinationAccountTest.id,destinationAccountTest); //
        testMergeAccount.destinationAccountRecordsMap.put(sourceAccountTest.id,sourceAccountTest); //
        testMergeAccount.next();
        destinationAccountTest = (Account)destinationAccTest;
        destinationAccountTest.RecordtypeId = prospectRecordtypeID;
        destinationAccountTest.Destination_Account_Name__c = destinationAccountName.id;
        destinationAccountTest.EHR_Vendor__c = null;
        destinationAccountTest.IHN__c = null;
        destinationAccountTest.name = 'Sony World';
        destinationAccountTest.Street1_Local__c='test';
        destinationAccountTest.Housenumber_Local__c = 'test1';
        destinationAccountTest.Country__c = 'India';
        destinationAccountTest.Region__c = regionData.id;
        destinationAccountTest.Zip_Postal_Code_Local__c = '234';
        destinationAccountTest.City_Local__c='test';
        update destinationAccountTest;
        testMergeAccount.selectedAccountID = destinationAccountTest.id;
        testMergeAccount.findAccounts();
        testMergeAccount.destinationAccountRecordsMap.put(destinationAccountTest.id,destinationAccountTest); //
        testMergeAccount.destinationAccountRecordsMap.put(sourceAccountTest.id,sourceAccountTest); //
        testMergeAccount.next();
        destinationAccountTest.RecordtypeId = customerRecordtypeID;
        update destinationAccountTest;
        testMergeAccount.findAccounts();
        testMergeAccount.selectedAccountID = destinationAccountTest.id; 
        testMergeAccount.searchedAccount.Street1_Local__c = 'test1';
        testMergeAccount.searchedAccount.Account_Name__c = 'test123';
        testMergeAccount.searchedAccount.Street1__c = 'test123';
        testMergeAccount.searchedAccount.Housenumber_Local__c = 'test1'; 
        testMergeAccount.searchedAccount.SFDC_Record_Id__c = '123';
        testMergeAccount.findAccounts();
        testMergeAccount.getlistPaginatedAccount(); 
        testMergeAccount.next();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2ODataManagementProfileId();           
        User testUser1= M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.id);
        insert testUser1;
        AccountTeamMember atm = new AccountTeamMember();
        atm.UserId = testUser1.id;
        atm.AccountId = sourceAccountTest.id;
        insert atm;
        sourceAccountTest.RecordtypeId = prospectRecordtypeID;
        update sourceAccountTest;
        destinationAccountTest.RecordtypeId = prospectRecordtypeID;
        update destinationAccountTest;
        testMergeAccount.selectedAccountID = destinationAccountTest.id;
        testMergeAccount.getlistPaginatedAccount();
        testMergeAccount.next();
        testMergeAccount.selectedAccountID = sourceAccountTest.id;
        testMergeAccount.next();
     }
}