/**
@Classname :       M2O_Merge_SearchAccountController
@Description :     This controller will be used by two VF pages: merge_searchAccount and merge_Account. This will merge two Accounts- Survivor Account 
                   and Victim Account.Once user searches and select survivor Account, he/she should have an option by clicking “Next” button to also 
                   select the not-CDH related fields (e.g. account information fields) & specify which all fields needs to be copied over to survivor 
                   account from victim account as these fields can be empty on the surviving account.
@Author:           Piyali Saha
@Last Modified:    23/08/2013
**/

public class M2O_Merge_SearchAccountController {
/*public Boolean displayRecords                                                           {get; set;}
public String selectedAccountID                                                         {get; set;}
public String sourceAccountID                                                           {get; set;}
@TestVisible List<M20_AccountRecordWrapper> lstAccountRecordWrapperValue                {get; set;}
public ApexPages.StandardSetController setPaginationSelectedAccounts                    {get; set;}
public String sourceAccountName                                                         {get; set;}
public String destinationAccountName                                                    {get; set;}
public List<Schema.FieldSetMember> fieldResult                                          {get; set;}
@TestVisible List<Schema.FieldSetMember> lstnonCDHfield = new List<Schema.FieldSetMember>();
@TestVisible Map<String, Schema.FieldSetMember> mapFieldSchema = new Map<String, Schema.FieldSetMember>();
@TestVisible Map<String, Object> mapApiValue = new Map<String, Object>();
@TestVisible Map<id, Account> mapSourceAccountRecords = new Map<id, Account>();
@TestVisible Map<id, Account> mapDestinationAccountRecords = new Map<id, Account>();
@TestVisible String sourceAccountQuery;
@TestVisible String destinationAccountQuery;
@TestVisible Account sourceAccountRecord = new Account();
@TestVisible public List<Account> destinationAccountRecords                                     {get; set;}
@TestVisible String queriableFields;
@TestVisible List<Related_Object_of_Account__c> lstRelatedObjects = new  List<Related_Object_of_Account__c>();
@TestVisible Set<Id> setAccRecordTypeId = new Set<Id>();*/
    
    /**Description: Controller method. Retrieve the fields that is going to be searched on from the fieldSet. Creates dynamic query which 
                    will be used to query the Source Account and Destination  Account
       Return:      Null
    **/
    
    /*public M2O_Merge_SearchAccountController(ApexPages.StandardController controller) {   
       
       displayRecords = false;
        lstnonCDHfield = SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
        queriableFields = '';
        for (Schema.FieldSetMember sf : lstnonCDHfield) {
        
            mapFieldSchema.put(sf.getFieldPath(), sf);
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
        sourceAccountQuery = 'SELECT recordtypeId, recordtype.name, name,' + queriableFields + 'id FROM Account WHERE id =: sourceAccountID' ;
        sourceAccountRecord = Database.query(sourceAccountQuery);
        mapSourceAccountRecords.put(sourceAccountRecord.id, sourceAccountRecord);
        sourceAccountName = sourceAccountRecord.name;
                                                                           
    }*/
    
    /**
    @Description: Retrive the fields that will be searched from the field set
    @Return: Searchable Fields
    **/
    
   /* public List<Schema.FieldSetMember> getSearchFields() {
    
        return SObjectType.Account.FieldSets.Search_fields_for_Merge_Account.getFields();
        
    }
    
     
    public Account searchedAccount {
    
        get{
            if (searchedAccount== null)
                searchedAccount= new Account();
                return searchedAccount;
        }
       set;
       
    }  */
    
    /**
    @Description: Search Accounts based on the search parameters
    @Return: Accounts that satisfy the searched parameters
    **/
    
    /* public pageReference findAccounts() {
        destinationAccountRecords = new List<Account>();
        String searchstring;
        searchstring ='';
        fieldResult = new List<Schema.FieldSetMember>();
        fieldResult = SObjectType.Account.FieldSets.Display_search_results_for_Merge_Account.getFields(); 
        String queryforDisplayingResult;
        queryforDisplayingResult = '';
        for (Schema.FieldSetMember sf : fieldResult) {
        
            queryforDisplayingResult += sf.getFieldPath() + ', ';
            
        }
        destinationAccountQuery = 'SELECT ' + queriableFields  + queryforDisplayingResult + ' Id FROM Account WHERE recordtypeId in: setAccRecordTypeId ';         
        
        for (Schema.FieldSetMember f : getSearchFields()) {
        
             if (searchedAccount.get(f.getfieldPath())!=null && f.getfieldPath()=='name' ) {
                 searchstring ='%' + (searchedAccount.get(f.getfieldPath())) + '%';
                 destinationAccountQuery +=  'AND name LIKE\'' + String.escapeSingleQuotes(searchstring) + '\'';
             }
             else if (searchedAccount.get(f.getfieldPath())!=null) {
                 destinationAccountQuery += ' AND ' + f.getfieldPath() + ' =\''+searchedAccount.get(f.getfieldPath()) + '\'';
             }
             
        }
        destinationAccountQuery += ' LIMIT 1000';                
        destinationAccountRecords = Database.query(destinationAccountQuery); 
        if(destinationAccountRecords.size() ==1000) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'Search Results are more than 1000, so please give precise Account name')); 
        }   
                             
        for (Account a : destinationAccountRecords) { 
                 
            
            mapDestinationAccountRecords.put(a.id, a);
                        
        }
        if (destinationAccountRecords.size()>0) {
            displayRecords = true;
        }
        setPaginationSelectedAccounts = new ApexPages.StandardSetController(destinationAccountRecords);
        setPaginationSelectedAccounts.setPageSize(integer.ValueOf(10));            
        return null;
        
    }*/
    
    /**
    @Description: Paginiation for the fields returned after search
    @Return:      The list of Accounts after pagination
    **/
    
   /* public list<Account> getpaginatedlstAccount() {
    
        List<Account> paginatedlstAccount = new List<Account>();
            for (Account SObj :(List<Account>)setPaginationSelectedAccounts.getRecords()) {
            
                 paginatedlstAccount.add(SObj);
                 
            }
        return paginatedlstAccount;   
        
    }*/
    
    /**
    @Description: Populates the value in a map selected by the user for the non-CDH fields.
    @Return:      Null
    **/
    
   /* public void selectedAccount() {       
     
          String fieldApiName = System.currentPagereference().getParameters().get('apiName');
          Object fieldValue = (Object)System.currentPagereference().getParameters().get('selectedValue');
          system.debug('Field API Name'+fieldApiName );
          mapApiValue.put(fieldApiName, fieldValue);
          System.debug('Value in the map having apiname and its value'+mapApiValue);
          
    }*/
    
    /**
    @Description: Navigates to the next page where the user will select the value for copying into Survivor Account. 
    @Return:      Null
    **/
    
    /* public pageReference next() {  
                      
        system.debug('selected account ID'+selectedAccountID);
        system.debug('Source Account ID'+sourceAccountID );
        if (selectedAccountID != null && selectedAccountID != '') {      
            string selectedAccountIDtrimmed=selectedAccountID.substring(0, 15); 
            if (sourceAccountRecord.Id== selectedAccountID) {
                ApexPages.Message mergeAccountItself = new ApexPages.Message(ApexPages.Severity.ERROR,'You cannot merge an Account with itself.');
                ApexPages.addMessage(mergeAccountItself);
                return null;
            }
            else if (mapSourceAccountRecords!=null && mapDestinationAccountRecords!=null && mapSourceAccountRecords.get(sourceAccountID).RecordtypeID == Label.Account_Customer_Record_Type_ID &&
                mapDestinationAccountRecords.get(selectedAccountID).RecordtypeID == Label.Account_Prospect_Record_Type_Id) {
                ApexPages.Message mergeCustomerProspect = 
                                new ApexPages.Message(ApexPages.Severity.ERROR,'You cannot merge a Customer Account with Prospect Account.');
                ApexPages.addMessage(mergeCustomerProspect);
                return null;
            }
            else if(mapDestinationAccountRecords !=null){
                destinationAccountName = mapDestinationAccountRecords.get(selectedAccountID).name;
                return Page.merge_Account;
            }
        }    
        else{
            ApexPages.Message selectAccount= new ApexPages.Message(ApexPages.Severity.ERROR,'Kindly select an Account to merge.');
            ApexPages.addMessage(selectAccount);
            return null;   
        }
        return null; 
    }*/
    
    /**
    @Description: Retrieve the values for the Survivor Account and Victim Account
    @Return:      The value of the non- CDH field in both Survivor and Victim Account.
    **/
    
    /*public List<M20_AccountRecordWrapper> getFieldsAndRecords() {
        
        lstAccountRecordWrapperValue = new List<M20_AccountRecordWrapper>();        
        for (String nonCDHFields : mapFieldSchema.keySet()) {        
            
            Sobject source = mapSourceAccountRecords.get(sourceAccountID);
            Object sourceValue = (Object)source.get(nonCDHFields);
            Sobject destination = mapDestinationAccountRecords.get(selectedAccountID);
            Object destinationValue = (Object)destination.get(nonCDHFields);
            system.debug('value in Field schema'+nonCDHFields);
            String srcVal;
            String destVal;
            if (sourceValue!=null || sourceValue!='')
                srcVal = String.valueOf(sourceValue);
            if (destinationValue!=null || destinationValue!='')
                destVal = String.valueOf(destinationValue);   
            
            system.debug('Source Account Value'+srcVal);
           
            M20_AccountRecordWrapper accvalue = new M20_AccountRecordWrapper(mapFieldSchema.get(nonCDHFields).getLabel(), 
                                                                                nonCDHFields, srcVal, destVal);              
            lstAccountRecordWrapperValue.add(accvalue);     
                  
        }
        system.debug('Value in Wrapper class'+lstAccountRecordWrapperValue);
        lstAccountRecordWrapperValue.sort();
        return lstAccountRecordWrapperValue;
        
    }*/
    
    /**
    @Description: Merging of two Accounts will take place. Victim Account(Prospect Account) will be deleted. Victim Account(Customer Account) will be
                  made inactive. Survivor Account will be updated with the value selected by the user. All the values in the related objects will be
                  copied from Victim Account to Survivor Account.
    @Return:      Redirects to the Survivor Account's detail page.
    **/
    
   /* public pageReference mergeAccounts() {
    Boolean error;
    error = false;
        Boolean customerAcc = false; 
        if (mapSourceAccountRecords.get(sourceAccountID).recordtypeId == Label.Account_Customer_Record_Type_ID) {
            customerAcc = true;
        }
        Account destAcc = new Account();
        Account sourceAcc = new Account();
        Sobject sObj = new Account();
        sObj.id = selectedAccountID;
        for (String str : mapApiValue.keySet()) {                    
            
            System.debug('Sobject value'+sObj);
            try{
            
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.String 
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.TextArea
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.Picklist 
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.MultiPicklist
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.Phone 
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.Reference) {
                    if (mapApiValue.get(str)!= '') {
                        String val = String.valueOf(mapApiValue.get(str));
                        sObj.put(str, val);  
                    }
                    else
                        sObj.put(str, mapFieldSchema.get(str));  
                }
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.Integer) {
                    if (mapApiValue.get(str)!= '') {
                        Integer val = Integer.valueOf(mapApiValue.get(str));
                        sObj.put(str, val);    
                    }
                    else
                        sObj.put(str, mapFieldSchema.get(str)); 
                }
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.Boolean) {
                    if (mapApiValue.get(str)!= '') {
                        Boolean val = Boolean.valueOf(mapApiValue.get(str));
                        sObj.put(str, val);    
                    }
                    else
                        sObj.put(str, mapFieldSchema.get(str)); 
                }
               
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.Datetime ) {
                    if (mapApiValue.get(str)!= '') {
                        Datetime val = Datetime.valueOf(mapApiValue.get(str));
                        sObj.put(str, val);    
                    }
                    else
                        sObj.put(str, mapFieldSchema.get(str)); 
                }                
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.Currency 
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.Double
                    || mapFieldSchema.get(str).getType() == Schema.DisplayType.Percent) {
                    if (mapApiValue.get(str)!= '') {
                        System.debug('doubleeeeeee'+mapApiValue.get(str));
                        Double val = Double.valueOf(mapApiValue.get(str));
                        sObj.put(str, val); 
                    }  
                    else
                        sObj.put(str, mapFieldSchema.get(str)); 
                }
            }
            
            catch(Exception e) {
            
                system.debug('Error due to type casting'+e.getMessage());
                error = true;
                system.debug('Error message'+e);
                
            }
            try{
            
                if (mapFieldSchema.get(str).getType() == Schema.DisplayType.Date) {
                    if (mapApiValue.get(str)!= '') {
                        String dte = String.valueOf(mapApiValue.get(str));
                        String str1 = dte.substring(0, dte.indexOf(' '));
                        Date val = date.valueOf(str1);
                        sObj.put(str, val);    
                    }
                    else
                        sObj.put(str, mapFieldSchema.get(str)); 
                    
                }
                
            }
            catch(Exception e) {
            
                ApexPages.Message selectAccount= new ApexPages.Message(ApexPages.Severity.ERROR,+'Date fied cannot be left blank');
                ApexPages.addMessage(selectAccount);
                error = true;
                system.debug('Error message'+e);
                
            }
        }                 
        String mergeHistoryTracking = mapSourceAccountRecords.get(sourceAccountID).name +' is merged with ' + 
                                      mapDestinationAccountRecords.get(selectedAccountID).name;
        sObj.put('Account_Merged__c', mergeHistoryTracking);
        destAcc = (Account)sObj;                 
        sourceAcc.id = sourceAccountID;
        String relatedObjectQuery  = '';
        lstRelatedObjects  = Related_Object_of_Account__c.getall().values();
        for (Related_Object_of_Account__c relObj : lstRelatedObjects) {
        
            relatedObjectQuery += '(SELECT id FROM ' + relObj.API_Name__c + '),';  
            
        }          
        relatedObjectQuery = 'SELECT ' + relatedObjectQuery + 'id FROM Account WHERE id=:sourceAccountID' ;                  
        system.debug('queryyyyyyy'+relatedObjectQuery);
        
        SObject queryParentObject = Database.query(relatedObjectQuery);
        system.debug('queryyyyyyy'+queryParentObject);   
        Schema.DescribeSObjectResult R = Account.sObjectType.getDescribe();
        List<Schema.ChildRelationship> C = R.getChildRelationships();
        Map<String, String> mapObjFieldAPI = new Map<String, String>();
        for (Schema.ChildRelationship sc : C) {
        
            mapObjFieldAPI.put(String.valueOf(sc.getRelationshipName()), String.valueOf(sc.getField()));
            
        }     
        system.debug('queryyyyyyy'+mapObjFieldAPI);      
        List<Sobject> lstSObj = new List<Sobject>();        
        List<AccountTeamMember> lstAccTeamMember = new List<AccountTeamMember>();
        List<AccountShare> lstAccShare = new List<AccountShare>();
        Map<id, AccountShare> mapUserIdAccShare = new Map<id, AccountShare>();
    
        lstAccShare = [SELECT AccountAccessLevel, AccountId, CaseAccessLevel, ContactAccessLevel, OpportunityAccessLevel, RowCause, UserOrGroupId
                       FROM AccountShare 
                       WHERE AccountId =: sourceAccountID];
                       system.debug('Acc share'+lstAccShare );
        for(AccountShare accShare : lstAccShare) {
            mapUserIdAccShare.put(accShare.UserOrGroupId , accShare);
        }
        List<AccountShare> newAccShare = new List<AccountShare>();
        
        lstAccTeamMember = [SELECT UserId, User.Id, User.IsActive, AccountId, TeamMemberRole
                            FROM AccountTeamMember 
                            WHERE AccountId =:sourceAccountID];
        List<AccountTeamMember> lstInsertAccTeam = new List<AccountTeamMember>();
        for (AccountTeamMember accTeamMem : lstAccTeamMember) {
        
           if (accTeamMem.User.IsActive == true) {
               AccountTeamMember ateam = new AccountTeamMember();
               ateam.UserId = accTeamMem.UserId;
               ateam.AccountId = selectedAccountID;
               ateam.TeamMemberRole = accTeamMem.TeamMemberRole;
               AccountShare accShare = new AccountShare();
               accShare.UserOrGroupId =  mapUserIdAccShare.get(accTeamMem.UserId).UserOrGroupId;
               accShare.AccountId =  selectedAccountID;
               accShare.AccountAccessLevel =  mapUserIdAccShare.get(accTeamMem.UserId).AccountAccessLevel;
               accShare.OpportunityAccessLevel =  mapUserIdAccShare.get(accTeamMem.UserId).OpportunityAccessLevel;
               accShare.CaseAccessLevel =  mapUserIdAccShare.get(accTeamMem.UserId).CaseAccessLevel;
               newAccShare.add(accShare);
               lstInsertAccTeam.add(ateam);
               
            }
            
        }
        system.debug('Share'+newAccShare);
        for (Related_Object_of_Account__c lp : lstRelatedObjects) {   
            system.debug('objectss'+lp);     
            SObject[] childRecordsFromParent = queryParentObject.getSObjects(lp.API_Name__c);
            system.debug('Value in related object'+childRecordsFromParent);                 
            if (childRecordsFromParent != null) {                   
                for (SObject childRecord : childRecordsFromParent) { 
                    system.debug('Related object'+lp.API_Name__c);
                    SObject soChildRecord = childRecord;                       
                    ID ChildFieldValue1 = (Id)childRecord.get('Id');   
                    soChildRecord.id =  ChildFieldValue1;
                    String relnName = mapObjFieldAPI.get(lp.API_Name__c);
                    soChildRecord.put(relnName, selectedAccountID);                                           
                    lstSObj.add(soChildRecord);
                    
                }
            }   
              
        }
        
        system.debug('Child Records'+lstSObj);
        Savepoint sp = Database.setSavepoint();
        try{
            if (lstSObj.size()>0)
                update lstSObj;
            if (sourceAcc!= null) {
                if (customerAcc == false)     
                    delete sourceAcc;
                else{
                    sourceAcc.Inactive_Flag__c = true;
                    update sourceAcc;
                }
            }
            if (destAcc!= null)
                update destAcc;
            
            if(lstInsertAccTeam.size()>0)
                insert lstInsertAccTeam;
            if (newAccShare.size() >0)
                insert newAccShare; 
           
           
        }
        catch(System.DmlException e) {
           //ApexPages.Message mergeAccount = new ApexPages.Message(ApexPages.Severity.ERROR,+e.getDmlMessage(0)); 
           Database.rollback(sp);                                      
           //ApexPages.addMessage(e.getDmlMessage(0));
           ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, e.getdmlMessage(0));
           ApexPages.addMessage(msg);
           system.debug('Error message'+e);
           error = true;
          
        }
        if (error==false) {
            PageReference reDirect = new PageReference('/'+selectedAccountID);
            return reDirect;
        }
        else
            return null;
        
    } */
}