/**
* @ClassName <M2O_SalesOrderOppUpdateService>
* @Description <This class is the Serviceclass of M2O_ChangeOpptyStatusOnSalesOrderInsert trigger. This class performes database related action of the page(SOQL and DML)>
* @Author <Somdev Bhattacharyya>
* @Last Modified <24/07/2014>
* @Discussionpoints <No Information>
*/
public with sharing class M2O_SalesOrderOppUpdateService {
    public static set<string> marketFetch () {
        set<String> marketSet = new set<string>();
       List<M2O_MarketsForSalesOrder__c> marketList = new List<M2O_MarketsForSalesOrder__c>(M2O_MarketsForSalesOrder__c.getall().values());
       for(M2O_MarketsForSalesOrder__c market : marketList) {
           marketSet.add(market.Name);    
       }
        return marketSet;
    }
    /**
    * @Description : This method updates the opportunity of sales order with Stage as "Order Booked".
    * @param       : List of Opportunity ID.
    * @return      : Void.
    **/
    public static void opportunityStatusToOrderBookedForLI(List<Sales_Order__c> newTrigger) {
       set<ID> setOpportunityId=new set<ID>();
       
       Sales_Order__c flagSalesorderList= new Sales_Order__c();
       List<Opportunity> opportunityList= new List<Opportunity>();
       List<Opportunity> updateOpportunityList= new List<Opportunity>();
       List<Sales_Order__c> salesOderOpptyDataList = new List<Sales_Order__c>();
       
       Map<Id,List<Sales_Order__c>> salesOrderOpptyIdMap = new Map<Id,List<Sales_Order__c>>();
       for(Sales_Order__c salesOrderObj : newTrigger){
           if(salesOrderObj.Opportunity__c!=null || salesOrderObj.Opportunity__c!='') {
                setOpportunityId.add(salesOrderObj.Opportunity__c);
           }    
       }
       system.debug('@@@@ list '+setOpportunityId);
       //calling DAO class method to get sales order data
       salesOderOpptyDataList = M2O_SalesOrderOppUpdateDAO.getOpportunitySalesOrderData(setOpportunityId);
       system.debug('@@@@ list '+salesOderOpptyDataList);
       for(Id opptyId :setOpportunityId) {
           if(!salesOderOpptyDataList.isEmpty() && salesOderOpptyDataList !=null ) {
               for(Sales_Order__c salOrd : salesOderOpptyDataList ) {
                   
                       if(salesOrderOpptyIdMap.containsKey(opptyId )) {
                           salesOrderOpptyIdMap.get(opptyId ).add(salOrd);
                       }
                       else {
                           salesOrderOpptyIdMap.put(opptyId ,new list<Sales_Order__c>());
                           salesOrderOpptyIdMap.get(opptyId ).add(salOrd);    
                           system.debug('@@@@ Map '+salesOrderOpptyIdMap);                   
                       }
                       
               }
           } 
           //else {   
                  // salesOrderOpptyIdMap.put(opptyId ,new Sales_Order__c[0]);
                   system.debug('@@@@ Map '+salesOrderOpptyIdMap);
           //}        
                                  
       }  opportunity OppObject;
       system.debug('@@@@ Map '+salesOrderOpptyIdMap);
       if(setOpportunityId.size()>0 ){
           for(Id OppId : setOpportunityId){
               OppObject = new Opportunity ( Id=OppId);
               list<Sales_Order__c> sOrderList ;
               for( Id i : salesOrderOpptyIdMap.keyset()) {
                   if(OppId == i) {
                       if (!salesOrderOpptyIdMap.get(OppId ).isempty()) {
                           OppObject.Id = i;
                           
                           OppObject.StageName=M2O_DataUtility.statusOrderBooked;
                           /**if(OppObject.First_Sales_Order_Check__c!=True ) {
                               //OppObject.CloseDate=system.Today();
                               sOrderList= new list<Sales_Order__c>();
                               sOrderList=salesOrderOpptyIdMap.get(OppId );
                               system.debug('test @@saleslist from map'+ sOrderList);
                               if(sOrderList!=null) {
                                   if(sOrderList[0].Order_Date__c!=null) {
                                       system.debug('@@@ fed 22'+sOrderList[0].Order_Date__c);
                                       OppObject.CloseDate=sOrderList[0].Order_Date__c;
                                   }
                                   if(sOrderList[0].Sales_Order_Billing_Status__c=='Fully Invoiced') {
                                       system.debug('@@@ fed33'+sOrderList[0].Sales_Order_Billing_Status__c);
                                       OppObject.StageName='Sales Recognized';    
                                   }
                               }
                               OppObject.First_Sales_Order_Check__c=true;
                            }   
                            if(OppObject.FlagSRD__c!=True && OppObject.StageName=='Sales Recognized') { 
                                system.debug('@@@@ FEd1');
                                OppObject.Sales_recognition_date__c=System.Today();
                                OppObject.FlagSRD__c=True;
                            }**/
                            
                           
                       }OppObject.Id=OppId;
                   }
               }
              
           updateOpportunityList.add(OppObject);
           } 
       }system.debug('dddddd'+updateOpportunityList);
       update updateOpportunityList;
       system.debug('dddddd1'+updateOpportunityList);
       //M2O_SalesOrderOppUpdateDAO.updateOpportunity(updateOpportunityList);
    }
    //method for healthcare sales order
    public static void opportunityStatusToOrderBookedForHC(List<Sales_Order__c> newTrigger) {
       set<ID> setOpportunityId=new set<ID>();
       map<Id,Sales_Order__c>salesorderIdMap=new map<Id,Sales_Order__c>();
       List<Opportunity> opportunityList= new List<Opportunity>();
       List<Opportunity> updateOpportunityList= new List<Opportunity>();
       set<String> marketSet = new set<string>();
       marketSet=marketFetch ();
       for(Sales_Order__c salesOrderObj : newTrigger){
           if(salesOrderObj.Opportunity__c!=null || salesOrderObj.Opportunity__c=='') {
                setOpportunityId.add(salesOrderObj.Opportunity__c);
                salesorderIdMap.put(salesOrderObj.Opportunity__c,salesOrderObj);
           }    
       }
       opportunityList = M2O_SalesOrderOppUpdateDAO.getOpportunityData(setOpportunityId);
       list<sales_order__c> salesOrderUpdateList = new list<sales_order__c>();
       system.debug('@@@@@opptylist1'+opportunityList);
       if(opportunityList.size()>0){
          for(Opportunity OppObject : opportunityList){
              OppObject.stageName=M2O_DataUtility.statusOrderBooked;
              if(OppObject.First_Sales_Order_Check__c!=True && marketSet.contains(OppObject.Market__c) ){
                  if(salesorderIdMap.get(OppObject.id).Order_Date__c!=null){
                      OppObject.CloseDate=salesorderIdMap.get(OppObject.id).Order_Date__c;
                  }
                  if(salesorderIdMap.get(OppObject.id).Sales_Order_Billing_Status__c=='Fully Invoiced' ) {
                      OppObject.StageName='Sales Recognized';
                      sales_order__c s = new sales_order__c(Id=salesorderIdMap.get(OppObject.id).Id,First_Sales_Order_Check__c=true);
                      salesOrderUpdateList.add(s);   
                  }
                  else {
                      sales_order__c s = new sales_order__c(Id=salesorderIdMap.get(OppObject.id).Id,First_Sales_Order_Check__c=true);
                      salesOrderUpdateList.add(s);      
                  }
                  OppObject.First_Sales_Order_Check__c=true;
              }
                       
              system.debug('@@@@@opptylist2'+opportunityList);
              updateOpportunityList.add(OppObject);
              system.debug('@@@@@opptylist3'+updateOpportunityList);
          } 
       }
       Update updateOpportunityList;
       update salesOrderUpdateList;
       //M2O_SalesOrderOppUpdateDAO.updateOpportunity(updateOpportunityList);
    }
}