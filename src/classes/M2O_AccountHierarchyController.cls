/**
@Classname :       M2O_AccountHierarchyController
@Description :     This class is querying account fields and parent account and building the hierarchy
@Last Modified:    19/4/2014
**/

public with sharing class M2O_AccountHierarchyController{
    
    // Declaration of Variables
    public static JSONGenerator JSONGeneratorObj {get; set;}
    public transient List<String> accountNodesList{get;set;}      
    public Map<id,List<Account>>accountListChildrenMap;
    Account currentAccount;
    public String currentAccountId{get;set;}
  //  public string hierarchyType{get;set;}
    public String searchString{get;set;}
    public Boolean hasMoreRecord;
    String topMostParentID; //, topMostIDN
  //  public Boolean showIDN{get;set;}
    Set<Id> profileIdSet = new Set<Id>();
    public List<accountWrapper> accountNodeCreateList;
    public List<Account> accountParentChildList;
    
    //Constructor call
    public M2O_AccountHierarchyController(ApexPages.StandardController controller){
     //   hierarchyType = 'Account';  
        hasMoreRecord = false;     
     /*   //restricting IDN hierarchy visibility from M2O users
        for(Profile pr : [Select Id, name from profile where Name LIKE 'M2O%']){
            profileIdSet.add(pr.Id);
        }
        if(profileIdSet.contains(userInfo.getProfileId())){
            showIDN = false;
        }else{
            showIDN = true;
        }    */
        currentAccountId = ApexPages.currentPage().getParameters().get('id');
        currentAccount = M2O_HierarchyService.getCurrentAccountRecord(currentAccountId);
         if(currentAccount.Level_1_Parent__c != Null)
            topMostParentID = currentAccount.Level_1_Parent__c; 
        else
            topMostParentID = currentAccount.Id;          
    }
    
    // Below method parses all Parent Accounts and adds them to JSON String which is rendered on VF as Tree Structure.
    public void generateTreeStructureForAccounts(){        
        accountNodeCreateList = new List<accountWrapper>();
        accountListChildrenMap = new Map<Id,List<Account>>();
        accountParentChildList = new List<Account>();
        accountNodesList = new List<String>();
     //   if(hierarchyType == 'Account'){
            if(currentAccount.Level_1_Parent__c != Null)
                accountParentChildList = M2O_HierarchyService.getParentChildRecord(currentAccount.Level_1_Parent__c, hasMoreRecord, currentAccountId); 
            else
                accountParentChildList = M2O_HierarchyService.getParentChildRecord(String.valueOf(currentAccount.Id), hasMoreRecord, currentAccountId); 
     /*   }else if(hierarchyType == 'Commercial Parent'){
            system.debug('test class print >>>>>> '+currentAccountId + '    '+ currentAccount.Inactive_Flag__c );
            accountParentChildList = M2O_HierarchyService.getParentChildRecordForIDN(currentAccountId, hasMoreRecord); 
            if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
                for(Account acc : accountParentChildList){
                    if(acc.Parent_IDN_of_Associated_IDN__c != Null){
                        topMostIDN = acc.Parent_IDN_of_Associated_IDN__c;
                    }else if(acc.Associated_IDN__c != Null){
                        topMostIDN = acc.Associated_IDN__c;
                    }else{
                        topMostIDN = acc.Id;
                    }
                }
            }
        }  */      
        //If account list has more than 1000 records, display message for downlaoding report on page
        if(accountParentChildList != Null && !accountParentChildList.isEmpty() && accountParentChildList.size() > 1000){
            ApexPages.Message exportMoreMsg = new ApexPages.Message(ApexPages.Severity.INFO,+'To view the entire hierarchy please export in a report');
            ApexPages.addMessage(exportMoreMsg);
        }
        if(accountParentChildList != Null && !accountParentChildList.isEmpty()) {      
           createParentChildMap(accountParentChildList); //, hierarchyType
        } 
        // Generating Tree Strucutre for all Parent Account.             
        if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
            for(Account acc : accountParentChildList){
                // Initializing JSON Generator Object.
                JSONGeneratorObj = JSON.createGenerator(true);            
             /*   if((hierarchyType == 'Account' && acc.Id == topMostParentID)
                 || (hierarchyType == 'Commercial Parent' && acc.Id == topMostIDN)){ */
                 if(acc.Id == topMostParentID){
                    accountWrapper node = createTreeStructure(acc);
                    accountNodeCreateList.add(node);
                }
            } 
        } 
        system.debug('%%%%%%%%%%%%%%%%%%%%% accountNodeCreateList '+accountNodeCreateList);
        if(accountNodeCreateList != Null && !accountNodeCreateList.isEmpty()){
            convertNodeToJSON(accountNodeCreateList);
            accountNodesList.add(JSONGeneratorObj.getAsString());
        }
        system.debug('^^^^^^^^^^^^ accountNodesList '+accountNodesList);
        accountNodeCreateList.clear();       
    }
    
    //Create Parent child account Map
    public void createParentChildMap(List<Account> accountParentChildList){ //, String hierarchyType
        List<Account> tempAccountsList;        
        if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
          //  if(hierarchyType == 'Account'){
                for(Account acc : accountParentChildList) {      
                    if(accountListChildrenMap.get(acc.ParentId) == null) {
                        tempAccountsList = new List<Account>();
                    }else {               
                        tempAccountsList = accountListChildrenMap.get(acc.ParentId);
                    }
                    tempAccountsList.add(acc);
                    accountListChildrenMap.put(acc.ParentId,tempAccountsList);
                }
          /*  }else if(hierarchyType == 'Commercial Parent'){
                for(Account acc : accountParentChildList) {      
                    if(accountListChildrenMap.get(acc.Associated_IDN__c) == null) {
                        tempAccountsList = new List<Account>();
                    }else {               
                        tempAccountsList = accountListChildrenMap.get(acc.Associated_IDN__c);
                    }
                    tempAccountsList.add(acc);
                    accountListChildrenMap.put(acc.Associated_IDN__c,tempAccountsList);
                }
            } */
        }
        system.debug('%%%%%%%%%%%%%% '+accountListChildrenMap);
    } 
    
    
    //Below method creates Parent and Child Nodes for each Accounts and returns instance of accountWrapper (Wrapper class)
    public accountWrapper createTreeStructure(Account acc){ 
        system.debug(accountListChildrenMap.get(acc.id) +'  createTreeStructure call'+acc.Name);
        accountWrapper wrpObj = new accountWrapper();
        wrpObj.accWrap = acc;
        List<accountWrapper>childAccountList;
        if(accountListChildrenMap.get(acc.id) != null){
            wrpObj.hasChildren = true;
            childAccountList = new List<accountWrapper>();
            for(Account acObj : accountListChildrenMap.get(acc.id)){
                accountWrapper accWrap = createTreeStructure(acObj);
                childAccountList.add(accWrap);
            }           
        }else{
             wrpObj.hasChildren =false;   
        }   
        wrpObj.accWrapChildNode = childAccountList;
        system.debug('>>>>>>>>>>>>>>>>>>>. wrpObj '+wrpObj);
        return wrpObj;        
    } 
    
    //Below method converts  instance of each Account Node(Wrapper class) into JSON.
    // Creating Account Nodes in JSON format which are also attributes of DynaTree JQuery used in VisualForce.   
    public void convertNodeToJSON(List<accountWrapper> accNodeList){ 
        List<accountWrapper> accountNodeCreateList;
        system.debug('$$$$$$$$$$$ accNodeList '+ accNodeList);
        if(accNodeList != Null && !accNodeList.isEmpty()){
            for(accountWrapper accNode : accNodeList){ 
                if(!test.isRunningTest()){
                    JSONGeneratorObj.writeStartObject();
                    JSONGeneratorObj.writeStringField('title', accNode.accWrap.Name+'@'+accNode.accWrap.id+'@'+(accNode.accWrap.Account_Name_Global__c==null?'':accNode.accWrap.Account_Name_Global__c)+'@'+(accNode.accWrap.Golden_Record_Key__c==null?'':accNode.accWrap.Golden_Record_Key__c)+'@'+(accNode.accWrap.Housenumber_Local__c==null?'':accNode.accWrap.Housenumber_Local__c)+'@'+(accNode.accWrap.Street1_Local__c==null?'':accNode.accWrap.Street1_Local__c)+'@'+(accNode.accWrap.City_Local__c==null?'':accNode.accWrap.City_Local__c)+'@'+(accNode.accWrap.Zip_Postal_Code_Local__c==null?'':accNode.accWrap.Zip_Postal_Code_Local__c)+'@'+(accNode.accWrap.Organization_Level__c==null?'':accNode.accWrap.Organization_Level__c));
                    JSONGeneratorObj.writeStringField('key', accNode.accWrap.Id);
                    JSONGeneratorObj.writeBooleanField('unselectable', false);
                    JSONGeneratorObj.writeBooleanField('expand', true);
                    JSONGeneratorObj.writeBooleanField('isFolder', false);
                    JSONGeneratorObj.writeBooleanField('icon', false);
                    
                    // Below condition checks for any child Account available for each Parent account.
                    if(accNode.hasChildren ){  
                        accountNodeCreateList = new List<accountWrapper>(); 
                        // Below line disables Radio buttons for all Parent Accounts.
                        JSONGeneratorObj.writeBooleanField('hideCheckbox',true);
                        JSONGeneratorObj.writeFieldName('children');
                        JSONGeneratorObj.writeStartArray();                       
                        // Iterating each child Account and adding further child Accounts to Tree nodes by calling convertNodeToJSON method recursively.
                        for(accountWrapper accWrap : accNode.accWrapChildNode){
                            convertNodeToJSONChild(accWrap);                   
                        }  
                        JSONGeneratorObj.writeEndArray();           
                    }
                    JSONGeneratorObj.writeEndObject();
                }
            }     
        }
    }
    
    //Getting child nodes converted in json format
    public void convertNodeToJSONChild(accountWrapper accNode){        
        // Creating Account Nodes in JSON format which are also attributes of DynaTree JQuery used in VisualForce.      
        if(!test.isRunningTest()){
            JSONGeneratorObj.writeStartObject();
            JSONGeneratorObj.writeStringField('title', accNode.accWrap.Name+'@'+accNode.accWrap.id+'@'+(accNode.accWrap.Account_Name_Global__c==null?'':accNode.accWrap.Account_Name_Global__c)+'@'+(accNode.accWrap.Golden_Record_Key__c==null?'':accNode.accWrap.Golden_Record_Key__c)+'@'+(accNode.accWrap.Housenumber_Local__c==null?'':accNode.accWrap.Housenumber_Local__c)+'@'+(accNode.accWrap.Street1_Local__c==null?'':accNode.accWrap.Street1_Local__c)+'@'+(accNode.accWrap.City_Local__c==null?'':accNode.accWrap.City_Local__c)+'@'+(accNode.accWrap.Zip_Postal_Code_Local__c==null?'':accNode.accWrap.Zip_Postal_Code_Local__c)+'@'+(accNode.accWrap.Organization_Level__c==null?'':accNode.accWrap.Organization_Level__c));
            JSONGeneratorObj.writeStringField('key', accNode.accWrap.Id);
            JSONGeneratorObj.writeBooleanField('unselectable', false);
            JSONGeneratorObj.writeBooleanField('expand', true);
            JSONGeneratorObj.writeBooleanField('isFolder', false);
            JSONGeneratorObj.writeBooleanField('icon', false);
            
            // Below condition checks for any child Accounts available for each Parent Account.
            if(accNode.hasChildren ){                
                // Below line disables Radio buttons for all Parent Accounts.
                JSONGeneratorObj.writeBooleanField('hideCheckbox',true);
                JSONGeneratorObj.writeFieldName('children');
                JSONGeneratorObj.writeStartArray();                       
                // Iterating each child Account and adding further child Accounts to Tree nodes by calling convertNodeToJSON method recursively.
                for(accountWrapper temp:accNode.accWrapChildNode){
                   convertNodeToJSONChild(temp);                  
                }                  
                JSONGeneratorObj.writeEndArray();           
            }
            JSONGeneratorObj.writeEndObject();   
        } 
    }
    
    //Method provides the radiobuttons for Hierarchy
  /*  public List<SelectOption> getHierarchyOptions() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Account','Account Hierarchy')); 
        options.add(new SelectOption('Commercial Parent','Commercial Hierarchy')); 
        return options; 
    } */
    
    //Below function is switches to selected hierarchy
    public void getHierarchy(){
        generateTreeStructureForAccounts();
    }
    
    //Export hierarchy in report format
    public PageReference ExportToExcel() {
        PageReference exportToExcel = Page.M2O_AccountExportToExcel;
        exportToExcel.getParameters().put('AccountID', currentAccountId);
     //   exportToExcel.getParameters().put('hierarchyType', hierarchyType);
        exportToExcel.setRedirect(true);
        return exportToExcel;
        return null;
    }
    
    // Below class wraps Accounts,List of Child Accounts and boolean variable for childs present for each Parent Accounts
    public class accountWrapper{        
        public List<accountWrapper>accWrapChildNode;
        public Boolean hasChildren;           
        public Account accWrap;     
    } 
}