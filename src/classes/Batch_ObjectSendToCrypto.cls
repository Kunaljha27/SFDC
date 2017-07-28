global class Batch_ObjectSendToCrypto implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts{

      public Batch_ObjectSendToCrypto (String aSObjectName) {
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
        system.debug('token '+token);
        if (test.isRunningtest()){
            system.debug('IFTEST!');
            DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests();
            mock.createTokenResponse();
            string test_token = HelperD.authorizationMasterIS();
            system.debug('testToken '+test_token);
            Test.setMock(HttpCalloutMock.class, mock);
            mock.createObjectResponse();    
            go = HelperD.getTypeMasterISObj(test_Token,SObjectName);
        }else{
            system.debug('SObjectName = ' + SObjectName);
            go = HelperD.getTypeMasterISObj(Token,SObjectName);   
        }
        system.debug('go '+go);
        String stringQuery = HelperD.returnQuerytoDB(go);
        system.debug(stringQuery);
        return Database.getQueryLocator(stringQuery);          
    }
    
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){ 
        try{    
            System.debug('go '+go); 
            system.debug('scope '+scope);
            String JSONEtoDFG = HelperD.JSONgenerateEntitySave(go,scope);
            String JSONEreq = HelperD.DataToCryptoSave(null, Token, JSONEtoDFG);
            system.debug('JSONEreq '+JSONEreq);
            system.debug('JSONEtoDFG '+JSONEtoDFG);
            HelperD.responsePD(JSONEreq, go);
        } catch(Exception ex) { HelperD.logError(ex, BC, scope, SObjectName, 'tokenization'); }
    } 
    
    global void finish(Database.BatchableContext BC){
        //  inform user?
    }    
//=============================================================================================================
}