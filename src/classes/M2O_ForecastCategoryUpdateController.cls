/**
* @ClassName : M2O_ForecastCategoryUpdateController
* @Description : This is the extension class for M2O_ForecastCategoryOveride page 
* @Author : Somdev Bhattacharyya
* @Last Modified : 10/11/2014
* @Discussionpoints : No Information
**/ 
public class M2O_ForecastCategoryUpdateController {
    public  Id oppId       {get;set;}
    public boolean flag     {get;set;}
    public String fullFileURL {get; set;}
    public M2O_ForecastCategoryUpdateController() {}
    public String forecastCategoryList {get;set;}
    public Opportunity opportunityStage {get;set;}
    public M2O_ForecastCategoryUpdateController(ApexPages.StandardController controller) {
        oppId = controller.getRecord().Id;
        opportunityStage = (Opportunity)controller.getRecord();
        Opportunity oppty = new Opportunity();
        Id userId = userInfo.getUserRoleId();
        flag = M2O_ForecastCategoryUpdateDAO.roleBasedForcasteChange(oppId,userId);
        system.debug('flage in controller'+flag);
        if (flag == true) {
                oppty.addError('You are not authorized for forcast override'); 
                
            } 
        
           
    }
    /**
    * @Description : This method retrevies forecastCategory information and also updates ..
    * @param       : none
    * @return      : null.
    **/
    public PageReference forecastCategoryAddition() {
        Opportunity opp = new Opportunity();
        opp.Id = oppId;
        opp.ForecastCategoryName = forecastCategoryList; 
        
        if(opp != null ) { 
            
            if (flag == false) {
                M2O_ForecastCategoryUpdateDAO.updateForecasteCategory (opp);
            }
            
        }
        PageReference userPage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' +oppId);
        userPage.setRedirect(true);
        return null;
    }   
    
    /**
    * @Description : This method retrevies retrieves and shows forecastCategory 
                     information on the page..
    * @param       : none
    * @return      : list of SelectOption.
    **/
    
    public list <SelectOption> getitems () {
        List<SelectOption> options = new List<SelectOption>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('Opportunity');//From the Object Api name retrieving the SObject
        Sobject objectName = targetType.newSObject();
        Schema.sObjectType sobject_type = objectName.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        Set<String> legalFC = new Set<String>();
        boolean open=false;
        boolean closedWon=false;
        boolean closedLost=false;   
        for(OpportunityStage loopVar : [Select ForecastCategoryName, MasterLabel, IsClosed, IsWon from OpportunityStage where MasterLabel=:opportunityStage.StageName and isActive=true limit 1]) {
            if(loopVar.IsClosed == false && loopVar.IsWon == false) {
                open = true;
            } else if(loopVar.IsClosed == true && loopVar.IsWon == false) {
                closedLost=true;
            } else if(loopVar.IsClosed == true && loopVar.IsWon == true) {
                closedWon=true;
                closedLost=true;
            }
        }
        system.debug('legal values are'+open+closedLost+closedwon);
        for(OpportunityStage loopVar :[Select ForecastCategoryName from OpportunityStage where IsActive=true and IsWon=:closedWon and IsClosed=:closedLost]) {
                        
            legalFC.add(loopVar.ForecastCategoryName);
            //system.debug('legal values are'+legalFC);
        }
        
        List<Schema.PicklistEntry> pick_list_values = field_map.get('ForecastCategoryName').getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            if(legalFC.contains(a.getValue()))
            options.add(new SelectOption(a.getValue(),a.getValue()));//add the value  to our final list
        }
        return options;
        
    }
}