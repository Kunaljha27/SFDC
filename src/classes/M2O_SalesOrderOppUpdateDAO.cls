/**
* @ClassName <M2O_SalesOrderOppUpdateDAO>
* @Description <This class is the DAO class of M2O_ChangeOpptyStatusOnSalesOrderInsert trigger. This class performes database related action of the page(SOQL and DML)>
* @Author <Somdev Bhattacharyya/Vishal Kashyap>
* @Last Modified <24/07/2014>
* @Discussionpoints <No Information>
*/
public with sharing class M2O_SalesOrderOppUpdateDAO {
    /**
    * @Description : This method retrevies retrieves Opportunity information.
    * @param       : Set of Opportunity ID.
    * @return      : List of Opportunity.
    **/
    public static List<Opportunity> getOpportunityData(set<ID> setOpportunityId) {
        try {
            List<Opportunity> opportunityList = new List<Opportunity>();
            opportunityList=[select id , name, stageName,RecordTypeId ,FlagSRD__c,Market__c from Opportunity where id in:setOpportunityId ];
            return opportunityList;
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        }
    }
    /**
    * @Description : This method gets sales order data for sum of all net values .
    * @param       : set of Opportunity ID. 
    * @return      : list of sales order.
    **/
    public static List<AggregateResult>getSalesOderNetAlldata (set<ID> setOpportunityId) {
        try {
            List<AggregateResult> salesOderOpptyDataList = new List<AggregateResult>();
            salesOderOpptyDataList=[select SUM(Net_Value__c) sumSalOrds,Opportunity__c opptyId from Sales_Order__c where Opportunity__c in :setOpportunityId GROUP BY Opportunity__c];
            return salesOderOpptyDataList;
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        }
    }
    
    /**
    * @Description : This method gets sales order data for sum of all invoiced net values .
    * @param       : set of Opportunity ID. 
    * @return      : list of sales order.
    **/
    public static List<AggregateResult>getSalesOderNetdata (set<ID> setOpportunityId) {
        try {
            List<AggregateResult> salesOderOpptyDataList = new List<AggregateResult>();
            salesOderOpptyDataList=[select SUM(Net_Value__c) sumSalOrds,Opportunity__c opptyId  from Sales_Order__c where Opportunity__c in :setOpportunityId AND Sales_Order_Billing_Status__c='Fully Invoiced' group by Opportunity__c];
            system.debug('Test @@alone'+salesOderOpptyDataList);
            return salesOderOpptyDataList;
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        }
    }
    /**
    * @Description : This method gets sales order data .
    * @param       : set of Opportunity ID. 
    * @return      : list of sales order.
    **/
    public static List<Sales_Order__c>getOpportunitySalesOrderData (set<ID> setOpportunityId) {
        try {
            List<Sales_Order__c> salesOderOpptyDataList = new List<Sales_Order__c>();
            system.debug('@@ set DAO'+ setOpportunityId);
            salesOderOpptyDataList = [select Opportunity__c, Order_Reason__c,name,Order_Date__c,Sales_Order_Billing_Status__c  from Sales_Order__c where Opportunity__c in:setOpportunityId AND Order_Reason__c!='ZSO'];
            system.debug('@@@ DAO List'+ salesOderOpptyDataList);
            return salesOderOpptyDataList;
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        }
    }
    
    /**
    * @Description : This method updates Opportunity.
    * @param       : List of Opportunity ID. 
    * @return      : Void.
    **/
    public static void updateOpportunity(List<Opportunity> updateOpportunityList) {
        try {
            update updateOpportunityList;
            system.debug('@@@@opptylist4'+updateOpportunityList);
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            system.debug('@@@@opptylist5'+e);
            insert error;
            
        }
    }
    /**
    * @Description : This method updates OpportunityLineItem.
    * @param       : List of OpportunityLineItem. 
    * @return      : Void.
    **/
    public static void updateOpportunityLine(List<OpportunityLineItem> updateOpportunityLineItemList) {
        try {
            update updateOpportunityLineItemList;
            system.debug('@@@@opptylinelist6'+updateOpportunityLineItemList);
        }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            system.debug('@@@@opptylist7'+e);
            insert error;
            
        }
    }
    
     /**
    * @Description : This method gets sales order data .
    * @param       : set of sales order ID. 
    * @return      : list of sales order.
    **/
    public static List<Sales_Order__c>getSalesOrderData (set<ID> salesOrdrIdSet) {
        try {
            return ([Select Opportunity__c,Net_Value__c,CurrencyIsoCode from Sales_Order__c where Id in :salesOrdrIdSet]);
            }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        } 
     }      
     /**
    * @Description : This method gets OpportunityLineItem data .
    * @param       : set of opportunity ID. 
    * @return      : list of OpportunityLineItem.
    **/
    public static List<OpportunityLineItem>getOpptyLineData (set<ID> opptyIdSet) {
        try {
            return ([Select Chapter_Number_MMD__c , Sales_Recognition_Date_2__c,Opportunity.Id,Trigger_total_price__c,TotalPrice,Extended_warranty_value__c from OpportunityLineItem where Opportunity.Id in :opptyIdSet]);
            }
        catch (Exception e) {
            Error_Handling__c error = M2O_ErrorHandling.errorHandling (e);
            insert error;
            return null;
        } 
     }
           
}