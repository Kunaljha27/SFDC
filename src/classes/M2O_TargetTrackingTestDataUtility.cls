/**
* @ClassName     :  M2O_TargetTrackingTestDataUtility 
* @Description   :  This class is is being used to create Test Data for Financial Tracking and Target Tracking.
* @Author        :  Vishal Kashyap
* @Last Modified :  2/12/2013
* @Discussion points : No Information
*/

public class M2O_TargetTrackingTestDataUtility {
    
    
    /**
    * @Description : This method creates Strategic Account Plan record.
    * @param       : None
    * @return      : Strategic account Plan record
    **/
         public static Strategic_Account_Plan__c getStrategicAccountPlanRecord() {
           Strategic_Account_Plan__c testStrategicAccountPlanRecord=new Strategic_Account_Plan__c();
           testStrategicAccountPlanRecord.name='Test';
           testStrategicAccountPlanRecord.From_Date__c=system.today();
           testStrategicAccountPlanRecord.To_Date__c=system.today()+10;
           testStrategicAccountPlanRecord.currencyIsoCode='EUR';
           testStrategicAccountPlanRecord.recordtypeID=system.label.M2O_StrategicAccountPlan_RecordType;
           testStrategicAccountPlanRecord.Philips_Sector__c = M2O_DataUtility.lightingSector;
           return testStrategicAccountPlanRecord;
         }   
  
    /**
    * @Description : This method inserts data to M2O Business Type Custom Setting.
    * @param       : None
    * @return      : M2O Business Type records list.
    **/ 
    public static List<M2O_Business_Type__C> getBT_CS() {
        List<M2O_Business_Type__C> businessType = new List<M2O_Business_Type__C>();
        businessType.add(new M2O_Business_Type__C(Name='BG1',   Business__c='Coffee'));
        return businessType;
    }
        
       public static  List<Target_Tracking__c> getTargetTrackingRecord(Id strategicAccountPlanId) {
        List<Target_Tracking__c> listTargetTracking= new List<Target_Tracking__c>();
        Target_Tracking__c testTargetTrackingRecord= new Target_Tracking__c(); 
        testTargetTrackingRecord.Apr_Actual__c = 734;
        testTargetTrackingRecord.Jun_Target__c=456;
        testTargetTrackingRecord.Jan_Target__c=456;
        testTargetTrackingRecord.Feb_Target__c=456;
        testTargetTrackingRecord.Mar_Target__c=456;
        testTargetTrackingRecord.Apr_Target__c=456;
        testTargetTrackingRecord.May_Target__c=456;
        testTargetTrackingRecord.Jul_Target__c=45;
        testTargetTrackingRecord.Aug_Target__c=456;
        testTargetTrackingRecord.Sep_Target__c=456;
        testTargetTrackingRecord.Oct_Target__c=456;
        testTargetTrackingRecord.Nov_Target__c=456;                
        testTargetTrackingRecord.Dec_Target__c=456;
        testTargetTrackingRecord.Strategic_Account_Plan__c=strategicAccountPlanId;
        //insert testTargetTrackingRecord;
        listTargetTracking.add(testTargetTrackingRecord);
        return listTargetTracking;
      }  
      
    /**
    * @Description : This method creates Target Tracking list.
    * @param       : SAP record ID.
    * @return      : List of Target Tracking records.
    **/ 
    public static List<Target_Tracking__c> getTarTrack(ID SAPID) {
        List<Target_Tracking__c> testTarTrack = new List<Target_Tracking__c>();
        testTarTrack.add(new Target_Tracking__c(Strategic_Account_plan__c = SAPID));
        return testTarTrack;
    }

 }