/**
@Classname :       M2O_UpdateEODOnOpptyProductService
@Description :     This class is a bussiness logic class which copies Expected Order Date form Opportunity to
                   Expected Order Date on Opportunity Products.
@Author:           Navaneet Pujar
@Last Modified:    21 July 2015
**/
public class M2O_UpdateEODOnOpptyProductService{
    public List<OpportunityLineItem> updateOpptyProduct(Set<Id> opportunityIdSet){
    
        List<OpportunityLineItem> opptyProdList = new List<OpportunityLineItem>();
        List<OpportunityLineItem> updateProdList = new List<OpportunityLineItem>();
        
        if(!opportunityIdSet.isEmpty() && opportunityIdSet != Null){
            opptyProdList = M2O_OpportunityDAO.getOpptyEODList(opportunityIdSet);

            for(OpportunityLineItem opptyLineItem : opptyProdList){
                opptyLineItem.Expected_Order_date__c =  opptyLineItem.Opportunity.CloseDate;
                updateProdList.add(opptyLineItem);
            }
            //M2O_OpportunityDAO.updateOpptyProd(updateProdList);
            //update updateProdList;
        }
        return updateProdList;
    }
}