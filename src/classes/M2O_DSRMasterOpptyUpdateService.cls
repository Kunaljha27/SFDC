public class M2O_DSRMasterOpptyUpdateService {
    public void updateMasterOppty (list<Deal_Support_Request_del__c> dSRList,set<id> opportunityIdSet) {
        list<opportunity> masterOpptyIdList = new list<opportunity>();
        masterOpptyIdList = M2O_OpportunityDao.getOpportunityEOD(opportunityIdSet);
        if(dSRList != null && !dSRList.isempty()) {
            for (Deal_Support_Request_del__c dsr :dSRList ) {
                for (Opportunity oppty :masterOpptyIdList ) {
                    if(oppty.Id == dsr.Related_Opportunity_del__c) {
                        dsr.Master_Opportunity__c=oppty.Opportunity_Hierarchy_Link__c;
                    }
                }
               
            }
        }
    }
    
    public void updateMasterOpptyForSalesOrder (list<Sales_Order__c> salesOderList,set<id> opportunityIdSet) {
        list<opportunity> masterOpptyIdList = new list<opportunity>();
        masterOpptyIdList = M2O_OpportunityDao.getOpportunityEOD(opportunityIdSet);
        if(salesOderList!= null && !salesOderList.isempty()) {
            for (Sales_Order__c sO :salesOderList) {
                for (Opportunity oppty :masterOpptyIdList ) {
                    if(oppty.Id == sO.Opportunity__c) {
                        sO.Master_Opportunity__c=oppty.Opportunity_Hierarchy_Link__c;
                    }
                }
               
            }
        }
    }
}