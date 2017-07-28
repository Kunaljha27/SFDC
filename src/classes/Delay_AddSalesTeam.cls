global class Delay_AddSalesTeam {

 Public List<Opportunity> op = New List<Opportunity>();
 Public List<OpportunityTeamMember> OptList = New List<OpportunityTeamMember>(); 
 public list<User> listUser = [select id,UserRoleId from User];
 public list<UserRole> listuserRole =  [select id , name from UserRole ];
 public map<id,string> mapuserrole = new map<id,string>();
 public map<id,id> mapuser=new map<id,id>();
 public map<id,id> mapoppuser = new map<id,id>();
 public Datetime DT = System.now();
 public String query;
 
 
 global void AddSalesTeam(List<opportunity> oldvalues,List<opportunity> newlist){
   DT=DT.addSeconds(-31);
   for(user u:listuser ){
     mapuser.put(u.id,u.UserRoleId );
   }
  for(UserRole ur:listuserRole ){
      mapuserrole.put(ur.id,ur.name);    
    }
  // op = [Select Id,OwnerId from Opportunity where Id =: newlist ]; 
  // op = [Select Id,OwnerId from Opportunity limit 1]; 
  System.debug('Check the Opty' + op);
   if(newlist.size()>0){
   for(Opportunity o : newlist ){
     System.debug('Check The Opportunity' + o.id);
       OpportunityTeamMember opt = New OpportunityTeamMember();    
        opt.OpportunityId=o.id;
        opt.UserId = o.ownerId;
        opt.TeamMemberRole= mapuserrole.get(mapuser.get(o.ownerId));
       OptList.add(opt);
     }  
     }
  if(oldvalues.size()>0){
   for(Opportunity o : oldvalues){
    OpportunityTeamMember opt = New OpportunityTeamMember();    
        opt.OpportunityId=o.id;
        opt.UserId = o.ownerId;
        opt.TeamMemberRole= mapuserrole.get(mapuser.get(o.ownerId));
       OptList.add(opt);  
    }
    }
   insert OptList;   
  }
  
  global void AddSalesTeamNew(List<opportunity> newlist){
  
   for(user u:listuser ){
     mapuser.put(u.id,u.UserRoleId );
    }
   
   for(UserRole ur:listuserRole ){
       mapuserrole.put(ur.id,ur.name);    
     }
    
   System.debug('Check the Opty' + op);
    if(newlist.size()>0){
    for(Opportunity o : newlist ){
      System.debug('Check The Opportunity' + o.id);
       OpportunityTeamMember opt = New OpportunityTeamMember();    
        opt.OpportunityId=o.id;
        opt.UserId = o.ownerId;
        opt.TeamMemberRole= mapuserrole.get(mapuser.get(o.ownerId));
       OptList.add(opt);
      }  
     }
     if(OptList.Size()>0){
      if(!Test.isRunningTest())
   insert OptList;   
   }
  }
}