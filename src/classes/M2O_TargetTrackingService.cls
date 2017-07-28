/**
* @ClassName : M2O_TargetTrackingService
* @Description : This class is the service class of M2O_TargetTracking visualforce page.This class performes the bussiness logic (functionality) of the page
* @Author : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_TargetTrackingService {
    /**
    * @Description : This menthod generated the first run data for Target Tracking.
    * @param       : SAP Record Type ID, Number of Drivelines, List of M2O Business Type & SAP Record ID.
    * @return      : List of Target Tracking records.
    **/    
    public static List<Target_Tracking__c> getFirstRunData(ID SAPRecordTypeID , Integer totalNoOfDriveLines , List<M2O_Business_Type__c> businessTypes , ID SAPID, Strategic_Account_Plan__c SAP) {
        Integer countOfDL = 0;
        List<Target_Tracking__c> notInDB = new List<Target_Tracking__c>();
        
        for(M2O_Business_Type__c businessType : businessTypes){
            if(businessType.SAP_business_type__c == SAP.Philips_Sector__c)
                for(countOfDL=1 ; countOfDL <= totalNoOfDriveLines ;countOfDL++) {              
                        notInDB.add(new Target_Tracking__c(business__c=businessType.Business__c, Strategic_Account_plan__c=SAPID));
           }
        }
        return notInDB;
    }
}