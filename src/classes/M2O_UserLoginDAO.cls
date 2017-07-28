/****
Description : M2O_UserLoginDAO class is used for the querrying out the user information of thr curent logged in user .
Class Name : M2O_UserLoginDAO
****/

Public with sharing Class M2O_UserLoginDAO {
     /**
    * @Description : This method retrieves user info by providing user Id data.
    * @param       : User Id.
    * @return      : User.
    **/
    Public User getCurrentUserInfo (Id currentUsrId) { 
        try {
            User usr = [Select LastLoginDate from User where id =:currentUsrId];
            return usr;
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
           /** for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
                error.Exception__c=e.getDmlMessage(i);
            }
            insert error;**/
            return null;
        }
    }
    
     /**
    * @Description : This method retrieves user all login history info by providing user Id data.
    * @param       : User Id.
    * @return      : List of login history.
    **/
    public list<LoginHistory> getAllLoginList (Id currentUsrId) {
        try {
        if(currentUsrId!=null || currentUsrId!=''){
            list<LoginHistory> allLoginList=[Select LoginTime,LoginType,SourceIp,ApiType,Status,Browser from LoginHistory where  UserId=:currentUsrId];
            return allLoginList;
        
        }
        else {
        return null;
        }
        }
        
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            //for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
               // error.Exception__c=e.getDmlMessage(i);
            //}
           // insert error;
            return null;
        }
    }
    
    /**
    * @Description : This method retrieves user login  info by providing user Id data.
    * @param       :  User Id.
    * @return      : AuthSession.
    **/
    public AuthSession getUserLogin(Id currentUsrId) {
        try {
        if(currentUsrId!=null || currentUsrId!=''){
            AuthSession userLogin = [SELECT ParentId,SourceIp,UsersId,LastModifiedDate,CreatedDate From AuthSession where UsersId=:currentUsrId limit 1];
            return userLogin;
        
        }
        else {
        return null;
        }
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            //for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
                //error.Exception__c=e.getDmlMessage(i);
           // }
            //insert error;
            return null;
        }    
    }
    
    /**
    * @Description : This method retrieves user all login history info by providing user Id data.
    * @param       : Current time and User Id.
    * @return      : List of login history.
    **/
    public LoginHistory getuserLoginHistory (AuthSession userLogin,Id currentUsrId) {
        try {
        if(currentUsrId!=null || currentUsrId!=''){
            LoginHistory userLoginHistory=[Select LoginTime,LoginType,SourceIp from LoginHistory where loginTime <:userLogin.CreatedDate and UserId=:currentUsrId  limit 1];
            return userLoginHistory;
        }
        else {
        return null;
        }
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            //for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
                //error.Exception__c=e.getDmlMessage(i);
            //}
           // insert error;
            return null;
        }
    }
    
    /**
    * @Description : This method retrieves user all concurrent login info by providing user Id data.
    * @param       : User Id.
    * @return      : List of AuthSession.
    **/
    public list<AuthSession> getConcurrentLoginList (Id currentUsrId) {
        try {
        if(currentUsrId!=null || currentUsrId!=''){
            list<AuthSession> concurrentLoginList=[Select ParentId,SourceIp,UsersId,LastModifiedDate,CreatedDate,SessionType,LoginType From AuthSession where UsersId=:currentUsrId];
            return concurrentLoginList;
        }
        
        else {
        return null;
        }
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
           // for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
               // error.Exception__c=e.getDmlMessage(i);
           // }
           // insert error;
            return null;
        }
    } 
}