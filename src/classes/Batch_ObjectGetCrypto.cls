global class Batch_ObjectGetCrypto implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts{
     
      public Batch_ObjectGetCrypto (String aSObjectName) {
        SObjectName = aSObjectName;
      }
//--------------------------------------------------------------------------------
     public  HelperD.GenObject  go;                             // запись с инфо по настройкам полей шифрования
     public  String Token; 
     public  String SObjectName {get;set;}
     public  Boolean showErrors {get;set;} 

//--------------------------------------------------------------------------------
     
    global database.querylocator start(Database.BatchableContext BC){  
        Token = HelperD.authorizationMasterIS();
        system.debug('CGC 1'); 
        go = HelperD.getTypeMasterISObj(Token,SObjectName);
        system.debug('CGC 2');
        String stringQuery = HelperD.returnQuerytoDBToken(go);
        system.debug('CGC 3');
        system.debug(stringQuery);
        system.debug('CGC 4');
        return Database.getQueryLocator(stringQuery);    
    }
    
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){  
       try{ 
            system.debug('BC.id = ' + BC.getJobId());
            String JSONEtoDFG = HelperD.JSONgenerateGET(go,scope);
            String JSONEreq = HelperD.sendDataToCrypto(JSONEtoDFG, Token);
            HelperD.responsePDGET(JSONEreq, scope, go);
       
        } 
          catch(Exception ex) { 
            if (showErrors != null && showErrors){
                HelperD.logError(ex, BC, scope, SObjectName, 'detokenization');  
            } 
          }
    }
     

    global void finish(Database.BatchableContext BC){
        //  inform user?
    }  
    
   }