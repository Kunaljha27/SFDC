/**
* @ClassName : HCNA_UserMappingOnDSRServiceClass
* @Description : This is the service class on Deal Support Request to map approvers depending upon the region and product family.
* @Author : Ramita Dutta
* @Last Modified : 24/06/2014
* @Discussionpoints : No Information
*/

public class HCNA_UserMappingOnDSRServiceClass{
    
    HCNA_UserMappingOnDSRDAOClass daoClass = new HCNA_UserMappingOnDSRDAOClass();
    
    /**
    * @Description : This method is for retrieving DSR Mapping records.
    * @param       : Set<String>,Set<String>
    * @return      : List<DSR_User_Mapping__c> 
    **/ 
    public List<DSR_User_Mapping__c> getDsrMappingRecords(Set<String> productFamilySet,Set<String> gtmRegionSet){
        List<DSR_User_Mapping__c> listOfUserMappingRecords = new List<DSR_User_Mapping__c>();
        try{
            if(productFamilySet != null && !productFamilySet.isEmpty() && gtmRegionSet != null && !gtmRegionSet.isEmpty()){
                listOfUserMappingRecords = daoClass.getDsrMappingRecords(productFamilySet,gtmRegionSet);
            }
            return listOfUserMappingRecords;
        }
        catch(Exception ex){
            return null;
        }
    }    
    
    /**
    * @Description : This method assigns the values to the fields on the Deal Support Request Record.
    * @param       : List<Deal_Support_Request_del__c> , Map<String,DSR_User_Mapping__c>
    * @return      : void.
    **/ 
    public void assignValuesToDSR(List<Deal_Support_Request_del__c> selectRecordsList,Map<String,DSR_User_Mapping__c> mapOfDealUser){
        if(selectRecordsList != null && !selectRecordsList.isEmpty() && mapOfDealUser != null && !mapOfDealUser.isEmpty()){
            for(Deal_Support_Request_del__c dealSupportReqRecord : selectRecordsList){
                if(mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c) != null){
                    dealSupportReqRecord.Sales_Market_Specialist__c = mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c).Sales_Market_Specialist__c;
                    dealSupportReqRecord.Region_Manager__c = mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c).Forecast_Manager_Owner__c; 
                    dealSupportReqRecord.DAR_Market_Leader__c = mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c).Market_Leader__c; 
                    dealSupportReqRecord.Finance_Director__c = mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c).Finance_Director__c; 
                    dealSupportReqRecord.Senior_Finance_Director__c = mapOfDealUser.get(dealSupportReqRecord.Product_Family__c+dealSupportReqRecord.GTM_Region__c).Senior_Finance_Director__c; 
                }
                else{
                    dealSupportReqRecord.Sales_Market_Specialist__c = null;
                    dealSupportReqRecord.Region_Manager__c= null; 
                    dealSupportReqRecord.DAR_Market_Leader__c = null;
                    dealSupportReqRecord.Finance_Director__c = null;
                    dealSupportReqRecord.Senior_Finance_Director__c = null;
                }     
            }
        } 
    }
}