/***** Purpose : This trigger works while we update owner
                 of opportunity through Mass Update functionality
****/

global class BatchUpdateOpportunityOwner implements Database.Batchable<sObject> {
   public String query;
 
   global Database.QueryLocator start(Database.BatchableContext BC){
   
   query = 'SELECT OwnerId, Id, Owner_email__c, Owner.Email, recordtypeID FROM Opportunity';
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
        
       List<Opportunity> listopp = (List<Opportunity>)scope;
       Set<Id> setUsers = new Set<Id>();
       Map<Id, String> mapUseridEmail = new Map<Id, String>();
       List<opportunity> lstupdateOpp = new List<opportunity>();
       Set<ID> m2oOpportunityID = new Set<ID>();
       for(M2O_Opportunity_RecordTypeID__c getID:[select Opportunity_RecordTypeID__c from M2O_Opportunity_RecordTypeID__c])
       {
           m2oOpportunityID.add(getID.Opportunity_RecordTypeID__c);
       } 
       for(Opportunity opp : listopp){
       //system.debug('PPPPPPPPPPPPPPPPPPPPP'+opp.Owner.Email);
           setUsers.add(opp.ownerId);
          
           if(!m2oOpportunityID.contains(opp.recordtypeID))
               if(opp.owner.Email != opp.Owner_email__c ){
                   Opportunity opi = new Opportunity();
                   opi.id = opp.id;
                   opi.Owner_email__c = opp.owner.Email;
                   lstupdateOpp.add(opi);
           
               }           
       }        
       if(lstupdateOpp.size()>0)
           update lstupdateOpp;
      
   }

   global void finish(Database.BatchableContext BC){
        Datetime sysTime = System.now();
        sysTime = sysTime.addMinutes(15);
        String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        scheduleUpdateOpprtunityOwner scheduleDelete = new scheduleUpdateOpprtunityOwner();
        
        System.schedule('GSSNA schedule opportunity field', chron_exp, scheduleDelete);
   }
}