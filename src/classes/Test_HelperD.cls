@isTest
global class Test_HelperD {
  
  public static testmethod void test_other_methods(){  
      HelperD.Field ff = new HelperD.Field();
      HelperD.PersonalData pd = new HelperD.PersonalData();
      HelperD.Token tok = new HelperD.Token();

      TokenizationSettings__c ts = new TokenizationSettings__c();
      ts.Name = 'Param';
      ts.CheckToken__c = true;
      ts.isUserProperty__c = false;
      ts.FieldForLocalization__c = 'DFGLocal__c';
      ts.isLocalize__c = true;
      ts.SignLocalization__c = 'Ru';
      ts.NameForTransaction__c = 'DFGLocal__c';
      ts.NameForLocalization__c = 'FirstName,LastName';
      ts.FieldForLocalization__c = 'FirstName,LastName'; 
      ts.NameForLocalizationLead__c = 'FirstName,LastName';
      ts.FieldForLocalization__c = 'FirstName,LastName';
      insert ts; 
      DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests(); 

      Test.startTest();
      
      mock.createTokenResponse();
      Test.setMock(HttpCalloutMock.class, mock);
      string token = HelperD.authorizationMasterIS();
      system.debug('token '+token);
      String jsonType = HelperD.getTypeMasterIS(token);
      system.debug('jsonType '+jsonType);
      mock.createObjectResponse();
      HelperD.GenObject genObj = new HelperD.GenObject();
      system.debug('AAA!'+ (HelperD.getTypeMasterISObj(token, 'Contact')));
      genObj=HelperD.getTypeMasterISObj(token, 'Contact');

      system.debug(HelperD.returnQuerytoDB(HelperD.getTypeMasterISObj( token,'Contact')));
      HelperD.initLocalizationLabels('Lead', ts); 

      IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');                
      String endPoint = dfgIS.EndPoint__c;
      String username = dfgIs.Username__c;
      String password = dfgIs.Password__c; 
      String last1 = HelperD.JSONTypeTransform(null,username,password);
      
      List <Contact> contacts = [select Id, FirstName, LastName, Phone,Accountid from Contact];
      List <Lead> leads = [select Id, FirstName, LastName,Company from Lead];

      String accId = contacts[0].Accountid;
      String conId =  contacts[0].Id;
      String leadId =  leads[0].Id;

      String responseJSON;

      genObj.name = 'Lead';
      responseJSON = '[{"id":4175093,"externalId":"' + leadId + '","typeId":1200759,"data":[{"key":"t$1084825c08a349939765be571600e71g7lja$","value":"test","fieldId":1200762},{"key":"t$23ea7eea7adc47b780e9e90eda01361g7lja$","value":"test","fieldId":1200760}]}]';
      try{
            HelperD.responsePD(responseJSON,genObj);
      } catch (Exception ex) { system.debug('Exception expected: '  + ex); }

      genObj.name = 'Contact';
      responseJSON = '[{"id":4175093,"externalId":"' + conId + '","typeId":1200759,"data":[{"key":"t$1084825c08a349939765be571600e71g7lja$","value":"test","fieldId":1200762},{"key":"t$23ea7eea7adc47b780e9e90eda01361g7lja$","value":"test","fieldId":1200760}]}]';
      try{
            HelperD.responsePD(responseJSON,genObj);
      } catch (Exception ex) { system.debug('Exception expected: '  + ex); }

      genObj.name = 'Account'; 
      responseJSON = '[{"id":4175093,"externalId":"' + accId + '","typeId":1200759,"data":[{"key":"t$1084825c08a349939765be571600e71g7lja$","value":"test","fieldId":1200762},{"key":"t$23ea7eea7adc47b780e9e90eda01361g7lja$","value":"test","fieldId":1200760}]}]';
      try{
            HelperD.responsePD(responseJSON,genObj);
      } catch (Exception ex) { system.debug('Exception expected: '  + ex); }


      Test.stopTest();

  }

  public static testmethod void testBatchError(){
      Exception ex;
      try{
            Account acc = new Account();
            insert acc;
      } catch (Exception accEx){
            ex = accEx;
      }
      List <Contact> contacts = [select Id, FirstName, LastName, Phone,Accountid from Contact];
      ex.setMessage('String message');
      HelperD.logError(ex, null, contacts, 'contact', 'tokenization');
  }

  public static testmethod void dotest(){

      DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests(); 

      Test.startTest();
      
      List <Contact> contacts = [select Id, FirstName, LastName, Phone,Accountid from Contact];
      List <Lead> leads = [select Id, FirstName, LastName,Company from Lead];

      mock.createTokenResponse();
      Test.setMock(HttpCalloutMock.class, mock);
      string token = HelperD.authorizationMasterIS();
      system.debug('token '+token);
      String jsonType = HelperD.getTypeMasterIS(token);
      system.debug('jsonType '+jsonType);
      mock.createObjectResponse();
      HelperD.GenObject genObj = new HelperD.GenObject();
      system.debug('AAA!'+ (HelperD.getTypeMasterISObj(token, 'Contact')));
      genObj=HelperD.getTypeMasterISObj(token, 'Contact');

      system.debug(HelperD.returnQuerytoDB(HelperD.getTypeMasterISObj( token,'Contact')));
      IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');                
      String endPoint = dfgIS.EndPoint__c;
      String username = dfgIs.Username__c;
      String password = dfgIs.Password__c;

      HelperD.getTypeObj( endPoint, token, 'Contact');
      String query = HelperD.returnQuerytoDBToken(genObj);
      String authorization = HelperD.authorization(endPoint, dfgIS.Username__c, dfgIS.password__c);

      HelperD.JSONgenerateEntitySave(genObj, contacts);
      String JSONString = HelperD.JSONgenerateGET( genObj, contacts);
      system.debug('JSON STRING '+JSONString);
      String returnedQuery = HelperD.returnQuerytoDBEasy(genObj);
      system.debug('returned Query '+returnedQuery);
      String last1 = HelperD.JSONTypeTransform(token,username,password);
      List <String> contactIds = new List <String>();
      contactIds.add(contacts[0].id);
      mock.createObjectResponse();
      HelperD.JSONgenerateCommit( Token,contacts[0], 'Contact','1338486');
      HelperD.JSONLeadToContact(leads[0].id, leads[0].id, contacts[0].id, last1);

      String jsonCom = '[{"externalId\\":"0032400000Dc6TD",  "criteria":{     "internalId":null,   "externalId":null,  "dataKeys":[       "т$eda5a46e5a314e748af26bb31a01244nweh1$"               ]               }}]  ' ;    
      String responseString = HelperD.DataToCryptoSave(endPoint, token,jsonCom);
      HelperD.responsePD(responseString, genObj);
      HelperD.getCheckCommit();
      HelperD.DataToCryptoCommit(EndPoint,Token, responseString);
      Set<Id> ObjSetId = new Set<Id> ();
      ObjSetId.add('0032000001sgPkZ');
      HelperD.convertArraysToString(ObjSetId);
      
      system.debug('responseString '+responseString);
      system.debug('token '+token);
      system.debug('EndPoint '+endpoint);
      system.debug('UserName '+username);
      system.debug('password '+password);
      system.assertequals (responseString, '[{"id":1200759,"code":"003","name":"Contact","domainId":1200740,"fields":[{"id":1200760,"name":"FirstName","tokenized":true},{"id":1200763,"name":"Phone","tokenized":true},{"id":1200762,"name":"LastName","tokenized":true}]}]');
      HelperD.sendDataToCrypto('upupupupu', token);
      mock.createTokenResponse();

      String typeJson = HelperD.getType(endPoint, token);

      HelperD.saveCommit(endpoint, null, password, 'Contact', contacts[0].Id, '1338486');
      HelperD.saveCommitAll(endpoint, null, password, 'Contact', new Set<Id>{contacts[0].Id}, new Map<Id,String>{contacts[0].Id => '1338486'});
      
      TokenizationSettings__c ts = new TokenizationSettings__c();
      ts.Name = 'Param';
      ts.CheckToken__c = true;
      ts.FieldForLocalization__c = 'DFGLocal__c';
      ts.isLocalize__c = true;
      ts.SignLocalization__c = 'Ru';
      ts.NameForTransaction__c = 'DFGLocal__c';
      insert ts; 
        
      Contact con2 = new Contact();
      con2.LastName= 'Contact 2';
      con2.FirstName = 'Contact 2';
      con2.put(ts.FieldForLocalization__c, 'ru');
      con2.phone =String.valueOf('7653455'); 
      con2.put(ts.NameForTransaction__c,'1338486');

      insert con2;
 
      HelperD.saveCommitNotTokn(endpoint, null, password, 'Contact', con2.Id, '1338486');
      HelperD.saveCommitNotToknAll(endpoint, null, password, 'Contact', new Set<Id>{con2.Id}, new Map<Id,String>{con2.Id => '1338486'});

      HelperD.transformStand(leads[0].id, leads[0].id, con2.Id, 'lead_to_contact');
      HelperD.transformStandAll(new Set<String> {leads[0].Id}, leads[0].id, new Map<String,String> {leads[0].id => leads[0].id},'lead_to_contact');

      HelperD.saveExtra(new List<String> {con2.Id},'Contact');

      Test.stopTest();    
  }


  @testSetup static void setup(){

      IntegrationSettingsMaster__c dfgIs =  new IntegrationSettingsMaster__c();  
      dfgIs.Name = 'Param';
      dfgIs.EndPoint__c='https://app.dfg152.ru:7084/dfg-test';
      dfgIs.UserName__c ='user';
      dfgIS.Password__c='user';   
      insert dfgIs;

      TokenizationSettings__c ts = new TokenizationSettings__c();
      ts.Name = 'Param';
      ts.CheckToken__c = true;
      ts.FieldForLocalization__c = 'DFGLocal__c';
      ts.isLocalize__c = true;
      ts.SignLocalization__c = 'Ru';
      ts.NameForTransaction__c = 'DFGLocal__c';
      insert ts; 


      Account acc = new Account();
      acc.Name = 's$TestAcc$';
      insert acc;

      Contact con1 = new Contact();
      con1.LastName= 'п$2707b887565a41feb15ac4b444010e1qs7r5$';
      con1.FirstName = 'п$2707b887565a41feb15ac4b444010e1qs7r5$';
      con1.phone =String.valueOf('п$2707b887565a41feb15ac4b444010e1qs7r5$');
      con1.Accountid=acc.id;
      con1.put(ts.NameForTransaction__c,'12345')  ;
      insert con1;
  
      List <Contact> cons = [Select Id, FirstName, LastName from Contact where id=:con1.id];
      
      system.assertequals(cons[0].FirstName,'п$2707b887565a41feb15ac4b444010e1qs7r5$');    
      system.assertequals(cons[0].LastName,'п$2707b887565a41feb15ac4b444010e1qs7r5$');      
      
      Lead lead1=new Lead();
      lead1.LastName = 'п$2707b887565a41feb15ac4b444010e1qs7r5$';
      lead1.FirstName = 'п$2707b887565a41feb15ac4b444010e1qs7r5$';
      lead1.Company = 'Company'; 
      insert lead1;
      update lead1;
 
  }

}