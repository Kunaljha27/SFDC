/*
Name : Default_Sales_Team
Button : Default Account Team
Description: Adds the team owned by a user. The Owner is same as that of the Account Owner.
*/
Global class Default_Sales_Team{
/*
        WebService Static String DefaultTeam(id Record_OwnerId,id OpportunityId){
        
            List<UserTeamMember> DefaultSalesTeam = new List<UserTeamMember>(); 
            List<Sales_Team__c> Default_OTM_list = new list<Sales_Team__c>(); 
            
            sales_Team__c SalesTeam;
            // fetch the default team defined by the Owner
            DefaultSalesTeam = [Select UserId,TeamMemberRole,OpportunityAccessLevel from UserTeamMember where OwnerId =: Record_OwnerId ];      
            Try{
                if(DefaultSalesTeam != null && DefaultSalesTeam.size()>0){
                    for(UserTeamMember Default_STM : DefaultSalesTeam ){
                        SalesTeam = new Sales_Team__c();
                        SalesTeam.User__c = Default_STM.UserId;
                        SalesTeam.Team_Role__c = Default_STM.TeamMemberRole;
                        SalesTeam.Opportunity__c = OpportunityId;
                        if(Default_STM.OpportunityAccessLevel == 'Read'){
                           SalesTeam.Opportunity_Access__c = 'Read Only';                            
                        }
                        if(Default_STM.OpportunityAccessLevel == 'Edit'){
                           SalesTeam.Opportunity_Access__c = 'Read/Write';                            
                        }
                        Default_OTM_list.add(SalesTeam);                        
                    }
                    If(Default_OTM_list!=null && Default_OTM_list.size()>0){
                    insert Default_OTM_list;
                    }
                    return 'true';
                }else{
                return 'false';
                }
            }catch(Exception e){
            return 'false';
            }
       }*/
}