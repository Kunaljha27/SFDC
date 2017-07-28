public class HCNA_IdentiferTriggerDAOClass {
     public void updateOpportunity(list<Opportunity> listOfOpportunityToUpdate) {
       update listOfOpportunityToUpdate;
    }
    public List<OpportunityLineItem> retrieveAllOpportunityLineItems(set<Id> opportunityIds) {
        List<OpportunityLineItem> allOpportunityLineItems = New List<OpportunityLineItem>();
        allOpportunityLineItems = [select Id, opportunityId,Product_Family__c,Discount_Authorization_Group__c from OpportunityLineItem where opportunityId in: opportunityIds];
        return allOpportunityLineItems;
    }
}