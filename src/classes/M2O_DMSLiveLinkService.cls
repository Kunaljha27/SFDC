/**
* @ClassName :M2O_DMSLiveLinkService
* @Description : This class is the service class for DMS Livelink flow.
* @Author : Vishal Kashyap 
* @Last Modified : 4/16/2014
* @Discussionpoints : No Information
*/

global with sharing class M2O_DMSLiveLinkService {
    /**
    * @Description : This functions updates DMS url and check the 'Send to OnePI' button.
    * @param       : Data from Opportunity - opportunity ID, GoldenID, and DMS Link  
    * @return      : None
    **/  
    WebService static void updateOpportunity(ID oppID, String goldenID, String DMSLink) {
        List<AggregateResult> minChapterList = new List<AggregateResult>();
        Opportunity toBeUpdated;
        Decimal minChapter;
        
        minChapterList = [Select min(Chapter_Number_MMD__c) from OpportunityLineItem where OpportunityID = :oppID];
        minChapter = (Decimal)minChapterList[0].get('expr0');
        if(DMSLink.length() > 0 && DMSLink != null) {
            toBeUpdated = new opportunity(ID = oppID, Send_to_OnePI__c = true);
        }
        else {
            if(goldenID != null && goldenID != '') {
                if(goldenID.startsWith('0')){
                    goldenID = goldenID.replaceFirst('^0+',''); 
                }   
                    toBeUpdated = new opportunity(ID = oppID, Send_to_OnePI__c = true, DMS__c = Label.M2O_DMSLiveLink_Static_URL+goldenID+'_0_'+minChapter );               
            }
        }
        M2O_DMSLiveLinkDAO.updateOpportunity(toBeUpdated);
    }
    
    /**
    * @Description : This function checks if the Opportunity has related Opportunity Products
    * @param       : Data from Opportunity - opportunity ID 
    * @return      : None
    **/ 
    WebService static boolean checkForOppProduct(ID oppID) {
        return M2O_DMSLiveLinkDAO.checkForOppProduct(oppID) > 0;
    }
}