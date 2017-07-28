global class AddSalesTeamSchedular implements Schedulable{
  public List<opportunity> listopp = new List<opportunity>();
  public List<opportunity> NewListopp = new List<opportunity>();
  Public Id thisUserId;
  Public User thisUser;
  Public string Action;
  
  global void execute(SchedulableContext SC) {
  
  /* Delay_AddSalesTeam ST = new Delay_AddSalesTeam();     
    if(Action == 'update'){
      ST.AddSalesTeam(listopp,NewListopp);
     
      }    
      
      
  if(Action == 'insert'){
    ST.AddSalesTeamNew(NewListopp);
    }
    Id cronTrigId2 = sc.getTriggerId();
    abortjob(cronTrigId2);
    
    
    
    */ 
    } 
      /* 
   @future
   global static void abortjob(id i){   
     System.abortJob(i);  
    }  */
  }