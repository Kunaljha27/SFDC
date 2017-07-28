public with sharing class campaign_Mem_update_helper {

  @future 
  Public static void UpdateCampHIst(List<Id> lid, List<Id> campid, List<string> rating) {    
   list<CampaignMember> cmlist = new list<CampaignMember>();
   map<id,CampaignMember> idcmmap = new map<id,CampaignMember>();
   list<CampaignMember> cmuplist = new list<CampaignMember>();
   integer NumberOfRecords = lid.size();
   For(integer I = 0;I<NumberOfRecords ; I++){
       cmlist=[select ID,Rating_for_campaign_Rollup__c from CampaignMember WHERE LeadId = :lid[I] and CampaignId = :campid[I] limit 1];
       CampaignMember cm = new CampaignMember();
       if(cmlist != null && !cmList.isEmpty()){
       cm.id = cmlist[0].ID;
       cm.Rating_for_campaign_Rollup__c = rating[I] ;
       cmuplist.add(cm);    
       }
   }
   if(cmuplist != null){
   update cmuplist;
   }
   }
}