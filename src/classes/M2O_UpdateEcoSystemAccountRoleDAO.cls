/************************************************************************************************
* @Description : This class is DAO class for Apex trigger - M2O_UpdateEcoSystemAccountRole.
* @Author : Ayush Gindolia
*************************************************************************************************/
public with sharing class M2O_UpdateEcoSystemAccountRoleDAO {
    
    //Declaration starts here   
    Set<String> SetAccountRoles = new Set<String>();
    //Declaration ends here
    
    // Method to return Opportunity Ecosystem and related Opportunities.
    public List<Opportunity> fetchOpportunityHeader(Set<Id> setOpportunities){
        if(setOpportunities!=null && setOpportunities.size() >0){
            return [Select id,Opportunity_Eco_System_End_User_City__c,Opportunity_Eco_System_End_User_Country__c,End_user_role__c,Opp_Eco_System_Distributor_City__c,Opp_Eco_System_Distributor_Country__c,Opp_Eco_System_Distributor_Name__c,(Select Account_Role__c,Account__c,Account__r.Name,Account__r.City_Local__c,Account__r.Country__c from Opportunity_Ecosystems__r where Account_Role__c=:Label.Account_Role_Distributor OR Account_Role__c=:Label.Account_Role_End_User order by LastModifiedDate) from Opportunity where id in:setOpportunities];                 
        }
        return null;
    }
    
    // Method to update fields on Opportunity Header.
    public void updateOpportunityHeader(List<Opportunity> listUpdatedOpportunity){      
        if(listUpdatedOpportunity.size()>0){
            try{
                update listUpdatedOpportunity;
            }
            catch(DMLException ex){
                system.debug(ex);
            }   
        }       
    } 
}