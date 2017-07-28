@isTest(SeeAllData=false)
public class M2O_Merge_SearchAccountControllerTest {
/*static testMethod void searchAcc() {

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
        destinationAccTest.put(str.getFieldPath(), 'testValues');

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
sourceAccountTest.RecordtypeId = customerRecordtypeID;
sourceAccountTest.name = 'Sony';
sourceAccountTest.Street1_Local__c='test';
sourceAccountTest.City_Local__c='test';
insert sourceAccountTest;
update destinationAccountTest;
ApexPages.StandardController controller4=new ApexPages.StandardController(sourceAccountTest);
System.currentPageReference().getParameters().put('id',sourceAccountTest.Id);
M2O_Merge_SearchAccountController testMergeAccount = new M2O_Merge_SearchAccountController(controller4);
testMergeAccount.getSearchFields();
testMergeAccount.searchedAccount.name = 'Sony';
testMergeAccount.selectedAccountID = '';   
testMergeAccount.findAccounts();
testMergeAccount.next();
testMergeAccount.selectedAccountID = destinationAccountTest.id;   
testMergeAccount.next();
destinationAccountTest = (Account)destinationAccTest;
destinationAccountTest.RecordtypeId = prospectRecordtypeID;
destinationAccountTest.name = 'Sony World';
destinationAccountTest.Street1_Local__c='test';
destinationAccountTest.City_Local__c='test';
insert destinationAccountTest;
testMergeAccount.selectedAccountID = destinationAccountTest.id;
testMergeAccount.findAccounts();
//testMergeAccount.next();
destinationAccountTest.RecordtypeId = customerRecordtypeID;
update destinationAccountTest;
testMergeAccount.findAccounts();
testMergeAccount.selectedAccountID = destinationAccountTest.id;
testMergeAccount.getpaginatedlstAccount();
//testMergeAccount.next();
//testMergeAccount.getFieldsAndRecords();
//testMergeAccount.selectedAccount();

for (Schema.FieldSetMember str : lstnonCDHfieldtestt) {
    if (str.getType() == Schema.DisplayType.String || str.getType() == Schema.DisplayType.TextArea
        || str.getType() == Schema.DisplayType.Picklist || str.getType() == Schema.DisplayType.MultiPicklist
        || str.getType() == Schema.DisplayType.Phone || str.getType() == Schema.DisplayType.Reference){
        o='test';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Integer) {
        o=25;
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Boolean) {
        o=true;
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Datetime ) {
        o=system.now();
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);
    }
    if (str.getType() == Schema.DisplayType.Currency || str.getType() == Schema.DisplayType.Double
                        || str.getType() == Schema.DisplayType.Percent) {
        o=10.2;
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);
    }

    if (str.getType() == Schema.DisplayType.Date) {
        o=system.today();
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);   
    }
}

Profile p = [select id from profile where name='System Administrator']; 
User testUser1 = new User(alias = 'u1', email='u1@testorg.com', IsActive = true, emailencodingkey='UTF-8', 
        lastname='Testing1', languagelocalekey='en_US', localesidkey='en_US', profileid = p.Id, 
        country='United States', timezonesidkey='America/Los_Angeles', username='u1@testorg123.com'); 
insert testUser1;
AccountTeamMember atm = new AccountTeamMember();
atm.UserId = testUser1.id;
atm.AccountId = sourceAccountTest.id;
insert atm;
//testMergeAccount.mergeAccounts();
sourceAccountTest.RecordtypeId = prospectRecordtypeID;
update sourceAccountTest;
destinationAccountTest.RecordtypeId = prospectRecordtypeID;
update destinationAccountTest;
testMergeAccount.selectedAccountID = destinationAccountTest.id;
//testMergeAccount.getpaginatedlstAccount();
//testMergeAccount.next();
//testMergeAccount.getFieldsAndRecords();
//testMergeAccount.selectedAccount();
//testMergeAccount.mergeAccounts();
for (Schema.FieldSetMember str : lstnonCDHfieldtestt) {
    if (str.getType() == Schema.DisplayType.String || str.getType() == Schema.DisplayType.TextArea
        || str.getType() == Schema.DisplayType.Picklist || str.getType() == Schema.DisplayType.MultiPicklist
        || str.getType() == Schema.DisplayType.Phone || str.getType() == Schema.DisplayType.Reference){
        o='';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Integer) {
        o='';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Boolean) {
        o='';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);

    }
    if (str.getType() == Schema.DisplayType.Datetime ) {
        o=system.now();
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);
    }
    if (str.getType() == Schema.DisplayType.Currency || str.getType() == Schema.DisplayType.Double
                        || str.getType() == Schema.DisplayType.Percent) {
        o='';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);
    }

    if (str.getType() == Schema.DisplayType.Date) {
        o='';
        testMergeAccount.mapApiValue.put(str.getFieldPath(),o);   
    }
}
//testMergeAccount.mergeAccounts();
}*/
}