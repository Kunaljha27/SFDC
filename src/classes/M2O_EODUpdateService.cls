/**
* @ClassName : M2O_EODUpdateService
* @Description : This class is the service class of M2O_EODUpdateService.
* @Author : Somdev Bhattacharyya
* @Last Modified : 12/06/2014
* @Discussionpoints : No Information
*/
public with sharing class M2O_EODUpdateService {
//Method that contains all the business logic for calculating the EOD on header Oppty on update and insert.
    public void eODUpdate (list<OpportunityLineItem> opportunityLineItemList, set<Id> opportunityIdSet) {
        if(opportunityIdSet != null && !opportunityIdSet.isempty() && opportunityLineItemList != null && !opportunityLineItemList.isempty()) {
            Map<id,object> opportunityLineItemIdMap = new Map<id,object>();
            List<OpportunityLineItem> oppItemNewList = new List<OpportunityLineItem>(); 
            List<AggregateResult>  oppLineList = new List<AggregateResult> ();
            List<Opportunity> opportunityList = new List<Opportunity>();
            Set<Id>oppIdSet = new Set<Id>();
            opportunityList = M2O_OpportunityDAO.getOpportunityEOD(opportunityIdSet);
            ////Method to get the aggregated results..    
            oppLineList=M2O_OpportunityDAO.getOpportunityLineItemForEODUpdateOnHeader(opportunityIdSet);
            system.debug('Time 1 list ' +oppLineList);
            if(oppLineList != null && !oppLineList.isempty()) {
                for (AggregateResult  oppLineItem : oppLineList) {
                    opportunityLineItemIdMap.put((id)oppLineItem.get('OptyId'),(Object)oppLineItem.get('trial'));
                }
            }
            system.debug('Time 2 map'+opportunityLineItemIdMap);
             List<Opportunity> oppty = new List<Opportunity>();
            
            for(Opportunity opp : opportunityList) {
                if(opportunityLineItemIdMap.keyset().contains(opp.id)==true){
                    if(Date.valueOf(opportunityLineItemIdMap.get(opp.Id))!= null && (opp.CloseDate > Date.valueOf(opportunityLineItemIdMap.get(opp.Id)))) {                     
                       opp.CloseDate= Date.valueOf(opportunityLineItemIdMap.get(opp.Id));
                    }
                    oppty.add(opp);   
                }
            }
            if(oppty != null && oppty.size()> 0 ){
                M2O_OpportunityDAO.opportunityEODUpdate(oppty);
            }           
         }
      }
      //Method that contains all the business logic for calculating the EOD on header Oppty on delete.
      public void eODUpdateOnDelete (list<OpportunityLineItem> opportunityLineItemList, set<Id> opportunityIdSet) {
           if(opportunityIdSet != null && !opportunityIdSet.isempty() && opportunityLineItemList != null && !opportunityLineItemList.isempty()) {
                Map<id,object> opportunityLineItemIdMap = new Map<id,object>();
                List<OpportunityLineItem> oppItemNewList = new List<OpportunityLineItem>(); 
                List<AggregateResult>  oppLineList = new List<AggregateResult> ();
                List<Opportunity> opportunityList = new List<Opportunity>();
                Set<Id>oppIdSet = new Set<Id>();
                //Method to get the number of oppty products
                Integer count = M2O_OpportunityDAO.getNumberOpportunityLineItem(opportunityIdSet);
                if(count >=2) {
                    ////Method to get the aggregated results..    
                    oppLineList=M2O_OpportunityDAO.getOpportunityLineItemForEODUpdateOnHeader(opportunityIdSet);
                    system.debug('Time 1 list ' +oppLineList);
                    if(oppLineList != null && !oppLineList.isempty()) {
                        for (AggregateResult  oppLineItem : oppLineList) {
                            opportunityLineItemIdMap.put((id)oppLineItem.get('OptyId'),(Object)oppLineItem.get('trial'));
                        }
                        system.debug('Time 2 map'+opportunityLineItemIdMap);
                        Opportunity oppty;
                        for(OpportunityLineItem oppLineItemRecord : opportunityLineItemList) {
                            oppty = new Opportunity();
                            oppty.Id = oppLineItemRecord.OpportunityId;
                            oppty.CloseDate= Date.valueOf(opportunityLineItemIdMap.get(oppLineItemRecord.OpportunityId));
                            system.debug('time opp ' + oppty);
                            M2O_OpportunityDAO.opportunityEODUpdate(oppty);
                        }    
                    }
                }     
           }
      }
  }