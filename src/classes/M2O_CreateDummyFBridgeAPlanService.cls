/**
* @ClassName :M2O_CreateDummyFBridgeAPlanService
* @Description : This class is the business class for creating dummy financial bridge and activation plan for new Strategic Account Plan 
* @Author : Srutadeba Chanda 
* @Last Modified : 29/11/2013
* @Discussionpoints : No Information
*/
public class M2O_CreateDummyFBridgeAPlanService{

M2O_CreateDummyFBridgeAPlanDAO CreateDummyFBridgeAPlanDAO;

    public M2O_CreateDummyFBridgeAPlanService(){
        CreateDummyFBridgeAPlanDAO= new M2O_CreateDummyFBridgeAPlanDAO();
    }
   
    /**
    * @Description : This method creates four dummy finacial bridge record for Revenue and four for 
                     finacial bridgeProfit when a new Strategic account plan gets created
    * @param       : List of Strategic Account Plan  
    * @return      : None
    **/  
    public void createFinancialBridgeForNewSap(List<Strategic_Account_Plan__c> sPlanObjList){
       List<Financial_Bridge__c> lstFinBridge=new List<Financial_Bridge__c>();
       Id profitRecordtype;
       Id revenueRecordtype;
       profitRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Profit').RecordTypeId;
       revenueRecordtype=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
       for(Strategic_Account_Plan__c sPlan: sPlanObjList){
            Financial_Bridge__c fBridgeRevenueQ1=new Financial_Bridge__c();
            fBridgeRevenueQ1.Quarter__c='AOP';
            fBridgeRevenueQ1.currencyIsoCode=sPlan.currencyIsoCode;
            fBridgeRevenueQ1.Strategic_Account_Plan__c=sPlan.id;
            fBridgeRevenueQ1.recordtypeId=revenueRecordtype;
            lstFinBridge.add(fBridgeRevenueQ1);
            Financial_Bridge__c fBridgeRevenueQ2=new Financial_Bridge__c();
            fBridgeRevenueQ2.Quarter__c='End of Q1';
            fBridgeRevenueQ2.currencyIsoCode=sPlan.currencyIsoCode;
            fBridgeRevenueQ2.Strategic_Account_Plan__c=sPlan.id;
            fBridgeRevenueQ2.recordtypeId=revenueRecordtype;
            lstFinBridge.add(fBridgeRevenueQ2);
            Financial_Bridge__c fBridgeRevenueQ3=new Financial_Bridge__c();
            fBridgeRevenueQ3.Quarter__c='End of Q2';
            fBridgeRevenueQ3.currencyIsoCode=sPlan.currencyIsoCode;
            fBridgeRevenueQ3.Strategic_Account_Plan__c=sPlan.id;
            fBridgeRevenueQ3.recordtypeId=revenueRecordtype;
            lstFinBridge.add(fBridgeRevenueQ3);
            Financial_Bridge__c fBridgeRevenueQ4=new Financial_Bridge__c();
            fBridgeRevenueQ4.Quarter__c='End of Q3';
            fBridgeRevenueQ4.currencyIsoCode=sPlan.currencyIsoCode;
            fBridgeRevenueQ4.Strategic_Account_Plan__c=sPlan.id;
            fBridgeRevenueQ4.recordtypeId=revenueRecordtype;
            lstFinBridge.add(fBridgeRevenueQ4);
            
            
            
            
           Financial_Bridge__c fbridgeProfitQ1=new Financial_Bridge__c();
           fbridgeProfitQ1.Quarter__c='AOP';
           fbridgeProfitQ1.currencyIsoCode=sPlan.currencyIsoCode;
           fbridgeProfitQ1.Strategic_Account_Plan__c=sPlan.id;
           fbridgeProfitQ1.recordtypeId=profitRecordtype;
           lstFinBridge.add(fbridgeProfitQ1) ;
           Financial_Bridge__c fbridgeProfitQ2=new Financial_Bridge__c();
           fbridgeProfitQ2.Quarter__c='End of Q1';
           fbridgeProfitQ2.currencyIsoCode=sPlan.currencyIsoCode;
           fbridgeProfitQ2.Strategic_Account_Plan__c=sPlan.id;
           fbridgeProfitQ2.recordtypeId=profitRecordtype;
           lstFinBridge.add(fbridgeProfitQ2) ;
           Financial_Bridge__c fbridgeProfitQ3=new Financial_Bridge__c();
           fbridgeProfitQ3.Quarter__c='End of Q2';
           fbridgeProfitQ3.currencyIsoCode=sPlan.currencyIsoCode;
           fbridgeProfitQ3.Strategic_Account_Plan__c=sPlan.id;
           fbridgeProfitQ3.recordtypeId=profitRecordtype;
           lstFinBridge.add(fbridgeProfitQ3) ;
           Financial_Bridge__c fbridgeProfitQ4=new Financial_Bridge__c();
           fbridgeProfitQ4.Quarter__c='End of Q3';
           fbridgeProfitQ4.currencyIsoCode=sPlan.currencyIsoCode;
           fbridgeProfitQ4.Strategic_Account_Plan__c=sPlan.id;
           fbridgeProfitQ4.recordtypeId=profitRecordtype;
           lstFinBridge.add(fbridgeProfitQ4) ;
       }
       CreateDummyFBridgeAPlanDAO.createNewFBridge(lstFinBridge);
    
    }
    
     /**
    * @Description : This method update the currency whenever currency got changed in master strategic Account Plan 
    * @param       : set of strategic account plan id and map of id and string
    * @return      : None
    **/ 
     public void updateFinancialBridgeCurrency(set<Id> sapId_set, map<Id,String> sapIdCurrency_map){
         List<Financial_Bridge__c> allFinancialBridgeList = new List<Financial_Bridge__c>();
         allFinancialBridgeList = CreateDummyFBridgeAPlanDAO.getFBridgeRecord(sapId_set);
         CreateDummyFBridgeAPlanDAO.updateFBridge(allFinancialBridgeList,sapIdCurrency_map);
        
     }
     
      /**
    * @Description : This method created dummy Activation Plan record when a new Strategic Account Plan gets created
    * @param       : List of Strategic Account Plan 
    * @return      : None
    **/ 
     public void createActivationPlan(List<Strategic_Account_Plan__c> sPlanObjList){
           List<Activation_Plan__c> aPlanList=new List<Activation_Plan__c>();
           for(Strategic_Account_Plan__c sPlan: sPlanObjList){
               Activation_Plan__c aplanObj=new Activation_Plan__c(Strategic_account_plan__c=sPlan.id, IsDummyrecord__c=true,Activity_Detail__c='none',Activity_End_Date__c 
                                        =system.today(), Activity_Start_Date__c=system.today());
                                         
               aPlanList.add(aplanObj);
               
           }
           CreateDummyFBridgeAPlanDAO.createActivationplan(aPlanList);
     }
     
}