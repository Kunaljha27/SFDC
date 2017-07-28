/**
* @ClassName : HCNA_CheckLeadRecordTypeCMService
* @Description : This class is the Service class for HCNA_CheckLeadRecordTypeCM trigger
* @Author : Ayush Gindolia
* @Last Modified : 12/27/2013
* @Discussionpoints : No Information
*/

public class HCNA_CheckLeadRecordTypeCMService{
    
     
    /* Method 'UpdateLeadWithAccountData' starts here - This method is used to 
       populate fields of Lead record corresponding to fields of Account. */
    public static void UpdateLeadWithAccountData( Map<Lead,Id> mapLeadRecords){  
    
        // Querying the desired fields of Account which will be used to populate fields of Lead.   
        Map<Id,Account> mapOfLeadIdAndAccount = new Map<Id,Account>([Select id,BillingCity,Name,BillingCountry,BillingState,
                                                               BillingStreet,BillingPostalCode,Siebel_ID__c from Account where id in:mapLeadRecords.values()]);
                
        for(Lead lst:mapLeadRecords.keyset()){    
                           
            // To check if field 'Existing Account' on Lead record is not blank.            
            if(lst.Account__c !=null){ 
            
                // Updating fields of Lead with corresponding fields on Account.              
                if(mapOfLeadIdAndAccount.get(lst.Account__c).BillingCity !='')
                    lst.City = mapOfLeadIdAndAccount.get(lst.Account__c).BillingCity;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).Name !='')
                    lst.Company = mapOfLeadIdAndAccount.get(lst.Account__c).Name;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).BillingCountry !='')
                    lst.Country = mapOfLeadIdAndAccount.get(lst.Account__c).BillingCountry;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).BillingState !='')
                    lst.State = mapOfLeadIdAndAccount.get(lst.Account__c).BillingState;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).BillingStreet !='')
                    lst.Street = mapOfLeadIdAndAccount.get(lst.Account__c).BillingStreet;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).BillingPostalCode !='')
                    lst.PostalCode= mapOfLeadIdAndAccount.get(lst.Account__c).BillingPostalCode;
                if(mapOfLeadIdAndAccount.get(lst.Account__c).Siebel_ID__c !='')
                    lst.Lead_s_Siebel_Account_ID__c= mapOfLeadIdAndAccount.get(lst.Account__c).Siebel_ID__c; 
            }                             
        } 
    }        
    /* Method 'UpdateLeadWithAccountData' ends here */  
}