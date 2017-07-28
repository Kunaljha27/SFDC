global class BatchUpdate_AccountTeamImage implements Database.Batchable<sObject> {
   public String query;

   
   global Database.QueryLocator start(Database.BatchableContext BC){

       query = 'Select Account_ID__c, Email__c, ID__c From Account_Team_Image__c';
       system.debug('ppppppp'+query);
       return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
      system.debug('llllllll1');
      Set<id> setid = new Set<id>();
      List<Account_Team_Image__c> lstai = (List<Account_Team_Image__c>)scope;
      for(Account_Team_Image__c a : lstai){
          setid.add(a.ID__c);
      }
      
      Map<id, AccountTeamMember> mapaccteam = new Map<id, AccountTeamMember>([Select Id, User.Email, AccountId 
                                                                               From AccountTeamMember 
                                                                               where id in:setid]);
      List<Delete_Account_Team__c> lstdelat = new List<Delete_Account_Team__c>();   
      List<Account_Team_Image__c> lstdeleteAccit = new List<Account_Team_Image__c>();                                                                     
      for(Account_Team_Image__c ai : lstai){
          if(mapaccteam.get(ai.ID__c) == null){
              Delete_Account_Team__c d = new Delete_Account_Team__c();
              d.Record_ID__c = ai.ID__c;
              d.Email__c = ai.Email__c;
              d.Account__c = ai.Account_ID__c;
              lstdelat.add(d);
              
              Account_Team_Image__c at = new Account_Team_Image__c();
              at.id = ai.id;
              lstdeleteAccit.add(at);
          }
      } 
      if(lstdelat.size()>0)
     database.insert(lstdelat,false);
     //insert lstdelat;  
      
      if(lstdeleteAccit.size()>0)
      delete lstdeleteAccit;                                                                            
      lstdelat.clear();  
      lstdeleteAccit.clear();  
    
   }

   global void finish(Database.BatchableContext BC){
        
    
  
       
   }
}