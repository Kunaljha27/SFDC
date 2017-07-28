public class HCNA_IdentiferTriggerServiceClass {
    HCNA_IdentiferTriggerDAOClass DAOClass = New HCNA_IdentiferTriggerDAOClass();
    public List<Opportunity> indentifyTheDuplicateProductFamily(set<Id> opportunityIds,List<OpportunityLineItem> allOpportunityLineItems ) {
        List<Opportunity> listOfOpportunityToUpdate = New List<Opportunity>();
        List<string> indentifingList;
        set<string> indentifingSet;
        for(Id opportunityId:opportunityIds) {
            indentifingList = New list<String>();
            for(OpportunityLineItem OpportunityLineItemRecord: allOpportunityLineItems ) {
                if(opportunityId == OpportunityLineItemRecord.opportunityId) {
                    indentifingList.add(OpportunityLineItemRecord.Discount_Authorization_Group__c);
                }
            }
            indentifingSet = New set<string>();
            indentifingSet.addall(indentifingList);
            Opportunity updateOpportunity = New Opportunity(Id = opportunityId);
            if(indentifingSet.size()> 1) {    
                //updateOpportunity.Having_Products_With_Same_Product_Family__c = true;
                updateOpportunity.Product_Family_for_DSR__c = '';
            }else {
               //updateOpportunity.Having_Products_With_Same_Product_Family__c = false;
               if(indentifingList.size()>0) {
                   updateOpportunity.Product_Family_for_DSR__c =indentifingList[0];
               }
            }
            listOfOpportunityToUpdate.add(updateOpportunity);
        }
        return listOfOpportunityToUpdate;
    }
    public List<OpportunityLineItem> retrieveAllOpportunityLineItems(set<Id> opportunityIds) {
        List<OpportunityLineItem> allOpportunityLineItems = New List<OpportunityLineItem>();
        allOpportunityLineItems = DAOClass.retrieveAllOpportunityLineItems(opportunityIds);
        return allOpportunityLineItems;
    }
    public void updateOpportunity(list<Opportunity> listOfOpportunityToUpdate) {
        DAOClass.updateOpportunity(listOfOpportunityToUpdate);
    }
}