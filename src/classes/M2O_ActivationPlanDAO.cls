/**
* @ClassName : M2O_ActivationPlan_DAO
* @Description : This class is the DAO class of M2O_ActivationPlan_VF.This class performes database related action of the page(SOQL and DML)
* @Author : Albin Deni Arul
* @Last Modified : 26/11/2013
* @Discussionpoints No Information
*/
public with sharing class M2O_ActivationPlanDAO {
    
    /**
    * @Description : This method retrevies the existing Activities associated to the Strategic Account plan
    * @param       : Id of Strategic Account Plan parent record
    * @return      : List of Activation plan records
    **/
    public list<Activation_Plan__c> retrevieActivationPlans(ID strategicAccountPlanId) {
        list<Activation_Plan__c> retreviedActivationPlans = new list<Activation_Plan__c>();
        try {
             if(strategicAccountPlanId != null) {
                retreviedActivationPlans = [select Id,Type__c,Category__c,Activity_Detail__c ,Activity_End_Date__c,Activity_Start_Date__c,Activity_Status__c,Strategic_account_plan__c from Activation_plan__c where Strategic_account_plan__c =: strategicAccountPlanId and IsDummyRecord__c=: false];
             }
             return retreviedActivationPlans;
        }
        catch(Exception exceptionMessage) {
              system.debug(exceptionMessage.getmessage());
              return null;
        }
    }
    
    /**
    * @Description : This method retrevies the record which is used to add the attachment
    * @param       : Id of Strategic Account Plan parent record
    * @return      : Attachment record
    **/
    public Activation_Plan__c retriveAttachmentRecord(ID strategicAccountPlanId) {
        Activation_Plan__C attachmentRecord = new Activation_Plan__c();
        try {
             if(strategicAccountPlanId != null){
                attachmentRecord = [select Id,Strategic_account_plan__r.From_date__c, Strategic_account_plan__r.To_date__c from Activation_plan__C where Strategic_account_plan__c =: strategicAccountPlanId and IsDummyRecord__c=: true limit 1];
             }
            return attachmentRecord;
        }
        catch(Exception exceptionMessage) {
               system.debug(exceptionMessage.getmessage()); 
               return null;
        }
    } 
      
    /**
    * @Description : This method retrevies current users access on the Activation plan
    * @param1      : Id of current user
    * @param2      : Id of Strategic Account Plan parent record
    * @return      : User record access
    **/
    public UserRecordAccess retriveCurrentUserAccess(Id currentUserId, ID strategicAccountPlanId) {
        UserRecordAccess access;
        try {
             if(currentUserId != null && strategicAccountPlanId != null) {
                access = [SELECT RecordId, HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUserId AND RecordId = :strategicAccountPlanId limit 1];
             }
            return access;
        }
        catch(Exception exceptionMessage) {
              system.debug(exceptionMessage.getmessage());
              return null;
        }
    }
    
    /**
    * @Description : This method inserts the new activity in database
    * @param       : Acctivation plan record for insert
    * @return      : Inserted record
    **/
    public Activation_Plan__c addActivityToDatabase(Activation_Plan__c activityToDataBase) {
        try {
             if(activityToDataBase != null) {
                insert activityToDataBase;
              }
            return activityToDataBase;
        }
        catch(DMLException exceptionMessage) {
              system.debug(exceptionMessage.getmessage());
              return null;
        }
        
    } 
    
    /**
    * @Description : This method updates the existing activity in database
    * @param       : Acctivation plan record for update
    * @return      : Updated record
    **/
     public Activation_Plan__c updateActivityToDatabase(Activation_Plan__c activityToDataBase) {      
        try {
             if(activityToDataBase != null) {
                update activityToDataBase;
             }
            return activityToDataBase;
        } 
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage()); 
            return null;
        }    
    }
    
    /**
    * @Description : This method deletes the existing activity in database
    * @param       : Acctivation plan record for delete
    * @return      : Null
    **/
    public void deleteActivityFromDatabase(Activation_Plan__c activityToDataBase) {
        try {
             if(activityToDataBase != null) {
                delete activityToDataBase;
             }
        } 
        catch(DMLException exceptionMessage) {
             system.debug(exceptionMessage.getmessage());
        }    
    }
    /**
    * @Description : This method retrevies retrieves SAP record information.
    * @param       : SAP record ID.
    * @return      : SAP record.
    **/
    public static strategic_account_plan__c querySapRecord(ID SAPID) {
        strategic_account_plan__c recordSAP = new strategic_account_plan__c();
        try {
            if(SAPID != null) {
                recordSAP=[Select ID, Name, Philips_Sector__c from strategic_account_plan__c where Id=:SAPID];
            }
            return recordSAP;
        }
        catch(Exception e) {
          
            system.debug('Fail to Query on Strategic Account Plan '+e.getMessage());
            return null;
        }
    }     
}