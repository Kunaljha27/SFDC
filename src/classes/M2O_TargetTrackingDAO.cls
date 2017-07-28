/**
* @ClassName : M2O_TargetTrackingDAO
* @Description : This class is the DOA class of M2O_FinancialTracking VF Page. This class performes database related action of the page(SOQL and DML)>
* @Author : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/

public with sharing class M2O_TargetTrackingDAO {
    
    /**
    * @Description : This method retrevies retrieves SAP recrod acess information.
    * @param       : Current User ID and SAP record ID.
    * @return      : UserRecordAccess Object, which containts Visibility information of SAP record.
    **/
  
    public static UserRecordAccess getRecordAccess(ID currentUser, ID SAPID) {
        UserRecordAccess hasaccess = new UserRecordAccess();
        
        try {
            if(currentUser != null && SAPID != null) {
                hasaccess=[SELECT RecordId,HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUser AND RecordId = :SAPID limit 1];
            }
            return Hasaccess;
        }
        catch(Exception e) {
            system.debug('Query failed for UserAccess' + e.getMessage());
            return null;
        }
    }
    
    /**
    * @Description : This method retrevies retrieves SAP recrod type information.
    * @param       : SAP record ID.
    * @return      : Record Type ID.
    **/
    public static ID getRecordType(ID SAPID) {
        ID sapRecordTypeID;
        
        try {
            if(SAPID != null) {
            sapRecordTypeID= ([Select Id , recordTypeID from Strategic_Account_Plan__c where ID = :SAPID]).recordTypeID;
            }
            return sapRecordTypeID;
        }
        catch(Exception e) {
            system.debug('Query failed for Strategic Account Plan record' + e.getMessage());ApexPages.addMessages(e);
            return null;
        }
    }
    
    
    /**
    * @Description : This method retrevies retrieves SAP recrod type information.
    * @param       : SAP record ID.
    * @return      : Record Type ID.
    **/
    public static List<Target_Tracking__C> getTargetTrackData(ID SAPID) {
        List<Target_Tracking__C> targetTrackList = new List<Target_Tracking__C>();
        
        try {
            if(SAPID != null) {
            targetTrackList = [Select Key_Product__c, Business__c ,Jan_Actual__c,Feb_Actual__c,Mar_Actual__c,Apr_Actual__c,May_Actual__c,Jun_Actual__c,Jul_Actual__c,Aug_Actual__c,Sep_Actual__c,Oct_Actual__c,Nov_Actual__c,Dec_Actual__c ,Jan_Target__c ,Feb_Target__c ,Mar_Target__c ,Apr_Target__c ,May_Target__c ,Jun_Target__c ,Jul_Target__c ,Aug_Target__c ,Sep_Target__c ,Oct_Target__c ,Nov_Target__c ,Dec_Target__c from Target_Tracking__c where Strategic_Account_plan__c=:SAPID order by ID asc];
            }
            return targetTrackList;
        }
        catch(Exception e) {
            system.debug('Query failed for Target tracking record ' + e.getMessage());
            return null;
        }
    }
    
    /**
    * @Description : This method Insets/Updates Finacial Tracking Records and also updates From Month on SAP.
    * @param       : SAP record and List of Financial Tracking records to be Inserted/ Updated.
    * @return      : Its a void method and returns null.
    **/
    public static boolean save(List<Target_Tracking__c> listTargetTrack ) {
        
        try {  
            upsert listTargetTrack;
            return true;
        } catch(System.DMLexception e) {
             system.debug('Update failed'+ e.getMessage());
            return false ;
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
                recordSAP=[Select ID,recordTypeID ,Philips_Sector__c from strategic_account_plan__c where Id=:SAPID order by ID asc];
            }
            return recordSAP;
        }
        catch(Exception e) {
          
            system.debug('Fail to Query on Strategic Account Plan '+e.getMessage());
            return null;
        }
    } 
}