/**
@Classname :       M2O_AccountExportExcelController 
@Description :     This class is for downlaoding report for account and IDN
@Last Modified:    19/4/2014
**/

public with sharing class M2O_AccountExportExcelController {
    public String currentAccountId{get;set;}
  //  public String currentAccounthierarchyType ;
    public Account currentAccount;
    public Boolean hasMoreRecord;
  //  public Boolean accountHierarchy{get;set;}
    public List<Account> accountList{get;set;}
    public List<accountWrapper> accountNodeList{get;set;}
    public List<accountWrapperValueDisplay> accountDisplayList{get;set;}
    public Map<id,List<Account>>accountListChildrenMap;
    String topMostParentID; //, topMostIDN
    public List<accountWrapper> accountNodeCreateList;    
    
    public M2O_AccountExportExcelController(ApexPages.StandardController controller) {
        accountList = new List<Account>();
        hasMoreRecord = true;
        currentAccountId = ApexPages.currentPage().getParameters().get('AccountID');
        system.debug('@@@@@@@@@@@@@@@@ currentAccountId  '+currentAccountId );
     //   currentAccounthierarchyType = ApexPages.currentPage().getParameters().get('hierarchyType');
        currentAccount = M2O_HierarchyService.getCurrentAccountRecord(currentAccountId);
      /*  if(currentAccounthierarchyType == 'Account'){
            accountHierarchy = true;
        }else{
            accountHierarchy = false;
        }*/
     //   if(currentAccounthierarchyType == 'Account'){
         system.debug('@@@@@@@@@@@@@@@@ currentAccount '+currentAccount);
            if(currentAccount.Level_1_Parent__c != Null){
                accountList = M2O_HierarchyService.getParentChildRecord(currentAccount.Level_1_Parent__c, hasMoreRecord, currentAccountId);
            }else{
                accountList = M2O_HierarchyService.getParentChildRecord(String.valueOf(currentAccount.Id), hasMoreRecord, currentAccountId); 
            }
       /* }else{
            accountList = M2O_HierarchyService.getParentChildRecordForIDN(currentAccount.Id, hasMoreRecord);
            if(accountList != Null && !accountList.isEmpty()){
                for(Account acc : accountList){
                    if(acc.Parent_IDN_of_Associated_IDN__c != Null){
                        topMostIDN = acc.Parent_IDN_of_Associated_IDN__c;
                    }else if(acc.Associated_IDN__c != Null){
                        topMostIDN = acc.Associated_IDN__c;
                    }else{
                        topMostIDN = acc.Id;
                    }
                }
            }
        } */ 
        if(currentAccount.Level_1_Parent__c != Null)
            topMostParentID = currentAccount.Level_1_Parent__c; 
        else
            topMostParentID = currentAccount.Id;  
        generateTreeStructureForAccounts();      
    }
    
    // Below method parses all Parent Accounts and adds them to JSON String which is rendered on VF as Tree Structure.
    public void generateTreeStructureForAccounts(){   
        accountDisplayList = new List<accountWrapperValueDisplay>();
        accountNodeList = new List<accountWrapper>();
        accountListChildrenMap = new Map<Id,List<Account>>();
        system.debug('>>>>>>>>>>>>>>>>> accountList '+accountList);
        
        if(accountList != Null && !accountList.isEmpty()) {      
           createParentChildMap(accountList); //, currentAccounthierarchyType 
        } 
        // Generating Tree Strucutre for all Parent Account.             
        if(accountList != Null && !accountList.isEmpty()){
            accountWrapperValueDisplay display = new accountWrapperValueDisplay();
            for(Account acc : accountList){     
               /* if((currentAccounthierarchyType  == 'Account' && acc.Id == topMostParentID) ||
                    (currentAccounthierarchyType  == 'Commercial Parent' && acc.Id == topMostIDN)){ */
                if(acc.Id == topMostParentID){
                    accountWrapper node = createTreeStructure(acc);
                    accountNodeList.add(node);
                }
            } 
        } 
        system.debug('%%%%%%%%%%%%%%%%%%%%% accountNodeList '+accountNodeList);   
        if(accountNodeList != Null && !accountNodeList.isEmpty()){
         //   populateDisplayList(accountNodeList);           
        }
    }

    //Populate display list
  /*  public void populateDisplayList(List<accountWrapper> accNodeList){  
        accountDisplayList = new List<accountWrapperValueDisplay>();          
        for(accountWrapper aWrap : accountNodeList){
            accountWrapperValueDisplay display = new accountWrapperValueDisplay();
            display.allAccWrapVal = aWrap.accWrap;
            accountDisplayList.add(display);
            system.debug('@@@@@@@@@@@@@@ accountDisplayList   '+accountDisplayList);
            if(aWrap.hasChildren){
                for(accountWrapper accWrap : aWrap.accWrapChildNode){
                    populateDisplayListChild(display, accWrap, accountDisplayList);                   
                }
            } 
        }
    }
    
    //Populate display list children
    public void populateDisplayListChild(accountWrapperValueDisplay display, accountWrapper accNode, List<accountWrapperValueDisplay> accountDisplayList){ 
        display.allAccWrapVal = accNode.accWrap;
        accountDisplayList.add(display);
        system.debug('$$$$$$$$$$$$$$$$$$ accountDisplayList    '+accountDisplayList);
        if(accNode.hasChildren ){     
            for(accountWrapper accWrap : accNode.accWrapChildNode){
                populateDisplayListChild(display, accWrap, accountDisplayList);                   
            }
        }
    }*/
    
    //Create Parent child account Map
    public void createParentChildMap(List<Account> accountParentChildList){  //, String currentAccounthierarchyType 
        List<Account> tempAccountsList;        
        if(accountParentChildList != Null && !accountParentChildList.isEmpty()){
          //  if(currentAccounthierarchyType  == 'Account'){
                for(Account acc : accountParentChildList) {      
                    if(accountListChildrenMap.get(acc.ParentId) == null) {
                        tempAccountsList = new List<Account>();
                    }else {               
                        tempAccountsList = accountListChildrenMap.get(acc.ParentId);
                    }
                    tempAccountsList.add(acc);
                    accountListChildrenMap.put(acc.ParentId,tempAccountsList);
                }
         /*   }else if(currentAccounthierarchyType  == 'Commercial Parent'){
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
        accountWrapper wrpObj = new accountWrapper();
        accountWrapperValueDisplay wrap = new accountWrapperValueDisplay();
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
        system.debug(wrap.allAccWrapVal +'   >>>>>>>>>>>>>>>>>>>. wrpObj '+wrpObj);
        wrap.allAccWrapVal = wrpObj;
        system.debug('&&&&&&&&&&&&&&&&&&&&. wrap.allAccWrapVal'+wrap.allAccWrapVal);
        accountDisplayList.add(wrap);
        system.debug('############## accountDisplayList    '+accountDisplayList);
        return wrpObj;        
    } 
    
    public class accountWrapper{        
        public List<accountWrapper>accWrapChildNode{get;set;}
        public Boolean hasChildren{get;set;}           
        public Account accWrap{get;set;}
    }
    
    public class accountWrapperValueDisplay{
        public accountWrapper allAccWrapVal{get;set;}     
    }
}