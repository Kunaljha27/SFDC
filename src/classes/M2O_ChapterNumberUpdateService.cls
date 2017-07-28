/**
@Classname :       M2O_ChapterNumberUpdateService 
@Description :     The Service class is invoked for the bussiness logic to performed on Opportuinty Line Item for Chapter Number Update.       
@Author:           Somdev Bhattacharyya
@Last Modified:    18/03/2014
**/
public with sharing class M2O_ChapterNumberUpdateService {
//Method that contains all the business logic for calculating the chapter number.
    public void ChapterNumberUpdate (list<OpportunityLineItem> opportunityLineItemList, set<Id> opportunityIdSet) {
        if(opportunityIdSet != null && !opportunityIdSet.isempty() && opportunityLineItemList != null && !opportunityLineItemList.isempty()) {
            Map<id,decimal> opportunityLineItemIdMap = new Map<id,decimal>();
            List<OpportunityLineItem> oppItemNewList = new List<OpportunityLineItem>(); 
            List<AggregateResult>  oppLineList = new List<AggregateResult> ();
            List<Opportunity> opportunityList = new List<Opportunity>();
            Set<Id>oppIdSet = new Set<Id>();
            //Method to get the opportunity list with type multi deal modality and record type healthcare.
            opportunityList = M2O_OpportunityDAO.getOpportunityId(opportunityIdSet);
            if(opportunityList != null && !opportunityList.isempty()) {
                for (Opportunity opp : opportunityList) {
                    oppIdSet.add(opp.Id);
                }
            }
            ////Method to get the aggregated results..    
            oppLineList=M2O_OpportunityDAO.getOpportunityLineItemForChapterNum(oppIdSet);
            if(oppLineList != null && !oppLineList.isempty()) {
                for (AggregateResult  oppLineItem : oppLineList) {
                    opportunityLineItemIdMap.put((id)oppLineItem.get('OpportunityId'),(decimal)oppLineItem.get('expr0'));
                }
            }
            for(OpportunityLineItem oppLineItemRecord : opportunityLineItemList) {
                if(oppIdSet.contains(oppLineItemRecord.OpportunityId)){ 
                    if(opportunityLineItemIdMap.get(oppLineItemRecord.OpportunityId) != null ) {
                        system.debug('Values in Map'+opportunityLineItemIdMap.get(oppLineItemRecord.OpportunityId));
                        oppLineItemRecord.Chapter_Number_MMD__c = (opportunityLineItemIdMap.get(oppLineItemRecord.opportunityId)) + 1;
                        opportunityLineItemIdMap.put(oppLineItemRecord.opportunityId, oppLineItemRecord.Chapter_Number_MMD__c);
                        system.debug('Map Values'+opportunityLineItemIdMap);
                        oppItemNewList.add(oppLineItemRecord); 
                    }  
                    else {
                        oppLineItemRecord.Chapter_Number_MMD__c = 1;
                        opportunityLineItemIdMap.put(oppLineItemRecord.opportunityId, oppLineItemRecord.Chapter_Number_MMD__c);
                        oppItemNewList.add(oppLineItemRecord); 
                    } 
                }   
            }
        }
    }  
}