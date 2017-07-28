/**
* @ClassName     : M2O_CampaignValidationService
* @Description   : This class includes the business logic for Master Campaign validation checks . 
* @Author        : Somdev Bhattacharyya
* @Last Modified : 02/04/2015
* @Discussionpoints : No Information
**/
global  class M2O_CampaignValidationService{
    global  List<Campaign> channelCampList=new List<Campaign>();
    global Set<Id>masterCampIdSet=new Set<id>();
    public M2O_CampaignValidationService (Set<Id>masterCampIdSet1) {
        channelCampList=[Select ParentId,Status from campaign where ParentId in :masterCampIdSet1];
        masterCampIdSet=masterCampIdSet1.clone();
    }
   
   /**
    * @Description : This method includes the business logic for Master Campaign validation checks     
    * @param       : none
    * @return      : Map of id and string
    **/ 
    public Map<Id,Integer> checkStatusforCancelled() {
        Map<Id,Integer> masterCampIdStatusCancelledMap=new Map<Id,Integer>();
        Integer count=0;
        for(Campaign cmp: channelCampList) {
            if(masterCampIdSet.contains(cmp.ParentId) && cmp.Status!='Cancelled') {
                masterCampIdStatusCancelledMap.put(cmp.ParentId,1);
            }
        }
        
        return masterCampIdStatusCancelledMap;
    }
    
    //Validation check for completed
    
     /**
    * @Description : This method includes the business logic for Master Campaign validation checks     
    * @param       : none
    * @return      : Map of id and string
    **/ 
    public Map<Id,Integer> checkStatusforCompleted() {
        Map<Id,integer> masterCampIdStatusCompletedMap=new Map<Id,integer>();
        Integer count=0;
        for(Campaign cmp: channelCampList) {
            if(masterCampIdSet.contains(cmp.ParentId) && cmp.Status!='Completed') {
                masterCampIdStatusCompletedMap.put(cmp.ParentId,1);
            }
        }
        
        return masterCampIdStatusCompletedMap;
    }
}