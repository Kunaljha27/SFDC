/*
* @ClassName : HCNA_UserListViewServiceClass 
* @Description : This class is the service class of HCNA_UserListView.This class performes the bussiness logic (functionality) of the page 
* @Author : Ramita Dutta
* @Last Modified : 2/5/2014
* @Discussionpoints : No Information
*/
public with sharing class HCNA_UserListViewServiceClass {    
    HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
    String value='';   
    /**
    * @Description : This method retriew map of fields list for object.
    * @param       : String selected object for which map of fields list to be retriew.
    * @return      : Map <String, Schema.SObjectField> of fields list
    **/
    public Map <String, Schema.SObjectField> getFieldList(String selectedObject){
        Map <String, Schema.SObjectField> fieldMap = New  Map <String, Schema.SObjectField> ();
        if(selectedObject != null){
            if(selectedObject  == 'User'){  
                fieldMap = user.sObjectType.getDescribe().fields.getMap();
            }else{
                fieldMap = Account.sObjectType.getDescribe().fields.getMap();
            }
            return fieldMap;   
        }
        else{
            return null;
        }
    }
    /**
    * @Description : This method create a filter criteria for query.
    * @param       : Map<String, String> fieldNameTypeMap, HCNA_FilterWrapper class object wraper, String criteria
    * @return      : String a filter criteria for query.
    **/
    public string getCriteria(Map<String, String> fieldNameTypeMap,HCNA_FilterWrapper wraper,String criteria){
        if(fieldNameTypeMap != null && fieldNameTypeMap.get(wraper.fieldSelected) == 'DOUBLE' || fieldNameTypeMap.get(wraper.fieldSelected) == 'INTEGER' 
           || fieldNameTypeMap.get(wraper.fieldSelected) == 'DATE' || fieldNameTypeMap.get(wraper.fieldSelected) == 'PERCENT' 
           || fieldNameTypeMap.get(wraper.fieldSelected) == 'BOOLEAN' || fieldNameTypeMap.get(wraper.fieldSelected) == 'CURRENCY' ) {
            list<string> multipleValuesList = New list<string>();
            if( wraper.Value != null && wraper.Value.contains(',')) {
                multipleValuesList = wraper.Value.split(',');
                string finalValue ='' ;                
                for(string fieldvalue : multipleValuesList) {
                    if(finalValue.length() == 0){
                        finalValue = fieldvalue; 
                    }else{
                        if(wraper.operatorSelected == '!=') {
                            finalValue += ' AND '+wraper.fieldSelected+' '+wraper.operatorSelected+' '+fieldvalue;
                        }else{
                            finalValue += ' OR '+wraper.fieldSelected+' '+wraper.operatorSelected+' '+fieldvalue;
                        }
                    }
                }
                value = finalValue; 
            }else {
                value = wraper.Value;   
            }           
        }else if(fieldNameTypeMap.get(wraper.fieldSelected) == 'REFERENCE') {
            list<string> multipleValuesList = New list<string>();
            if(wraper.lookUprecordIds != null && wraper.lookUprecordIds.contains(',')) {
                multipleValuesList = wraper.lookUprecordIds.split(',');
                string finalValue ='' ;
                for(string fieldvalue : multipleValuesList){
                    if(finalValue.length() == 0){
                        finalValue = '\''+fieldvalue +'\''; 
                    }else{
                        if(wraper.operatorSelected == '!=') {
                            finalValue += ' AND '+wraper.fieldSelected+' ' +wraper.operatorSelected+' '+'\''+fieldvalue +'\'';
                        }else {
                            finalValue += ' OR '+wraper.fieldSelected+' ' +wraper.operatorSelected+' '+'\''+fieldvalue +'\'';
                        }
                    }
                }
                value = finalValue; 
            }else if(wraper.lookUprecordIds != null) {                      
                value = '\'' + wraper.lookUprecordIds + '\'';
            }                   
        }else if(fieldNameTypeMap.get(wraper.fieldSelected) == 'PICKLIST' || fieldNameTypeMap.get(wraper.fieldSelected) == 'STRING' || fieldNameTypeMap.get(wraper.fieldSelected) == 'TEXTAREA') {
            list<string> multipleValuesList = New list<string>();
            if(wraper.Value.contains(',')) {                
                multipleValuesList = wraper.Value.split(',');
                string finalValue ='' ;
                for(string fieldvalue : multipleValuesList) {
                    if(finalValue.length() == 0) {
                        if(wraper.operatorSelected == 'Like' || wraper.operatorSelected == 'Not Like') {
                            finalValue = fieldvalue;
                        }else {
                            finalValue = '\''+fieldvalue +'\''; 
                        }
                    }else{
                        if(wraper.operatorSelected == '=') {
                            finalValue += ' OR '+wraper.fieldSelected+' '+wraper.operatorSelected+' '+'\''+fieldvalue +'\'';
                        }else if(wraper.operatorSelected == '!=') {
                            finalValue += ' AND '+wraper.fieldSelected+' '+wraper.operatorSelected+' '+'\''+fieldvalue +'\'';
                        }else if(wraper.operatorSelected == 'Like') {
                            finalValue += '%\' OR '+wraper.fieldSelected+' '+wraper.operatorSelected+' '+'\'%'+fieldvalue;
                        } else if(wraper.operatorSelected == 'Not Like') {
                            finalValue += '%\') AND (NOT '+wraper.fieldSelected+' LIKE '+'\'%'+fieldvalue;
                        }
                    }
                }
                value = finalValue; 
            } else {
                if(wraper.operatorSelected == 'Like' || wraper.operatorSelected == 'Not Like' ) {
                    value = wraper.Value;
                } else {
                    value = '\'' + wraper.Value + '\'';
                }
            } 
        }else{              
            value = '\''+ wraper.Value +'\'';
        }
        if(wraper.fieldSelected != 'None' && wraper.operatorSelected != 'None') {           
            if(criteria == NULL) {
                if( wraper.operatorSelected == 'Not Like') {
                   criteria  = '( NOT ' + wraper.fieldSelected +' Like \'%'+ Value +'%\') '; 
                }else if( wraper.operatorSelected == 'Like'){
                    criteria  = '(' + wraper.fieldSelected +' Like \'%'+ Value +'%\') '; 
                }else {               
                    criteria  = '(' + wraper.fieldSelected +' '+wraper.operatorSelected+' '+ Value + ')'; 
                }
            }else{
                if( wraper.operatorSelected == 'Not Like') {
                
                    value = value.replaceAll('\'','');
                    criteria  = criteria + 'AND ( NOT ' + wraper.fieldSelected +' Like \'%'+ Value +'%\')) ';                   
                }else if( wraper.operatorSelected == 'Like'){
                    Value = value.replaceAll('\'','');
                    criteria  = criteria + 'AND ( ' + wraper.fieldSelected +' Like \'%'+ Value +'%\') ';                     
                } else {
                    criteria = criteria +' AND'+' '+wraper.fieldSelected +' '+wraper.operatorSelected+' '+ Value;                     
                }
            }
        }       
    return criteria;
    }
    /**
    * @Description : This method create query to retriew account details according to filter criteria and fields selected.
    * @param       : List<System.SelectOption> selectedFields,String criteria,boolean z,list<String> columnLists 
    * @return      : String a query to retriew account details.
    **/
    public String getAccountDetails(List<System.SelectOption> selectedFieldsList,String criteria,boolean z,list<String> columnLists){
        string c='';
        string fields = '';
        string query = '';
        if(selectedFieldsList != null){
            for(SelectOption field: selectedFieldsList){
                if(fields == ''){
                    if(field.getValue()!= 'Id') {
                        fields = field.getValue();
                    }
                    columnLists.add(fields);
                }else{
                    c=field.getValue();
                    columnLists.add(c);
                    if(field.getValue()!= 'Id') {
                        fields  = fields + ','+field.getValue();
                    }
                }
            }
        }    
        if(criteria != NULL && criteria != '' && fields != null &&  fields !=''){
            query=dAOClass.getAccountDetails(criteria,fields);
        }else{
            if(criteria != NULL && criteria != '') {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please select at least one field to display.');
                ApexPages.addMessage(myMsg);
                z = false;
            } else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter the filter criteria.');
                ApexPages.addMessage(myMsg);  
                z = false;                          
            }
        }
    return query;   
    }
    /**
    * @Description : This method create query to retriew user details according to filter criteria and fields selected.
    * @param       : List<System.SelectOption> selectedFields,String criteria,boolean v,list<String> columnLists 
    * @return      : String a query to retriew account details.
    **/
    public String getUserDetails(List<System.SelectOption> selectedFieldsList,String criteria,boolean v,list<String> columnLists){
        string q='';
        string fields = '';
        string query = '';
        if(selectedFieldsList != null){
            for(SelectOption field: selectedFieldsList){
                if(fields == ''){
                    if(field.getValue()!= 'Id') {
                      fields = field.getValue();
                    }
                    columnLists.add(fields);
                }else{
                    q=field.getValue();
                    columnLists.add(q);
                    if(field.getValue()!= 'Id') {
                          fields  = fields + ','+field.getValue();
                    }                    
                }
            } 
        }      
        if(criteria != NULL && criteria != '' && fields != null &&  fields !=''){
            query=dAOClass.getUserDetails(criteria,fields);
        }else{
            if(criteria != NULL && criteria != '') {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please select atleast one field to display.');
                ApexPages.addMessage(myMsg);
                v = false;
            }else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter the filter criteria.');
                ApexPages.addMessage(myMsg);
                v = false;
            }
        }       
    return query;
    }
    /**
    * @Description : This method insert account team member and share according to selected account and user.
    * @param       : List<Account> selectedAccount,List<User> selectedUsers.
    * @return      : null
    **/  
    public void insertAccountTeamAndShare(List<Account> selectedAccountList,List<User> selectedUsersList,String accountAccess,String opportunityAccess,String caseAccess){
        if(selectedAccountList != null && selectedUsersList != null){
            if(accountAccess == 'Read Only'){
                accountAccess = 'Read';
            }
            if(accountAccess == 'Read/Write'){
                accountAccess = 'Edit';
            }
            if(opportunityAccess == 'Read Only'){
                opportunityAccess = 'Read';
            }
            if(opportunityAccess == 'Read/Write'){
                opportunityAccess = 'Edit';
            }
            if(opportunityAccess == 'Private'){
                opportunityAccess = 'None';
            }
            if(caseAccess == 'Read Only'){
                caseAccess = 'Read';
            }
            if(caseAccess == 'Read/Write'){
                caseAccess = 'Edit';
            }
            if(caseAccess == 'Private'){
                caseAccess = 'None';
            }
            list<AccountTeamMember> accTeamList = New list<AccountTeamMember>();
            List<AccountShare> accShareList = new List<AccountShare>();
            AccountShare accShareRecord;
            AccountTeamMember accTeamMemberRecord;
            for(Account accountRecord :selectedAccountList) {
                for(User userRecord : selectedUsersList) {
                    accShareRecord = new AccountShare();
                    accTeamMemberRecord = new AccountTeamMember();
                    accShareRecord.AccountAccessLevel=accountAccess;
                    accShareRecord.AccountId=accountRecord.id;
                    accShareRecord.CaseAccessLevel=opportunityAccess;
                    accShareRecord.OpportunityAccessLevel=caseAccess;
                    accShareRecord.UserOrGroupId=userRecord.id;
                    accTeamMemberRecord.AccountId=accountRecord.id;
                    accTeamMemberRecord.TeamMemberRole=userRecord.UserRole.name;
                    accTeamMemberRecord.UserId= userRecord.id;
                    accShareList.add(accShareRecord);
                    accTeamList.add(accTeamMemberRecord);
                }
            }            
            dAOClass.insertListOfAccountShare(accShareList);
            dAOClass.insertListOfAccountTeam(accTeamList);  
        }                  
    }                
    /**
    * @Description : This method retriew list of user based on filter criteria and fields selected.
    * @param       : String query which is to retriew list of user based on filter criteria and fields selected.
    * @return      : List of user
    **/
    public List<User> getUserList(String query){
        List<User> userList = new List<User>();
        if(query != null){
            userList=dAOClass.getUserList(query);
            return userList;
        }
        else{
            return null;
        }      
    }
    /**
    * @Description : This method retriew list of Account based on filter criteria and fields selected.
    * @param       : String query which is to retriew list of Account based on filter criteria and fields selected.
    * @return      : List of Account
    **/        
    public List<Account> getAccountList(String query){
        List<Account> accountList = new List<Account>();
        if(query != null){
            accountList=dAOClass.getAccountList(query);
            return accountList;
        }
        else{
            return null;
        }    
    }
}