/**
* @ClassName : M2O_FinancialTracking
* @Description : This class is the controller class for M2O_FinancialTracking
* @Author : Vishal Kashyap
* @Last Modified : 2/12/2013
* @Discussionpoints : No Information
*/
public with sharing class M2O_FinancialTrackingController {

    public List<financial_tracking__c> relatedFinTrack{set;get;}
    public List<financial_tracking__c> finalRelatedFinTrack{set;get;}
    public financial_tracking__c total{get;set;}
    public Boolean editMode{get;set;}
    public List<M2O_Financial_Tracking_Category__c> businessTypes=M2O_Financial_Tracking_Category__c.getall().values();
    public List<financial_tracking__c> notInDB;
    ID SAPID;
    public Integer Year{get;set;}
    public Date Month{get;set;}
    public Date fromDate{get;set;}
    public String currencyS{get;set;}
    public strategic_account_plan__c SAP{get;set;}
    public Map<String,M2O_CurrencySymbol__c> currencySymbolMap=new Map<String,M2O_CurrencySymbol__c>();
    public UserRecordAccess Hasaccess{get;set;}
    public boolean renderAttachment{get;set;}
 
    /**
    * @Description : This is the constructer for M2O_FinancialTrackingwhich retrieves SAP, Financial Tracking and Current User Information.
    * @param       : ApexPage Standard Controller.
    * @return      : null.
    **/
    public M2O_FinancialTrackingController (ApexPages.StandardController controller) {
        finalRelatedFinTrack= new List<Financial_Tracking__C>();
        notInDB = new List<financial_tracking__c>();
        relatedFinTrack=new List<financial_tracking__c>();
        SAPID = ApexPages.currentPage().getParameters().get('id');
        SAP=new strategic_account_plan__c();

        SAP = M2O_FinancialTrackingDao.querySapRecord(SAPID);
        if(SAP.From_Date__c != null){
            fromDate=SAP.From_Date__c;
        } else {
            Year=null;
            currencyS=null;
        }
        
        currencySymbolMap=M2O_CurrencySymbol__c.getAll();
        currencyS =(currencySymbolMap.get(SAP.CurrencyIsoCode)).Symbol__c;
        showdata();
        renderAttachment = relatedFinTrack.size() > 0 ? true : false;
        relatedFinTrack.addall(notInDB); 
        
    }
    
    /**
    * @Description : This method performs operation to view data from Financial Tracking related to current SAP in The Financial Tracking VF Page.
    * @param       : No Parameter.
    * @return      : Void method.
    **/
    public void showdata() {
        Hasaccess = new UserRecordAccess();
        Id currentUser=UserInfo.getUserId();
        
        Hasaccess = M2O_FinancialTrackingDao.recordAccess(currentUser , SAPID);
        businessTypes.sort();
        
        relatedFinTrack=new List<financial_tracking__c>(M2O_FinancialTrackingDao.getFTRecords(SAPID));
        if(relatedFinTrack.size()==0) {
            notInDB = M2O_FinancialTrackingService.getFirstRunFT(businessTypes , SAP);         
        }
        total = M2O_FinancialTrackingService.getFindTotal(relatedFinTrack);
        finalRelatedFinTrack= M2O_FinancialTrackingService.getThousandScaleUI(relatedFinTrack);
        total=M2O_FinancialTrackingService.getThousandScaleUI(total);
    }
    
    /**
    * @Description : This method changes the Edit mode when invoked.
    * @param       : No Parameter.
    * @return      : Void method.
    **/
    public void enableEditing() {
            editMode=(editMode==true)?false:true;
            if(editMode!=true) {
                showdata();
            }
    }
    
    /**
    * @Description : This method changes the edit mode and Cancels the page.
    * @param       : No Parameter.
    * @return      : Void method.
    **/
    public pagereference cancel() {
        if(notInDB!=null && !notInDB.isEmpty()) {
            save();
        }
        editMode = false;
        return ApexPages.currentPage();
    }
    
    /**
    * @Description : This method invokes Save method after changing the Financial Tracking to 1000 scale and changes the edit mode..
    * @param       : No Parameter.
    * @return      : Void method.
    **/
    public void save() {
      M20_ShowResultFinancialTrackingWrapper ShowResultFinancialTrackingWrapper; 
      relatedFinTrack= M2O_FinancialTrackingService.getThousandScaleDB(finalRelatedFinTrack); 
      ShowResultFinancialTrackingWrapper=M2O_FinancialTrackingDao.save(SAP , relatedFinTrack);
      if(ShowResultFinancialTrackingWrapper.errorMessage!=null){
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ShowResultFinancialTrackingWrapper.errorMessage));   
      }
      
      enableEditing();
    }
}