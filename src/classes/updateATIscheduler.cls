global class updateATIscheduler implements Schedulable {


global void execute(SchedulableContext SC) {
    
    BatchUpdate_AccountTeamImage BATI = new BatchUpdate_AccountTeamImage();
    Id batchprocessid = Database.executeBatch(BATI);
      //Id cronTrigId2 = sc.getTriggerId();
     if(!Test.isRunningTest()){
    
    // System.abortJob(cronTrigId2);
     }
    
    /*AsyncApexJob aaj = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors 
                        FROM AsyncApexJob WHERE ID =: batchprocessid ];
     system.debug('ppppppppppp'+aaj.Status);                */   
    List<Account_Team_Image__c> lstATImage = new List<Account_Team_Image__c>();
    Datetime dt = System.now();
      dt = dt.addDays(-1);
      //dt = dt.addMinutes(-5);
        List<AccountTeamMember> lstaccteammember = [Select User.Email, Id, AccountId 
                                                    From AccountTeamMember 
                                                    where CreatedDate >= :dt];
                                                    
    for(AccountTeamMember at : lstaccteammember){
         
          Account_Team_Image__c ati = new Account_Team_Image__c();
          ati.Account_ID__c = at.AccountId;
          ati.Email__c = at.User.Email;
          ati.ID__c = at.Id;
          lstATImage.add(ati);          
      }
      database.insert(lstATImage,false);
      //insert lstATImage;
      
    
    }
  
    

}