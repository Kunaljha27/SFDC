/**
* @ClassName : HCNA_OpportunityOveridePageDAOClasss
* @Description : This is the DAO class of HCNA_OpportunityOveridePage.This class performs the functionality of overriding.
* @Author : Harmeet Kaur
* @Last Modified : 07/04/2014
* @Discussionpoints : No Information
**/
public class HCNA_OpportunityOveridePageDAOClass {
         
       
    /**
    * @Description : This Method will be retrieve List Of Oppotrunities to be updated.
    * @param       : List<Id> opportunityIdsList
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getListOfOpportunities(Set<Id> opportunityIdsList){
        List<Opportunity> opportunityList = new List<Opportunity>();
        opportunityList = [Select Product_Family__c from Opportunity where Id in :opportunityIdsList];
        return opportunityList; 
    }
    
    /**
    * @Description : This Method will be retrieve product family for deleted line items.
    * @param       : List<Id> opportunityIdsList
    * @return      : List<OpportunityLineItem>
    **/
    public List<OpportunityLineItem> getListOfDeletedLineItems(Set<Id> opportunityIdsSet){
        List<OpportunityLineItem> opportunityItemList = new List<OpportunityLineItem>();
        try{
                opportunityItemList = [Select Id,Product_Family__c,OpportunityId from OpportunityLineItem where OpportunityId in :opportunityIdsSet];
        }
        catch(Exception exceptionMessage){
            System.debug(exceptionMessage.getMessage());
            return null;
        }
        return opportunityItemList ; 
    }
    
    /**
    * @Description : This Method will update the opportunites records.
    * @param       : List<Opportunity> opportunityUpdateList
    * @return      : void
    **/
    public void updateListOfOpportunites(List<Opportunity> opportunityUpdateList){
        try{
            Database.update(opportunityUpdateList,false);
        }
        catch(Exception exceptionMessage){
            System.debug(exceptionMessage.getMessage());
        }
    }
    
    

}