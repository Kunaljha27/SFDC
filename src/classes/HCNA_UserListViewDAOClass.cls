/**
* @ClassName : HCNA_UserListViewDAOClass 
* @Description : This class is the DAO class of HCNA_UserListView Class.This class performes database related action of the page(SOQL and DML)
* @Author : Ramita Dutta
* @Last Modified : 
* @Discussionpoints :
*/
public with sharing class HCNA_UserListViewDAOClass {
    /**    
    * @Description : This method generate query to retrevies user details based on filter criteria and fields to fetch    
    * @param       : String Criteria for filter and String fields to fetch   
    * @return      : String query to retrevie user details   
    **/
    public String getUserDetails(String Criteria,string fields){
        try{
            if((Criteria != null)&&(fields != null)){
                string query = '';
                query = 'Select id,UserRole.name,'+fields +' from user where '+ criteria+' Limit 100' ;
                return query;
            }
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**    
    * @Description : This method retrevies user details    
    * @param       : String Query to retrevies user details   
    * @return      : List of user record   
    **/
    public List<User> getUserList(String query){
        try{
            if(query != null){
            List<User> userList = new List<User>();
                userList=Database.query(query);
                return userList;
            }
            else{
                return null;
            }
        } 
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }                        
    }
    /**    
    * @Description : This method generate query to retrevies Account details based on filter criteria and fields to fetch    
    * @param       : String Criteria for filter and String fields to fetch   
    * @return      : String query to retrevie Account details   
    **/
    public String getAccountDetails(String Criteria,string fields){
        try{
            if((Criteria != null)&&(fields != null)){
                String query= '';
                query = 'Select id,'+fields +' from Account where '+ criteria +'Limit 100' ;
                return query;
            }
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }        
    }
    /**    
    * @Description : This method retrevies Account details    
    * @param       : String Query to retrevies Account details   
    * @return      : List of Account record   
    **/
    public List<Account> getAccountList(String query){
        try{
            if(query != null){
            List<Account> accountList = new List<Account>();
                accountList=Database.query(query);
                return accountList;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }                  
    }
    /**    
    * @Description : This method insert List Of AccountShare  
    * @param       : List Of AccountShare to be inserted   
    * @return      : null   
    **/
    public void insertListOfAccountShare(List<AccountShare> lstAccShare){
        try{
            if(lstAccShare != null){
                Database.insert(lstAccShare,false);
            }
        }                                    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }        
    }
    /**    
    * @Description : This method insert List Of AccountTeamMember
    * @param       : List Of AccountTeamMember to be inserted   
    * @return      : null   
    **/
    public void insertListOfAccountTeam(list<AccountTeamMember> accTeamList){
        try{
            if(accTeamList != null){
                Database.insert(accTeamList,false);
            }
        }                                    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }
    }
}