global class AutomatedSalesTeamCreationcls {

webservice static void AddsalesTeam(String Dept,String MedSer,id AccId,id OppId){
//List<Opportunity_Routing_Table__c> RoutingTable = New List<Opportunity_Routing_Table__c>();
SET<String> RoutingRole = New SET<String>();
String RotgRole;
String RoutingFunctionalrole;
SET<String> FunctionalRole = New SET<String>();
Map<Id,String> MapOppandRole = New Map<Id,String>();
Map<Id,String> MapOppandFuncRole = New Map<Id,String>();
List<AccountTeamMember> ATM = New List<AccountTeamMember>();
Map<Id,String> MapAcTRole = New Map<Id,String>();
List<OpportunityTeamMember> optmem = New List<OpportunityTeamMember>();
List<OpportunityTeamMember> NewListOptmem = New List<OpportunityTeamMember>();
//RoutingTable = [Select Routing_Active__c,Routing_Department__c,Routing_Functional_Role__c,Routing_Medical_Services__c,Routing_Roles__c from Opportunity_Routing_Table__c where Routing_Active__c =: true];
Map<String,String> MapRoleFuncRole = New Map<String,String>();
String NewOwner;
 List<User> Users = [Select Id,Name,IsActive  from user where IsActive = True];
  Map<Id,boolean> UserActive = New Map<Id,Boolean>();
 
 for(User u: Users){
     UserActive.put(u.id,u.IsActive);
   }

  /*for(Opportunity_Routing_Table__c OpRT : RoutingTable){     
   if(Dept == OpRT.Routing_Department__c && MedSer == OpRT.Routing_Medical_Services__c){    
      FunctionalRole.add(OpRT.Routing_Functional_Role__c);
      RoutingRole.add(OpRT.Routing_Roles__c);        
      RotgRole = OpRT.Routing_Roles__c;
      RoutingFunctionalrole = OpRt.Routing_Functional_Role__c;
      MapRoleFuncRole.put(OpRT.Routing_Roles__c,OpRT.Routing_Functional_Role__c);
      MapOppandFuncRole.put(OppId,OpRT.Routing_Functional_Role__c);
     }  
    }
 */
 ATM = [Select TeamMemberRole,UserId,AccountId from AccountTeamMember where AccountId =: AccId];
 
   for(AccountTeamMember at : ATM){
    String Atrole = at.TeamMemberRole;
     //if(Atrole.contains(RotgRole) && UserActive.get(at.UserId)==true){
      MapAcTRole.put(at.UserId,at.TeamMemberRole);
       OpportunityTeamMember opt = New OpportunityTeamMember();
       opt.OpportunityId = OppId;
       opt.UserId = at.UserId;
       opt.TeamMemberRole = MapAcTRole.get(at.UserId);
       //opt.Functional_Role__c = MapRoleFuncRole.get(MapAcTRole.get(at.UserId));
       opt.Functional_Role__c = RoutingFunctionalrole;
       optmem.add(opt);
      //}
     } 
     if(optmem.size()>0){
      insert  optmem;     
    }
  
NewListOptmem = [Select UserId,TeamMemberRole,Functional_Role__c  from OpportunityTeamMember where OpportunityId=: OppId];  
     
   for(OpportunityTeamMember opt : NewListOptmem){
     if(opt.Functional_Role__c == 'Primary'){      
       NewOwner = opt.UserId;      
      }     
     }
    if(NewOwner != NULL){
     Opportunity op = New Opportunity();
      op.Id = OppId;
      op.OwnerId = NewOwner;          
      update op;
      }
    }
  }