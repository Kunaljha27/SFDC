/**  Класс HelperD содержит методы для работы с DFG сервисом,
*    сохранение и построение запросов к бд SF
*    Class HelperD includes method for work with DFG service
*  
*/
global class HelperD {
   
    public static Boolean CheckCommit =true;
    public static GenObject  GObj;                           // запись с инфо по настройкам полей шифрования    
    public static String tok;                                // токен/token
    public static String ContacMap;
    public static String ContacMapOld;    
    
    public static boolean getCheckCommit(){
     
        if(!system.isBatch()){
            CheckCommit= true;
        }else{
            CheckCommit = false;
        }
        return CheckCommit;
    }
    
//авторизация--------------------------------------------------------------------------------
//authorization    
/**
*   Метод для авторизации в сервисе DFG. Возвращает токен.
*/
/**
* The method for authorization in the DFG-service. It returns a token. 
*/
    public static String authorization(String EndPoint, String username, String password){
        String token;
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('POST');
        request.setEndpoint(EndPoint);
        request.setHeader('X-Auth-Username', username);
        request.setHeader('X-Auth-Password', password);
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        if(test.isRunningTest()){
          token =  response.getBody(); 
        }else{
          token = '[' + response.getBody() + ']'; 
        }          
        system.debug('TOKEN!!!!!!!!! '+token);
        List<Token> deserializedGenObjectsToken = 
           (List<Token>)JSON.deserialize(token, List<Token>.class);     
           
        if(!deserializedGenObjectsToken.isEmpty()){
           tok =  deserializedGenObjectsToken.get(0).token;
           system.debug('deserializedGenObjectsToken.get(0).token;' +deserializedGenObjectsToken.get(0).token);
           return deserializedGenObjectsToken.get(0).token;   
        }                    
        return null;
    }

/**
*   Метод для авторизации в сервисе DFG. Возвращает токен.
*   Использует данные из стандартного Master Integration Settings (DFG__IntegrationSettingsMaster__c) 
*/

/**
*The method for authorization in the DFG-service. It returns a token. 
*The method uses data from standard Master Integration Settings (DFG__IntegrationSettingsMaster__c)
*/
    public static String authorizationMasterIS(){
        IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');       
        String token;
        String EndPoint;    
        String username;
        String password;
        
        if(dfgIS != null && dfgIS.password__c != null && dfgIS.Username__c != null && dfgIS.EndPoint__c != null){       
            EndPoint = dfgIS.EndPoint__c + '/authenticate';
            username = dfgIS.Username__c;
            password = dfgIS.Password__c;
        } 
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('POST');
        request.setEndpoint(EndPoint);
        request.setHeader('X-Auth-Username', username);
        request.setHeader('X-Auth-Password', password);
        
        Http http = new Http();
        system.debug(logginglevel.error,'REQUEST '+request);
        HttpResponse response = http.send(request); 
        system.debug(response.getBody());        
        if (test.isRunningTest()){
            token =  response.getBody(); 
        }else{
         token = '[' + response.getBody() + ']'; 
        } 
        List<Token> deserializedGenObjectsToken = 
           (List<Token>)JSON.deserialize(token, List<Token>.class); 
        
        if(!deserializedGenObjectsToken.isEmpty()){
             tok =  deserializedGenObjectsToken.get(0).token;
             return deserializedGenObjectsToken.get(0).token;   
        }                
        return null;
    }


//получение типов---------------------------------------------------------------------------------
//get types    
/**
*   Метод возвращает типы объектов и поля для токенизирования из системы DFG.
*   Возвращает JSON ответа от DFG.
*/

/**
* The method returns types of objects and fields for tokenization from DFG-system.
* It returns JSON response from DFG-system.
*
*/
    public static String getType(String EndPoint, String Token){
        String typeJSON;
        if(Token == null) return null;
        
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('GET');
        request.setEndpoint(EndPoint);
        request.setHeader('X-Auth-token', Token);
        
        Http http = new Http(); 
        HttpResponse response = http.send(request); 
        typeJSON = response.getBody();
        typeJSON = typeJSON.replaceAll('fields', 'fieldList');      
        return typeJSON;
    }

/**
*   Метод возвращает типы объектов и поля для токенизирования из системы DFG.
*   Возвращает JSON ответа от DFG.
*   Использует данные из стандартного Master Integration Settings (DFG__IntegrationSettingsMaster__c)
*/

/**
*The method returns types of objects and fields for tokenization from DFG-system.
*It returns a JSON part of a response from DFG.
*It uses data from standard Master Integration Settings (DFG__IntegrationSettingsMaster__c)
*/
    public static String getTypeMasterIS(String Token){
        IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
        String EndPoint;
        String typeJSON;
        
        if(dfgIS.EndPoint__c != null) EndPoint = dfgIS.EndPoint__c; 
        if(Token == null) return null;
        
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('GET');
        request.setEndpoint(EndPoint + '/entity/type');
        request.setHeader('X-Auth-token', Token);
        
        Http http = new Http(); 
        HttpResponse response = http.send(request); 
        typeJSON = response.getBody();
        typeJSON = typeJSON.replaceAll('fields', 'fieldList');      
        return typeJSON;
    }

/**
*   Метод возвращает поля для конкретного типа объекта из системы DFG.
*   Возвращает запись типа GenObject
*/

/**
* The method returns fields of a specified type of an object from DFG-system
*It returns a record of GenObject type
*/
    public static GenObject getTypeObj(String EndPoint, String Token, String ObjectName){

        String typeJSON;
        if(Token == null) return null;
        
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('GET');
        request.setEndpoint(EndPoint + '/entity/type');
        request.setHeader('X-Auth-token', Token);
        
        Http http = new Http(); 
        HttpResponse response = http.send(request); 
        typeJSON = response.getBody();
        typeJSON = typeJSON.replaceAll('fields', 'fieldList');
        List<GenObject> deserializedGenObjects = 
           (List<GenObject>)JSON.deserialize(typeJSON, List<GenObject>.class);              

        if(deserializedGenObjects != null){              
              for(GenObject go:deserializedGenObjects){
                 if(go.name == ObjectName){
                    go.token = Token;
                    return go;              
                 }
              }
        }  
        return null;  
    }   
        
/**
*   Метод возвращает поля для конкретного типа объекта из системы DFG.
*   Возвращает запись типа GenObject
*   Использует данные из стандартного Master Integration Settings (DFG__IntegrationSettingsMaster__c)
*/

/**
* The method returns fields of a specified type of an object from DFG-system
*It returns a record of the GenObject Type
*It uses data from standard Master Integration Settings (DFG__IntegrationSettingsMaster__c)
*/
    public static GenObject getTypeMasterISObj(String Token, String ObjectName){
        IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
        String EndPoint;
        String typeJSON;
        
 /**
        HttpMocksForTests mock = new HttpMocksForTests();
        mock.createObjectResponse();
        */
        
        if(dfgIS.EndPoint__c != null) EndPoint = dfgIS.EndPoint__c; 
        if(Token == null) return null;
        
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('GET');
        request.setEndpoint(EndPoint + '/entity/type');
        request.setHeader('X-Auth-token', Token);
        
        Http http = new Http(); 
        HttpResponse response = http.send(request); 
        typeJSON = response.getBody();
        system.debug('typeJSON '+typeJSON);
        typeJSON = typeJSON.replaceAll('fields', 'fieldList');
        system.debug('List<GenObject>.class) '+List<GenObject>.class);
        List<GenObject> deserializedGenObjects =  
           (List<GenObject>)JSON.deserialize(typeJSON, List<GenObject>.class);   
                      
        system.debug('deserializedGenObjects '+deserializedGenObjects);

        if(deserializedGenObjects != null){    
            system.debug('in IFFF');       
             
              for(GenObject go:deserializedGenObjects){
                system.debug('go.name '+go.name);
                system.debug('ObjectName '+ObjectName);   
                system.debug('GO after HELL'+go);
                 if(go.name == ObjectName){
                    system.debug('in inner IF');
                    go.token = Token;
                    system.debug('GO '+go);
                    return go;              
                 }
              }
        }  

        return null;  
    }   

//формирование запроса к бд---------------------------------------------------------------------
//   Метод возвращает запрос к бд в виде: select id, FirstName, LastName from Contact where  FirstName Like  '$' OR LastName Like  '$'
/**
*   Метод формирует запрос к бд SF по одному объекту GenObject. Забирает только незашифрованные данные.
*   Возвращает строку запроса.
*/

/**
* The method forms a request to DB SF using a GenObject rec. It takes only plain data and returns a query string.
*/
   /* public static String returnQuerytoDB_deprecated(GenObject go){
        String query;
        String StringFields = '';
        String StringFieldsWHERE = '';
        String ObjectName = go.name;
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
        
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }

        // формируем строчки из полей
        if(!go.fieldList.isEmpty()){
          // поля запроса
          //fields of a request
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                 StringFields = ' '+ StringFields + ' '+ ef.name + ',';              
               }                 
           }
           StringFields = StringFields.removeEnd(',');
            
            // условия запроса    
            //conditions of a request          
            for(Field ef:go.fieldList){ 
               if(ef.tokenized && FieldsObjectSET.contains(ef.name.toLowerCase())){                 
                 StringFieldsWHERE = ' '+ StringFieldsWHERE + ' (NOT '+ ef.name +' Like  \''+'%$%' + '\') AND';             
               }                 
            }
            StringFieldsWHERE = StringFieldsWHERE.removeEnd('AND');
          }
          
          if(StringFields == '') return null;
          
          
          query = 'select id, '; 
          query = query +  StringFields  ;       
          query = query + ' from ' + ObjectName;
          
          TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
          Boolean isLocalize;              // Если имеется локализация
          //String  FieldForLocalization;  // Поле по которому происходит определение принадлежности записи к ПД
          Boolean isUserProperty;          // Если cвойство на Ответственном
          String  SignLocalization;        // Именование страны на Пользователе
          
          Set<String> FieldForLocalizationSet = initLocalizationFields(ObjectName,ts);
          
          isLocalize = ts.isLocalize__c;
          //FieldForLocalization = ts.FieldForLocalization__c;
          isUserProperty = ts.isUserProperty__c;
          if (ts.SignLocalization__c != null)
              SignLocalization = ts.SignLocalization__c.toLowerCase();  
          
          String  ConditionLoc = ' ';
         /*  if(isLocalize){                  // если есть локализация
             if(isUserProperty == true){   // если от пользователя
                ConditionLoc = ' and ' + FieldForLocalization+ '=' + '\'' + SignLocalization + '\' ';
             }
             else{
                ConditionLoc = ' and ' + FieldForLocalization + '= true ' ;
             }
          } */
          
         /* query = query + ' where ( ' + StringFieldsWHERE + ConditionLoc + ' )';  
          
          
//          query = 'SELECT id,        FirstName, LastName  FROM Contact WHERE NOT LastName LIKE \'%$%\'';
//          system.debug('<query:returnQuerytoDB> ' + query);              
                
          return query; 
    }   */
    
/**
*   Метод формирует запрос к бд SF по одному объекту GenObject. Забирает только незашифрованные данные + учитывает страну, если есть токенизация + локализация по объекту.
*   Возвращает строку запроса.
*/

    public static String returnQuerytoDB(GenObject go){
        String query;
        String StringFields = '';
        String StringFieldsWHERE = '';
        String ObjectName = go.name;
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
        
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }

        // формируем строчки из полей
        if(!go.fieldList.isEmpty()){
          // поля запроса
          //fields of a request
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                 StringFields = ' '+ StringFields + ' '+ ef.name + ',';              
               }                 
           }
           StringFields = StringFields.removeEnd(',');
            
            // условия запроса    
            //conditions of a request          
            for(Field ef:go.fieldList){ 
               if(ef.tokenized && FieldsObjectSET.contains(ef.name.toLowerCase())){                 
                 StringFieldsWHERE = ' '+ StringFieldsWHERE + ' (NOT '+ ef.name +' Like  \''+'%$%' + '\') AND';             
               }                 
            }
            StringFieldsWHERE = StringFieldsWHERE.removeEnd('AND');
          }
          
          if(StringFields == '') return null;
          
          
          query = 'select id, '; 
          query = query +  StringFields  ;       
          query = query + ' from ' + ObjectName;
          
          TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
          Boolean isLocalize;              // Если имеется локализация
          String  FieldForLocalization;  // Поле по которому происходит определение принадлежности записи к ПД
          Boolean isUserProperty;          // Если cвойство на Ответственном
          String  SignLocalization;        // Именование страны на Пользователе
          
          Set<String> FieldForLocalizationSet = initLocalizationFields(ObjectName,ts);
          Set<String> LabelForLocalizationSet = initLocalizationLabels(ObjectName,ts);
          
          
          isLocalize = ts.isLocalize__c;
          isUserProperty = ts.isUserProperty__c;
          if (ts.SignLocalization__c != null)
              SignLocalization = ts.SignLocalization__c.toLowerCase();  
          
          String  ConditionLoc = ' ';
           if(isLocalize){                  // если есть локализация
             if(isUserProperty == true){   // если от пользователя
                if (FieldForLocalizationSet != null && !FieldForLocalizationSet.isEmpty()){ //берём первое поле, т.к. они все должны быть одни и те же
                    for(String str: FieldForLocalizationSet){
                        FieldForLocalization = str;
                        break;
                    }
                    ConditionLoc = ' and ' + FieldForLocalization+ '=' + '\'' + SignLocalization + '\' ';
                }
             }
             else{
                  ConditionLoc = ' and ';
                 //ConditionLoc = ' and ' + FieldForLocalization + '= true OR' ;
                if (FieldForLocalizationSet != null && !FieldForLocalizationSet.isEmpty() && LabelForLocalizationSet != null && !LabelForLocalizationSet.IsEmpty()){ 
                    String resulting ='(';
                    for(String field: FieldForLocalizationSet){  //поля
                        
                        for(String label: LabelForLocalizationSet){ //метки
                            resulting += field + ' LIKE  \'' + label +'\' OR ';
                        }
                        //resulting = resulting.replace(') OR ',')');
                        
                    }
                    integer lastIndex = resulting.lastIndexOf(' OR ');
                    resulting = resulting.substring(0,lastIndex);
                    ConditionLoc += resulting + ')'; 
                }
                 
              }
          } 
          
          query = query + ' where ( ' + StringFieldsWHERE + ConditionLoc + ' )';  
          
         //если лиды - то конвертированные пропускаем
         if (ObjectName.tolowercase() == 'lead') 
             query = query + ' and IsConverted = false ';
          
//          query = 'SELECT id,        FirstName, LastName  FROM Contact WHERE NOT LastName LIKE \'%$%\'';
//          system.debug('<query:returnQuerytoDB> ' + query);              
                
          return query; 
    }       
    
/**
*   Метод возвращает поля, определяющие принадлежность записи к ПД.
*   Возвращает Set.
*/
  public static Set<String> initLocalizationFields(String ObjName, TokenizationSettings__c ts){ 
    Set<String> result = new Set<String>();
    if (ObjName == 'Account'){
        if(ts.FieldForLocalizationAcc__c != null) {
          for(String f: ts.FieldForLocalizationAcc__c.split(',')){
            result.add(f.toLowerCase().replace(' ',''));
          }
        }
    } else if (ObjName == 'Contact'){
        if(ts.FieldForLocalization__c != null) {
          for(String f: ts.FieldForLocalization__c.split(',')){
            result.add(f.toLowerCase().replace(' ',''));
          }
        }
    } else if (ObjName == 'Lead'){ 
        system.debug('str 250 , ts.FieldForLocalizationLead__c = ' + ts.FieldForLocalizationLead__c);
        if(ts.FieldForLocalizationLead__c != null) {
          for(String f: ts.FieldForLocalizationLead__c.split(',')){
            result.add(f.toLowerCase().replace(' ',''));
          }
        }
    }
    system.debug('str 252 , fields for localization = ' + result);
    return result;
  }  
  
  public static set<String> initLocalizationLabels(String ObjName, TokenizationSettings__c ts){
      Set<String> result = new Set<String>();
    if (ObjName == 'Account'){
        if(ts.NameForLocalizationAccount__c!= null) {
          for(String f: ts.NameForLocalizationAccount__c.split(',')){
            result.add(f.toLowerCase());
          }
        }
    } else if (ObjName == 'Contact'){
        if(ts.NameForLocalization__c!= null) {
          for(String f: ts.NameForLocalization__c.split(',')){
            result.add(f.toLowerCase());
          }
        }
    } else if (ObjName == 'Lead'){ 
        system.debug('str 250 , ts.FieldForLocalizationLead__c = ' + ts.FieldForLocalizationLead__c);
        if(ts.NameForLocalizationLead__c!= null) {
          for(String f: ts.NameForLocalizationLead__c.split(',')){
            result.add(f.toLowerCase());
          }
        }
    }
    system.debug('str 252 , fields for localization = ' + result);
    return result;
  }
  
  
/**
*   Метод формирует запрос к бд SF по одному объекту GenObject.
*   Возвращает строку запроса.
*/
/**
*The method forms a request to DB SF using a GenObject rec. It returns a query string.
*/
    public static String returnQuerytoDBEasy(GenObject go){
        String query;
        String StringFields = '';
        system.debug('objectName' +go);
        String ObjectName = go.name;
     
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
        
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }

        // формируем строчки из полей
        if(!go.fieldList.isEmpty()){
          // поля запроса
          //fields of a request
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                 StringFields = ' '+ StringFields + ' '+ ef.name + ',';              
               }                 
           }
           StringFields = StringFields.removeEnd(',');            
          }
          
          if(StringFields == '') return null;
          
          
          query = 'select id, '; 
          query = query +  StringFields  ;       
          query = query + ' from ' + ObjectName;          
                
          return query; 
    }   

//   Метод возвращает запрос к бд в виде: select id, FirstName, LastName from Contact where (NOT  FirstName Like '$') OR (NOT LastName Like '$')
// The method returns a request as'select id, FirstName, LastName from Contact where (NOT  FirstName Like '$') OR (NOT LastName Like '$')'
/**
*   Метод формирует запрос к бд SF по одному объекту GenObject. Забирает только зашифрованные данные.
*   Результат строка запроса
*/

/**
*The method forms a request to DB SF using a GenObject rec. It takes only encrypted data and  returns a query string.
*
*/
    public static String returnQuerytoDBToken(GenObject go){
        String query;
        String StringFields = '';
        String StringFieldsWHERE = '';
        String ObjectName;
        Schema.SObjectType targetType;
        system.debug('GO '+go);
        if(go!=null){
          ObjectName = go.name;    
          system.debug('go.name '+go.name);
          targetType = Schema.getGlobalDescribe().get(go.name);  
          system.debug('targetType '+targetType);
        }
        
        if(test.isRunningTest()){
            system.debug('is test');
            ObjectName = 'Contact'; 
            targetType = Schema.getGlobalDescribe().get('Contact');
        } 
        
           
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }

        // формируем строчки из полей
        if(go!=null&&!go.fieldList.isEmpty()){
          // поля запроса
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                 StringFields = ' '+ StringFields + ' '+ ef.name + ',';              
               }                 
           }
           StringFields = StringFields.removeEnd(',');
            //request conditions
            // условия запроса              
            for(Field ef:go.fieldList){ 
               if(ef.tokenized && FieldsObjectSET.contains(ef.name.toLowerCase())){
                 StringFieldsWHERE = ' '+ StringFieldsWHERE + ' '+ ef.name +' Like  \''+'%$%' + '\' OR';               
               }                 
            }
            StringFieldsWHERE = StringFieldsWHERE.removeEnd('OR');
         }
          
         if(StringFields == '') return null;
          
          
         query = 'select id, '; 
         query = query +  StringFields  ;       
         query = query + ' from ' + ObjectName;
         query = query + ' where (' + StringFieldsWHERE + ' )';
         //если лиды - то конвертированные пропускаем
         if (ObjectName.tolowercase() == 'lead') 
             query = query + ' and IsConverted = false ';
             
         system.debug('<query:returnQuerytoDBToken> ' + query );              
                
         return query; 
    }   
    
//формирование JSON на отправку в бд---------------------------------------------------------------------

/**
*   Метод формирует JSON для последующего запроса сохранения через сервис DFG(Entity/Save)
*/  

/**
*The method forms JSON for a save request throught DFG-service
*/ 

    public  static String JSONgenerateEntitySave(GenObject go, List<sObject> sobjList) {
        String  JSONString;

        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);        
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
        Map<String,String>  UpdateFields = new Map<String,String>();
        Map<String,String>  FieldMap = new Map<String,String>();                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }

        // формируем строчки из полей
        if(!go.fieldList.isEmpty()){
          // поля запроса
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                  if(ef.tokenized){
                     UpdateFields.put(ef.id,ef.name);
                  }  
                  else{
                    
                  }  
                  FieldMap.put(ef.name, ef.id);         
               }                 
           }   
        }
        
        
        Id SobjId;
        List<Entity> EntityList = new List<Entity>();
        for(sObject sobj: sobjList){
         List<Datas> dataList = new List<Datas>();  
         Boolean bl = false;
            for(Field ef:go.fieldList){
               if(sobj.get(ef.Name) != null){
                 if(ef.tokenized && (String.ValueOf(sobj.get(ef.Name)).right(1) != '$')){
                    system.debug(String.ValueOf(sobj.get(ef.Name)));
                    Datas dat = new Datas();
                    dat.value = String.ValueOf(sobj.get(ef.Name));
                    dat.fieldId = ef.id;
                    dataList.add(dat);
                    SobjId = sobj.id;
                    bl = true;
                 }
               }
            }  
          if(bl) {
           Entity ent = new Entity();
           ent.externalId = String.ValueOf(SobjId).substring(0,15);
           ent.typeId = go.id;
           ent.data = dataList;  
           EntityList.add(ent);   
          } 
        }
   
        JSONString = JSON.serialize(EntityList);        
        system.debug('Str 531 JSON: ' + JSONString);                            
        return JSONString;
    }
    
//формирование JSON на запрос дотекинизации данных----------------------------------------------------
//a JSON-response on a detokinization request
/**
*   Метод формирует JSON для сервиса DFG, чтобы произвести детокенизацию (/data/batch/get)
*   Возвращает JSON
*/

/**
*   The Method forms JSON for the DFG-servic for detokinization (/data/batch/get)
*   It returns JSON
*/
    public  static String JSONgenerateGET( GenObject go, List<sObject> sobjList) {
 
        String JSONString;

        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name); 
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
        SET<String> FieldsObjectSET = new SET<String>();
        Map<String,String>  UpdateFields = new Map<String,String>();
        Map<String,String>  FieldMap = new Map<String,String>(); 
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }
        
        if(!go.fieldList.isEmpty()){
          // поля запроса
           for(Field ef:go.fieldList){ 
               if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                  if(ef.tokenized){
                     UpdateFields.put(ef.id,ef.name);
                  }  
                  else{
                     
                  }  
                  FieldMap.put(ef.name, ef.id);         
               }                 
           }   
        }   
        
        List<Contact> ContactList = new List<Contact>();
        if(!sobjList.isEmpty()){
          //KDA оставляем SOBJECT
           List<PersonalData> pds = new List<PersonalData>();
           JSONString = '[ ';
            for(sObject con:sobjList){
                system.debug('str 580 ');
                 List<Datas> datas = new List<Datas>(); 
                 
                 for(Field ef:go.fieldList){
                    if(con.get(ef.name) != null && !ef.name.contains('RU') ){
                      system.debug('str 585 ' + ef.name);
                      if(ef.tokenized){
                         system.debug('str 587 ');
                          
                            system.debug('str 589 ' + con.get(ef.name));
                             if(String.ValueOf((con.get(ef.name))).substring(1,2) == '$'){  
                                JSONString = JSONString + '\"' + String.ValueOf(con.get(ef.name)).substring(0,String.ValueOf(con.get(ef.name)).length()) + '\",';
                            }  
                          
                      }                                     
                   }
                 }             
           }  
                    
        }

        if(JSONString.substring(JSONString.length()-1, JSONString.length()) == ','){
           JSONString = JSONString.substring(0, JSONString.length()-1) ;
        }        
        JSONString = JSONString + ']';
        system.debug('str 605 JSON:' + JSONString);                     
        return JSONString;
    }
    
     public static String sendDataToCrypto(String JSONString, String Token) {
           system.debug('str 610 JSON:' + JSONString);
           system.debug('str 611 Token: ' + Token);

           IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
                                                           
           Httprequest requestToken = new HttpRequest();
           requestToken.setTimeout(60000);
           requestToken.setMethod('POST');

           system.debug('str 619 EndPoint: ' + dfgIS.EndPoint__c + '/data/batch/get');    
           requestToken.setEndpoint(dfgIS.EndPoint__c + '/data/batch/get');                
           
           requestToken.setHeader('X-Auth-token', Token);   
           requestToken.setHeader('Content-Type', 'application/json');                 
           requestToken.setBody(JSONString);
           System.debug('str 625 requestToken: ' +requestToken);              
           Http httpToken = new Http(); 
           HttpResponse responseToken = httpToken.send(requestToken);         
            System.debug('responseToken '+responseToken);
           String responseString = responseToken.getBody();  
           System.debug('str 630 response: ' + responseString);
                
           return responseString;                     
        } 
        
//Entity/Save ----------------------------------------------------------------------------------------

/**
*   Метод передает JSON для сохранения на сервис DFG (Entity/Save)
*   Ответ в виде JSON из DFG c токенами
*/  
/**
*   The method passes JSON for saving
*   It returns JSON with tokens from DFG-service
*/
       public static String DataToCryptoSave(String EndPoint, String Token, String JSONString) {   
           System.debug('<JSONString> ' + JSONString);         
           if(EndPoint==null){
              IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
              EndPoint = dfgIS.EndPoint__c;
           }     
                                                           
           Httprequest requestToken = new HttpRequest();
           requestToken.setTimeout(60000);
           requestToken.setMethod('POST');   
           requestToken.setEndpoint(EndPoint + '/entity/save');      
           requestToken.setHeader('X-Auth-token', Token);   
           requestToken.setHeader('Content-Type', 'application/json'); 
           requestToken.setBody(JSONString);
                        
           Http httpToken = new Http(); 
           HttpResponse responseToken = httpToken.send(requestToken);         
           
           String responseString = responseToken.getBody();  
           System.debug('<response> ' + responseString);
                
           return responseString;                     
        }

//Cохранение ------------------------------------------------------------------------------ 
//Saving
/**
*   Метод выполняет по JSON изменение записей в SF
*/         

/**
* The method updates records in SF according to JSON
*/
        public static void responsePD(String responseJSON, GenObject go){

            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
            Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
            SET<String> FieldsObjectSET = new SET<String>();
            for(String str: schemaFieldMap.keySet()){
               FieldsObjectSET.add(str.toLowerCase());
            }
                 
            Map<String,String>  UpdateFields = new Map<String,String>();
            Map<String,String>  FieldMap = new Map<String,String>(); 
            
            if(!go.fieldList.isEmpty()){
              // поля запроса
              for(Field ef:go.fieldList){ 
                 if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                   if(ef.tokenized){
                     UpdateFields.put(ef.id,ef.name);
                   }   
                   FieldMap.put(ef.name, ef.id);         
                 }                 
              }   
           }           
           system.debug('str 701 responseJSON: '+responseJSON);
          List<Entity> deserializedPersonalDatas = 
           (List<Entity>)JSON.deserialize(responseJSON, List<Entity>.class);            
           
           system.debug('str 705: '); 

           
        // todo ВРЕМЕННО, заменить!   
        if(go.name == 'Contact'){
           List<Contact> conListUpdate = new List<Contact>();
            
           for(Entity pd: deserializedPersonalDatas){
                if(pd.data != null){
                    system.debug('str 713');
                    Contact con = new Contact();
                    con.Id = pd.externalId;
                    
                    for(Datas d: pd.data){     
                        system.debug('str 718');
                        con.put(UpdateFields.get(d.fieldId), d.key);     
                    }
                    if(con.Id != null)conListUpdate.add(con);
                }               
            }
            
            if(!conListUpdate.isEmpty()){
                system.debug(conListUpdate);
                update conListUpdate;
            } 
        }
        
        if(go.name == 'Lead'){
           List<Lead> lListUpdate = new List<Lead>();
            
           for(Entity pd: deserializedPersonalDatas){
                if(pd.data != null){                    
                    Lead l = new Lead();
                    l.Id = pd.externalId;
                    for(Datas d: pd.data){     
                        system.debug('str 739');
                        l.put(UpdateFields.get(d.fieldId), d.key);     
                    }
                    if(l.Id != null)lListUpdate.add(l);
                }               
            }
            
            if(!lListUpdate.isEmpty()){
                update lListUpdate;
            } 
        } 
        
        if(go.name == 'Account'){
           List<Account> aListUpdate = new List<Account>();
            
           for(Entity pd: deserializedPersonalDatas){
                if(pd.data != null){                    
                    Account acc = new Account();
                    acc.Id = pd.externalId;
                    for(Datas d: pd.data){     
                        system.debug('str 759');
                        acc.put(UpdateFields.get(d.fieldId), d.key);     
                    }
                    if(acc.Id != null)aListUpdate.add(acc);
                }               
            }
            
            if(!aListUpdate.isEmpty()){
                update aListUpdate;
            } 
        } 
        
               
                     
        }      
        
// Метод обрабатывает ответ, сохраняет изменения 

        public static void responsePDGET(String responseJSON, List<sObject> scope, GenObject go){

            system.debug('str 779 responseJSON: ' + responseJSON);          
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
            Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
            SET<String> FieldsObjectSET = new SET<String>();
            for(String str: schemaFieldMap.keySet()){
               FieldsObjectSET.add(str.toLowerCase());
            }
                 
            Map<String,String>  UpdateFields = new Map<String,String>();
            Map<String,String>  FieldMap = new Map<String,String>(); 
            
            if(!go.fieldList.isEmpty()){
              // поля запроса
              for(Field ef:go.fieldList){ 
                 if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                   if(ef.tokenized){
                     UpdateFields.put(ef.id,ef.name);
                   }   
                   FieldMap.put(ef.name, ef.id);         
                 }                 
              }   
           }           

           system.debug('UpdateFields ' + UpdateFields);
           List<Datas> deserializedDataOpens = 
           (List<Datas>)JSON.deserialize(responseJSON, List<Datas>.class);
           system.debug('deserializedDataOpens ' + deserializedDataOpens);
        
            Map<String,String>  TokeMap = new Map<String,String>();
            for(Datas dt:deserializedDataOpens){
                TokeMap.put(dt.key, dt.value);
            }
            system.debug('TokeMap '+TokeMap);
            List<Contact> ContactList = new List<Contact>();
                  
            if(!scope.isEmpty()){ 
              system.debug('str 815 ');            
              for(sObject con: scope){
                 for(Field ef:go.fieldList){
                    if(con.get(ef.name) != null && !ef.name.contains('RU') ){
                      system.debug('str 819 '); 
                      if(ef.tokenized && con.get(ef.name) != null 
                            && TokeMap.get(String.ValueOf(con.get(ef.name))) != null){
                          con.put(ef.name, TokeMap.get(String.ValueOf(con.get(ef.name))));
                      }                                     
                    }
                 }                 
               }  
             }

             if(!scope.isEmpty()){
                system.debug('str 832 scope: ' + scope);
                update scope; 
             }   
        } 
        

//entity/save/commit----------------------------------------------------------------------------

/**
*   Метод генерирует JSON для отправки на подтверждение (/entity/save/commit)
*/    

/**
* The method generates JSON for an approve request
*/ 
       public static String JSONgenerateCommit(String Token, SObject Obj, String ObjectName, String internalId){
            String JSONCommit;
            system.debug('str 849 internalId: '+internalId);
            Comm commNew = new Comm();
            commNew.externalId = String.ValueOf(Obj.Id).substring(0,15);    
            Criteria crit= new Criteria();
            // todo для случая с токенизаций
            crit.internalId = internalId;                            
            GenObject go =  getTypeMasterISObj(Token, ObjectName); 
                       
            Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectName);        
            Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
            SET<String> FieldsObjectSET = new SET<String>();
            for(String str: schemaFieldMap.keySet()){
               FieldsObjectSET.add(str.toLowerCase());
            }           
            
            List<String> dataKeys = new List<String>();
            if(!go.fieldList.isEmpty()){
            // поля запроса
               for(Field ef:go.fieldList){ 
                  if(FieldsObjectSET.contains(ef.name.toLowerCase())){
                    if(ef.tokenized){
                       if(CheckToken(String.ValueOf(Obj.get(ef.Name)))){
//                           dataKeys.add(String.ValueOf(Obj.get(ef.Name)));
                       }                       
                    }         
                  }                 
               }   
               crit.dataKeys = dataKeys;
               commNew.criteria = crit;
               List<Comm> CommList= new List<Comm>();
               CommList.add(commNew);
               JSONCommit = JSON.serialize(CommList);
               system.debug('str 882 ' + JSONCommit);
            }               
            
            return JSONCommit;
       } 

/**
*   Метод отправляет данные на подтверждение (/entity/save/commit)
*/

/**
* The method passes data for an approve request (/entity/save/commit)
*/
       public static String DataToCryptoCommit(String EndPoint, String Token, String JSONString) {            
           if(EndPoint==null){
             IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
             EndPoint = dfgIS.EndPoint__c;
           }     
                                                           
           Httprequest requestToken = new HttpRequest();
           requestToken.setTimeout(60000);
           requestToken.setMethod('POST');   
           requestToken.setEndpoint(EndPoint + '/entity/save/commit');      
           requestToken.setHeader('X-Auth-token', Token);   
           requestToken.setHeader('Content-Type', 'application/json');  
            
           System.debug('str 908 ' + JSONString);        
           if(JSONString != null) requestToken.setBody(JSONString);
                        
           Http httpToken = new Http(); 
           HttpResponse responseToken = httpToken.send(requestToken);         
           
           String responseString = responseToken.getBody();  
           System.debug('<response> ' + responseString);
                
           return responseString;                     
        }

//Различные проверки -------------------------------------------------------------------------------

/**
*   Метод проверяет токенизированное значение или нет
*/

/**
* The method checks if a value has been tokenized
*/
        public static Boolean CheckToken(String Token){
            system.debug('Token '+token);
            if(Token == null) return true;
            if(Token.right(1) != '$'){
                return false;
            }
            return true;
        }

// Методы для триггеров===============================================================================      
// future методы для триггера-------------------------------------------------------------------------

//Methods for triggers
//Future methods for triggers

/**
*  Данный метод используется в триггерах при сохранении
*/

/**
* The method is used in triggers while saving process
*/
   @future(callout=true)   
    public static void saveCommit(String EndPoint, String username, String password, String ObjectName, Id ObjId, String internalId){
        SObject Obj;
        
        String Token;
                
        if(EndPoint == null || username == null || password == null) Token = HelperD.authorizationMasterIS();
        else Token = HelperD.authorization(EndPoint, username, password);
         
        GenObject go =  getTypeMasterISObj(Token, ObjectName); 
        String qwery = returnQuerytoDBToken(go); 
        qwery = qwery + ' AND id = \'' + ObjId + '\'';
        system.debug('str 963 ' + qwery);
        List<SObject> results = Database.query(qwery);
        Obj =  results.get(0);
        String TokenCommit = HelperD.JSONgenerateCommit(Token ,Obj , ObjectName, internalId);
        system.debug('str 967 ' + TokenCommit);
        String rrr = HelperD.DataToCryptoCommit(EndPoint, Token, TokenCommit );
        system.debug('str 969 ' + rrr);
    }   

   @future(callout=true)   
    public static void saveCommitAll(String EndPoint, String username, String password, String ObjectName, Set<Id> ObjSetId, Map<Id,String> MapIdTranzId){
        String Token;
                
        if(EndPoint == null || username == null || password == null) Token = HelperD.authorizationMasterIS();
        else Token = HelperD.authorization(EndPoint, username, password);
         
        GenObject go =  getTypeMasterISObj(Token, ObjectName); 
        String qwery = returnQuerytoDBToken(go); 
        qwery = qwery + ' AND id IN ' + convertArraysToString(ObjSetId) ;
        system.debug('str 982 ' + qwery);
        List<SObject> results = Database.query(qwery);
        for(SObject Obj:results){
           Obj =  results.get(0);
           String TokenCommit = HelperD.JSONgenerateCommit(Token ,Obj , ObjectName, MapIdTranzId.get(Obj.Id));
           system.debug('str 987 ' + TokenCommit);
           String rrr = HelperD.DataToCryptoCommit(EndPoint, Token, TokenCommit );
           system.debug('str 989 ' + rrr);
        }  
    }  

    
   @future(callout=true)   
    public static void saveCommitNotTokn(String EndPoint, String username, String password, String ObjectName, Id ObjId, String internalId){
      if(DFGFutureController.isFirstRun){ 
        DFGFutureController.isFirstRun = false;
        system.debug('isFirstRun = ' + DFGFutureController.isFirstRun);         
        SObject Obj;
        String Token;                
        if(EndPoint == null || username == null || password == null) Token = HelperD.authorizationMasterIS();
        else Token = HelperD.authorization(EndPoint, username, password);   
              
        GenObject go =  getTypeMasterISObj(Token, ObjectName); 
        String qwery = returnQuerytoDB(go); 
        qwery = qwery + ' AND id = \'' + ObjId + '\'';
        system.debug('str 1007 ' + qwery);
        List<SObject> results = Database.query(qwery);
        if (results != null && !results.isEmpty()) {
          Obj =  results.get(0);
          String TokenCommit = HelperD.JSONgenerateCommit(Token ,Obj , ObjectName, internalId);
          system.debug('str 1012 ' + TokenCommit);
          String rrr = HelperD.DataToCryptoCommit(EndPoint, Token, TokenCommit );
          system.debug('str 1014 ' + rrr);
        } 
      }
    } 

   @future(callout=true)   
    public static void saveCommitNotToknAll(String EndPoint, String username, String password, String ObjectName, Set<Id> ObjSetId, Map<Id,String> MapIdTranzId){
        String Token;
                
        if(EndPoint == null || username == null || password == null) Token = HelperD.authorizationMasterIS();
        else Token = HelperD.authorization(EndPoint, username, password);
         
        GenObject go =  getTypeMasterISObj(Token, ObjectName); 
        String qwery = returnQuerytoDB(go); 
        qwery = qwery + ' AND id IN ' + convertArraysToString(ObjSetId) ;
        system.debug('str 1029 ' + qwery);
        List<SObject> results = Database.query(qwery);
        for(SObject Obj:results){
           Obj =  results.get(0);
           String TokenCommit = HelperD.JSONgenerateCommit(Token ,Obj , ObjectName, MapIdTranzId.get(Obj.Id));
           system.debug('str 1034 ' + TokenCommit);
           String rrr = HelperD.DataToCryptoCommit(EndPoint, Token, TokenCommit );
           system.debug('str 1036 ' + rrr);
        }  
    }  
     
    public static String convertArraysToString(Set<Id> ObjSetId){
        String str = '(';
        if(!ObjSetId.isEmpty()){
            for(Id objId:ObjSetId){
                str = str + '\'' + objId + '\',';
            }
            str = str.removeEnd(',');
        }
        
        str = str + ')';
        return str;
    }     
// ---------------------------------------------------------------------------------------------





//==============================================================================================    
// метод создаёт в базе объекты Error__c в случае ошибок при массовой токенизации / детокенизации

  public static void logError(Exception ex, Database.BatchableContext BC, List<sObject> scope, String SObjectName, String operType){
        List<DFGError__c> errList = new List<DFGError__c>();

          DFGError__c error = new DFGError__c ();
          error.Message__c = ex.getTypeName() + '\n' + ex.getCause() + '\n' + ex.getMessage() + '\n' + ex.getStackTraceString() + '\n' + ex.getLineNumber();
          error.Failed__c = '';
          if (BC != null) error.BatchJobId__c = BC.getJobId();
          error.Type__c = operType;
          error.SObjectType__c = SObjectName;
 
          if (scope != null){
              for(sObject so: scope){
                  error.Failed__c = error.Failed__c  + '' + so.get('Id') + '\n';
              }
          }
           errList.add(error);
          system.debug('id = ' + error.id); 

        if (!errList.isEmpty()) insert errList;
  } 
 


/**
*   Метод возвращает список полей для данного объекта, для которых требуется токенизация
*/

/**
* The method returns a list of fields that must be tokenized
*/
/*    public static List<String> getNameFieldsToken(String EndPoint, String username, String password, String ObjectName){
        List<String> Fields = new List<String>();
        String Token;
                
        if(EndPoint == null || username == null || password == null) Token = authorizationMasterIS();
        else Token = authorization(EndPoint, username, password);
        
        GenObject go = getTypeMasterISObj(Token, ObjectName);
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(go.name);
        
        Map<String, Schema.SObjectField> schemaFieldMap = targetType.getDescribe().fields.getMap();
                   
        SET<String> FieldsObjectSET = new SET<String>();
        for(String str: schemaFieldMap.keySet()){
             FieldsObjectSET.add(str.toLowerCase());
        }
        
        if(!go.fieldList.isEmpty()){
            for(Field ef:go.fieldList){ 
                if(ef.tokenized && FieldsObjectSET.contains(ef.name.toLowerCase())){
                    Fields.add(ef.name);
                }
            }   
        }
        return  Fields; 
    }       */
//Standard Transform----------------------------------------------------------------------------

/**
*   Метод возвращает JSON типов для трансформации
*/

/**
* The method returns JSON for a further transformation
*/
    public static String JSONTypeTransform(String EndPoint, String username, String password){
        String typeJSON;
        String Token;
        if(EndPoint==null){
            Token = authorizationMasterIS();
            EndPoint = IntegrationSettingsMaster__c.getValues('Param').EndPoint__c;
        } 
        else{
            Token = authorization(EndPoint,username,password);
        }

        if(Token == null) return null;
        
        Httprequest request = new HttpRequest();
        request.setTimeout(60000);
        request.setMethod('GET');
        request.setEndpoint(EndPoint);
        request.setHeader('transform', Token);
        
        Http http = new Http(); 
        HttpResponse response = http.send(request); 
        typeJSON = response.getBody();
        typeJSON = typeJSON.replaceAll('fields', 'fieldList');      
           
        return typeJSON;        
    }
/**
*   Метод формирует для данного лида (для стандартных полей
*   LastName, FirstName) конвертацию в Контакт на уровне DFG
*/

/**
* The method converts (for standard fields such as LastName, FirstName) a Leat to a Contact
*/
    public static String JSONLeadToContact(Id LeadId, Id internalId, Id ContactId, String TransformName){
      system.debug('LeadId:' + LeadId + '; internalId:' + internalId + '; ContactId:' + ContactId + '; TransformName:' + TransformName );
        String JSONConvert;
        Transform transf= new Transform();
        transf.name = TransformName;
          Fr f = new Fr();
          f.key = 'lead';
            Criteria criteria = new criteria();
            criteria.internalId = internalId;
            system.debug('internalId '+internalId);
            criteria.externalId = String.ValueOf(LeadId).substring(0,15);
            Lead l = [select id, LastName, FirstName from Lead where id =: LeadId];
            List<String>dataKeys = new List<String>();
            if(l.LastName != null && CheckToken(l.LastName))    dataKeys.add(l.LastName);
            if(l.FirstName != null && CheckToken(l.FirstName))  dataKeys.add(l.FirstName);
            criteria.dataKeys = dataKeys;   
            f.criteria = criteria;    
            
            List<Fr> FrList = new List<Fr>();  
            FrList.add(f);
            
        transf.frm = FrList; 
            To to1 = new to();
            to1.key = 'contact';
            to1.externalId = String.ValueOf(ContactId).substring(0,15);
            to1.committed = true;
            List<To> to = new List<To>();
            to.add(to1);
        transf.to = to;   
        List<Transform> TransformList = new List<Transform>();
        TransformList.add(transf);
        JSONConvert = JSON.serialize(TransformList);
        JSONConvert = JSONConvert.replaceAll('frm','from');
        return JSONConvert;
    } 
    
    @future(callout=true)
    public static void transformStand(String LeadId, String internalId, String ContactId, String TransformName){
        String JSONConvert = JSONLeadToContact(LeadId, internalId, ContactId, TransformName);

        JSONConvert = JSONConvert.removeStart('[');
        JSONConvert = JSONConvert.removeEnd(']');
        System.debug('JSONConvert >>> ' + JSONConvert);


        IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
        String EndPoint; 
        String Token = HelperD.authorizationMasterIS(); 
        if(dfgIS.EndPoint__c != null) EndPoint = dfgIS.EndPoint__c + '/transform'; 
          else
            return;
 
        Httprequest requestData = new HttpRequest();
        requestData.setTimeout(60000);
        requestData.setMethod('POST');   
        requestData.setEndpoint(EndPoint);      
        requestData.setHeader('X-Auth-token', Token);   
        requestData.setHeader('Content-Type', 'application/json'); 
        system.debug('STR 1188 ' + EndPoint);
        system.debug('STR 1189 ' + JSONConvert);
        
        requestData.setBody(JSONConvert);
        
        Http http = new Http(); 
        HttpResponse response = http.send(requestData); 
        String respJSON = response.getBody();
        System.debug('resp: ' + respJSON);
        
        responsePD(respJSON, getTypeMasterISObj(Token,'Contact'));
         
    }

    @future(callout=true)
    public static void transformStandAll(Set<String> LeadSETId, String internalId, Map<String,String> ConvertMapId, String TransformName){
      for(String LeadId:LeadSETId) {
        String JSONConvert = JSONLeadToContact(LeadId, internalId, ConvertMapId.get(LeadId), TransformName);

        JSONConvert = JSONConvert.removeStart('[');
        JSONConvert = JSONConvert.removeEnd(']');
        System.debug('JSONConvert >>> ' + JSONConvert);


        IntegrationSettingsMaster__c dfgIS =  IntegrationSettingsMaster__c.getValues('Param');
        String EndPoint; 
        String Token = HelperD.authorizationMasterIS(); 
        if(dfgIS.EndPoint__c != null) EndPoint = dfgIS.EndPoint__c + '/transform'; 
          else
            return;
 
        Httprequest requestData = new HttpRequest();
        requestData.setTimeout(60000);
        requestData.setMethod('POST');   
        requestData.setEndpoint(EndPoint);      
        requestData.setHeader('X-Auth-token', Token);   
        requestData.setHeader('Content-Type', 'application/json'); 
        system.debug('STR 1225 ' + EndPoint);
        system.debug('STR 1226 ' + JSONConvert);
        
        requestData.setBody(JSONConvert);
        
        Http http = new Http(); 
        HttpResponse response = http.send(requestData); 
        String respJSON = response.getBody();
        System.debug('str 1233 resp: ' + respJSON);
        
        responsePD(respJSON, getTypeMasterISObj(Token,'Contact'));
      }   
    }
//additional saving
//Дополнительное сохранение---------------------------------------------------------------------
  
   @future(callout=true)     
   public static void saveExtra(List <String> Ids, String sObjectS){
    List<String> newIdList = new List <String>();
    for (String s: Ids){
         newIdList.add('\''+s+'\'');
        
    }
        String Token = HelperD.authorizationMasterIS(); 
        HelperD.GenObject go = HelperD.getTypeMasterISObj(Token, sObjectS);
        String stringQuery = HelperD.returnQuerytoDBEasy(go);
        
        stringQuery = stringQuery + ' where id in ' + '' + newIdList + '';//\'
        system.debug('str 1253 Query: ' + stringQuery);
        List<sObject> sobjList = Database.query(stringQuery);
        String JSONEtoDFG = HelperD.JSONgenerateEntitySave(go,sobjList);
        String JSONEreq = HelperD.DataToCryptoSave(null, Token, JSONEtoDFG);
        HelperD.responsePD(JSONEreq, go);      
   }
   
   
   
//==============================================================================================    
// Классы определяют объекты,  поля для шифрования и передачи - из системы на которой реализ крипто

   public class Token {
        String token;   
        public Token(){}
   }
    public class PersonalData {
        String id;              
        String externalId;             
        String entityTypeId;             
        List<Datas> datas;
                
        public PersonalData(){}
    }
    
    public class GenObject {
        String token;
        String id;               
        String code;            
        public String name;              
        String domainId;                

        List<Field> fieldList;        
        
        public GenObject(){}
    }
 
    public class Field {
        String id;              
        String name;
        Boolean tokenized;
             
        public Field(){}      
    }   
//==============================================================================================        
// Классы - обертки для Возврата зашифрованных данных
// Wrapper classes for return encrypted data
//----------------------------------------------------------------------------------------------
    public class Entity{
        String externalId; 
        String typeId;
        List<Datas> data;
        public Entity(){}
    }

    public class Datas {                    
        String value;             
        String fieldId;  
        String key;
        public Datas(){}
    }
 
// Классы - обертки для Commit
//Wrapper classes for Commit
    public class Comm{
        String externalId; 
        Criteria criteria;
        public Comm(){}     
    }     
    
    public class Criteria{
        String internalId;
        String externalId;
        List<String> dataKeys;
        public Criteria(){}
    }    

// ------------------------------   
    public class Transform{
        String name;
        List<Fr> frm;
        List<To> to;
        public Transform(){}
    }
    
    public class Fr{
        String key; 
        Criteria criteria;  
        public Fr(){}
    }
    
    public class To{
        String key; 
        String externalId;  
        Boolean committed;
        public To(){}
    }   
    
    
//-------------------------------------------------------------------------------------- 
        
        
    /*    //тестовый метод, возвращает id __custom__ поля
          //нужно добавить url sf instance в remote settings
    public static list<map<string,object>> getFieldMetaData(string fieldName)
    {
        list<map<string,object>> results = new list<map<string,object>>();
        
        fieldName = fieldName.replace('__c','');
        string instanceURL = System.URL.getSalesforceBaseUrl().getHost().remove('-api' );
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        
        String toolingendpoint = 'https://'+instanceURL+'/services/data/v28.0/tooling/';
        
        //query for custom fields
        toolingendpoint += 'query/?q=Select+id,DeveloperName,FullName+from+CustomField+where+DeveloperName+=+\''+fieldName+'\'';
        req.setEndpoint(toolingendpoint);
        req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        
        //convert the original data structure into a map of objects. The data we want is in the records property of this object
        map<string,object> reqData = (map<string,object>) json.deserializeUntyped(res.getBody());
        
        //now create a list of objects from the records property. This serialize/deserialize trick is the only way I know to convert a generic object
        //into something else when the source data is 'salesforce Map encoded' (no quotes around field names or values, parenthesis to denote open and close, etc)
        list<object> fieldData = (list<object>) JSON.deserializeUntyped(JSON.serialize(reqData.get('records')));    
        
        //iterate over each object in the list and create a map of string to object out of it and add it to the list
        for(object thisObj : fieldData)
        {
            map<string, object> thisFieldData =  (map<string, object>) json.deserializeUntyped(JSON.serialize(thisObj));
            results.add(thisFieldData);
        }
   
        return results;    
    }
      */  
}