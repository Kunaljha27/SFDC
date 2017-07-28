public with sharing class GroupMultiselectController 
{  
    Public List<GroupMember> UserId;
    public String AccountAccess { get; set; }
    public String OpportunityAccess { get; set; }
    public String CaseAccess { get; set; }
    public List<Id> FinalId = New List<Id>(); // Stores UserId to insert in Accoun Team.
    public List<UserRole> userrole = New List<UserRole>();
    public List<ID> userroleID = New List<Id>();
    public List<user> Activeuser = New List<user>();
    public List<Id> GroupId = new List<ID>(); 
    public SelectOption[] selectedgroups { get; set; }
    public SelectOption[] allgroups { get; set; }    
    public String message { get; set; }
    public String AccId; // To Store the AccountId
    Public String CheId;
    public String substring;    
    public List<GroupMember> usersId = New List<GroupMember>();
    public set<Id> internalgroup = New Set<Id>();
    public PageReference pageRef;
    public List<Group> newlist = New List<Group>();
    Public List<AccountTeamMember> Atl = New List<AccountTeamMember>();
    public List<AccountShare> AccShare = New List<AccountShare>();
    public List<AccountShare> UpdateAccShare = New List<AccountShare>();
    public  Map<Id,String> rolenamemap = New Map<Id,String>();
   
    //  To disply the Account access level option in vf page.    
    public List<SelectOption> getAccessLevel() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new selectOption('Read','Read Only'));
        options.add(new selectOption('Edit','Read/Write'));      
        return options;
    }        
    // To disply the Opportunity access level option in vf page.         
    public List<SelectOption> getOpptyAccessLevel() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new selectOption('None','Private'));
        options.add(new selectOption('Read','Read Only'));
        options.add(new selectOption('Edit','Read/Write'));      
        return options;
    }       
    // Constructor to Display all the Public group in Picklist. 
    public GroupMultiselectController(ApexPages.StandardController controller) 
    {     
        // Store Account Id     
        AccId = ApexPages.currentPage().getParameters().get('Id') ; 
        pageRef  = new PageReference('/'+ AccId);
        selectedgroups = new List<SelectOption>();           
        // Query on group and quesueSobject to 
          
        //List<Group> groups = [SELECT Name,Id,email FROM group];

        //List<QueueSobject> Queue = [Select QueueId from QueueSobject limit 40];
        
        List<Group> groupsList = [SELECT Name,Id,email FROM group where id NOT IN (Select QueueId from QueueSobject)order by Name asc];
        allgroups = new List<SelectOption>();            
        // To filter queus from the Group query.    
       /* for (group gp : groups) 
        {
            integer i = 0;
            for(QueueSobject q : Queue)
            {             
                if(gp.id == q.QueueId)
                {                        
                    i = 1;                               
                }           
            } 
            if(i == 0)
            {
                newlist.add(gp);    //Contains Public Group list.     
            }      
        } */           
        //for(group g : newlist) 
        for(group g : groupsList)
        {    
            if(g.name !=null)
            {
                allgroups.add(new SelectOption(g.Id, g.name)); // Map group Id with name 
            }
        }
    }      
    // Method to add all the members in group in account taeam.  
    public pagereference addteam()
    {      
        // To display warning message if user will not select any group   
        if(selectedgroups.size() == 0 )
        {        
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning, 'Please Select atleast one Group')); 
            return NULL;
        }      
        else
        {
            for(SelectOption so : selectedgroups)
            {        
                CheId = so.getValue();
                if(CheId != NULL)
                {
                    GroupId.add(CheId);
                }
            }  
            // Query the Role from user       
            userrole  = [Select Id,Name from UserRole];  
            // Map UserId and Role.    
            for(UserRole us : userrole)
            {
                rolenamemap.put(us.Id,us.Name);
            }          
            UserId = [Select UserOrGroupId from GroupMember where GroupId =:GroupId]; 
            // Add all the users part of selected groups in FinalId list.  
            if(userID != NULL)
            {
                for(GroupMember g1 : UserId)
                {
                    string grouporuserId = g1.UserOrGroupId;
                    substring = grouporuserId.substring(0, 3);
                    if(substring == '005')
                    {
                        usersId.add(g1);
                        FinalId.add(g1.UserOrGroupId);
                    }   
                    // If there is any Internel group part of the group calls the method (internalgroup)         
                    if(substring == '00G')
                    {
                        internalgroup.add(g1.UserOrGroupId);               
                    }
                }
            } 
            // If there is any group in the selected group
  
   if(internalgroup.size() !=  0){
   
   // Calls the method which will insert the Records in Account team.
    
        internalgroups(internalgroup);
      }
  
   // To Filter only active users fromt the list to insert in account team.   
  
    if(FinalId != NUll){      
       Activeuser = [Select Id,UserRoleId from user where Id =:FinalId AND IsActive =: true];      
     }  
   
   // To insert all the users in to accoun team with Corresponding user Role. 
       
     if(Activeuser != NULL){   
      for(user u :  Activeuser){
          AccountTeamMember at = New AccountTeamMember(); 
          String rolename = rolenamemap.get(u.UserRoleId);

           if(rolename != NULL){
             rolename = rolename.abbreviate(40) ;
           }  
          at.AccountId = AccId;
          at.UserId = u.Id;
          if(rolename != NULL){
            at.TeamMemberRole = rolename;
          }                
         Atl.add(at);       
        }
      insert Atl; 
    }
     
    if(FinalId != NULL){
 
  // After inserting update the Access level of opportunity and account by updating the Account share object. 
    
     AccShare = [Select UserOrGroupId,Id from AccountShare  where AccountId =:AccId AND RowCause =: 'Team' AND UserOrGroupId =:FinalId ];
   
     for(AccountShare  ASh : AccShare ){
        ASh.AccountAccessLevel = AccountAccess;
        ASh.OpportunityAccessLevel = OpportunityAccess; 
        ASh.CaseAccessLevel = CaseAccess;
        UpdateAccShare.add(ASh);
       }      
      update UpdateAccShare;   
     }   
     Atl.Clear();
     FinalId.Clear();    
     return pageRef;
    }    
   } 
 
 // method to insert user's in finel id list to add all the users in account team. 
    
  public List<Id> internalgroups(Set<Id> GrId){
   
    set<Id> interId = New Set<Id>();
    List<GroupMember> Grpmem = New List<GroupMember>();
    List<Id> RelatdId= New List<Id>();
    List<User> UsRol = New List<User>();  
    List<Group> rolegrp = New List<Group>(); 
    List<Group> LirolGp = New List<Group>(); 
  
  // Query all the users from the internal group where roles is present.
  
    if(GrId != NULL){
      LirolGp = [SELECT Id,Name,RelatedId FROM Group WHERE Id =: GrId And RelatedId != NULL];
     }
  
  // Store the related Id in RelatdId list.
   
    for(Group Grprl : LirolGp){
       RelatdId.add(Grprl.RelatedId); 
     }
 
  // Select All the users with corresponding relatedId
   
   if(RelatdId != NULL){   
       UsRol = [Select Id from user where UserRoleId =:RelatdId];    
     }
  
  // Store user's having the role in Final Id list.
     
    for(user usro: UsRol ){
       FinalId.add(usro.Id);
     }
 
 // Take User or Group Id from the Outer group.       
  
    if(GrId != NULL){
      Grpmem = [Select UserOrGroupId from GroupMember where GroupId =: GrId];
     }

 // If the Interna group has one more internal group it will call the method again Recursively.
    
    if(Grpmem != NULL){
        for(GroupMember Ing1 : Grpmem ){
           string grouporuserId = Ing1.UserOrGroupId;
           substring = grouporuserId.substring(0, 3);
           if(substring == '005'){
             usersId.add(Ing1);
             FinalId.add(Ing1.UserOrGroupId);
             }  
           if(substring == '00G'){
            interId.add(Ing1.UserOrGroupId);                                     
           }
          }
         }
      if(interId.size() != 0){
     
     //Calss the Same method if the group contains another group or role.
      
        internalgroups(interId);
      }
     return FinalId;    
    }           
   }