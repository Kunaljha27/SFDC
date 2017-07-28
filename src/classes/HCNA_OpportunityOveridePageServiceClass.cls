/**
* @ClassName : HCNA_OpportunityOveridePageServiceClass
* @Description : This is the Service class of HCNA_OpportunityOveridePage.This class performs the functionality of overriding.
* @Author : Harmeet Kaur
* @Last Modified : 07/04/2014
* @Discussionpoints : No Information
**/
public class HCNA_OpportunityOveridePageServiceClass {
    HCNA_OpportunityOveridePageDAOClass daoObj = new HCNA_OpportunityOveridePageDAOClass();
    
        /**
    * @Description : This Method will be retrieve List Of Oppotrunities to be updated.
    * @param       : List<Id> opportunityIdsList
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getListOfOpportunities(Set<Id> opportunityIdsList){
        try{
            List<Opportunity> opportunityList = new List<Opportunity>();
            opportunityList = daoObj.getListOfOpportunities(opportunityIdsList); 
            return opportunityList; 
        }
        catch(Exception exceptionMessage){
            System.debug(exceptionMessage.getMessage());
            return null;
        }
    }
    
    /**
    * @Description : This Method will be retrieve product family for deleted line items.
    * @param       : List<Id> opportunityIdsList
    * @return      : List<OpportunityLineItem>
    **/
    public List<OpportunityLineItem> getListOfDeletedLineItems(Set<Id> opportunityIdsSet){
        List<OpportunityLineItem> opportunityItemList = new List<OpportunityLineItem>();
        opportunityItemList= daoObj.getListOfDeletedLineItems(opportunityIdsSet); 
        return opportunityItemList; 
    }
    
    /**
    * @Description : This Method will update the opportunites records.
    * @param       : List<Opportunity> opportunityUpdateList
    * @return      : void
    **/
    public void updateListOfOpportunites(List<Opportunity> opportunityUpdateList){
        daoObj.updateListOfOpportunites(opportunityUpdateList); 
    }
    
}