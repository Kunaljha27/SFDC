/**
* @ClassName : M2O_TargetTrackingController
* @Description : This class is the controller class for M2O_TargetTracking
* @Author : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/

public with sharing class M2O_TargetTrackingController {

    public List<Target_Tracking__c> relatedtargetTrack;
    public List<Target_Tracking__c> notInDB{set;get;}
    public List<M2O_Business_Type__c> businessTypes=M2O_Business_Type__c.getall().values();
    public UserRecordAccess Hasaccess{get;set;}
    public ID SAPID{get;set;}
    public Boolean editMode{get;set;}
    public strategic_account_plan__c SAP{get;set;}

    public M2O_TargetTrackingController(ApexPages.StandardController controller) {
        //showData();
        SAPID = ApexPages.currentPage().getParameters().get('id');
        Hasaccess = new UserRecordAccess();
        Id currentUser=UserInfo.getUserId();
        Hasaccess = M2O_TargetTrackingDAO.getRecordAccess(currentUser , SAPID);
        SAP=new strategic_account_plan__c();
        SAP = M2O_TargetTrackingDAO.querySapRecord(SAPID);
        
    }

    /**
    * @Description : This method is calling the showData function in the same class to get the related Target Tracking record
    * @param       : None
    * @return      : List of Target Tracking records
    **/
        
    public List<Target_Tracking__C> getrelatedtargetTrack()
    {
        relatedtargetTrack = new List<Target_Tracking__C>();
        showData();
        return relatedtargetTrack;
    }

    /**
    * @Description : This method is calling the showData function in the same class to get the related Target Tracking record
    * @param       : List of Target Tracking records
    * @return      : None
    **/
        
    public void getrelatedtargetTrack(List<Target_Tracking__C> changedRelatedTT)
    {
        relatedtargetTrack = changedRelatedTT;
    }
    
    /**
    * @Description : This method is calling the M2O_TargetTrackingService class function getFirstRunData to display Target Tracking record
    * @param       : None
    * @return      : None
    **/    
    public void showData() {
        relatedTargetTrack = new List<Target_Tracking__c>();
        notInDB = new List<Target_Tracking__c>();
        Integer totalNoOfDriveLines = integer.ValueOf(Label.M2O_TargetTracking_VF_Total_No_Of_Drivelines);
        Integer countOfDL;
        ID SAPRecordTypeID;
        
        SAPRecordTypeID = M2O_TargetTrackingDAO.getRecordType(SAPID);
        relatedTargetTrack = M2O_TargetTrackingDAO.getTargetTrackData(SAPID);
        businessTypes.sort();
        if(relatedTargetTrack.size()==0) {
            notInDB = M2O_TargetTrackingService.getFirstRunData(SAPRecordTypeID , totalNoOfDriveLines , businessTypes , SAPID, SAP);
        }
        relatedTargetTrack .addall(notInDB);            
    }

    /**
    * @Description : This method is for enabling the page in edit mode
    * @param       : None
    * @return      : None
    **/    

    public void enableEditing() {
        editMode=(editMode==true)?false:true;
        if(editMode!=true) {
            showData();
        }
    }
    /**
    * @Description : This method is for saving the changes made on the M2O_TargetTracking Visualforce page
    * @param       : None
    * @return      : None
    **/    
   public void save() {
      // List<Target_Tracking__c> targetTest = new List<Target_Tracking__c>();
       boolean result ; 
       result =M2O_TargetTrackingDAO.save(relatedTargetTrack);
       if(result==true){
           enableEditing();
       }
       else{
           ApexPages.Message msg = new ApexPages.Message(Apexpages.Severity.ERROR, 'Update Failed');
           ApexPages.addMessage(msg);
       }        
   } 
}