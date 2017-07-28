/**
@Classname :       M2O_Merge_SearchAccountController
@Description :     This controller will be used by two VF pages: merge_searchAccount and merge_Account. This will merge two Accounts- Survivor Account 
                   and Victim Account.Once user searches and select survivor Account, he/she should have an option by clicking “Next” button to also 
                   select the not-CDH related fields (e.g. account information fields) & specify which all fields needs to be copied over to survivor 
                   account from victim account as these fields can be empty on the surviving account.
@Author:           Nitish Bansal
@Last Modified:    04/04/2014
**/

public class M2O_MergeSearchAccountController {
    public Boolean hasDisplayRecords {get; set;}
    public String selectedAccountID {get; set;}
    public ApexPages.StandardSetController setPaginationSelectedAccounts {get; set;}
    public String sourceAccountName {get; set;}
    public List<Account> destinationAccountRecords {get; set;}
    public List<Schema.FieldSetMember> fieldResult {get; set;}   
    public String destinationAccountName;    
    public String sourceAccountID;
    @TestVisible private List<Schema.FieldSetMember> nonCDHfieldList = new List<Schema.FieldSetMember>();
    @TestVisible private Map<String, Schema.FieldSetMember> fieldSchemaMap = new Map<String, Schema.FieldSetMember>();
    @TestVisible private Map<id, Account> sourceAccountRecordsMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> destinationAccountRecordsMap = new Map<id, Account>();
    @TestVisible private String sourceAccountQuery;
    @TestVisible private String destinationAccountQuery;
    @TestVisible private Account sourceAccountRecord = new Account();    
    @TestVisible private String queriableFields;
    @TestVisible private Set<Id> setAccRecordTypeId = new Set<Id>();
    
    /**Description: Controller method. Retrieve the fields that is going to be searched on from the fieldSet. Creates dynamic query which 
                    will be used to query the Source Account and Destination  Account
       Return:      Null
    **/    
    public M2O_MergeSearchAccountController(ApexPages.StandardController controller) {
        hasDisplayRecords = false;
        nonCDHfieldList = SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
        queriableFields = '';
        for (Schema.FieldSetMember sf : nonCDHfieldList) {        
            fieldSchemaMap.put(sf.getFieldPath(), sf);
            if (queriableFields == null || queriableFields =='') {
                queriableFields = sf.getFieldPath() + ',';   
            }
            else {
                queriableFields += sf.getFieldPath() + ',';   
            }
         } 
         
        sourceAccountID = ApexPages.currentPage().getParameters().get('Id');
        setAccRecordTypeId.add(Label.Account_Prospect_Record_Type_Id);
        setAccRecordTypeId.add(Label.Account_Customer_Record_Type_ID); 
        setAccRecordTypeId.add(Label.Account_Influencer_Record_Type_Id);
        setAccRecordTypeId.add(Label.Account_Indirect_Customer_Id);
        sourceAccountQuery = 'SELECT recordtypeId, recordtype.name, name,' + queriableFields + 'id FROM Account WHERE id =\''+ sourceAccountID+'\'' ;
        sourceAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(sourceAccountQuery);
        
        if(sourceAccountRecord != Null){
            sourceAccountRecordsMap.put(sourceAccountRecord.id, sourceAccountRecord);
            sourceAccountName = sourceAccountRecord.name;
        }                                                                   
    }
    
    /**
    @Description: Retrive the fields that will be searched from the field set
    @Return: Searchable Fields
    **/
    public List<Schema.FieldSetMember> getSearchFields() {    
        return SObjectType.Account.FieldSets.Search_fields_for_Merge_Account.getFields();
    }
    
    /**
    @Description: Funtion to search selecte account
    @Return: Searched account
    **/ 
    public Account searchedAccount {    
        get{
            if (searchedAccount== null)
                searchedAccount= new Account();
            return searchedAccount;
        }
       set;
    }  
    
    /**
    @Description: Search Accounts based on the search parameters
    @Return: Null
    **/    
    public pageReference findAccounts() {
        destinationAccountRecords = new List<Account>();
        String searchstring = '';
        fieldResult = new List<Schema.FieldSetMember>();
        fieldResult = SObjectType.Account.FieldSets.Display_search_results_for_Merge_Account.getFields(); 
        String queryforDisplayingResult;
        queryforDisplayingResult = '';
        if(fieldResult != Null && !fieldResult.isEmpty()){
            for (Schema.FieldSetMember sf : fieldResult) {        
                queryforDisplayingResult += sf.getFieldPath() + ', ';            
            }
        }
        destinationAccountQuery = 'SELECT recordtype.name, ' +  queryforDisplayingResult + ' Id FROM Account WHERE recordtypeId in :setAccRecordTypeId ' ;         
        if(getSearchFields() != Null && !getSearchFields().isEmpty()){
            for (Schema.FieldSetMember f : getSearchFields()) {        
                 if (searchedAccount.get(f.getfieldPath())!=null && f.getfieldPath()=='Account_Name__c' ) {
                     searchstring ='%' + (searchedAccount.get(f.getfieldPath())) + '%';
                     if(searchedAccount.get(f.getfieldPath())=='*') {
                         searchstring ='%' + '' + '%';
                     }    
                     destinationAccountQuery +=  'AND name LIKE\'' + String.escapeSingleQuotes(searchstring) + '\'';
                 }
                 else if (searchedAccount.get(f.getfieldPath())!=null && f.getfieldPath()=='Street__c' ) {
                     searchstring ='%' + (searchedAccount.get(f.getfieldPath())) + '%';
                     destinationAccountQuery +=  'AND Street__c LIKE\'' + String.escapeSingleQuotes(searchstring) + '\'';
                 }
                 else if (searchedAccount.get(f.getfieldPath())!=null && f.getfieldPath()=='Street__c' ) {
                     searchstring ='%' + (searchedAccount.get(f.getfieldPath())) + '%';
                     destinationAccountQuery +=  'AND Street__c LIKE\'' + String.escapeSingleQuotes(searchstring) + '\'';
                 }
                 
                 else if (searchedAccount.get(f.getfieldPath())!=null && f.getfieldPath()=='SFDC_Record_Id__c' ) {
                     searchstring ='%' + (searchedAccount.get(f.getfieldPath())) + '%';
                     destinationAccountQuery +=  'AND Account_Internal_ID__c LIKE\'' + String.escapeSingleQuotes(searchstring) + '\'';
                 }
                 else if (searchedAccount.get(f.getfieldPath())!=null) {
                     destinationAccountQuery += ' AND ' + f.getfieldPath() + ' =\''+searchedAccount.get(f.getfieldPath()) + '\'';
                 }
            }
        }
        destinationAccountQuery += ' AND Inactive_Flag__c=false LIMIT 1000'; 
        destinationAccountRecords = M2O_MergeAccountService.getDestinationAccount(setAccRecordTypeId, destinationAccountQuery); 
        if(destinationAccountRecords != Null && !destinationAccountRecords.isEmpty()) {
            if(destinationAccountRecords.size() == 1000) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'Search Results are more than 1000, so please give precise Account name')); 
            }             
            for (Account a : destinationAccountRecords) {             
                destinationAccountRecordsMap.put(a.id, a);                        
            }
            hasDisplayRecords = true;
            setPaginationSelectedAccounts = new ApexPages.StandardSetController(destinationAccountRecords);
            setPaginationSelectedAccounts.setPageSize(integer.ValueOf(10));
        }  
        else{
            hasDisplayRecords = false;
        }          
        return null;        
    }
    
    /**
    @Description: Paginiation for the fields returned after search
    @Return:      The list of Accounts after pagination
    **/    
    public list<Account> getlistPaginatedAccount() {    
        List<Account> listPaginatedAccount = new List<Account>();
            for (Account SObj :(List<Account>)setPaginationSelectedAccounts.getRecords()) {            
                 listPaginatedAccount.add(SObj);
            }
        return listPaginatedAccount;
    }
       
    
    /**
    @Description: Navigates to the next page where the user will select the value for copying into Survivor Account. 
    @Return:      Null
    **/
    public pageReference next() {
        if (selectedAccountID != null && selectedAccountID != '') { 
            string selectedAccountIDtrimmed=selectedAccountID.substring(0, 15); 
            if (sourceAccountRecord.Id == selectedAccountID) {
                ApexPages.Message mergeAccountItself = new ApexPages.Message(ApexPages.Severity.ERROR,'You cannot merge an Account with itself.');
                ApexPages.addMessage(mergeAccountItself);
                return null;
            }
            else if (sourceAccountRecordsMap.get(sourceAccountID).RecordtypeId == Label.Account_Customer_Record_Type_ID && (
                destinationAccountRecordsMap.get(selectedAccountID).RecordtypeID == Label.Account_Prospect_Record_Type_Id ||
                destinationAccountRecordsMap.get(selectedAccountID).RecordtypeID == Label.Account_Influencer_Record_Type_Id ||
                destinationAccountRecordsMap.get(selectedAccountID).RecordtypeID == Label.Account_Indirect_Customer_Id)) {
                ApexPages.Message mergeCustomerProspect = 
                                new ApexPages.Message(ApexPages.Severity.ERROR, M2O_DataUtility.cannotMergeString+ M2O_DataUtility.spaceVal + destinationAccountRecordsMap.get(selectedAccountID).Recordtype.Name + M2O_DataUtility.spaceVal + M2O_DataUtility.accountObjectVal);
                ApexPages.addMessage(mergeCustomerProspect);
                return null;
            }
            else{
                destinationAccountName = destinationAccountRecordsMap.get(selectedAccountID).name;
                PageReference mergeAccountPage = Page.merge_Account;
                mergeAccountPage.getParameters().put(M2O_DataUtility.recordId, selectedAccountID);
                mergeAccountPage.getParameters().put(M2O_DataUtility.sourceAccountid, sourceAccountID);
                mergeAccountPage.setRedirect(true);
                return mergeAccountPage;
            }
        }    
        else{
            ApexPages.Message selectAccount= new ApexPages.Message(ApexPages.Severity.ERROR, M2O_DataUtility.selectAccountToMergeString);
            ApexPages.addMessage(selectAccount);
            return null;   
        }
    }        
}