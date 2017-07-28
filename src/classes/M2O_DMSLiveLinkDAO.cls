/**
* @ClassName :M2O_DMSLiveLinkService
* @Description : This class is the DAO class for DMS Livelink flow.
* @Author : Vishal Kashyap 
* @Last Modified : 4/16/2014
* @Discussionpoints : No Information
*/
global with sharing class M2O_DMSLiveLinkDAO {

    /**
    * @Description : This functions updates Opportunity.
    * @param       : Opportunity Data
    * @return      : None
    **/
    public static void updateOpportunity(Opportunity toBeUpdated) {
        try {
            if(toBeUpdated != null) {
                update toBeUpdated;
            }
        }
        catch(DMLException e) {
            system.debug(e);
        }
    }
    
    /**
    * @Description : This function checks if the Opportunity has related Opportunity Products
    * @param       : Data from Opportunity - opportunity ID 
    * @return      : Count of related Opportunity Product - Integer
    **/ 
    public static Integer checkForOppProduct(ID oppID) {
        Integer countOppProduct;
        countOppProduct = [Select count() from OpportunityLineItem where OpportunityID = :oppID];
        return countOppProduct;
    }
}