/**
* @ClassName :M2O_FinancialTrackingDAO
* @Description :This Dao class is been used to perform any DML action on Financial Tracking object.
* @Author :Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_FinancialTrackingDAO {
    
    /**
    * @Description : This method retrevies retrieves SAP recrod information.
    * @param       : SAP record ID.
    * @return      : SAP record.
    **/
    public static strategic_account_plan__c querySapRecord(ID SAPID) {
        strategic_account_plan__c recordSAP = new strategic_account_plan__c();
        try {
            if(SAPID != null) {
                recordSAP=[Select ID ,FT_to_month__c, From_Month__c, recordTypeID ,CurrencyISOcode, From_Date__c, Philips_Sector__c from strategic_account_plan__c where Id=:SAPID];
            }
            return recordSAP;
        }
        catch(Exception e) {
          
            system.debug('Fail to Query on Strategic Account Plan '+e.getMessage());
            return null;
        }
    } 
    
    /**
    * @Description : This method retrevies retrieves SAP recrod acess information.
    * @param       : Current User ID and SAP record ID.
    * @return      : UserRecordAccess Object, which containts Visibility information of SAP record.
    **/
    public static UserRecordAccess recordAccess(ID currentUser, ID SAPID) {
        UserRecordAccess hasaccess = new UserRecordAccess();
        
        try {
            if(currentUser != null && SAPID != null) {
                hasaccess=[SELECT RecordId,HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUser AND RecordId = :SAPID limit 1];
            }
            return hasaccess;
        }
        catch(Exception e) {
           
             system.debug('Fail to Query on user Access on Strategic Account Plan'+e.getMessage());
            return null;
        }
    }
    
    /**
    * @Description : This method list of SAP related Financial Tracking records.
    * @param       : SAP record ID.
    * @return      : List of Financial Tracking Records.
    **/
    public static List<Financial_Tracking__c> getFTRecords(ID SAPID) {
        List<Financial_Tracking__c> listFinTrack = new List<Financial_Tracking__c>();
        
        try {
            if(SAPID != null) {
                listFinTrack =[Select ID,BMC__c , Strategic_Account_plan__c ,IGM_Actuals_YTD__c, IGM_Target__c, IGM_Current_Target__c,IGM_Outlook_latest_view__c,IGM_Current_Outlook_latest_view__c,IGM_Current_Actuals_YTD__c , Business__C,Year__c,Current_Actuals_YTD__c,Current_Outlook_latest_view__c,Current_Target__c , To_Be_Considered_For_Total__c   from financial_tracking__c where Strategic_Account_plan__c =: SAPID  order by ID asc];
            }
            return listFinTrack ;
        }
        catch(Exception e) {
           
             system.debug('Fail to Query on Financial Tracking '+e.getMessage());
            return null;
        }
    }
    
    /**
    * @Description : This method Insets/Updates Finacial Tracking Records and also updates From Month on SAP.
    * @param       : SAP record and List of Financial Tracking records to be Inserted/ Updated.
    * @return      : Its a void method and returns null.
    **/
    public static M20_ShowResultFinancialTrackingWrapper save(Strategic_Account_plan__c SAP , List<Financial_Tracking__c> listTargetTrack ) {
        M20_ShowResultFinancialTrackingWrapper ShowResultFinancialTrackingWrapper;
        try {  
           if(!listTargetTrack.isEmpty()){
                upsert listTargetTrack;
           } 
           if(SAP!=null){
               update SAP;
            }   
            ShowResultFinancialTrackingWrapper = new M20_ShowResultFinancialTrackingWrapper(listTargetTrack,null);
            
               
        } catch(System.DMLexception e) {
            
             ShowResultFinancialTrackingWrapper = new M20_ShowResultFinancialTrackingWrapper(listTargetTrack,e.getMessage());
             system.debug('Fail to upsert finacial Tracking '+e.getMessage());
        } 
        return  ShowResultFinancialTrackingWrapper; 
    }
}