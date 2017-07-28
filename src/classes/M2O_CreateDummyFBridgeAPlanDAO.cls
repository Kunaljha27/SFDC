/**
* @ClassName : M2O_CreateDummyFBridgeAPlanDAO
* @Description : This class performs the DML operation for creating financila bridge and activation plan while creating new Strategic Account Plan 
* @Author :Bindesh Kushwah
* @Last Modified :28/11/2013
* @Discussionpoints :No Information
*/
public class M2O_CreateDummyFBridgeAPlanDAO{
    public M2O_CreateDummyFBridgeAPlanDAO(){
    
    }
    
      /**
    * @Description : This method creates financial bridge record while creating new Strategic Account Plan
    * @param       : List of Financial Bridge
    * @return      : None
    **/ 
    public void createNewFBridge(List<Financial_Bridge__c> lstFinBridge){
        try{
            insert lstFinBridge;
        } 
         catch(System.DmlException e){
            system.debug(e.getMessage());
        }
     }  
     
    /**
    * @Description : This method update the currency of financial bridge record when ever any change in the currency field in master Strategic Account plan 
    * @param       : List of Financial Bridge and map of id and string for the currency record
    * @return      : None
    **/ 
     public void updateFBridge(List<Financial_Bridge__c> allFinancialBridgeList, map<Id,String> sapIdCurrency_map){ 
         List<Financial_Bridge__c> updateFinancialBridgeList = new List<Financial_Bridge__c>();
         for(Financial_Bridge__c finBridge: allFinancialBridgeList){
             finBridge.CurrencyIsoCode=sapIdCurrency_map.get(finBridge.Strategic_Account_Plan__c);
             updateFinancialBridgeList.add(finBridge);
       }
         try{
             update updateFinancialBridgeList;
         }
          catch(System.DmlException e){
            system.debug(e.getMessage());
        }
     }
     
     /**
    * @Description : Get all the Financial Bridge record for a Strategic Account Plan
    * @param       : set of strategic Account Plan id
    * @return      : List of Financial Bridge
    **/ 
     public List<Financial_Bridge__c> getFBridgeRecord(set<Id> sapId_set){
          List<Financial_Bridge__c> allFinancialBridgeList = new List<Financial_Bridge__c>();
           allFinancialBridgeList=[select id , CurrencyIsoCode,Strategic_Account_Plan__c from Financial_Bridge__c where Strategic_Account_Plan__c in :sapId_set];
          return allFinancialBridgeList;
     }
     
     public void createActivationplan(List<Activation_Plan__c> aPlanList){
         try{
             insert aPlanList;
             
         }
          catch(System.DmlException e){
            system.debug(e.getMessage());
        }
  
     }
}