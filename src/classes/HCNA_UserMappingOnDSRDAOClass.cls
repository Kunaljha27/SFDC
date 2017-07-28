/**
* @ClassName : HCNA_UserMappingOnDSRDAOClass
* @Description : This is the DAO class on Deal Support Request to map approvers depending upon the region and product family.
* @Author : Ramita Dutta
* @Last Modified : 23/06/2014
* @Discussionpoints : No Information
*/

public class HCNA_UserMappingOnDSRDAOClass{

    /**
    * @Description : This method is for retrieving DSR Mapping records.
    * @param       : Set<String>,Set<String>
    * @return      : List<DSR_User_Mapping__c> 
    **/  
    public List<DSR_User_Mapping__c> getDsrMappingRecords(Set<String> productFamilySet,Set<String> gtmRegionSet){
        List<DSR_User_Mapping__c> listOfUserMappingRecords = new List<DSR_User_Mapping__c>();
        listOfUserMappingRecords = [select Region__c,Forecast_Manager_Owner__c,Sales_Market_Specialist__c,Market_Leader__c,Finance_Director__c,Senior_Finance_Director__c,Channel_Type__c,Zone__c,Product_Family__c from DSR_User_Mapping__c WHERE Product_Family__c IN :productFamilySet AND Region__c IN :gtmRegionSet];
        return listOfUserMappingRecords;
    }
}