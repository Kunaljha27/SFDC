/**
@Classname :       M2O_MergeAccountController 
@Description :     This controller will be used by VF page: merge_Account. This will merge two Accounts- Survivor Account 
                   and Victim Account.Once user searches and select survivor Account, he/she should have an option by clicking “Next” button to also 
                   select the not-CDH related fields (e.g. account information fields) & specify which all fields needs to be copied over to survivor 
                   account from victim account as these fields can be empty on the surviving account.
@Author:           Nitish Bansal
@Last Modified:    29/03/2014
**/

public class M2O_MergeAccountController {
    public Boolean hasDisplayRecords {get; set;}
    public String sourceAccountName {get; set;}
    public String nonCDHapiNames {get;set;}
    public String nonCDHfieldValues {get;set;}

    public String marketAttributesNames {get;set;}
    public String marketAttributesValues {get;set;}
    
    public String destinationAccountName {get; set;}
    @TestVisible private List<M20_AccountRecordWrapper> accountRecordWrapperList;
    @TestVisible String selectedAccountID ;
    @TestVisible string sourceAccountID ;
    @TestVisible private List<Schema.FieldSetMember> nonCDHfieldList = new List<Schema.FieldSetMember>();
    @TestVisible private List<Schema.FieldSetMember> CDHfieldList = new List<Schema.FieldSetMember>();
    
    @TestVisible private List<Schema.FieldSetMember> nonMDMCDHFieldList = new List<Schema.FieldSetMember>();
    @TestVisible private List<Schema.FieldSetMember> marketAttributesList = new List<Schema.FieldSetMember>();
    @TestVisible private List<Schema.FieldSetMember> nonCDHHCNAfieldlist = new List<Schema.FieldSetMember>();
    @TestVisible private String queriableFields;
    @TestVisible private String cdhqueriableFields;

    @TestVisible private String nonMDMCDHQueriableFields;
    @TestVisible private String nonCDHHCNAqueriableFields;
    @TestVisible private String marketAttributesFields;
    @TestVisible private String sourceAccountQuery;
    @TestVisible private String destinationAccountQuery;
    @TestVisible private String sourceAccountQueryCDH;
    @TestVisible private String destinationAccountQueryCDH;

    @TestVisible private String cdhNonMDMSourceAccountQuery;
    @TestVisible private String cdhNonMDMDestinationAccountQuery;
    @TestVisible private String nonCDHHCNASourceAccountQuery;
    @TestVisible private String nonCDHHCNADestinationAccountQuery;
    @TestVisible private String sourceMarketAttributesQuery;
    @TestVisible private String destinationMarketAttributesQuery;

    @TestVisible private Account sourceAccountRecordCDH = new Account();
    @TestVisible private Account destinationAccountRecordCDH = new Account();
    @TestVisible private Account sourceAccountRecord = new Account();
    @TestVisible private Account destinationAccountRecord = new Account();

    @TestVisible private Account cdhNonMDMSourceAccountRecord = new Account();
    @TestVisible private Account cdhNonMDMDestinationAccountRecord = new Account();

    @TestVisible private Account nonCDHHCNASourceAccountRecord = new Account();
    @TestVisible private Account nonCDHHCNADestinationAccountRecord = new Account();
    
    @TestVisible private Account_Market_Sector_Attribute__c sourceMarketSectorAttributeRecord = new Account_Market_Sector_Attribute__c();
    @TestVisible private Account_Market_Sector_Attribute__c destinationMarketSectorAttributeRecord = new Account_Market_Sector_Attribute__c();
    

    @TestVisible private List<Related_Object_of_Account__c> relatedObjectsList = new List<Related_Object_of_Account__c>();
    @TestVisible private Map<String, Schema.FieldSetMember> fieldSchemaMap = new Map<String, Schema.FieldSetMember>();
    @TestVisible private Map<id, Account> sourceAccountRecordsMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> sourceAccountRecordsCDHMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> sourceAccountRecordsCDHNonMDMMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> sourceAccountRecordsNonCDHHCNAMap = new Map<id, Account>();
    @TestVisible private Map<String, Schema.FieldSetMember> attribFieldSchemaMap = new Map<String, Schema.FieldSetMember>();
    @TestVisible private Map<id, Account_Market_Sector_Attribute__c> sourceAccountMarketAttributesMap = new Map<id, Account_Market_Sector_Attribute__c>();

    @TestVisible private Set<Id> accRecordTypeIdSet = new Set<Id>();    
    @TestVisible private Map<String, Object> apiValueMap = new Map<String, Object>();
    
    @TestVisible private Map<String, Object> attributesApiValueMap = new Map<String, Object>();
    
    @TestVisible private Map<id, Account> destinationAccountRecordsMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> destinationAccountRecordsCDHMap = new Map<id, Account>();  
    @TestVisible private Map<id, Account> destinationAccountRecordsCDHNonMDMMap = new Map<id, Account>();
    @TestVisible private Map<id, Account> destinationAccountRecordsNonCDHHCNAMap = new Map<id, Account>();
    @TestVisible private Map<id, Account_Market_Sector_Attribute__c> destinationAccountMarketAttributesMap = new Map<id, Account_Market_Sector_Attribute__c>();
    
    @TestVisible private List<M20_AccountRecordWrapper> CDHaccountRecordWrapperList;  
    @TestVisible private List<M20_AccountRecordWrapper> CDHNonMDMAccountRecordWrapperList;
    @TestVisible private List<M20_AccountRecordWrapper> nonCDHHCNAAccountRecordWrapperList;

    @TestVisible private List<M20_AccountRecordWrapper> marketAttributesWrapperList;
    
    public M2O_MergeAccountController (ApexPages.StandardController controller) {
        hasDisplayRecords = false;
        nonCDHfieldList = SObjectType.Account.FieldSets.M2O_Non_CDH_Fields.getFields();
        queriableFields = '';
        if(nonCDHfieldList != Null && !nonCDHfieldList.isEmpty()){
            for (Schema.FieldSetMember sf : nonCDHfieldList) {        
                fieldSchemaMap.put(sf.getFieldPath(), sf);
                if (String.isBlank(queriableFields) || queriableFields =='') {
                    queriableFields = sf.getFieldPath() + ',';   
                }
                else {
                    queriableFields += sf.getFieldPath() + ',';   
                }
            } 
        }
        nonMDMCDHFieldList = SObjectType.Account.FieldSets.M2O_CDH_NON_MDM.getFields();
        nonMDMCDHqueriableFields = '';
        if(nonMDMCDHFieldList != Null && !nonMDMCDHFieldList.isEmpty()){
            for (Schema.FieldSetMember sf : nonMDMCDHFieldList) {        
                fieldSchemaMap.put(sf.getFieldPath(), sf);
                if (String.isBlank(nonMDMCDHqueriableFields) || nonMDMCDHqueriableFields =='') {
                    nonMDMCDHqueriableFields = sf.getFieldPath() + ',';   
                }
                else {
                    nonMDMCDHqueriableFields += sf.getFieldPath() + ',';   
                }
            } 
        }
    nonCDHHCNAFieldList = SObjectType.Account.FieldSets.NON_CDH_HCNA.getFields();
        nonCDHHCNAqueriableFields = '';
        if(nonCDHHCNAFieldList != Null && !nonCDHHCNAFieldList.isEmpty()){
            for (Schema.FieldSetMember sf : nonCDHHCNAFieldList) {        
                fieldSchemaMap.put(sf.getFieldPath(), sf);
                if (String.isBlank(nonCDHHCNAqueriableFields) || nonCDHHCNAqueriableFields =='') {
                    nonCDHHCNAqueriableFields = sf.getFieldPath() + ',';   
                }
                else {
                    nonCDHHCNAqueriableFields += sf.getFieldPath() + ',';   
                }
            } 
        }
        CDHfieldList = SObjectType.Account.FieldSets.M2O_CDH_Fields.getFields();
        cdhqueriableFields = '';
        if(CDHfieldList  != Null && !CDHfieldList .isEmpty()){
            for (Schema.FieldSetMember sf : CDHfieldList) {        
                fieldSchemaMap.put(sf.getFieldPath(), sf);
                if (String.isBlank(cdhqueriableFields) || cdhqueriableFields =='') {
                    cdhqueriableFields = sf.getFieldPath() + ',';   
                }
                else {
                    cdhqueriableFields += sf.getFieldPath() + ',';   
                }
            }         
        } 
        marketAttributesList = SObjectType.Account_Market_Sector_Attribute__c.FieldSets.Market_Sector_Attribute.getFields();
        marketAttributesFields = '';
        if(marketAttributesList  != Null && !marketAttributesList.isEmpty()){
            for (Schema.FieldSetMember sf : marketAttributesList) {        
                attribFieldSchemaMap.put(sf.getFieldPath(), sf);
                if (String.isBlank(marketAttributesFields) || marketAttributesFields =='') {
                    marketAttributesFields = sf.getFieldPath() + ',';   
                }
                else {
                    marketAttributesFields += sf.getFieldPath() + ',';   
                }
            }         
        } 
        sourceAccountID = ApexPages.currentPage().getParameters().get(M2O_DataUtility.sourceAccountid);
        selectedAccountID = ApexPages.currentPage().getParameters().get(M2O_DataUtility.recordId);
        accRecordTypeIdSet.add(Label.Account_Prospect_Record_Type_Id);
        accRecordTypeIdSet.add(Label.Account_Customer_Record_Type_ID); 
        accRecordTypeIdSet.add(Label.Account_Influencer_Record_Type_Id);        
        sourceAccountQuery = 'SELECT recordtypeId,golden_record_key__c, recordtype.name, name,' + queriableFields + 'id FROM Account WHERE id =\''+ sourceAccountID+'\'' ;
        if(!String.isBlank(sourceAccountQuery)){
            sourceAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(sourceAccountQuery);
        }
        if(sourceAccountRecord != Null){
            sourceAccountRecordsMap.put(sourceAccountRecord.id, sourceAccountRecord);
            sourceAccountName = sourceAccountRecord.name;
        }
        
        destinationAccountQuery = 'SELECT recordtypeId, recordtype.name, name,' + queriableFields + 'id FROM Account WHERE id =\''+ selectedAccountID +'\' limit 1' ;
        if(!String.isBlank(destinationAccountQuery)){
            destinationAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(destinationAccountQuery );
        }
        if(destinationAccountRecord != Null){
            destinationAccountRecordsMap.put(destinationAccountRecord.id, destinationAccountRecord);                
        }

        destinationAccountName = destinationAccountRecordsMap.get(selectedAccountID).name;
        sourceAccountQueryCDH = 'SELECT ' + cdhqueriableFields + 'id,recordtype.name,Region__r.Name,owner.name,createdby.name,lastmodifiedby.name FROM Account WHERE id =\''+ sourceAccountID+'\'' ;
        if(!String.isBlank(sourceAccountQueryCDH)){
            sourceAccountRecordCDH = M2O_MergeAccountService.getAccountQueriableFields(sourceAccountQueryCDH);
        }
        if(sourceAccountRecordCDH != Null){
            sourceAccountRecordsCDHMap.put(sourceAccountRecordCDH.id, sourceAccountRecordCDH);
        }
        destinationAccountQueryCDH = 'SELECT ' + cdhqueriableFields + 'id,recordtype.name,Region__r.Name,owner.name,createdby.name,lastmodifiedby.name FROM Account WHERE id =\''+ selectedAccountID +'\' limit 1' ;
        if(!String.isBlank(destinationAccountQueryCDH)){
            destinationAccountRecordCDH = M2O_MergeAccountService.getAccountQueriableFields(destinationAccountQueryCDH );
        }
        if(destinationAccountRecordCDH != Null){
            destinationAccountRecordsCDHMap.put(destinationAccountRecordCDH.id, destinationAccountRecordCDH);                
        }
        
        // Market Attributes
        sourceMarketAttributesQuery = 'SELECT ' + marketAttributesFields + 'id FROM Account_Market_Sector_Attribute__c WHERE AccountId__c LIKE\'%'+ sourceAccountID+'%\' limit 1' ;
        if(!String.isBlank(sourceMarketAttributesQuery)){
            try {
            sourceMarketSectorAttributeRecord = M2O_MergeAccountService.getAccountAttributeQueriableFields(sourceMarketAttributesQuery);
            }
            catch(Exception e) {
                system.debug('Exception: '+e);
            }
        }
        if(sourceMarketSectorAttributeRecord != Null){
            sourceAccountMarketAttributesMap.put(sourceAccountRecord.id, sourceMarketSectorAttributeRecord);
        }
        destinationMarketAttributesQuery = 'SELECT ' + marketAttributesFields + 'id FROM Account_Market_Sector_Attribute__c WHERE AccountId__c =\''+ selectedAccountID +'\' limit 1' ;
        if(!String.isBlank(destinationMarketAttributesQuery)){
            try {
                destinationMarketSectorAttributeRecord = M2O_MergeAccountService.getAccountAttributeQueriableFields(destinationMarketAttributesQuery );
            }  
            catch(Exception ex) {
                system.debug('Exception'+ex);
            }  
        }
        if(destinationMarketSectorAttributeRecord != Null){
            destinationAccountMarketAttributesMap.put(destinationAccountRecord.id, destinationMarketSectorAttributeRecord);                
        }

    //cdh non mdm
        cdhNonMDMSourceAccountQuery = 'SELECT name,' + nonMDMCDHQueriableFields + 'id FROM Account WHERE id =\''+ sourceAccountID+'\'' ;
        if(!String.isBlank(cdhNonMDMSourceAccountQuery)){
            cdhNonMDMSourceAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(cdhNonMDMSourceAccountQuery);
        }
        if(cdhNonMDMSourceAccountRecord != Null){
            sourceAccountRecordsCDHNonMDMMap.put(cdhNonMDMSourceAccountRecord.id, cdhNonMDMSourceAccountRecord);
        }
        
        cdhNonMDMDestinationAccountQuery = 'SELECT name,' + nonMDMCDHQueriableFields + 'id FROM Account WHERE id =\''+ selectedAccountID +'\' limit 1' ;
        if(!String.isBlank(cdhNonMDMDestinationAccountQuery)){
            cdhNonMDMDestinationAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(cdhNonMDMDestinationAccountQuery );
        }
        if(cdhNonMDMDestinationAccountRecord != Null){
            destinationAccountRecordsCDHNonMDMMap.put(cdhNonMDMDestinationAccountRecord.id, cdhNonMDMDestinationAccountRecord);                
        }
    //non cdh hcna
        nonCDHHCNASourceAccountQuery = 'SELECT name,' + nonCDHHCNAQueriableFields + 'id FROM Account WHERE id =\''+ sourceAccountID+'\'' ;
        if(!String.isBlank(nonCDHHCNASourceAccountQuery)){
            nonCDHHCNASourceAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(nonCDHHCNASourceAccountQuery);
        }
        if(nonCDHHCNASourceAccountRecord != Null){
            sourceAccountRecordsNonCDHHCNAMap.put(nonCDHHCNASourceAccountRecord.id, nonCDHHCNASourceAccountRecord);
        }
        
        nonCDHHCNADestinationAccountQuery = 'SELECT name,' + nonCDHHCNAQueriableFields + 'id FROM Account WHERE id =\''+ selectedAccountID +'\' limit 1' ;
        if(!String.isBlank(cdhNonMDMDestinationAccountQuery)){
            nonCDHHCNADestinationAccountRecord = M2O_MergeAccountService.getAccountQueriableFields(nonCDHHCNADestinationAccountQuery );
        }
        if(nonCDHHCNADestinationAccountRecord != Null){
            destinationAccountRecordsNonCDHHCNAMap.put(nonCDHHCNADestinationAccountRecord.id, nonCDHHCNADestinationAccountRecord);                
        }
    }
    
    /*@Description: Populates the value in a map selected by the user for the non-CDH fields.
    @Return:      Null
    **/    
    public void selectedAccount() {            
        String fieldApiName = System.currentPagereference().getParameters().get(M2O_DataUtility.apiName);
        Object fieldValue = (Object)System.currentPagereference().getParameters().get(M2O_DataUtility.selectedRadioValue);
        if(!String.isBlank(fieldApiName)) {
            apiValueMap.put(fieldApiName, fieldValue);
        }
    }
     /*@Description: Populates the value in a map selected by the user market sector Attributes.
    @Return:      Null
    **/    
    public void selectedAttribute() {            
        String attribFieldApiName = System.currentPagereference().getParameters().get(M2O_DataUtility.apiName);
        Object attribFieldValue = (Object)System.currentPagereference().getParameters().get(M2O_DataUtility.selectedRadioValue);
        if(!String.isBlank(attribFieldApiName)) {
            attributesApiValueMap.put(attribFieldApiName, attribFieldValue);
        }
    }
    /**
    @Description: Populates the values in a map selected by user for the non-CDH fields.
    @Return: NULL
    **/
    public void selectAllAccount() {    
        List<String> fieldApiNameList = nonCDHapiNames.split(',');
        List<String> fieldValueStringList = nonCDHfieldValues.split(',');
        List<object> fieldValueList = new List<Object>();
        if(fieldValueStringList != Null && !fieldValueStringList.isEmpty()){       
            for(String str : fieldValueStringList) {
                fieldValueList.add((Object) str);
            }
        }
        if(fieldApiNameList!=null && !(fieldApiNameList.isEmpty()) && fieldValueList!=null && !(fieldValueList.isEmpty())) {
            for(integer i=0;i<fieldApiNameList.size();i++) {
                if(!String.isBlank(fieldApiNameList[i])) {
                apiValueMap.put(fieldApiNameList[i],fieldValueList[i]);
                }
            }
        }
    }
    /**
    @Description: Populates the values in a map selected by user for the Account Market Sector Attributes
    @Return: NULL
    **/
    public void selectAllAccountAttributes() {    
        List<String> fieldApiNameList = marketAttributesNames.split(',');
        List<String> fieldValueStringList =  marketAttributesValues.split(',');
        List<object> fieldValueList = new List<Object>();
        if(fieldValueStringList != Null && !fieldValueStringList.isEmpty()){       
            for(String str : fieldValueStringList) {
                fieldValueList.add((Object) str);
            }
        }
        if(fieldApiNameList!=null && !(fieldApiNameList.isEmpty()) && fieldValueList!=null && !(fieldValueList.isEmpty())) {
            attributesApiValueMap.clear();
            for(integer i=0;i<fieldApiNameList.size();i++) {
                if(!String.isBlank(fieldApiNameList[i])) {
                attributesApiValueMap.put(fieldApiNameList[i],fieldValueList[i]);
                }
            }
        }
    }

     /**
    @Description: Retrieve the values for the Survivor Account and Victim Account
    @Return:      The value of the Attribute field in both Survivor and Victim Account.
    **/
    public List<M20_AccountRecordWrapper> getAttributesFieldsAndRecords() {
        marketAttributesWrapperList = new List<M20_AccountRecordWrapper>();        
        if(marketAttributesList != Null && !marketAttributesList.isEmpty()){
            Sobject source = sourceAccountMarketAttributesMap.get(sourceAccountID);
            Sobject destination = destinationAccountMarketAttributesMap.get(selectedAccountID);
            Object sourceValue, destinationValue;
            String srcVal, destVal;
            M20_AccountRecordWrapper marketValue;
            for(schema.FieldSetMember marketAttribFields : marketAttributesList){                             
                
                sourceValue = (Object)source.get(marketAttribFields.getfieldpath());                          
                destinationValue = (Object)destination.get(marketAttribFields.getfieldpath());
                
                if (sourceValue!=null || sourceValue!='') {
                    srcVal = String.valueOf(sourceValue);
                }
                if (destinationValue!=null || destinationValue!='') {
                    destVal = String.valueOf(destinationValue);
                }
                if((srcVal != null && srcVal !='') || (destVal != null && destVal != '')) {
                    marketValue = new M20_AccountRecordWrapper(marketAttribFields.getLabel(), marketAttribFields.getfieldpath(), srcVal, destVal);
                    marketAttributesWrapperList.add(marketValue);
                }
            }
        }
        if(marketAttributesWrapperList != Null && !marketAttributesWrapperList.isEmpty()){
            return marketAttributesWrapperList;
        }
        return null;
    }
    
    /**
    @Description: Retrieve the values for the Survivor Account and Victim Account
    @Return:      The value of the non- CDH field in both Survivor and Victim Account.
    **/
    public List<M20_AccountRecordWrapper> getFieldsAndRecords() {
        accountRecordWrapperList = new List<M20_AccountRecordWrapper>();        
        if(nonCDHfieldList != Null && !nonCDHfieldList.isEmpty()){
            Sobject source = sourceAccountRecordsMap.get(sourceAccountID);
            Sobject destination = destinationAccountRecordsMap.get(selectedAccountID);
            Object sourceValue, destinationValue;
            String srcVal, destVal;
            M20_AccountRecordWrapper accvalue;
            for(schema.FieldSetMember nonCDHFields : nonCDHfieldList){                             
                
                sourceValue = (Object)source.get(nonCDHFields.getfieldpath());                          
                destinationValue = (Object)destination.get(nonCDHFields.getfieldpath());
                
                if (sourceValue!=null || sourceValue!='') {
                    srcVal = String.valueOf(sourceValue);
                }
                if (destinationValue!=null || destinationValue!='') {
                    destVal = String.valueOf(destinationValue);
                }
                if((srcVal != null && srcVal !='') || (destVal != null && destVal != '')) {
                    accvalue = new M20_AccountRecordWrapper(nonCDHFields.getLabel(), nonCDHFields.getfieldpath(), srcVal, destVal);
                    accountRecordWrapperList.add(accvalue);
                }
            }
        }
        if(accountRecordWrapperList != Null && !accountRecordWrapperList.isEmpty()){
            return accountRecordWrapperList;
        }
        return null;
    }
    
    /**
    @Description: Retrieve the values for the Survivor Account and Victim Account
    @Return:      The value of the CDH NON MDM field in both Survivor and Victim Account.
    **/
    public List<M20_AccountRecordWrapper> getCDHNonMDMFieldsAndRecords() {
        CDHNonMDMAccountRecordWrapperList = new List<M20_AccountRecordWrapper>();        
        if(nonMDMCDHFieldList!= Null && !nonMDMCDHFieldList.isEmpty()){
            Sobject source = sourceAccountRecordsCDHNonMDMMap.get(sourceAccountID);
            Sobject destination = destinationAccountRecordsCDHNonMDMMap.get(selectedAccountID);
            Object sourceValue, destinationValue;
            String srcVal, destVal;
            M20_AccountRecordWrapper accvalue;
            for(schema.FieldSetMember nonMDMCDHFields : nonMDMCDHFieldList){                             
                
                sourceValue = (Object)source.get(nonMDMCDHFields.getfieldpath());                          
                destinationValue = (Object)destination.get(nonMDMCDHFields.getfieldpath());
                
                if (sourceValue!=null || sourceValue!='') {
                    srcVal = String.valueOf(sourceValue);
                }
                if (destinationValue!=null || destinationValue!='') {
                    destVal = String.valueOf(destinationValue);
                }
                if((srcVal != null && srcVal !='') || (destVal != null && destVal != '')) {
                    accvalue = new M20_AccountRecordWrapper(nonMDMCDHFields.getLabel(), nonMDMCDHFields.getfieldpath(), srcVal, destVal);
                    CDHNonMDMAccountRecordWrapperList.add(accvalue);
                }
            }
        }
        if(CDHNonMDMAccountRecordWrapperList!= Null && !CDHNonMDMAccountRecordWrapperList.isEmpty()){
            return CDHNonMDMAccountRecordWrapperList;
        }
        return null;
    }
    /**
    @Description: Retrieve the values for the Survivor Account and Victim Account
    @Return:      The value of the NON CDH HCNA MDM field in both Survivor and Victim Account.
    **/
    public List<M20_AccountRecordWrapper> getNonCDHHCNAFieldsAndRecords() {
        nonCDHHCNAAccountRecordWrapperList = new List<M20_AccountRecordWrapper>();        
        if(nonCDHHCNAFieldList!= Null && !nonCDHHCNAFieldList.isEmpty()){
            Sobject source = sourceAccountRecordsNonCDHHCNAMap.get(sourceAccountID);
            Sobject destination = destinationAccountRecordsNonCDHHCNAMap.get(selectedAccountID);
            Object sourceValue, destinationValue;
            String srcVal, destVal;
            M20_AccountRecordWrapper accvalue;
            for(schema.FieldSetMember nonCDHHCNAFields : nonCDHHCNAFieldList){                             
                
                sourceValue = (Object)source.get(nonCDHHCNAFields.getfieldpath());                          
                destinationValue = (Object)destination.get(nonCDHHCNAFields.getfieldpath());
                
                if (sourceValue!=null || sourceValue!='') {
                    srcVal = String.valueOf(sourceValue);
                }
                if (destinationValue!=null || destinationValue!='') {
                    destVal = String.valueOf(destinationValue);
                }
                if((srcVal != null && srcVal !='') || (destVal != null && destVal != '')) {
                    accvalue = new M20_AccountRecordWrapper(nonCDHHCNAFields.getLabel(), nonCDHHCNAFields.getfieldpath(), srcVal, destVal);
                    nonCDHHCNAAccountRecordWrapperList.add(accvalue);
                }
            }
        }
        if(nonCDHHCNAAccountRecordWrapperList!= Null && !nonCDHHCNAAccountRecordWrapperList.isEmpty()){
            return nonCDHHCNAAccountRecordWrapperList;
        }
        return null;
    }
    
    public List<M20_AccountRecordWrapper> getCDHFieldsAndRecords() {
        Object sourceValue;
        Object destinationValue;
        String srcVal;
        String destVal;
        CDHaccountRecordWrapperList = new List<M20_AccountRecordWrapper>();        
        if(CDHfieldList != Null && !CDHfieldList.isEmpty()){
            for (schema.FieldSetMember cdhFields : CDHfieldList){  
                Account source = sourceAccountRecordsCDHMap.get(sourceAccountID);
                Account destination = destinationAccountRecordsCDHMap.get(selectedAccountID);                
                if(cdhFields.getfieldpath() == M2O_DataUtility.recordTypeLookup) {                           
                    sourceValue = (Object)source.RecordType.Name;
                    destinationValue = (Object)destination.RecordType.Name;    
                }
                else if(cdhFields.getfieldpath() == M2O_DataUtility.regionLookup ){
                    sourceValue = (Object)source.Region__r.Name;
                    destinationValue = (Object)destination.Region__r.Name;     
                }   
                else if(cdhFields.getfieldpath() == 'OwnerId' ){
                    sourceValue = (Object)source.Owner.Name;
                    destinationValue = (Object)destination.Owner.Name;     
                } 
                else if(cdhFields.getfieldpath() == 'CreatedById' ){
                    sourceValue = (Object)source.CreatedBy.Name;
                    destinationValue = (Object)destination.CreatedBy.Name;     
                }
                else if(cdhFields.getfieldpath() == 'LastModifiedById' ){
                    sourceValue = (Object)source.LastModifiedBy.Name;
                    destinationValue = (Object)destination.LastModifiedBy.Name;     
                }        
                else{
                    sourceValue = (Object)source.get(cdhFields.getfieldpath());
                    destinationValue = (Object)destination.get(cdhFields.getfieldpath());               
                }
                
                if (sourceValue!=null || sourceValue!='')
                    srcVal = String.valueOf(sourceValue);
                if (destinationValue!=null || destinationValue!='')
                    destVal = String.valueOf(destinationValue);
                if((srcVal != null && srcVal !='') || (destVal != null && destVal != '')) {
                    M20_AccountRecordWrapper accvalue = new M20_AccountRecordWrapper(cdhFields.getLabel(), 
                                                                                    cdhFields.getfieldpath(), srcVal, destVal);
                    CDHaccountRecordWrapperList.add(accvalue);
                }
            }
        }
        if(CDHaccountRecordWrapperList != Null && !CDHaccountRecordWrapperList.isEmpty()){
            return CDHaccountRecordWrapperList;
        }
        return null;
    }
     public List<M20_AccountRecordWrapper> getAttributeRecords() {
         CDHaccountRecordWrapperList = new List<M20_AccountRecordWrapper>();
         Set<id> accountsIdSet = new Set<id>();
         accountsIdSet.add(sourceAccountID);
         accountsIdSet.add(selectedAccountID);
         Map<id, Account_Market_Sector_Attribute__c> attributeAccountMap = M2O_MergeAccountService.getAttributeRecords(accountsIdSet);
         if(attributeAccountMap != null) {
             M20_AccountRecordWrapper attributeRecords = new M20_AccountRecordWrapper(attributeAccountMap.get(sourceAccountID).Name, attributeAccountMap.get(selectedAccountID).Name, 
                                                                                      attributeAccountMap.get(sourceAccountID).Id, attributeAccountMap.get(selectedAccountID).Id);
             CDHaccountRecordWrapperList.add(attributeRecords);
         }
         if(CDHaccountRecordWrapperList != null && !CDHaccountRecordWrapperList.isEmpty()) {
             return CDHaccountRecordWrapperList;
         }
         else {
             return null;
         }
     }
    /**
    @Description: Merging of two Accounts will take place. Victim Account(Prospect Account) will be deleted. Victim Account(Customer Account) will be
                  made inactive. Survivor Account will be updated with the value selected by the user. All the values in the related objects will be
                  copied from Victim Account to Survivor Account.
    @Return:      Redirects to the Survivor Account's detail page.
    **/    
    public pageReference mergeAccounts() {
        Boolean isError, isCustomerAccount, boolVal;
        isError = isCustomerAccount = false;
        String strVal;
        Integer intVal;
        Datetime dateVal;
        Double dblVal;
        Date dtval;
        SObject[] childRecordsFromParent;
        Set<Id> userIdSet = new Set<Id>();
        Set<String> sObjectNameSet = new Set<String>();
        Map<String, String> objFieldAPIMap = new Map<String, String>();
        Boolean isOwnerInactive;
        Account destAcc = new Account();
        Account sourceAcc = new Account();
        Sobject sObj = new Account();
    
        SObject queryParentObject, queryParentForSelectedObject;
        if (sourceAccountRecordsMap.get(sourceAccountID).recordtypeId == Label.Account_Customer_Record_Type_ID) {
            isCustomerAccount = true;
        }        
        sObj.id = selectedAccountID;
        if(!apiValueMap.isEmpty()){
            for (String str : apiValueMap.keySet()) {     
                try{
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.String 
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.TextArea
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Picklist 
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.MultiPicklist
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Phone 
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Reference
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Email
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.URL) {
                        if (apiValueMap.get(str)!= '') {
                            strVal = String.valueOf(apiValueMap.get(str));
                            sObj.put(str, strVal);  
                        }else{
                            sObj.put(str, fieldSchemaMap.get(str));  
                        }
                    }
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.Integer) {
                        if (apiValueMap.get(str)!= '') {
                            intVal = Integer.valueOf(apiValueMap.get(str));
                            sObj.put(str, intVal);    
                        }else{
                            sObj.put(str, fieldSchemaMap.get(str)); 
                        }
                    }
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.Boolean) {
                        if (apiValueMap.get(str)!= '') {
                            boolVal = Boolean.valueOf(apiValueMap.get(str));
                            sObj.put(str, boolVal);    
                        }else{
                            sObj.put(str, fieldSchemaMap.get(str)); 
                        }
                    }
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.Datetime ) {
                        if (apiValueMap.get(str)!= '') {
                            dateVal = Datetime.valueOf(apiValueMap.get(str));
                            sObj.put(str, dateVal);    
                        }else
                            sObj.put(str, fieldSchemaMap.get(str)); 
                    }                
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.Currency 
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Double
                        || fieldSchemaMap.get(str).getType() == Schema.DisplayType.Percent) {
                        if (apiValueMap.get(str)!= '') {
                            dblVal = Double.valueOf(apiValueMap.get(str));
                            sObj.put(str, dblVal); 
                        }else{
                            sObj.put(str, fieldSchemaMap.get(str)); 
                        }
                    }
                }catch(Exception e) { 
                    system.debug('Exception occured:'+e);
                }
                try{            
                    if (fieldSchemaMap.get(str).getType() == Schema.DisplayType.Date) {
                        if (apiValueMap.get(str)!= '') {
                            String dte = String.valueOf(apiValueMap.get(str));
                            String str1 = dte.substring(0, dte.indexOf(' '));
                            dtval = date.valueOf(str1);
                            sObj.put(str, dtval);    
                        }else{
                            sObj.put(str, fieldSchemaMap.get(str)); 
                        }
                    }                
                }catch(Exception e) {
                    system.debug('Exception occured:'+e);
                }
            } 
        } 
        
    Account_Market_Sector_Attribute__c destAttrib = new Account_Market_Sector_Attribute__c();
    Sobject attribObj = new Account_Market_Sector_Attribute__c();
        
    attribObj.id = destinationMarketSectorAttributeRecord.id;
        if(!attributesApiValueMap.isEmpty()){
            for (String str : attributesApiValueMap.keySet()) {     
                try{
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.String 
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.TextArea
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Picklist 
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.MultiPicklist
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Phone 
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Reference) {
                        if (attributesApiValueMap.get(str)!= '') {
                            strVal = String.valueOf(attributesApiValueMap.get(str));
                            attribObj.put(str, strVal);  
                        }else{
                            attribObj.put(str, attribFieldSchemaMap.get(str));  
                        }
                    }
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Integer) {
                        if (attributesApiValueMap.get(str)!= '') {
                            intVal = Integer.valueOf(attributesApiValueMap.get(str));
                            attribObj.put(str, intVal);    
                        }else{
                            attribObj.put(str, attribFieldSchemaMap.get(str)); 
                        }
                    }
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Boolean) {
                        if (attributesApiValueMap.get(str)!= '') {
                            boolVal = Boolean.valueOf(attributesApiValueMap.get(str));
                            attribObj.put(str, boolVal);    
                        }else{
                            attribObj.put(str, attribFieldSchemaMap.get(str)); 
                        }
                    }
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Datetime ) {
                        if (attributesApiValueMap.get(str)!= '') {
                            dateVal = Datetime.valueOf(attributesApiValueMap.get(str));
                            attribObj.put(str, dateVal);    
                        }else
                            attribObj.put(str, attribFieldSchemaMap.get(str)); 
                    }                
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Currency 
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Double
                        || attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Percent) {
                        if (attributesApiValueMap.get(str)!= '') {
                            dblVal = Double.valueOf(attributesApiValueMap.get(str));
                            attribObj.put(str, dblVal); 
                        }else{
                            attribObj.put(str, attribFieldSchemaMap.get(str)); 
                        }
                    }
                }catch(Exception e) { 
                    system.debug('Exception occured:'+e);
                }
                try{            
                    if (attribFieldSchemaMap.get(str).getType() == Schema.DisplayType.Date) {
                        if (attributesApiValueMap.get(str)!= '') {
                            String dte = String.valueOf(attributesApiValueMap.get(str));
                            String str1 = dte.substring(0, dte.indexOf(' '));
                            dtval = date.valueOf(str1);
                            attribObj.put(str, dtval);    
                        }else{
                            attribObj.put(str, attribFieldSchemaMap.get(str)); 
                        }
                    }                
                }catch(Exception e) {
                    system.debug('Exception occured:'+e);
                }
            } 
        }
    
    
    
    String mergeHistoryTracking = M2O_DataUtility.accountObjectVal + M2O_DataUtility.spaceVal + sourceAccountRecordsMap.get(sourceAccountID).name + M2O_DataUtility.spaceVal + M2O_DataUtility.mergingString + M2O_DataUtility.spaceVal + 
                                      destinationAccountRecordsMap.get(selectedAccountID).name;
        sObj.put('Account_Merged__c', mergeHistoryTracking);
        destAcc = (Account)sObj;        
        destAttrib = (Account_Market_Sector_Attribute__c) attribObj;
        sourceAcc.id = sourceAccountID;
        
        isError = M2O_MergeAccountService.setAccountRelatedObject(mergeHistoryTracking, destAcc, isCustomerAccount, isError, sourceAccountID, selectedAccountID, objFieldAPIMap, destAttrib);
        
        if (!isError) {
            PageReference reDirect = new PageReference('/'+selectedAccountID);
            return reDirect;
        } else
            return null;
    } 
}