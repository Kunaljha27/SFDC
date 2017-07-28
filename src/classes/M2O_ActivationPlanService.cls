/**
* @ClassName : M2O_ActivationPlanService
* @Description : This class is the service class of M2O_ActivationPlan.This class performes the bussiness logic (functionality) of the page 
* @Author : Albin Deni Arul
* @Last Modified : 26/11/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_ActivationPlanService {
    public Id strategicAccountPlanId;
    public integer monthIndex;
    public M2O_ActivationPlanWrapperTypCatActivity wrapperTypCatActivity;
    public list<M2O_ActivationPlanWrapperTypCatActivity> typeList;
    public set<integer> monthsSet = new set<Integer>();
    public list<Activation_Plan__C> retrievedActivationPlans = new list<Activation_Plan__c>();
    public Map<Id, Activation_plan__C> mapOfTypeCategoryActivity = new Map<Id, Activation_plan__C>();
    public Map<String, M2O_ActivationPlanWrapperTypCatActivity> mapOfTypeCategoryActivationPlan = new Map<String, M2O_ActivationPlanWrapperTypCatActivity>();
    public Map<String, list<M2O_ActivationPlanWrapperTypCatActivity>> mapOfWrapperTypeCategoryActivityList = new Map<String, list<M2O_ActivationPlanWrapperTypCatActivity>> ();
    public Map<String, M2O_ActivationPlanWrapperActDetails> mapOfWrapperTypeCategoryActivities= new Map<String, M2O_ActivationPlanWrapperActDetails>();
    public M2O_ActivationPlanWrapperActDetails wrapperActDetails;
    public Activation_Plan__c attachmentRecord = new Activation_Plan__c();
    public Activation_Plan__c activationPlan = new Activation_Plan__c();
    public Activation_Plan__C activityToDataBase;
    public M2O_ActivationPlanDAO dao = new M2O_ActivationPlanDAO(); 
 
   /**
    * @Description : This method performs the initial action when the page is loaded.Creating wrapper class records according to the picklist values of Type and category fields
    * @param       : None
    * @return      : Map of the wrapper record and type picklist
    **/
    public Map<String, list<M2O_ActivationPlanWrapperTypCatActivity>> initialAction() {
        Schema.DescribeFieldResult categoryResult = Activation_Plan__c.Category__c.getDescribe();
        List<Schema.PicklistEntry> categoryPicklistValues = categoryResult .getPicklistValues();
        Schema.DescribeFieldResult typeResult = Activation_Plan__c.Type__c.getDescribe();
        List<Schema.PicklistEntry> typePicklistValues = typeResult.getPicklistValues();
        Set<String> filteredCategory = new Set<string>();
        List<M2O_Activation_Plan_Category_Filter__c> categoryFilter = M2O_Activation_Plan_Category_Filter__c.getall().values();
        strategic_account_plan__C SAP = new strategic_account_plan__c();
        SAP = M2O_ActivationPlanDAO.querySapRecord(Apexpages.Currentpage().getparameters().get('Id'));
        if(SAP.Philips_Sector__c == M2O_DataUtility.lifestyleSector) {
            for(M2O_Activation_Plan_Category_Filter__c category : categoryFilter) {
                if(category.Is_CL__c) {
                    filteredCategory.add(category.Name);
                }
            }
        }
        if(SAP.Philips_Sector__c == M2O_DataUtility.lightingSector) {
            for(M2O_Activation_Plan_Category_Filter__c category : categoryFilter) {
                if(category.Is_LI__c) {
                    filteredCategory.add(category.Name);
                }
            }
        }
        
        for(Schema.PicklistEntry typeValue :typePicklistValues) {
            typeList = new list<M2O_ActivationPlanWrapperTypCatActivity>();
            for(Schema.PicklistEntry categoryValue : categoryPicklistValues) {
                if(filteredCategory.contains(categoryValue.getvalue())) { 
                    M2O_ActivationPlanWrapperTypCatActivity wrapperTypeCategory = new M2O_ActivationPlanWrapperTypCatActivity(typeValue.getvalue(), categoryValue.getvalue());
                    mapOfTypeCategoryActivationPlan.put(typeValue.getvalue()+categoryValue.getvalue(),wrapperTypeCategory);
                    typeList.add(wrapperTypeCategory);
                }
            }
            mapOfWrapperTypeCategoryActivityList.put(typeValue.getvalue(),typeList) ;
        }
        
        return mapOfWrapperTypeCategoryActivityList;
    }
    
    /**
    * @Description : This method performs the retrival of existing activities and adding it in the wrapper record accordingly
    * @param       : Id of Strategic Account Plan parent record
    * @return      : Void
    **/
    public void retriveActivationPlans(Id strategicAccountPlanId) {
        if(strategicAccountPlanId != null) {
            this.strategicAccountPlanId=strategicAccountPlanId;
            retrievedActivationPlans = dao.retrevieActivationPlans(strategicAccountPlanId);
            if(retrievedActivationPlans != null && (!(retrievedActivationPlans.isEmpty()))) {
                for(Activation_plan__c retreviedActivationPlan:retrievedActivationPlans) {
               
                    if(retreviedActivationPlan.Activity_Start_Date__c != null && retreviedActivationPlan.Activity_End_Date__c != null) {
                        mapOfTypeCategoryActivity.put(retreviedActivationPlan.id,retreviedActivationPlan);
                        wrapperTypCatActivity = mapOfTypeCategoryActivationPlan.get(retreviedActivationPlan.Type__C+retreviedActivationPlan.category__C);
                         
                        for(monthIndex = retreviedActivationPlan.Activity_Start_Date__c.month()-1; monthIndex<=retreviedActivationPlan.Activity_End_Date__c.month()-1; monthIndex++) {
                            wrapperActDetails = new M2O_ActivationPlanWrapperActDetails( retreviedActivationPlan.Activity_Detail__c, retreviedActivationPlan.Activity_Start_Date__c, retreviedActivationPlan.Activity_End_Date__c, retreviedActivationPlan.Activity_Status__c, retreviedActivationPlan.type__c, retreviedActivationPlan.category__c,retreviedActivationPlan.id);
                            try{
                                wrapperTypCatActivity.activity[monthIndex].add(wrapperActDetails);
                            } catch(exception e) {
                                system.debug(e);
                            }
                            mapOfWrapperTypeCategoryActivities.put(retreviedActivationPlan.Type__c+retreviedActivationPlan.Category__c+monthIndex+retreviedActivationPlan.id,wrapperActDetails);
                        }
                    }  
                }
            }
        } 
    }
    
    /**
    * @Description : This method performs the retrival of running user access on the object
    * @param1      : Current user id
    * @param2      : Id of Strategic Account Plan parent record
    * @return      : Record of UserRecordAccess 
    **/
    public UserRecordAccess retriveCurrentUserAccess(Id currentUserId, Id strategicAccountPlanId) {
        if(currentUserId != null && strategicAccountPlanId != null) {
           return dao.retriveCurrentUserAccess(currentUserId, strategicAccountPlanId); 
        } else {
            return null;
        }    
    }
    
    /**
    * @Description : This method performs the retrival of attachment record. The record used to attach the files.
    * @param       : Id of Strategic Account Plan parent record
    * @return      : Id of the attachment record
    **/
    public string retriveAttachmentRecord(Id strategicAccountPlanId) {
        if(strategicAccountPlanId != null) {
            attachmentRecord=dao.retriveAttachmentRecord(strategicAccountPlanId);
            return attachmentRecord.id;
        }else {
            return null;
        }
    }
    
    /**
    * @Description : This method performs the addition of newly added activity in wrapper class and in database.
    * @param       : Activation Plan record
    * @return      : Return error message string 
    **/
    public string addActivity(Activation_Plan__c activationPlan) {
        Id retrievedActivationPlanID;
        String errorMsg;
        if(activationPlan != null) {
          if(Activationplan.Activity_Start_Date__c != null && Activationplan.Activity_End_Date__c != null && 
                attachmentRecord.Strategic_account_plan__r.From_date__c != null && attachmentRecord.Strategic_account_plan__r.To_date__c != null){
                if((Activationplan.Activity_Start_Date__c.year() == attachmentRecord.Strategic_account_plan__r.From_date__c.year()) &&
                     ( Activationplan.Activity_End_Date__c.year()== attachmentRecord.Strategic_account_plan__r.To_date__c.year())&& 
                         Activationplan.Activity_Start_Date__c >= attachmentRecord.Strategic_account_plan__r.From_date__c) {
                    if(Activationplan.Activity_Start_Date__c <= Activationplan.Activity_End_Date__c) {
                       activityToDataBase = new Activation_Plan__c (Type__c = ActivationPlan.Type__c, Category__c = ActivationPlan.Category__c, Activity_Detail__c=ActivationPlan.Activity_Detail__c, Activity_End_Date__c=ActivationPlan.Activity_End_Date__c, Activity_Start_Date__c=ActivationPlan.Activity_Start_Date__c, Activity_Status__c=ActivationPlan.Activity_Status__c, Strategic_Account_Plan__c=strategicAccountPlanId);
                       activityToDataBase = dao.addActivityToDatabase(activityToDataBase);
                       system.debug('@@@@@'+activityToDataBase );
                       system.debug('AAAA'+activityToDataBase.Id);
                       retrievedActivationPlanID = activityToDataBase.Id;
                       mapOfTypeCategoryActivity.put(retrievedActivationPlanID, activityToDataBase);
                       WrapperTypCatActivity = mapOfTypeCategoryActivationPlan.get(ActivationPlan.Type__C+ActivationPlan.category__C);
                       for(monthIndex = ActivationPlan.Activity_Start_Date__c.month()-1; monthIndex <= ActivationPlan.Activity_End_Date__c.month()-1; monthIndex++) {
                           wrapperActDetails = new M2O_ActivationPlanWrapperActDetails( ActivationPlan.Activity_Detail__c, ActivationPlan.Activity_Start_Date__c, ActivationPlan.Activity_End_Date__c, ActivationPlan.Activity_Status__c, ActivationPlan.type__c, ActivationPlan.category__c,retrievedActivationPlanID);
                           try {
                           wrapperTypCatActivity.activity[monthIndex].add(wrapperActDetails);
                           }
                           catch (NullPointerException ex) {
                               system.debug('Exception occured:'+ex);
                           }
                           mapOfWrapperTypeCategoryActivities.put(ActivationPlan.Type__c+ActivationPlan.Category__c+monthIndex+retrievedActivationPlanID,wrapperActDetails);      
                          } 
                     }else {
                         errorMsg = 'Error_' + System.Label.M2O_ActivationPlan_VF_ErrorMsgForStartAndEndDateValidation;
                         return errorMsg;
                     }                  
                 }else {
                      errorMsg = 'Error_' + System.Label.M2O_ActivationPlan_VF_ErrorMsgForDateValidation;
                      return errorMsg;
                 }
             }else {
                errorMsg = 'Error_' + System.Label.M2O_ActivationPlan_VF_ErrorMsgForDateValueEmpty;
                return errorMsg;
             }
         }else {
             return null;
         }
         return 'added';
    }
    
    /**
    * @Description : This method performs the update of the activity in wrapper class and in database.
    * @param1      : Activation Plan record
    * @param2      : Previous Type value before the update
    * @param3      : Previous Category value before the update
    * @param4      : Previous Activity Detail value before the update
    * @param5      : Id of the Activity
    * @return      : Record of Activation Plan 
    **/
    public M2O_DisplayWrapperActDetails updateActivity(Activation_Plan__c activationPlan,string previousType, string previousCategory, string previousActivityDetail, ID activityId) {
        M2O_ActivationPlanWrapperActDetails retrievedActivity;
        M2O_DisplayWrapperActDetails displayWrapper;
        if(activationPlan != null) {        
            if(Activationplan.Activity_Start_Date__c != null && Activationplan.Activity_End_Date__c!= null &&
                 attachmentRecord.Strategic_account_plan__r.From_date__c != null && attachmentRecord.Strategic_account_plan__r.To_date__c != null){
                if((Activationplan.Activity_Start_Date__c.year() == attachmentRecord.Strategic_account_plan__r.From_date__c.year()) &&
                     (Activationplan.Activity_End_Date__c.year() == attachmentRecord.Strategic_account_plan__r.To_date__c.year())&&
                          Activationplan.Activity_Start_Date__c >= attachmentRecord.Strategic_account_plan__r.From_date__c) {
                    if(Activationplan.Activity_Start_Date__c <= Activationplan.Activity_End_Date__c) {
                       wrapperTypCatActivity = mapOfTypeCategoryActivationPlan.get(ActivationPlan.Type__C+ActivationPlan.category__C);
                       monthsSet.clear();
                       monthsSet = monthsToAdd(Activationplan.Activity_Start_Date__c, Activationplan.Activity_End_Date__c);
                       monthIndex = 0;
                       try {
                           for(list<M2O_ActivationPlanWrapperActDetails>  activityOnMonth:WrapperTypCatActivity.activity) { 
                               retrievedActivity=mapOfWrapperTypeCategoryActivities.get(previousType+previousCategory+monthIndex+activityId);
                               if(previousType != Activationplan.Type__c || previousCategory !=Activationplan.category__c ) {
                                  if(retrievedActivity != null) {
                                     retrievedActivity.activityDetail = '';
                                  }
                                  if(monthsSet.contains(monthIndex+1)) {
                                     wrapperActDetails = new M2O_ActivationPlanWrapperActDetails( ActivationPlan.Activity_Detail__c, ActivationPlan.Activity_Start_Date__c, ActivationPlan.Activity_End_Date__c, ActivationPlan.Activity_Status__c, ActivationPlan.type__c, ActivationPlan.category__c,activityId);
                                     activityOnMonth.add(wrapperActDetails);
                                     mapOfWrapperTypeCategoryActivities.put(ActivationPlan.Type__c+ActivationPlan.Category__c+monthIndex+activityId,wrapperActDetails );  
                                  }
                               }else if(monthsSet.contains(monthIndex+1)) {   
                                        if(retrievedActivity != null) {
                                           retrievedActivity.activityDetail = ActivationPlan.Activity_Detail__c;
                                           retrievedActivity.activityStatus = ActivationPlan.Activity_Status__c;
                                           retrievedActivity.activityStartDate = ActivationPlan.Activity_Start_Date__c;
                                           retrievedActivity.activityEndDate = ActivationPlan.Activity_End_Date__c;
                                        }else if(retrievedActivity == null) {
                                                 wrapperActDetails = new M2O_ActivationPlanWrapperActDetails( ActivationPlan.Activity_Detail__c, ActivationPlan.Activity_Start_Date__c, ActivationPlan.Activity_End_Date__c, ActivationPlan.Activity_Status__c, ActivationPlan.type__c, ActivationPlan.category__c,activityId);
                                                 activityOnMonth.add(wrapperActDetails);
                                                 mapOfWrapperTypeCategoryActivities.put(ActivationPlan.Type__c+ActivationPlan.Category__c+monthIndex+activityId,wrapperActDetails );
                                         }       
                                      }else {
                                         if(retrievedActivity != null) {
                                            retrievedActivity.activityDetail = '';
                                         }
                                       }
                            monthIndex = monthIndex+1;
                        }
                   } catch(NullPointerException ex) {
                       system.debug('Exception occured'+ex);
                     }
                    activityToDataBase = new Activation_Plan__c (Type__c=ActivationPlan.Type__c,Category__c=ActivationPlan.Category__c, Activity_Detail__c=ActivationPlan.Activity_Detail__c, Activity_End_Date__c=ActivationPlan.Activity_End_Date__c, Activity_Start_Date__c=ActivationPlan.Activity_Start_Date__c, Activity_Status__c=ActivationPlan.Activity_Status__c,Strategic_account_plan__c=strategicAccountPlanId,Id=activityId);
                    activityToDataBase = dao.updateActivityToDatabase(activityToDataBase); 
                    displayWrapper = new M2O_DisplayWrapperActDetails(activityToDataBase, null);
                    mapOfTypeCategoryActivity.put(activityId, activityToDataBase);
                    return displayWrapper;
                  }else {
                    displayWrapper = new M2O_DisplayWrapperActDetails(null, System.Label.M2O_ActivationPlan_VF_ErrorMsgForStartAndEndDateValidation);
                    return displayWrapper;
                  }
                }else {
                    displayWrapper = new M2O_DisplayWrapperActDetails(null, System.Label.M2O_ActivationPlan_VF_ErrorMsgForDateValidation);
                    return displayWrapper;
                }                
            }else {
                displayWrapper = new M2O_DisplayWrapperActDetails(null, System.Label.M2O_ActivationPlan_VF_ErrorMsgForDateValueEmpty);
                return displayWrapper;
            }
        }else {
            return null;
        }
    }
    
    /**
    * @Description : This method performs the delete of the activity in wrapper class and in database.
    * @param1      : Activation Plan record
    * @param2      : Activity Id
    * @return      : Void
    **/
    public void deleteActivity(Activation_Plan__c activationPlan, ID activityId) {
        if(activationPlan != null && activityId != null) {
            monthIndex = 0;
            wrapperTypCatActivity = mapOfTypeCategoryActivationPlan.get(activationPlan.Type__C+activationPlan.category__C);
            if(wrapperTypCatActivity!=null){
                for(list<M2O_ActivationPlanWrapperActDetails> activity:wrapperTypCatActivity.activity){
                    wrapperActDetails = mapOfWrapperTypeCategoryActivities.get(activationPlan.Type__c+activationPlan.category__C+monthIndex+activityId);
                    if(wrapperActDetails != null) {
                        wrapperActDetails.activityDetail='';      
                    }
                    monthIndex=monthIndex+1;
                }
                activityToDataBase = new Activation_Plan__c (Id=(mapOfTypeCategoryActivity.get(activityId)).Id);
                dao.deleteActivityFromDatabase(activityToDataBase );
            }    
        }
    }
    
    /**
    * @Description : This method gives the set of month numbers to which the activity should get added.
    * @param1      : Activity starting date 
    * @param2      : Activity end date 
    * @return      : Set of Month numbers
    **/          
    @TestVisible private set<integer> monthsToAdd(date startingDate ,date endingDate ) {
        if(startingDate != null && endingDate != null) {
            for(monthIndex=startingDate.month()  ; monthIndex<= endingDate.month() ; monthIndex++){
                monthsSet.add(monthIndex);
            }    
            return monthsSet; 
        }else {
            return null;
        }
    }
    
    /**
    * @Description : This method nullifies the activation plan values on cancel.
    * @param       : None
    * @return      : Activation plan
    **/
    public Activation_Plan__c cancel() {
        activationPlan.Type__c='';
        activationPlan.Category__c='';
        activationPlan.Activity_Detail__c='';
        activationPlan.Activity_Start_Date__c=null;
        activationPlan.Activity_End_Date__c=null;
        activationPlan.Activity_Status__c='';
        return activationPlan;
    }
}