/**
* @ClassName : M2O_ActivationPlanController
* @Description : This is the controller class of M2O_ActivationPlan.This class performes the function of retreving the Activation plans, inserting activities, deleting activities and updating activities 
* @Author : Albin Deni Arul
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_ActivationPlanController {
    public M2O_ActivationPlanService serviceClass;  
    public string previousType{set; get;} 
    public string previousCategory{set; get;}
    public string previousActivityDetail{set; get;}
    public boolean showEditActivity{get; set;}
    public boolean showAddActivity{get; set;}
    public Id activityId{set; get;}
    public string attachmentRecordId{set; get;}
    public UserRecordAccess hasAccess{get;set;}
    public Id currentUserId;    
    public Map<String, list<M2O_ActivationPlanWrapperTypCatActivity>> mapOfWrapperTypeCategoryActivityList {get; set;}
    public Strategic_Account_plan__c SAP;
    public Activation_Plan__c activationPlan {
    get{
        SAP = new strategic_account_plan__c();
        SAP = M2O_ActivationPlanDAO.querySapRecord(Apexpages.Currentpage().getparameters().get('Id'));
        if(activationPlan == null)
           if(SAP.Philips_Sector__c == M2O_DataUtility.lightingSector) { 
               activationPlan = new Activation_Plan__c(recordtypeID = Schema.SObjectType.Activation_Plan__c.getRecordTypeInfosByName().get('M2O Lighting').getRecordTypeId());
           } else if(SAP.Philips_Sector__c == M2O_DataUtility.lifestyleSector) {
               activationPlan = new Activation_Plan__c(recordtypeID = Schema.SObjectType.Activation_Plan__c.getRecordTypeInfosByName().get('M2O Consumer Lifestyle').getRecordTypeId()); 
           } else {
               activationPlan = new Activation_Plan__c();
           }
           return activationPlan;
        }
    set;}
    
    /**
    * @Description: This is the constructor, which performs initial action,retriving existing activities and retriving the user access on the object
    * @return : Void
    **/
    public M2O_ActivationPlanController (ApexPages.StandardController controller) { 
        Id strategicAccountPlanId;
        strategicAccountPlanId=Apexpages.Currentpage().getparameters().get('Id');
        currentUserId = UserInfo.getUserId();
        serviceClass = New M2O_ActivationPlanService();  
        mapOfWrapperTypeCategoryActivityList = serviceClass.initialAction();
        serviceClass.retriveActivationPlans(strategicAccountPlanId);
        attachmentRecordId = serviceClass.retriveAttachmentRecord(strategicAccountPlanId);
        hasAccess = serviceClass.retriveCurrentUserAccess(currentUserId, strategicAccountPlanId);
        showAddActivity = true; 
    }
     
    public void initializeAP() {
        SAP = new strategic_account_plan__c();
        SAP = M2O_ActivationPlanDAO.querySapRecord(Apexpages.Currentpage().getparameters().get('Id'));
        if(SAP.Philips_Sector__c == M2O_DataUtility.lightingSector) { 
               activationPlan = new Activation_Plan__c(recordtypeID = Schema.SObjectType.Activation_Plan__c.getRecordTypeInfosByName().get('M2O Lighting').getRecordTypeId());
           } else if(SAP.Philips_Sector__c == M2O_DataUtility.lifestyleSector) {
               activationPlan = new Activation_Plan__c(recordtypeID = Schema.SObjectType.Activation_Plan__c.getRecordTypeInfosByName().get('M2O Consumer Lifestyle').getRecordTypeId()); 
           }

    }
   
    public M2O_ActivationPlan_ControllerClass.M2O_ActivationPlanController() {
    }
    /**
    * @Description : This method is calling the addActivity function in service class to perform the logic function
    * param        : None
    * @return      : Void
    **/
    public void addActivity() {
        string result;
        try {
            result = serviceClass.addActivity(activationPlan);
            if(result != null) {
                if(result.startsWith('Error_')){
                   showErrorMessage(result.substringAfter('Error_')); 
                }
                else{
                 cancel();
                }
            }
            
        }catch (Exception ex) {
            ApexPages.addMessages(ex);   
        }
        initializeAP();
    }
    
    /**
    * @Description : This method is calling the updateActivity function in service class to perform the logic function
    * param        : None
    * @return      : Void
    **/
    
    public void updateActivity() {
        try {
            M2O_DisplayWrapperActDetails displayWrapper = serviceClass.updateActivity(activationPlan, previousType, previousCategory, previousActivityDetail, activityId); 
            if(displayWrapper.displayActivationPlan != null) {
               previousActivityDetail = displayWrapper.displayActivationPlan.Activity_Detail__c;
               previousType = displayWrapper.displayActivationPlan.Type__c;
               previousCategory = displayWrapper.displayActivationPlan.Category__c;
               activityId = displayWrapper.displayActivationPlan.Id;
            }
            if(displayWrapper.errorMessage!=null){
                showErrorMessage(displayWrapper.errorMessage);
            }
        }catch (Exception ex) {
            ApexPages.addMessages(ex); 
        }
        initializeAP();
    }
    
    /**
    * @Description : This method is calling the deleteActivity function in service class to perform the logic function
    * param        : None
    * @return      : Void
    **/
    public void deleteActivity() {
        try {
            serviceClass.deleteActivity(activationPlan, activityId);
            cancel();
        }catch (Exception ex) {
            ApexPages.addMessages(ex);
        }
        initializeAP();
    }
    
    /**
    * @Description : This method is calling the cancel function in service class to perform the logic function
    * param        : None
    * @return      : Void
    **/
    public void cancel() {
        try {
            activationPlan=serviceClass.cancel();
            showAddActivity();
        }catch(Exception ex) {
               ApexPages.addMessages(ex);
        }
        initializeAP();
    }
    
    /**
    * @Description: This method is setting the boolean value to show the sections
    * @return : Void
    **/
    public void showEditActivity() {
        showEditActivity = true; 
        showAddActivity = false;
    }
     
     /**
     * @Description: This method is setting the boolean value to show the sections
     * @return : Void
     **/
    public void showAddActivity() { 
        showEditActivity = false; 
        showAddActivity = true;    
    }
    
    /**
    * @Description: This method is for displaying error message in visual force page.
    * @return : Void
    **/
    public void showErrorMessage(string errorMessage) { 
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, errorMessage));   
    }
}