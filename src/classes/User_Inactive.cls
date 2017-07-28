/*
Name User_Inactive
Description : check the standard Account team member and Sales Team member and reflect the change in the custom Account Team Member and Sales Team Member
Created by : Yunus
*/

Global Class User_Inactive
{
    Public void Check_User_Status(){
/*
        // list for Inactive Users 
        List<User> In_Active_User = new List<User>();
        List<User> Active_User = new List<User>();
        List<User> UpdateUserActive = New List<User>();
        List<User> UpdateUserInActive = New List<User>();

        // id set
        set<Id> Active_UserId = new set<Id>();
        set<Id> InActive_UserId = new Set<Id>();   
                
        try{ 
            // inactive user set                       
            In_Active_User = [Select Id,AccountId,UserName, Previous_User_Status__c from User where IsActive =: False and LastModifiedDate = today and Previous_User_Status__c = true];           
            system.debug('#########In_Active_User########'+In_Active_User);
           //active user set
            Active_User  = [Select Id,accountid,userName, Previous_User_Status__c from User where IsActive =: True and LastModifiedDate = today and Previous_User_Status__c = true];
            system.debug('#########Active_User########'+Active_User);
                                                           
        }Catch(Exception e){
        }
        
               
       
//---------------------------------------------------------------------------------------------------------------------------------------------------------                       
        //Scenario if the user was made In-active without deleting the records in standard. And user is made active before the schedular works.            
        if(Active_User!= null && Active_User.size()>0){            
            try{
                //for update scenario                                
                //Map for the Standard Account Share And Custom Account Team
                Map<string,AccountShare>Account_ShareMap = New Map<string,AccountShare>();
                Map<String,OpportunityShare>Opportunity_ShareMap = New Map<String,OpportunityShare>();
                
                // Update set
                List<Account_Team_Member__c> Update_AccountTeam_Custom = new List<Account_Team_Member__c>();
                List<Sales_Team__c> Update_SalesTeam_Custom = new List<Sales_Team__c>();
                
                OpportunityShare TempOppShare;
                AccountShare TempShare ;
                string KeyCombination;                    
    
                //for delete scenario 
                //Standard and Custom Account Team Member
                //change
                for(User ActiveUser : Active_User){
                    Active_UserId.add(ActiveUser.id);
                }                                  
                
                for(User tempUser : Active_User){
                    tempUser.Previous_User_Status__c = false; 
                    UpdateUserActive.add(tempUser);                
                }
                                              
                for(Accountshare accshare : [Select id,Accountid, UserOrGroupId,OpportunityAccessLevel,CaseAccessLevel,AccountAccessLevel from AccountShare where UserOrGroupId in: Active_UserId] ){
                    KeyCombination = accshare.UserOrGroupId+''+accshare.Accountid;
                    Account_ShareMap.put(KeyCombination,accshare);                         
                }
                
                if(Account_ShareMap.size()>0){
                    for(Account_Team_Member__c AccountTeam_Custom : [Select id,Account__c, User__c, Team_Role__c,Account_Access__c,Case_Access__c,Opportunity_Access__c from Account_Team_Member__c where User__c in: Active_UserId]){
                        TempShare = new AccountShare();
                        KeyCombination = AccountTeam_Custom.User__c+''+AccountTeam_Custom.Account__c;
                        if(Account_ShareMap.ContainsKey(KeyCombination)){
                            
                            TempShare =  Account_ShareMap.get(KeyCombination);
                            
                            if( TempShare.AccountAccessLevel == 'Read')
                                AccountTeam_Custom.Account_Access__c = 'Read Only';
                            if(TempShare.AccountAccessLevel == 'Edit')     
                                AccountTeam_Custom.Account_Access__c = 'Read/Write';
                        
                            if(TempShare.OpportunityAccessLevel == 'Read')
                                AccountTeam_Custom.Opportunity_Access__c = 'Read Only';
                            if(TempShare.OpportunityAccessLevel == 'Edit')   
                                AccountTeam_Custom.Opportunity_Access__c = 'Read/Write'; 
                            if(TempShare.OpportunityAccessLevel == 'None')   
                                AccountTeam_Custom.Opportunity_Access__c = 'Private'; 
                                
                            if(TempShare.CaseAccessLevel== 'Read')
                                AccountTeam_Custom.Case_Access__c= 'Read Only';
                            if(TempShare.CaseAccessLevel== 'Edit')   
                                AccountTeam_Custom.Case_Access__c= 'Read/Write'; 
                            if(TempShare.CaseAccessLevel== 'None')   
                                AccountTeam_Custom.Case_Access__c= 'Private';  
                            Update_AccountTeam_Custom.add(AccountTeam_Custom);
                        }
                    }
                }
                for(OpportunityShare OppShare_Closed : [select id ,UserOrGroupId,OpportunityAccessLevel,Opportunityid  from OpportunityShare where UserOrGroupId in: Active_UserId and Opportunity.IsClosed = True]){
                    KeyCombination = OppShare_Closed.UserOrGroupId+''+OppShare_Closed.Opportunityid;
                    Opportunity_ShareMap.put(KeyCombination,OppShare_Closed);
                }
                
                for(OpportunityShare OppShare : [select id ,UserOrGroupId,OpportunityAccessLevel,Opportunityid  from OpportunityShare where UserOrGroupId in: Active_UserId and Opportunity.IsClosed = False]){
                    KeyCombination = OppShare.UserOrGroupId+''+OppShare.Opportunityid;
                    Opportunity_ShareMap.put(KeyCombination,OppShare);
                }
                
                if(Opportunity_ShareMap.size()>0){                
                    for(Sales_Team__c OppTeam_Custom : [Select id, User__c, opportunity__c,Opportunity_Access__c from Sales_Team__c where User__c in: Active_UserId]){
                        TempOppShare = new OpportunityShare();
                        KeyCombination = OppTeam_Custom.User__c+''+OppTeam_Custom.opportunity__c;
                        if(Opportunity_ShareMap.containskey(KeyCombination)){
                            TempOppShare =  Opportunity_ShareMap.get(KeyCombination);
                            if(TempOppShare .OpportunityAccessLevel == 'Read' ){
                                OppTeam_Custom.Opportunity_Access__c = 'Read Only';
                            }
                            if(TempOppShare .OpportunityAccessLevel == 'Edit' ){
                                OppTeam_Custom.Opportunity_Access__c = 'Read/Write';
                            }
                            Update_SalesTeam_Custom.add(OppTeam_Custom);
                            
                        }
                    }
                }               
               
                if(Update_SalesTeam_Custom!=null && Update_SalesTeam_Custom.size()>0){
                    update Update_SalesTeam_Custom;
                }

                if(Update_AccountTeam_Custom!= null && Update_AccountTeam_Custom.size()>0){
                    update  Update_AccountTeam_Custom;   
                }
                if(UpdateUserActive.size()>0&&UpdateUserActive!= null){
                    Update UpdateUserActive;
                }
                

            }catch(Exception e){
             
            }                                   
        }
    
            
            
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// scenario to delete the custom Account Team member object records if the Standard object records are delete             
        if( In_Active_User != null && In_Active_User.size() > 0){
            Try{
                map<String,AccountTeamMember> Inactive_AccountTeamMember = new map<String,AccountTeamMember>();
                map<String,OpportunityTeamMember> Inactive_OpporunityTeamMember = new map<String,OpportunityTeamMember>();                
                List<Account_Team_Member__c> Delete_AccountTeam_Custom = new List<Account_Team_Member__c>();
                List<Sales_Team__c> Delete_SalesTeam_Custom = new List<Sales_Team__c>();  
                //Map key
                String KeyCombination;
                
                for(User InActiveUser : In_Active_User){
                    InActive_UserId.add(InActiveUser.id);
                }   
                
                for(User tempUser : In_Active_User){
                    tempUser.Previous_User_Status__c = false; 
                    UpdateUserInActive.add(tempUser);                
                }
                
                                
                for(AccountTeamMember accMember : [Select id,Accountid, Userid,AccountAccessLevel from AccountTeamMember where UserId in: In_Active_User] ){
                    KeyCombination = accMember.UserId+''+accMember.Accountid;
                    Inactive_AccountTeamMember.put(KeyCombination,accMember); 
                }
                
                if(Inactive_AccountTeamMember.size()== 0 ){
                   Delete_AccountTeam_Custom =  [Select id,Account__c, User__c, Team_Role__c,Account_Access__c,Case_Access__c,Opportunity_Access__c from Account_Team_Member__c where User__c in: In_Active_User];
                }
                if(Inactive_AccountTeamMember.size()>0){
                    for(Account_Team_Member__c AccountTeam_Custom : [Select id,Account__c, User__c, Team_Role__c,Account_Access__c,Case_Access__c,Opportunity_Access__c from Account_Team_Member__c where User__c in: In_Active_User]){
                        KeyCombination = AccountTeam_Custom.User__c+''+AccountTeam_Custom.Account__c;   
                        if(!Inactive_AccountTeamMember.containskey(KeyCombination)){                    
                            Delete_AccountTeam_Custom.add(AccountTeam_Custom);
                        }                                                
                    }       
                }      
                for(OpportunityTeamMember OppMember_Closed : [select id ,UserId,OpportunityAccessLevel,Opportunityid  from OpportunityTeamMember where UserId in: In_Active_User ]){
                    KeyCombination = OppMember_Closed.UserId+''+OppMember_Closed.Opportunityid  ;
                    Inactive_OpporunityTeamMember.put(KeyCombination,OppMember_Closed);
                }                
                if(Inactive_OpporunityTeamMember.size()== 0){                
                    Delete_SalesTeam_Custom = [Select id, User__c, opportunity__c,Opportunity_Access__c from Sales_Team__c where User__c in: In_Active_User];
                }
                if(Inactive_OpporunityTeamMember.size()>0){
                    for(Sales_Team__c OppTeam_Custom : [Select id, User__c, opportunity__c,Opportunity_Access__c from Sales_Team__c where User__c in: In_Active_User]){ 
                        KeyCombination = OppTeam_Custom.User__c+''+OppTeam_Custom.Opportunity__c;
                        if(!Inactive_OpporunityTeamMember.containsKey(KeyCombination)){
                            Delete_SalesTeam_Custom.add(OppTeam_Custom);
                        }                                                               
                    }            
                }
                if(Delete_SalesTeam_Custom!=null && Delete_SalesTeam_Custom.size()>0){
                    Delete  Delete_SalesTeam_Custom;   
                }
                if(Delete_AccountTeam_Custom!= null && Delete_AccountTeam_Custom.size()>0){
                   Delete  Delete_AccountTeam_Custom;
                }
                if(UpdateUserInActive.size()>0 && UpdateUserInActive!= null){
                update  UpdateUserInActive;
                }
            }Catch(Exception e){
            }         
        } */
    }    
}