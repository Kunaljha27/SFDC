/**
* @ClassName : M2O_FinancialTrackingService
* @Description : This class is the service class of M2O_FinancialTracking visualforce page.This class performes the bussiness logic (functionality) of the page 
* @Author : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_FinancialTrackingService {
        
        /**
        * @Description : This menthod changes the value of Currency to 1000 scale.
        * @param       : List of Financial Tracking records.
        * @return      : List of Financial Tracking records.
        **/ 
        public static List<Financial_Tracking__C> getThousandScaleUI(List<Financial_Tracking__C> listFinTrack)
        {
            Integer listSize;
            if(listFinTrack!=null && !listFinTrack.isEmpty()){
                for(listSize = 0 ; listSize < listFinTrack.size() ; listSize++) {
                    if(listFinTrack[listSize].Current_Target__c != null) {
                        listFinTrack[listSize].Current_Target__c = listFinTrack[listSize].Current_Target__c / 1000;
                    }
                    listFinTrack[listSize].Current_Outlook_latest_view__c /= 1000;
                    listFinTrack[listSize].Current_Actuals_YTD__c /= 1000;
                    listFinTrack[listSize].IGM_Current_Target__c /= 1000;
                    listFinTrack[listSize].IGM_Current_Outlook_latest_view__c /= 1000;
                    listFinTrack[listSize].IGM_Current_Actuals_YTD__c /= 1000;
                }
              }  
            return listFinTrack;
        }
        
        /**
        * @Description : This menthod changes the value of Currency to 1000 scale.
        * @param       : Financial Tracking record.
        * @return      : Financial Tracking record.
        **/
        public static Financial_Tracking__C getThousandScaleUI(Financial_Tracking__C finTrack)
        {
          if(finTrack!=null){
                finTrack.Current_Target__c /= 1000;
                finTrack.Current_Outlook_latest_view__c /= 1000;
                finTrack.Current_Actuals_YTD__c /= 1000;
                finTrack.IGM_Current_Target__c /= 1000;
                finTrack.IGM_Current_Outlook_latest_view__c /= 1000;
                finTrack.IGM_Current_Actuals_YTD__c /= 1000;
           }      
                return finTrack;
        }
        
        /**
        * @Description : This menthod changes the value of Currency from 1000 scale.
        * @param       : List of Financial Tracking records.
        * @return      : List of Financial Tracking records.
        **/
        public static List<Financial_Tracking__C> getThousandScaleDB(List<Financial_Tracking__C> listFinTrack)
        {
            Integer listSize;
           if(listFinTrack!=null && !listFinTrack.isEmpty()){ 
                for(listSize = 0 ; listSize < listFinTrack.size() ; listSize++) {
                    if(listFinTrack[listSize].Current_Target__c != null) {
                        listFinTrack[listSize].Current_Target__c *= 1000;
                    }
                    listFinTrack[listSize].Current_Outlook_latest_view__c *= 1000;
                    listFinTrack[listSize].Current_Actuals_YTD__c *= 1000;
                    listFinTrack[listSize].IGM_Current_Target__c *= 1000;
                    listFinTrack[listSize].IGM_Current_Outlook_latest_view__c *= 1000;
                    listFinTrack[listSize].IGM_Current_Actuals_YTD__c *= 1000;
                }
            }    
            return listFinTrack;
        }
        /**
        * @Description : This menthod prepares first run records to be displayed in the Financial Tracking VF Page.
        * @param       : List of Business Type and SAP record.
        * @return      : List of Financial Tracking records.
        **/
        public static List<Financial_Tracking__C> getFirstRunFT(List<M2O_Financial_Tracking_Category__c> businessTypes , Strategic_Account_Plan__c SAP ) {
            List<Financial_Tracking__C> notInDB = new List<Financial_Tracking__C>();
            Integer BTCount;
            Integer totalNoOfDriveLines = integer.ValueOf(Label.M2O_FinancialTracking_VF_Total_No_Of_Drivelines);
           if(businessTypes!=null && !businessTypes.isEmpty()){
             for(M2O_Financial_Tracking_Category__c businessType : businessTypes){
                if(businessType.Sector__c == SAP.Philips_Sector__c) {
                    for(BTCount=1;BTCount<=totalNoOfDriveLines;BTCount++) {              
                        if(math.mod(BTCount,totalNoOfDriveLines) == 0) {                                     
                            notInDB.add(new financial_tracking__c(Current_Target__c=0, CurrencyISOcode = SAP.CurrencyISOcode , Current_Outlook_latest_view__c=0, Current_Actuals_YTD__c=0, IGM_Current_Target__c=0, IGM_Current_Outlook_latest_view__c=0, IGM_Current_Actuals_YTD__c=0, To_Be_Considered_For_Total__c = true , business__c=businessType.Category__c, Strategic_Account_plan__c=SAP.ID));
                        } else {
                            notInDB.add(new financial_tracking__c(Current_Target__c=0, CurrencyISOcode = SAP.CurrencyISOcode , Current_Outlook_latest_view__c=0, Current_Actuals_YTD__c=0, IGM_Current_Target__c=0, IGM_Current_Outlook_latest_view__c=0, IGM_Current_Actuals_YTD__c=0, business__c=businessType.Category__c, Strategic_Account_plan__c=SAP.ID));
                        }
                    }
                }
             }
            } 
            return notInDB;       
        }
        
        /**
        * @Description : This menthod total all the values present in the Financial Tracking Record.
        * @param       : List of Financial Tracking records.
        * @return      : Financial Tracking records total.
        **/
        public static Financial_Tracking__C getFindTotal(List<financial_tracking__c> finTrackList) {
            Financial_Tracking__C total = new financial_tracking__c(Current_Target__c=0, Current_Outlook_latest_view__c=0, Current_Actuals_YTD__c=0, IGM_Current_Target__c=0, IGM_Current_Outlook_latest_view__c=0, IGM_Current_Actuals_YTD__c=0);
           if(finTrackList!=null && !finTrackList.isEmpty()){ 
            for(financial_tracking__c finTrack : finTrackList) {
               if(finTrack.To_Be_Considered_For_Total__c == true )  {
                total.Current_Target__c += fintrack.Current_Target__c==null?0:fintrack.Current_Target__c;
                total.Current_Outlook_latest_view__c += fintrack.Current_Outlook_latest_view__c==null?0:fintrack.Current_Outlook_latest_view__c;
                total.Current_Actuals_YTD__c += fintrack.Current_Actuals_YTD__c==null?0:fintrack.Current_Actuals_YTD__c;
                total.IGM_Current_Target__c += fintrack.IGM_Current_Target__c==null?0:fintrack.IGM_Current_Target__c;
                total.IGM_Current_Outlook_latest_view__c += fintrack.IGM_Current_Outlook_latest_view__c==null?0:fintrack.IGM_Current_Outlook_latest_view__c;
                total.IGM_Current_Actuals_YTD__c += fintrack.IGM_Current_Actuals_YTD__c==null?0:fintrack.IGM_Current_Actuals_YTD__c;
               }
            }
          }  
            return total;
        }
    
}