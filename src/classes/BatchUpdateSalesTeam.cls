/***** Purpose : This trigger works while we update owner
                 of opportunity through Mass Update functionality
****/

global class BatchUpdateSalesTeam implements Database.Batchable<sObject> {
   public String query;
 
   global Database.QueryLocator start(Database.BatchableContext BC){
   Datetime d = datetime.now();
   d = d.addMinutes(-6);
  
    String formatedDt = d.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');   
     System.debug('Check the Time Stamp' + d);
      System.debug('Check the Time Stamp formated' + formatedDt);
      //System.debug('Check the Time Stamp formated ' + 'd.format('yyyy-MM-dd')+'T'+ d.format('HH:mm')+':00.000Z'' );
      //query = 'SELECT  Id,userId  FROM OpportunityTeamMember where CreatedDate > = '+ formatedDt ;
      System.debug('--------beforequery--------'+query );
      query = 'SELECT  Id,userId  FROM OpportunityTeamMember where CreatedDate > = '+ formatedDt + 'AND Sent_to_siebel__c = FALSE' ;
      System.debug('--------afterquery--------'+query );
      //query = 'SELECT  Id,userId' + 'FROM OpportunityTeamMember' + 'where CreatedDate >=\'' + formatedDt + '\'' + 'AND Sent_to_siebel__c = FALSE' ;
     // query = 'SELECT  Id,userId  FROM OpportunityTeamMember where CreatedDate > '+ d.format('yyyy-MM-dd')+'T'+ d.format('HH:mm')+':00.000Z' + 'AND Sent_to_siebel__c = FALSE' ;
      //query = 'SELECT  Id,userId  FROM OpportunityTeamMember where Sent_to_siebel__c = FALSE';
    //  query = 'SELECT  Id,userId  FROM OpportunityTeamMember where CreatedDate > '+ d.format('yyyy-MM-dd')+'T'+ d.format('HH:mm')+':00.000Z' ;
     
      return Database.getQueryLocator(query);
    }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
        
       List<OpportunityTeamMember> listopp = (List<OpportunityTeamMember>)scope;
       System.debug('----------listopp-----------'+listopp);
       List<OpportunityTeamMember> RecodsToUpdate = New List<OpportunityTeamMember>();
       List<User> UserList = [Select id,QuotingSystem__c from user];
       System.debug('----------UserList-----------'+UserList);
       Map<Id,String> mapUserQutingSys = New Map<Id,String>();
       for(user u: UserList){
           mapUserQutingSys.put(u.Id,u.QuotingSystem__c);
        }
        System.debug('----------mapUserQutingSys-----------'+mapUserQutingSys);
        System.debug('Check the Time Stamp' + System.Now());
       for(OpportunityTeamMember Opteam: listopp){
          Opteam.Quoting_System__c = mapUserQutingSys.get(Opteam.UserId);
          //Opteam.Sent_to_siebel__c = TRUE;
          RecodsToUpdate.add(Opteam);
        }
      System.debug('----------RecodsToUpdate-----------'+RecodsToUpdate);
      Update RecodsToUpdate;  
      System.debug('Check the Picked List'+RecodsToUpdate); 
      System.debug('Check the Picked List Size'+RecodsToUpdate.Size());
    }
     
   global void finish(Database.BatchableContext BC){
   
        system.debug('Checking For Stop Issue');
        scheduleUpdateSalesTeam schedulerClassVar = new scheduleUpdateSalesTeam();

        Datetime sysTime = System.now();
        Datetime sysTime1 = sysTime.addMinutes(5);

       String sec = String.valueOf(sysTime1.second());
       String min = String.valueOf(sysTime1.minute());
       String hour = String.valueOf(sysTime1.hour());
       
       String mon = String.valueOf(sysTime1.month());
       String day = String.valueOf(sysTime1.day());
       String year = String.valueOf(sysTime1.year());
       
       String chron_exp  = String.valueOf(sec) + ' ' + String.valueOf(min) + ' ' + String.valueOf(hour) + ' '+day+' '+mon+' ? '+ year;

        //String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        //scheduleUpdateSalesTeam  scheduleDelete = new scheduleUpdateSalesTeam();
        
      System.schedule('GSSNA schedule opportunity Team Update', chron_exp, schedulerClassVar );
   }
}