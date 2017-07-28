/************************************************************************************************
* @Description : This class is service class for Apex trigger - M2O_UpdateEcoSystemAccountRole.
* @Author : Ayush Gindolia
*************************************************************************************************/
public with sharing class M2O_UpdateEcoSystemAccountRoleService {
    
    //Declaration of variables starts here
    List<Opportunity> listUpdatedOpportunity = new List<Opportunity>();
    //Declaration of variables ends here
    
    // Method is aimed at populating Opportunity Header fields.
    public void populateOpportunityHeader(Set<Id> setOpportunities){
        
        if(setOpportunities!=null && setOpportunities.size() >0){
            
            // Recently deleted Opportunity Line Items are being fetched along with Related Opportunities.
            M2O_UpdateEcoSystemAccountRoleDAO fetchOppHeader = new M2O_UpdateEcoSystemAccountRoleDAO();
            Opportunity[] listOpportunity = fetchOppHeader.fetchOpportunityHeader(setOpportunities);
            
            for(Opportunity opp:listOpportunity){
                // Check if Opportunity Eco System exists for an Opportunity.
                if(opp.Opportunity_Ecosystems__r!=null && opp.Opportunity_Ecosystems__r.size() > 0){
                    integer countEndUser =0;
                    integer countDistUser =0;
                    // Populating Opportunity Header Fields.
                    for(Opportunity_Ecosystem__c oppEcosys : opp.Opportunity_Ecosystems__r){    
                        
                        // Populating Opportunity Header End User Fields.                   
                        if(oppEcosys.Account_Role__c == Label.Account_Role_End_User){
                            opp.Opportunity_Eco_System_End_User_City__c=oppEcosys.Account__r.City_Local__c;
                            opp.Opportunity_Eco_System_End_User_Country__c=oppEcosys.Account__r.Country__c;
                            opp.End_user_role__c=oppEcosys.Account__r.Name;
                            countEndUser++;
                        
                        // Populating Opportunity Header Distributor Fields.    
                        }else if(oppEcosys.Account_Role__c ==Label.Account_Role_Distributor){                           
                            opp.Opp_Eco_System_Distributor_City__c=oppEcosys.Account__r.City_Local__c;
                            opp.Opp_Eco_System_Distributor_Country__c=oppEcosys.Account__r.Country__c;
                            opp.Opp_Eco_System_Distributor_Name__c=oppEcosys.Account__r.Name;
                            countDistUser++;                        
                        }
                    }
                    // Set Opp Header End User fields to blank in case of Zero End User Opportunity Eco-system.
                    if(countEndUser==0){
                        opp.Opportunity_Eco_System_End_User_City__c='';
                        opp.Opportunity_Eco_System_End_User_Country__c='';
                        opp.End_user_role__c='';    
                    }
                    // Set Opp Header Distributor fields to blank in case of Zero Distributor Opportunity Eco-system.
                    if(countDistUser==0){
                        opp.Opp_Eco_System_Distributor_City__c='';
                        opp.Opp_Eco_System_Distributor_Country__c='';
                        opp.Opp_Eco_System_Distributor_Name__c='';  
                    }
                }else{
                    // Set Opp Header fields to blank in case of Zero Opportunity Eco-system.
                    opp.Opportunity_Eco_System_End_User_City__c='';
                    opp.Opportunity_Eco_System_End_User_Country__c='';
                    opp.End_user_role__c='';
                    opp.Opp_Eco_System_Distributor_City__c='';
                    opp.Opp_Eco_System_Distributor_Country__c='';
                    opp.Opp_Eco_System_Distributor_Name__c='';
                }       
                listUpdatedOpportunity.add(opp);
            }
            // Method to call DAO class to update Opportunity Header fields.
            if(listUpdatedOpportunity !=null && listUpdatedOpportunity.size() >0){
                fetchOppHeader.updateOpportunityHeader(listUpdatedOpportunity); 
            }               
        }
    }       
}