public with sharing class M2O_SimpleHierarchyController {
    Account currentAccount;
    public Boolean isLevel1{get;set;}
    public ID level1ID{get;set;}
    public String level1Country{get;set;}
    public String level1Global{get;set;}
    public Boolean isLevel2{get;set;}
    public ID level2ID{get;set;}
    public String level2Country{get;set;}
    public String level2Global{get;set;}
    public Boolean isLevel3{get;set;}
    public ID level3ID{get;set;}
    public String level3Country{get;set;}
    public String level3Global{get;set;}
    public Boolean isLevel4{get;set;}
    public ID level4ID{get;set;}
    public String level4Country{get;set;}
    public String level4Global{get;set;}
      

    public M2O_SimpleHierarchyController(ApexPages.StandardController controller) {
        currentAccount = new Account();
        currentAccount = (Account)controller.getRecord();
        isLevel1 =false;
        isLevel2 =false;
        isLevel3 =false;
        isLevel4 =false;        
        if(currentAccount.ParentID != null) {
            isLevel1 = true;
            if(currentAccount.Parent.ParentID != null) {
                isLevel2 = true;
                if(currentAccount.Parent.Parent.ParentID != null) {
                    isLevel3 = true;
                    if(currentAccount.Parent.Parent.Parent.ParentID != null) {
                        isLevel4 = true;
                    }            
                }
            }
        }
        if(isLevel4) {
            level1ID = currentAccount.Parent.Parent.Parent.ParentID;
            level2ID = currentAccount.Parent.Parent.ParentID;
            level3ID = currentAccount.Parent.ParentID;
            level4ID = currentAccount.ParentID;
            level1Country = currentAccount.Parent.Parent.Parent.Parent.Country__c;
            level2Country = currentAccount.Parent.Parent.Parent.Country__c;
            level3Country = currentAccount.Parent.Parent.Country__c;
            level4Country = currentAccount.Parent.Country__c;
            level1Global = currentAccount.Parent.Parent.Parent.Parent.Account_Name_Global__c;
            level2Global = currentAccount.Parent.Parent.Parent.Account_Name_Global__c;
            level3Global = currentAccount.Parent.Parent.Account_Name_Global__c;
            level4Global = currentAccount.Parent.Account_Name_Global__c;

        } else if(isLevel3) {
            level1ID = currentAccount.Parent.Parent.ParentID;
            level2ID = currentAccount.Parent.ParentID;
            level3ID = currentAccount.ParentID;
            level1Country = currentAccount.Parent.Parent.Parent.Country__c;
            level2Country = currentAccount.Parent.Parent.Country__c;
            level3Country = currentAccount.Parent.Country__c;
            level1Global = currentAccount.Parent.Parent.Parent.Parent.Account_Name_Global__c;
            level2Global = currentAccount.Parent.Parent.Parent.Account_Name_Global__c;
            level3Global = currentAccount.Parent.Parent.Account_Name_Global__c;
        } else if(isLevel2) {
            level1ID = currentAccount.Parent.ParentID;
            level2ID = currentAccount.ParentID;
            level1Country = currentAccount.Parent.Parent.Country__c;
            level2Country = currentAccount.Parent.Country__c;   
            level1Global = currentAccount.Parent.Parent.Parent.Parent.Account_Name_Global__c;
            level2Global = currentAccount.Parent.Parent.Parent.Account_Name_Global__c;         
        } else if(isLevel1) {
            level1ID = currentAccount.ParentID;
            level1Country = currentAccount.Parent.Country__c;
            level1Global = currentAccount.Parent.Parent.Parent.Parent.Account_Name_Global__c;
        }
    }

}