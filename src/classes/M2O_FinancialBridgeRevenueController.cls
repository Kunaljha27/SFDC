/**
* @ClassName : M2O_FinancialBridgeRevenue_controller
* @Description : This is the controller class of M2O_FinancialBridgeRevenue_Chart Visualforce page.This class performes the function of retreving the Financial Bridge data , editing the existing data and show it in the Financial chart accordingly 
* @Author : Srutadeba Chanda
* @Last Modified : 24/12/2013
* @Discussionpoints : No Information
*/

public with sharing class M2O_FinancialBridgeRevenueController {

    Strategic_Account_Plan__c SapRecord;
    public string lastyear                                                         {get;set;}
    public string currentyear                                                      {get;set;} 
    public boolean displayGrid                                                     {get;set;}
    public boolean displayChart                                                    {get;set;}
    public Boolean saveRecord                                                      {get;set;}
    public string errorMessage                                                     {get;set;}
    public boolean editGrid                                                        {get;set;}
    public UserRecordAccess Hasaccess                                              {get;set;}
    public string currencyValue                                                    {get;set;}
    public M2O_Financial_Bridge_Business_Group__c FinBusinessGrp                   {get;set;}
    public Map<String,M2O_Financial_Bridge_Business_Group__c> businessTypesMap=new Map<String,M2O_Financial_Bridge_Business_Group__c>();
    Id currentUser;
    Id sapRecordID;
    Id revenue;
    public string revenueRecordtypeName                                                       {get;set;}                                                          
    
    /**
    * @Description: This is the constructor, which performs initial action,retriving existing Financial bridge data and retriving the user access on the object
    * @return : Null
    **/
    
    public M2O_FinancialBridgeRevenueController (ApexPages.StandardController controller) {
        displayChart=true;
        SapRecordID = apexpages.currentpage().getparameters().get('id');
        currentUser=UserInfo.getUserId();
        revenue=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
        revenueRecordtypeName ='Revenue';
        SapRecord=M2O_FinancialBridgeService.getMasterRecordSAP(sapRecordID);
        lastyear=string.valueof(SapRecord.From_Date__c.year()-1);
        currentyear=string.valueof(SapRecord.From_Date__c.year());
        Hasaccess =M2O_FinancialBridgeService.getUserAccess(currentUser,sapRecordID);
        currencyValue=M2O_FinancialBridgeService.getCurrencyValue(sapRecordID);
        businessTypesMap=M2O_Financial_Bridge_Business_Group__c.getAll();
        FinBusinessGrp=businessTypesMap.get(SapRecord.philips_sector__c);
        financialBridgeListQ1Q2=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(sapRecordID,revenue);
        financialBridgeListQ2Q3 =M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(sapRecordID,revenue);
    }
    
    public List<Financial_Bridge__c> financialBridgeListQ1Q2{
        get {
            if(financialBridgeListQ1Q2==null){
                financialBridgeListQ1Q2=new List<Financial_Bridge__c>();
            }
            return financialBridgeListQ1Q2;
        }
        set;  
    }       
        
    public List<Financial_Bridge__c> financialBridgeListQ2Q3 {
        get{
            if(financialBridgeListQ2Q3 ==null){
                financialBridgeListQ2Q3 =new List<Financial_Bridge__c>();
            }
            return financialBridgeListQ2Q3 ;
        }
        set;  
    }  
    /**
    * @Description : This method is for Edit function and show the chart
    * param        : None
    * @return      : Null
    **/     
   public void editGrid() {
       displayChart=false;
   }
    
    /**
    * @Description : This method is for cancel function and load the financial data saved for particular strategic Account Plan
    * param        : None
    * @return      : Null
    **/  
    public void cancelGrid() {
        displayChart=true;
        financialBridgeListQ1Q2=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(sapRecordID,revenue);
        financialBridgeListQ2Q3 =M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(sapRecordID,revenue);
    }
     
     /**
    * @Description : This method is for Save function and call the service class for further processing of data 
    * param        : None
    * @return      : Null
    **/ 
     
    public Void saveData(){
        M20_ShowResultFinancialBridgeWrapper ShowResultFinancialBridgeWrapper;
        ShowResultFinancialBridgeWrapper=M2O_FinancialBridgeService.saveGrid(FinancialBridgeListQ1Q2,FinancialBridgeListQ2Q3,revenue);
        if(ShowResultFinancialBridgeWrapper.errorMessage==null) {
            displayChart=true;
            financialBridgeListQ1Q2=M2O_FinancialBridgeService.getFinancialBridgeListQ1Q2(sapRecordID,revenue);
            financialBridgeListQ2Q3 =M2O_FinancialBridgeService.getFinancialBridgeListQ2Q3(sapRecordID,revenue);
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ShowResultFinancialBridgeWrapper.errorMessage));   
        }
    }
}