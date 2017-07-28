/**
* @ClassName     :  M2O_FinancialTrackingTestDataUtility
* @Description   :  This class is being used to create Test Data for Financial Tracking and Target Tracking.
* @Author        :  Vishal Kashyap
* @Last Modified :  2/12/2013
* @Discussion points : No Information
*/
@isTest
public class M2O_FinancialTrackingTestDataUtility{
    
    /**
    * @Description : This method creates Financial Tracking list.
    * @param       : SAP record ID.
    * @return      : List of Financial Tracking records.
    **/ 
    public static List<Financial_Tracking__c> createFinTrack(ID SAPID) {
        List<Financial_Tracking__c> testFinTrack = new List<Financial_Tracking__c>();
        testFinTrack.add(new Financial_Tracking__c(Strategic_Account_plan__c = SAPID ,To_Be_Considered_For_Total__C = true , Current_Target__c=1000, Current_Outlook_Latest_view__c=2000,Current_Actuals_YTD__c =3000 , IGM_Current_Target__c=1000, IGM_Current_Outlook_Latest_view__c=2000,IGM_Current_Actuals_YTD__c =3000, To_Month__c='Dec'));
       // insert testFinTrack;
        return testFinTrack;
    } 
    /**
    * @Description : This method creates Target Tracking list.
    * @param       : SAP record ID.
    * @return      : List of Target Tracking records.
    **/ 
    public static List<Target_Tracking__c> createTarTrack(ID SAPID) {
        List<Target_Tracking__c> testTarTrack = new List<Target_Tracking__c>();
        testTarTrack.add(new Target_Tracking__c(Strategic_Account_plan__c = SAPID));
       // insert testTarTrack;
        return testTarTrack;
    }
    /**
    * @Description : This method inserts data to M2O Business Type Custom Setting.
    * @param       : None
    * @return      : M2O Business Type records list.
    **/ 
    public static List<M2O_Business_Type__C> createBT_CS() {
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        businessType.add(new M2O_Business_Type__C(Name='BG1',   Business__c='Coffee'));
      //insert businessType;
        return businessType;
    }
    /**
    * @Description : This method inserts data to M2O Financial Tracking Category Custom Setting.
    * @param       : None
    * @return      : M2O Financial Tracking Category records list.
    **/
    public static List<M2O_Financial_Tracking_Category__c> createFT_CS() {
        List<M2O_Financial_Tracking_Category__c> csCategory = new List<M2O_Financial_Tracking_Category__c>();
        csCategory.add(new M2O_Financial_Tracking_Category__c(Category__c = 'Lamps', Sector__c = 'Lighting'));
        return csCategory;
    }
    /**
    * @Description : This method creates Strategic Account Plan record.
    * @param       : None
    * @return      : Strategic account Plan record
    **/     
     public static Strategic_Account_Plan__c insertStrategicAccountPlanRecord() {
        Strategic_Account_Plan__c testStrategicAccountPlanRecord=new Strategic_Account_Plan__c();
        testStrategicAccountPlanRecord.name='Test';
        testStrategicAccountPlanRecord.From_Date__c=system.today();
        testStrategicAccountPlanRecord.To_Date__c=system.today()+10;
        testStrategicAccountPlanRecord.currencyIsoCode='EUR';
        testStrategicAccountPlanRecord.recordtypeID=system.label.M2O_StrategicAccountPlan_RecordType;
        
        return testStrategicAccountPlanRecord;
     }
    /**
    * @Description : This method creates currency symbol record for Financial Tracking.
    * @param       : None
    * @return      : List of Currency symbol
    **/     
         public static List<M2O_CurrencySymbol__c> insertCurrencyRecord(){
         List<M2O_CurrencySymbol__c> currecyList=new List<M2O_CurrencySymbol__c>();
         M2O_CurrencySymbol__c Currency1= new M2O_CurrencySymbol__c();
         Currency1.Symbol__c='€';
         Currency1.name='EUR';
         currecyList.add(Currency1);
         M2O_CurrencySymbol__c Currency2= new M2O_CurrencySymbol__c();
         Currency2.Symbol__c='₹';
         Currency2.name='INR';
         currecyList.add(Currency2);
         
         return currecyList;
     }
}