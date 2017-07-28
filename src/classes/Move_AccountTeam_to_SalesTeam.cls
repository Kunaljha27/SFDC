/*
Name  Move_AccountTeam_to_SalesTeam
Created by : Yunus
Description : Add account team members to the sales team object. 
*/

Global class Move_AccountTeam_to_SalesTeam{
    WebService static String Move_ATM(Id Opp_Id){
        Opportunity Opp_Account_id = [select Accountid from Opportunity where id =: Opp_Id];
        List<Account_Team_Member__c> Check_ATM = [select Account__c,Opportunity_Access__c,Team_Role__c,User__c,User__r.isactive from Account_Team_Member__c where Account__c =: Opp_Account_id.Accountid];        
        List<Sales_Team__c> Check_OTM = [Select Opportunity__c,User__c, Opportunity_Access__c from Sales_team__c where Opportunity__c =: Opp_Id];            
        List<Sales_Team__c> Insert_OTM = new List<Sales_Team__c>();        
        list<Id>Acc_Team_user_list = new list<Id>();
        map<Id,Account_Team_Member__c>map_acc_team = new map<Id,Account_Team_Member__c>();
        list<user> Active_User = new List<User>();
        set<Id>Opp_team_list = new set<Id>();        
        system.debug('#########atm#########'+Check_ATM);          
        system.debug('##########atm#########'+Check_OTM);
    
            if(Check_ATM.size()>0){                
                    for(Account_Team_Member__c AccTeamMem : Check_ATM){
                        Sales_Team__c OppTM = new Sales_Team__c();
                        if(Check_OTM ==null || (Check_OTM!=null && Check_OTM.size()==0)){
                           // if no users are present
                           if(AccTeamMem.User__r.isactive ==true){
                           OppTM.Opportunity__c = Opp_id;
                           OppTM.User__c = AccTeamMem.User__c;
                           OppTM.Opportunity_Access__c = AccTeamMem.Opportunity_Access__c;
                           OppTM.Team_Role__c = AccTeamMem.Team_Role__c;
                           Insert_OTM.add(OppTM);
                           }
                        }
                        Acc_Team_user_list.add(AccTeamMem.User__c);
                        map_acc_team.put(AccTeamMem.User__c,AccTeamMem);  
                   }    
            
                if(Check_OTM!=null && Check_OTM.size()>0){
                    for(Sales_Team__c existing_rec :Check_OTM){
                        Opp_team_list.add(existing_rec.User__c);
                    }
               
                    for(Account_Team_Member__c AccTeamMember : Check_ATM){
                        if(!(Opp_team_list.contains(AccTeamMember.User__c))){
                               
                               Sales_Team__c OppTM = new Sales_Team__c();
                              if(AccTeamMember.User__r.isactive ==true){
                               OppTM.Opportunity__c = Opp_id;
                               OppTM.User__c = AccTeamMember.User__c;
                               OppTM.Opportunity_Access__c = AccTeamMember.Opportunity_Access__c;
                               OppTM.Team_Role__c = AccTeamMember.Team_Role__c;
                               Insert_OTM.add(OppTM);             
                             }
                        }                    
                    }               
                }                                                              
                if(Insert_OTM!=null){    
                    system.debug('atm'+Insert_OTM);
                    insert Insert_OTM;
                }
                return 'true';
           }else{
               return 'false';
           }              
       }                  
}