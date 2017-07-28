/**
* @ClassName <M2O_StrategicAccountPlan>
* @Description <This class is performing search functionality from Account object as per the input given in the VF, showing 
                the results with pagination,results will be having checkbox to select,showing the selected Accounts with pagination and 
                creating or Updating the Strategic Account Plan with selected Accounts>
* @Author <Albin Deni Arul>
* @Last Modified <26/08/2013>
* @Discussionpoints <No Information>
*/

public with sharing class M2O_StrategicAccountPlan {
  public String searchString;
  public String accountPlanName {get;set;}
  public String goldenRecordKey {get;set;}
  public string firstQuerySection;
  public string queryString;
  public String preselectedAccountQuery;
  public String preselectedAccountID;
  public String preselectedSAPID;
  public integer count1;
  public list<SelectOption> recordTypeSAPPickList;
  public String recordTypeSelected {get; set;} { recordTypeSelected = Schema.SObjectType.Strategic_Account_Plan__c.getRecordTypeInfosByName().get(M2O_DataUtility.retailSAPRecordType).getRecordTypeId(); }
  Public Integer searchResultsListSize=0; 
  Public Integer selectedAccountListSize=0;
  Public Integer setPageSizeSearchResultsList=0; 
  Public Integer setPageSizeSearchResultsListSelectedAccountList=0;
  public boolean selectedAccountListSizeboolean {get;set;}
  public Set<Id> setselectedList = New Set<Id>();
  public Set<Id> accountIdSet = new  Set<Id>();
  public Set<Id> recordTypeId = new  Set<Id>();
  public list<RecordType> recordTypeSAP=new List<RecordType>();
  public transient list<Account> accountList {get;set;}
  public transient list<Account> preselectedAccount = new list<Account>();
  public transient list<Account_Plan_Account__c> accountPlanList = new list<Account_Plan_Account__c>();
  @TestVisible list<Account> selectedList= New list<Account>();
  @TestVisible list<Account_Plan_Account__c> accountPlanInsertList= New list<Account_Plan_Account__c>();
  list<Account> tempSelectedList= New list<Account>();
  @TestVisible list<Account_Plan_Account__c> accountPlanDelete=new List<Account_Plan_Account__c>();
  @TestVisible transient List<WrapperAccount> wrappedSearchResultsList {get;set;}
  @TestVisible transient List<WrapperAccount> wrappedSelectedaccountList {get;set;}
  Map<Id,Account_Plan_Account__c> mapofAccountPlanWithAccount =new Map<Id,Account_Plan_Account__c>();
  Public ApexPages.StandardSetController setPaginationSearchResults {get;set;}
  Public ApexPages.StandardSetController setPaginationSelectedAccounts {get;set;}
  final static string SLASH='/';
  public Boolean nonSectorProfile{get;set;}
  public Boolean lightingSectorProfile{get;set;}
  public String profileName;
  @TestVisible list<Related_Account_Plan__c> relatedAccountPlanInsertList;
  public string parentSAPID;
  public Id profileId;
  public Id associatedAccountForGSP;
  public String  associatedAccountNameForGSP;

  /**
   * @Description: Function to query list of recordtype for SAP and diplay in Business Type picklist
   * @return : Record Type of SAP
   **/
   
  public List<selectoption> getrecordTypeSAPPickList() {
      recordTypeSAPPickList=new List<Selectoption>();
      recordTypeSAP=this.recordTypeSAP;
      for(recordtype recordType: recordTypeSAP) {
          if(recordType.name != M2O_DataUtility.hcnaSAPRecordType ) {
              recordTypeSAPPickList.add(new selectOption(recordType.id , recordType.Name));
          }
      }
      return recordTypeSAPPickList;
  }
  
  public Account account {
    get{
        if (account== null)
            account= new Account();
            return account;
    }
   set;
  }  
   public Strategic_Account_Plan__c strategicAccountPlan {
    get{
        if (strategicAccountPlan == null)
            strategicAccountPlan = new Strategic_Account_Plan__c();
            return strategicAccountPlan;
    }
   set;
  }  
  public Integer getsearchResultsListSize() {
    return searchResultsListSize;
  }
  public Integer getselectedAccountListSize() {
    return selectedAccountListSize;
  }
  public M2O_StrategicAccountPlan(ApexPages.StandardController controller) {
  }
  public void goToM2OStrategicAccountPlan() {
    profileId=userinfo.getProfileId();
    profileName = [Select Id,Name from Profile where Id=:profileId].Name;    
    nonSectorProfile = false;
    lightingSectorProfile = false;
    setSectorFlag();
    setPageSizeSearchResultsList=integer.ValueOf(label.Set_displaynumber_SearchResults_SAPVF);
    setPageSizeSearchResultsListSelectedAccountList=integer.ValueOf(label.Set_displaynumber_Selectedrecords_SAPVF);
    preselectedAccountID=Apexpages.Currentpage().getparameters().get('preselectedAccount');
    preselectedSAPID=Apexpages.Currentpage().getparameters().get('preselectedSAP');
    parentSAPID=Apexpages.Currentpage().getparameters().get('parentSAP');  
    recordTypeId.add(label.Account_Customer_Record_Type_ID);
    recordTypeId.add(label.Account_Hierarchy_Node_Record_Type_ID);
    firstQuerySection= 'SELECT ';
    //loop to get fields from Field Set
    for(Schema.FieldSetMember fieldSet : this.getFields()) {
        firstQuerySection += fieldSet.getFieldPath() + ', ';
    }
    //Forming dynamic SOQL query to get preselected Account 
    if(preselectedAccountID !=null) {
       preselectedAccountQuery = firstQuerySection + 'Id From Account Where recordTypeId IN :recordTypeId AND Id =\'' +preselectedAccountID+'\'';
    }
    //Forming dynamic SOQL query to get preselected Accounts from SAP record
    if(preselectedSAPID!= null) {
       accountPlanList =[select Account__c from Account_Plan_Account__c where Account_Plan__c =:preselectedSAPID];
       for(Account_Plan_Account__c accountPlan:accountPlanList ) {
           AccountIdSet.add(accountPlan.account__C);
           mapofAccountPlanWithAccount.put(accountPlan.account__C,accountPlan);
          }    
       if(AccountIdSet.size()>0) {
          selectedAccountListSizeboolean=true;
          preselectedAccountQuery = firstQuerySection + 'Id From Account Where recordTypeId IN :recordTypeId AND ID IN :AccountIdSet';
          }
          else {
              selectedAccountListSizeboolean=true;
          }    
       } 
       if((preselectedAccountID !=null  || preselectedSAPID!= null) && preselectedAccountQuery!=null) {
          preselectedAccount= Database.query(preselectedAccountQuery);
          // Adding the preselected Accounts to Selected list
          selectedList.addall(preselectedAccount );
          //setselectedList has been used to prevent duplicates in selected list
          for(Account preSelect:preselectedAccount) {
              setselectedList.add(preSelect.id);
             }
          selectedAccountListSize=selectedList.size();
          //Setting the pagination for preselected records
          setPaginationSelectedAccounts = new ApexPages.StandardSetController(getListSelectedAccounts());
          setPaginationSelectedAccounts.setPageSize(integer.ValueOf(label.Set_displaynumber_Selectedrecords_SAPVF));
          tempSelectedList=selectedList.clone();
       }
        recordTypeSAP=[Select Name,ID,SobjectType from recordtype where SobjectType='Strategic_Account_Plan__c'];
        firstQuerySection += 'Id FROM Account Where recordTypeId IN :recordTypeId ';      
  }
  public pagereference redirect() {
      PageReference redirectTo;
      associatedAccountForGSP = Apexpages.Currentpage().getparameters().get('associatedAccountForGSP');
      associatedAccountNameForGSP = Apexpages.Currentpage().getparameters().get('associatedAccountNameForGSP'); 
      Validate_M2O_Profiles__c validateProfile = Validate_M2O_Profiles__c.getInstance( userInfo.getProfileId());
      if(validateProfile.Validate_Profiles__c) {
          goToM2OStrategicAccountPlan();
          return null;
      } else {           
          if(associatedAccountForGSP == null) {
              redirectTo = new PageReference('/a1H/e?retURL=%2Fa1H%2Fo&nooverride=1');
          }else {               
              redirectTo = new PageReference('/a1H/e?CF00Nd00000077evQ='+associatedAccountNameForGSP+'&CF00Nd00000077evQ_lkid='+associatedAccountForGSP+'retURL=%2Fa1H%2Fo&nooverride=1');
          }
          redirectTo.setRedirect(true);
          return redirectTo;
        } 
    }
  
  public List<Schema.FieldSetMember> getFields() {
    return SObjectType.Account.FieldSets.DisplayFieldsForSAP_VF.getFields();
  }
  public List<Schema.FieldSetMember> getSearchFields() {
    return SObjectType.Account.FieldSets.SearchFieldsForSAP_VF.getFields();
  }
  
  /**
   * @Description: AccountList method gives the search results according to the input given as search criteria
   * @return : Build Query based on fields
   **/
  public list<Account> getaccountList() {
    queryString ='';
    queryString =firstQuerySection;
        for(Schema.FieldSetMember fieldSet : this.getFields()) {
             if(account.get(fieldSet.getfieldPath())!=null && fieldSet.getfieldPath()=='name' ) {
                 searchString='%'+(account.get(fieldSet.getfieldPath()))+'%';
                 queryString +=  'AND name LIKE\''+ String.escapeSingleQuotes(searchString) + '\'';
               }else if((account.get(fieldSet.getfieldPath())!=null)) {
                       queryString += +' AND ' +fieldSet.getfieldPath()+' =\''+account.get(fieldSet.getfieldPath())+'\'';
               }
    }
    queryString += ' LIMIT 1000';
    return Database.query(queryString);
  }
  /**
   * @Description: Search method takes the Account name as base search criteria and calls the accountList method to get the search result
   * @return : Null
   **/
  public void search() {
    searchString='';
    setPaginationSearchResults=null;
    accountList = New list<Account>();
    accountList=getaccountList();// getting the search results in accountList
    searchResultsListSize=accountList.size();
    if(searchResultsListSize==1000) {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'Search Results are more than 1000, so please give precise Account name')); 
    }
    if(searchResultsListSize==0) {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'No matches found')); 
    }
    //Setting the pagination for search results
    setPaginationSearchResults = new ApexPages.StandardSetController(getlistSearchResults());
    setPaginationSearchResults.setPageSize(integer.ValueOf(label.Set_displaynumber_SearchResults_SAPVF));    
  }
  
  /**
   * @Description: Adding the selected records to Selected list
   * @return : Null
   **/
  public void addToSelectedList() {
    for(WrapperAccount wrapperAccount:WrappedSearchResultsList) {
        if(wrapperAccount.selected==true) {
           wrapperAccount.selected=false;
           if(setselectedList.add(wrapperAccount.Wrapaccount.id)) {
              selectedList.add(wrapperAccount.wrapaccount);
           }   
        }
    }
    selectedAccountListSize=selectedList.size();
    //Setting the Pagination for Selected records
    setPaginationSelectedAccounts = new ApexPages.StandardSetController(getListSelectedAccounts());
    setPaginationSelectedAccounts.setPageSize(integer.ValueOf(label.Set_displaynumber_Selectedrecords_SAPVF));
    tempSelectedList=selectedList.clone();
  }
  /**
   * @Description:  Removing the selected records from the Selected List
   * @return : Null
   **/
  Public void removeEntries() {
    count1=0;
    count1=(pageNumber()-1)*integer.ValueOf(label.Set_displaynumber_Selectedrecords_SAPVF);
    for(WrapperAccount wrapperAccount: wrappedSelectedaccountList){
        if(wrapperAccount.selected == true){
           tempSelectedList.remove(count1);
           setselectedList.remove(wrapperAccount.wrapaccount.Id);
           accountPlanDelete.add(mapofAccountPlanWithAccount.get(wrapperAccount.wrapaccount.Id));
           count1=count1-1;
        }
        count1=count1+1; 
    }
    selectedList=tempSelectedList.clone();
    selectedAccountListSize=selectedList.size();
    //Setting the pagination for selected recods after removing the records
    setPaginationSelectedAccounts = new ApexPages.StandardSetController(getListSelectedAccounts());
    setPaginationSelectedAccounts.setPageSize(integer.ValueOf(label.Set_displaynumber_Selectedrecords_SAPVF));
  }
  /**
   * @Description: To set the Sector flag for the Categories based on Profile name.
   * @return : Null
   **/
   public void setSectorFlag(){
       if(profileName == label.M2O_KAM_Lighting_Profile || profileName == label.M2O_KAM_Healthcare_Profile){
           lightingSectorProfile = true;
       }
       else if(profileName == label.M2O_System_Admin_Profile || profileName == label.Data_Steward_Name){
           nonSectorProfile = true;   
       }
       else if(profileName == label.M2O_KAM_Consumer_Lifestyle_Profile) {
           nonSectorProfile = false;
           lightingSectorProfile = false;
       }
   }
 
 /**
   * @Description: Creating New Account Plan with Selected Accounts as relatedlist records by taking Record Type from UI.
   * @return :  Account Plan List
   **/
  public pagereference createAccountPlan() {
    Strategic_Account_Plan__c SAP; 
    if((profileName == label.M2O_System_Admin_Profile || profileName == label.Data_Steward_Name) && lightingSectorProfile == false && accountPlanName != null && recordTypeSelected != null && strategicAccountPlan.From_Date__c != null && strategicAccountPlan.CurrencyIsoCode!= null && strategicAccountPlan.Philips_Sector__c != null) {
        strategicAccountPlan.To_Date__c = (date.newinstance(strategicAccountPlan.From_Date__c.year(), 12, 31));
        SAP= new Strategic_Account_Plan__c(name=accountPlanName, recordTypeId=recordTypeSelected,From_Date__c=strategicAccountPlan.From_Date__c, To_Date__c=strategicAccountPlan.To_Date__c,CurrencyIsoCode=strategicAccountPlan.CurrencyIsoCode,Philips_Sector__c=strategicAccountPlan.Philips_Sector__c);
    }
    else if((profileName == label.M2O_System_Admin_Profile || profileName == label.Data_Steward_Name) && lightingSectorProfile == true && accountPlanName != null && recordTypeSelected != null && strategicAccountPlan.From_Date__c != null && strategicAccountPlan.CurrencyIsoCode!= null && strategicAccountPlan.Philips_Sector__c != null) {
        strategicAccountPlan.To_Date__c = (date.newinstance(strategicAccountPlan.From_Date__c.year(), 12, 31));
        SAP= new Strategic_Account_Plan__c(name=accountPlanName, recordTypeId=recordTypeSelected,From_Date__c=strategicAccountPlan.From_Date__c, To_Date__c=strategicAccountPlan.To_Date__c,CurrencyIsoCode=strategicAccountPlan.CurrencyIsoCode,Philips_Sector__c=strategicAccountPlan.Philips_Sector__c);
    }
    else if(profileName == label.M2O_KAM_Lighting_Profile && accountPlanName != null && recordTypeSelected != null && strategicAccountPlan.From_Date__c != null && strategicAccountPlan.CurrencyIsoCode!= null) {
        strategicAccountPlan.To_Date__c = (date.newinstance(strategicAccountPlan.From_Date__c.year(), 12, 31));
        SAP= new Strategic_Account_Plan__c(name=accountPlanName, recordTypeId=recordTypeSelected,From_Date__c=strategicAccountPlan.From_Date__c, To_Date__c=strategicAccountPlan.To_Date__c,CurrencyIsoCode=strategicAccountPlan.CurrencyIsoCode);           
    }
    else if(profileName == label.M2O_KAM_Healthcare_Profile && accountPlanName != null && recordTypeSelected != null && strategicAccountPlan.From_Date__c != null && strategicAccountPlan.CurrencyIsoCode!= null) {
        strategicAccountPlan.To_Date__c = (date.newinstance(strategicAccountPlan.From_Date__c.year(), 12, 31));
        SAP= new Strategic_Account_Plan__c(name=accountPlanName, recordTypeId=recordTypeSelected,From_Date__c=strategicAccountPlan.From_Date__c, To_Date__c=strategicAccountPlan.To_Date__c,CurrencyIsoCode=strategicAccountPlan.CurrencyIsoCode);           
    }
    else if(profileName == label.M2O_KAM_Consumer_Lifestyle_Profile && accountPlanName != null && recordTypeSelected != null && strategicAccountPlan.From_Date__c != null && strategicAccountPlan.CurrencyIsoCode!= null) {
        strategicAccountPlan.To_Date__c = (date.newinstance(strategicAccountPlan.From_Date__c.year(), 12, 31));
        SAP= new Strategic_Account_Plan__c(name=accountPlanName, recordTypeId=recordTypeSelected,From_Date__c=strategicAccountPlan.From_Date__c, To_Date__c=strategicAccountPlan.To_Date__c,CurrencyIsoCode=strategicAccountPlan.CurrencyIsoCode);            
    }
    else {
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
         return null;
    }
    
    
    try{
       insert SAP;
    }catch(Exception e){
           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Creating Account Plan has failed'));         
    }
    for(Account selectedAccount :selectedList) {
        Account_Plan_Account__c  AccountPlan= new Account_Plan_Account__c();
        AccountPlan.Account_Plan__c=SAP.Id;
        AccountPlan.Account__c=selectedAccount.id;
        accountPlanInsertList.add(AccountPlan); 
    }
    if(parentSAPID!=null) {
            relatedAccountPlanInsertList= new list<Related_Account_Plan__c>();
            Related_Account_Plan__c relatedAccountPlan = new Related_Account_Plan__c();
            relatedAccountPlan.Strategic_Account_Plan__c=parentSAPID;
            relatedAccountPlan.Account_Plan__c=SAP.Id;
            relatedAccountPlanInsertList.add(relatedAccountPlan);
    }
    try {
            insert accountPlanInsertList;
        if(relatedAccountPlanInsertList!=null && !relatedAccountPlanInsertList.isEmpty()) {
            insert relatedAccountPlanInsertList;
        }
        }catch(Exception e) {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Creating Account Plan has failed'));
        }
    PageReference pageRef = new PageReference(SLASH+SAP.id+'/e?retURL=%2F'+SAP.id);
    return pageRef ;       
  }
  
  /**
   * @Description: Saving the existing Acccount plan with newly added Accounts
   * @return :  Account Plan List
   **/
  public pagereference save() {
    for(Account selectedAccount :selectedList) {
        if(!(AccountIdSet.contains(selectedAccount.id))) {
           Account_Plan_Account__c  AccountPlan= new Account_Plan_Account__c();
           AccountPlan.Account_Plan__c=preselectedSAPID;
           AccountPlan.Account__c=selectedAccount.id;
           accountPlanInsertList.add(AccountPlan);
        }
    }
    if(!accountPlanDelete.isEmpty() && accountPlanDelete!=null) {
       try {
           delete accountPlanDelete;
       }catch(Exception e) {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Removal of already existing Account Plans for the Strategic Account Plan have been failed '));  
       }
    }   
   if(!accountPlanInsertList.isEmpty()&&accountPlanInsertList!=null) {
       try {
          insert accountPlanInsertList;
       }catch(Exception e) {
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Newly added Accounts are failed to get attached with Strategic Account Plan'));  
       }
   }   
   PageReference pageRef = new PageReference(SLASH+preselectedSAPID);
   return pageRef ;
  }
  /**
   * @Description: Cancelling the whole process and going back to the source place
   * @return :  Redirecting to Previous page
   **/
 
  public pagereference cancel() {
    String PagerefString;
    if(preselectedAccountID!=null) {
       PagerefString=SLASH+preselectedAccountID;
    }   
    if(preselectedSAPID!=null) {
       PagerefString= SLASH+preselectedSAPID;
    }   
    if(preselectedAccountID==null &&preselectedSAPID==null) {
       PagerefString= SLASH + System.Label.SF_Object_Reference_For_Strategic_Account_Plan + '/o';
    }
    PageReference pageRef = new PageReference(PagerefString); 
    return pageRef ;
  }
  /**
   * @Description: Pagination Method: getting the records from set controller and wrapping it with checkbox      
   * @return : Wrapped selected list
   **/
  Public List<WrapperAccount> getwrappedSelectedAccountList() {
    wrappedSelectedaccountList = New List<WrapperAccount>();
    for(Account SObj :(List<Account>)setPaginationSelectedAccounts.getRecords())
        wrappedSelectedaccountList.add(new WrapperAccount(SObj)); 
        return  wrappedSelectedaccountList ;   
  }  
   /**
   * @Description: Pagination Method: getting the selected Accounts     
   * @return :  Selected Accounts
   **/
  public List<Account> getListSelectedAccounts() {
    List<Account> ListSelectedAccounts =selectedList;
    return ListSelectedAccounts;
  }
   /**
   * @Description: Pagination Method: getting the records from set controller and wrapping it with checkbox      
   * @return : Wrapped search results
   **/      
  Public List<WrapperAccount> getWrappedSearchResultsList() {
    wrappedSearchResultsList = New List<WrapperAccount>();
    for(Account SObj :(List<Account>)setPaginationSearchResults.getRecords())
        WrappedSearchResultsList.add(new WrapperAccount(SObj)); 
        system.debug('Pagination list'+WrappedSearchResultsList.size());
        return  wrappedSearchResultsList ;   
  }  
    /**
   * @Description: Pagination Method: getting the Search results     
   * @return :  Search Results
   **/   
  public List<Account> getlistSearchResults() {
    List<Account> listSearchResults =accountList;
    return listSearchResults;
  }
// returns the page number of the current page set
    public Integer pageNumber() {
        
            return setPaginationSelectedAccounts.getPageNumber();
                
    }
}