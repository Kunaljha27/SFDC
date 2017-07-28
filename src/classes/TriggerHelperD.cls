/**  Класс TriggerHelperD содержит основные методы для
*    работы DFG-решения
*    Class contains methods for DFG solution 
*
*/
global class TriggerHelperD {
    public static integer runCounter = 0;
    public static Boolean isFirstRun = true;
    
/*  Проверка для включения объекта работы с DFG
*   Check settings for Objects
*/  
    public static boolean CheckDFGForObject(String ObjName){
        return  ObjectSettings__c.getValues(ObjName).Active__c;
    }

/*  Возвращаем поля для передачи в DFG
*   List<String> - Fields for DFG
*/      
    public static String[] getObjectFieldsT(String ObjName){
        return  ObjectSettings__c.getValues(ObjName).FieldName__c.replaceAll(' ','').split(',');
    }
    
//ПРОВЕРКА:ВСТАВКА И ОБНОВЛЕНИЕ ЗАПИСИ / Check for INSERT and Update-----------------------------------------
/*  
*   Производим проверку по вставке данных в SF
*   CheckToken(List<sObject> ObjectList, String ObjName, String FieldName)
*   параметры: вх. лист объектов, имя объекта, имя поля сессия Id
*
*
*/      
    public static void CheckToken(List<sObject> ObjectList,  String ObjName, Map<Id,sObject> TriggerOldMap){ 
      system.debug('in CheckToken');
      
      Boolean isTokenization;          // Признак нужна ли токенизация
      Boolean isLocalize;              // Если имеется локализацияы
      Boolean isUserProperty;          // Если cвойство на Ответственном 
      Boolean changeNOTRFcountry = false;         // Страна РФ была изменена/убрана  (v 1.18)


      String NameForLocalization;
      String FieldForLocalizationAcc;
      String NameForLocalizationAccount;
      String FieldForLocalizationLead;
      String NameForLocalizationLead;
              
      String  SignLocalization;        // Именование страны на Пользователе
    
      Boolean CheckToken;              // Если нужно выдавать сообщение об ошибке
      String NameForTransaction;       // Имя поля TransactionId
      String LocalizationLabel;        // метка страны (для checkPersonalRFBefore)
        
      TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
      if(ts.isTokenization__c != null) isTokenization = ts.isTokenization__c;
      isUserProperty = ts.isUserProperty__c;
      isLocalize = ts.isLocalize__c;
      if(SignLocalization == null  && ts.SignLocalization__c != null) SignLocalization = ts.SignLocalization__c.toLowerCase();
 
      if (ObjName == 'Account'){ 
          if(ts.NameForLocalizationAccount__c != null) NameForLocalization = ts.NameForLocalizationAccount__c.toLowerCase();
      } else if (ObjName == 'Contact'){ 
          if(ts.NameForLocalization__c != null)  NameForLocalization = ts.NameForLocalization__c.toLowerCase();
      } else if (ObjName == 'Lead'){  
          if(ts.NameForLocalizationLead__c != null)  NameForLocalization = ts.NameForLocalizationLead__c.toLowerCase();
      }
         
      if (isUserProperty != null && isUserProperty)    
          LocalizationLabel = SignLocalization;          //если смотрим на локализацию на пользователе
      else 
          LocalizationLabel = NameForLocalization;       //если смотрим на локализацию на объекте
   
      system.debug('NameForLocalization = ' + NameForLocalization);  
      Set<String> FieldForLocalizationSet = HelperD.initLocalizationFields(ObjName, ts);
      system.debug('73 set = ' + FieldForLocalizationSet);
 
      CheckToken = ts.CheckToken__c;  
      NameForTransaction = ts.NameForTransaction__c;

      Boolean flag = false;
      if(TriggerOldMap == null) {  // если в первый раз 
         flag = true;
      }
      else{                        // на update
         for(sObject obj: ObjectList){
            for(String strF:getObjectFieldsT(ObjName)){
            
                //добавляем проверку на смену страны с RUS на другую
                changeNOTRFcountry = checkNotRFAfter(obj,FieldForLocalizationSet,NameForLocalization, TriggerOldMap.get(obj.Id)); 
                
                if(obj.get(strF)!=TriggerOldMap.get(obj.Id).get(strF)  || checkPersonalRFBefore(obj,FieldForLocalizationSet,LocalizationLabel, TriggerOldMap.get(obj.Id)) || changeNOTRFcountry){
                    if(isFirstRun){
                        flag = true;
                        isFirstRun = false;
                        system.debug('str 80; flag = true, isFirstRun =' + isFirstRun);
                    }              
                }
            }
         }
      }

      system.debug('isFirstRun : ' + isFirstRun);
      system.debug('LocalizationLabel = ' + LocalizationLabel);
      system.debug('NameForTransaction  = ' + NameForTransaction );
      system.debug('flag = ' + flag);
      system.debug('SignLocalization = ' + SignLocalization);
      system.debug('changeNOTRFcountry  = ' + changeNOTRFcountry );
              
      if(flag){
        if(CheckDFGForObject(ObjName)){
            system.debug('STR 65');  
                system.debug('STR 68');
                // и делать проверку на отображение ошибки
                if(CheckToken){
                    if(!getObjectFieldsT(ObjName).isEmpty()){
                        system.debug('STR 72');
                        for(sObject obj: ObjectList){                           
                            for(String strF:getObjectFieldsT(ObjName)){       
                                system.debug('STR 76');
                                //если есть локализация
                                if(isLocalize){     
                                    system.debug('STR 79 ' + isUserProperty + ';FieldForLocalizationSet: ' + FieldForLocalizationSet);
                                    boolean isPersonal = checkEmptyPersonal(obj,FieldForLocalizationSet);
                                    boolean isPersonalRF = checkPersonalRF(obj,FieldForLocalizationSet,LocalizationLabel);
                                    
                                    system.debug('isPersonal = ' + isPersonal);
                                    system.debug('isPersonalRF = ' + isPersonalRF );
                                 
                                    //если cвойство на Ответственном                              
                                    if(isUserProperty == true){
                                        if(isPersonal){
                                          // Если нужно токенизировать
                                          if(isTokenization){
                                            system.debug('isTokenization ');
                                             if(!HelperD.CheckToken((String.ValueOf(obj.get(strF)))) && isPersonalRF ){
                                               system.debug('STR 87 error' + HelperD.CheckToken((String.ValueOf(obj.get(strF)))) + ' ; ' + obj.get(strF));
                                               obj.addError(Label.DFG_Plugin_Error, true);
                                             }
                                             
                                             //если сменили страну без плагина (данные не де-токенизировались)
                                             if (changeNOTRFcountry){
                                                  String token = String.ValueOf(obj.get(strF));
                                                  if (token.right(1) == '$'){
                                                      system.debug('str 454, add error (change country without plugin');
                                                      obj.addError(Label.DFG_Plugin_Error, true);
                                                  }
                                              }
                                                
                                          } else{
                                             if( obj.get(NameForTransaction) == null && isPersonalRF){
                                               system.debug('STR 91 error');
                                               obj.addError(Label.DFG_Plugin_Error, true);
                                             }    
                                          }
                                        }
                                    } 
                                    else{//если cвойство на записи ПД  

                                        system.debug('STR 123 ' + obj.get(strF));

                                        if (obj.get(strF) != null && isPersonal){
                                            system.debug('STR 99: isPersonal = ' + isPersonal + ' ; ' + HelperD.CheckToken((String.ValueOf(obj.get(strF)))));
                                            system.debug('isPersonalRF = ' + isPersonalRF);
                                            system.debug('obj.get(strF) = ' + obj.get(strF));
                                            system.debug('isTokenization ' + isTokenization);

                                            if(isTokenization){ // Если нужно токенизировать
                                               if(!HelperD.CheckToken((String.ValueOf(obj.get(strF)))) && isPersonalRF){
                                                 system.debug('STR 103');
                                                 obj.addError(Label.DFG_Plugin_Error, true);
                                               } 
                                               //если сменили страну без плагина (данные не де-токенизировались)
                                                system.debug('str 160 ') ;
                                                if (changeNOTRFcountry){
                                                    String token = String.ValueOf(obj.get(strF));
                                                    if (token.right(1) == '$'){
                                                        system.debug('str 454, add error (change country without plugin');
                                                        obj.addError(Label.DFG_Plugin_Error, true);
                                                    }
                                                } 
                                            } else{
                                                 system.debug('STR 106 ; ' + ObjName + ' ; ' + NameForLocalization);
                                               if( (obj.get(NameForTransaction) == null) && isPersonalRF ){
                                                 system.debug('STR 108 error');
                                                 obj.addError(Label.DFG_Plugin_Error, true);
                                               }    
                                            } 
                                         }                                        
                                    }
                                }else{ // если локализации нет

                                   if(isTokenization){ // Если нужно токенизировать
                                     if(!HelperD.CheckToken((String.ValueOf(obj.get(strF))))){
                                        system.debug('STR 117');
                                        obj.addError(Label.DFG_Plugin_Error, true);
                                     }  
                                   } else{
                                     if( obj.get(NameForTransaction) == null ){
                                       system.debug('STR 123');
                                       obj.addError(Label.DFG_Plugin_Error, true);
                                     }      
                                 }                                     
                                }
                            }
                            
                        }
                    }                    
              }
        }
     } 
    }   

    //проверка смены страны с пустой либо не-РФ на РФ
    public static Boolean checkPersonalRFBefore(Sobject obj, Set<String> fields, String SignLocalization, Sobject pastObj){
    system.debug('in checkPersonalRFBefore');
        boolean result = false;
        system.debug('SignLocalization = ' + SignLocalization);
       
        if (fields != null && SignLocalization != null && pastObj != null) {
          for(String f: fields){
            try{
              if (String.valueof(obj.get(f))!= null ){
                  system.debug('String.valueof(obj.get(f)).toLowerCase() = ' + String.valueof(obj.get(f)).toLowerCase());
                     if (  SignLocalization.containsignorecase(String.valueof(obj.get(f)))) //если сейчас страна RUS
                         if (String.valueof(pastObj.get(f))== null || (String.valueof(pastObj.get(f)) != null && !SignLocalization.containsignorecase(String.valueof(pastObj.get(f))))) //если в прошлом объекте страны не было либо страна была не RUS
                          result = true;
              }
            }catch(Exception ex){
              system.debug('!!!Exception str204!!! ' + ex);
            }
            }
        } 
        
        system.debug('before out checkPersonalRFBefore, result = ' + result);
        return result;
  }
  
    //проверяем смену страны с РФ на иностранную
  //todo объединить с checkPersonalRFBefore
    public static Boolean checkNotRFAfter(Sobject obj, Set<String> fields, String SignLocalization, Sobject pastObj){
    system.debug('in checkNotRFAfter');
        boolean result = false;
        system.debug('SignLocalization = ' + SignLocalization);
        
        //23.12.2015 если сменили RU на одной стране, а другую (остальные) оставили
        List<Boolean> labels = new List<Boolean>();
       
        if (fields != null && SignLocalization != null && pastObj != null) {
          for(String f: fields){
            boolean wasEdited; //23.12.2015 
            try{
                  if (pastObj.get(f) != null && obj.get(f) != null){ 
                      system.debug('String.valueof(obj.get(f)).toLowerCase() = ' + String.valueof(obj.get(f)).toLowerCase());
                         if (  SignLocalization.containsignorecase(String.valueof(pastObj.get(f)))){ //если в прошлом страна была RUS
                             wasEdited = false;
                             if (!SignLocalization.containsignorecase(String.valueof(obj.get(f)))){ //если сейчас страну делают не RUS
                                  result = true;
                                  wasEdited = true; 
                              }
                          } else if ( !SignLocalization.containsignorecase(String.valueof(pastObj.get(f)))){ //если в прошлом страна была не-RUS
                             wasEdited = true;
                             if (SignLocalization.containsignorecase(String.valueof(obj.get(f)))){ //а сейчас страну делают RUS
                                  wasEdited = false; 
                              }
                          }
                  } else if (pastObj.get(f) != null && obj.get(f) == null){                //если старая страна была, а сейчас её убрали
                      if (SignLocalization.containsignorecase(String.valueof(pastObj.get(f)))){//если старая страна была RU
                          result = true;
                          wasEdited = true;
                      }
                  } else if (pastObj.get(f) == null && obj.get(f) != null){                //если страны не было, а сейчас её выбрали
                      if (SignLocalization.containsignorecase(String.valueof(obj.get(f)))){//и новая страна RU 
                          wasEdited = false;
                      }
                  } 
              }catch(Exception ex){
                  system.debug('!!!Exception str204!!! ' + ex);
              }
                
             system.debug('field : ' + f + ' wasEdited: ' + wasEdited);
             if (wasEdited != null) labels.add(wasEdited);
             
            }
        }     
        
        //23.12.2015
        for(Boolean wasEdited: labels){
            if (!wasEdited)
                result = false;
        }
        
        system.debug('before out checkNotRFAfter, result = ' + result);
        return result;
  }

  public static Boolean checkBoolean (Sobject obj, Set<String> fields){
        boolean result = false;
        if (fields != null) {
            for(String f: fields){
                   try{
                       if ( obj.get(f) == true  )
                           result = true;
                   }catch(Exception ex){
                       system.debug('!!!Exception str204!!! ' + ex);
                   }
            }
        }
        system.debug('checkBoolean = ' + result);
        return result;
    }

  public static boolean checkEmptyPersonal(Sobject obj, Set<String> fields){
    boolean result = false;
      if (fields != null) {
        for(String f: fields){
          system.debug('field: ' + f);
          try{
            if (String.valueof(obj.get(f)) != null){
              result = true;
            }
          }catch(Exception ex){
            system.debug('!!!Exception str189!!! ' + ex);
          }
        }
      }
    return result;
  }
    
  public static Boolean checkPersonalRF(Sobject obj, Set<String> fields, String SignLocalization){
    boolean result = false;
    system.debug('SignLocalization = ' + SignLocalization);
    if (fields != null && SignLocalization != null) {
      for(String f: fields){
        try{
          if (String.valueof(obj.get(f))!= null ){
              system.debug('String.valueof(obj.get(f)).toLowerCase() = ' + String.valueof(obj.get(f)).toLowerCase());
                 if (  SignLocalization.containsignorecase(String.valueof(obj.get(f))))
                      result = true;
          }
        }catch(Exception ex){
          system.debug('!!!Exception str204!!! ' + ex);
        }
        }
      }
    return result;
  } 


//COMMIT-----------------------------------------------------------------------------------    
    public static void checkCommit(List<sObject> ObjectList){   // очищаем поля
        TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
        String NameForTransaction;        // Имя поля TransactionId
        NameForTransaction = ts.NameForTransaction__c;
        
        for(sObject obj:ObjectList){
            system.debug('STR 146');
            if(obj.get(NameForTransaction)!=null){
                system.debug('STR 148');
                HelperD.ContacMap = String.ValueOf(obj.get(NameForTransaction));
                obj.put(NameForTransaction, null);
            }
        }
    }
 

    public static void checkCommit2(List<sObject> ObjectList,String ObjName,Map<Id, SObject> TriggerOldMap ){
        system.debug('in checkCommit2');
        
        Set<ID> SetId = new set<Id>();
        Map<Id,String> MapIdTranzId = new  Map<Id,String>();  
        Boolean bool1 = false;
        Boolean bool2 = false;
        Boolean flag = false;
        
        Boolean ch = false;
        if(TriggerOldMap == null) flag = true ;
        if(TriggerOldMap != null) ch = true ;
        system.debug('STR 161');

         for(sObject obj: ObjectList){
           if(ch){
            for(String strF:getObjectFieldsT(ObjName)){
                if(obj.get(strF)!=TriggerOldMap.get(obj.Id).get(strF)){
                  system.debug('STR 175 ' + obj.get(strF) + '__' + TriggerOldMap.get(obj.Id).get(strF));
                  flag = true;                  
                }  
            }
           }
         } 
        
        for(sObject obj: ObjectList){
         if(flag){
            system.debug('STR 163');
            Boolean chek = false;
            if(HelperD.ContacMap !=null){
              system.debug('STR 166');
              chek = true;
            }
            if(chek){   
                system.debug('STR 170');
                Boolean isTokenization;          // Признак нужна ли токенизация
                TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
                if (ts!= null) isTokenization = ts.isTokenization__c;
                //if(!test.isRunningTest()){
                    system.debug('STR 172');
                    if(isTokenization){    
                        SetId.add(obj.Id);
                        MapIdTranzId.put(obj.Id, HelperD.ContacMap) ;   
                        bool1 = true;         
                    }else{  
                        SetId.add(obj.Id);
                        MapIdTranzId.put(obj.Id, HelperD.ContacMap) ; 
                        bool2 = true;                                               
                    }                   
                //}
            }
          } 
        }  
        
        if(bool1 & flag){ HelperD.saveCommitAll(null, null, null, ObjName, SetId, MapIdTranzId);  system.debug('str 213');}      
        if(bool2 & flag){ HelperD.saveCommitNotToknAll(null, null, null, ObjName, SetId, MapIdTranzId);  system.debug('str 214'); }
    }
    
//Convert-----------------------------------------------------------------------------------     
   public static void convertationForLead(List<Lead> TriggerNew, Map<Id,Lead> TriggerOldMap){
       // lead_to_contact
       
        Boolean bool1 = false;
        Set<String> LeadSelectSetId = new Set<String>();
        Map<String,String> ConvertMapId= new Map<String,String>();
       
        Boolean isTokenization;          // Признак нужна ли токенизация//
        Boolean isLocalize;              // Если имеется локализация//
        String  FieldForLocalization;  // Поле по которому происходит определение принадлежности записи к ПД//
        Boolean isUserProperty;          // Если cвойство на Ответственном //
        
        String  SignLocalization;         // Именование страны на Пользователе//
        
        String TransformName;        
      
        String NameForTransaction;        // Имя поля TransactionId//
        
        TokenizationSettings__c ts = TokenizationSettings__c.getValues('Param');
        isTokenization = ts.isTokenization__c;
        isUserProperty = ts.isUserProperty__c;
        Set<String> FieldForLocalizationSet = HelperD.initLocalizationFields('Lead',ts);
        FieldForLocalization= ts.FieldForLocalization__c;
        isLocalize = ts.isLocalize__c;
        SignLocalization = ts.SignLocalization__c;
        TransformName =  ts.TransformName__c;
        
        NameForTransaction = ts.NameForTransaction__c;
        String NameForLocalization ;
        
        if(ts.NameForLocalizationLead__c != null)  
                NameForLocalization = ts.NameForLocalizationLead__c.toLowerCase(); 
        
      system.debug('NameForLocalization = ' + NameForLocalization);  
               
       SET<Id> LeadSETId = new SET<Id>(); 
       Boolean check = false;
       system.debug('str 226 ');
       for(Lead le: TriggerNew){
            system.debug('str 228 ');
            if(le.ConvertedContactId!=null && (TriggerOldMap.get(le.Id)).ConvertedContactId==null){
              system.debug('str 230 '); 
              if(isLocalize){
                system.debug('str 232 ');
                if(isUserProperty == true){ 
                    system.debug('str 234 ');  
                      if (checkPersonalRF(le,FieldForLocalizationSet,NameForLocalization)){
                      LeadSETId.add(le.ConvertedContactId);
                      check = true; 
                    }
                }else{
                    system.debug('str 240 ');  
                    if(checkEmptyPersonal(le,FieldForLocalizationSet)){
                      LeadSETId.add(le.ConvertedContactId);
                      check = true; 
                    }
                }
              }  
            }           
       }
       if(check){
          system.debug('str 250 ');
          List<Contact> contList = [select id, LastName, FirstName  from contact where id IN: LeadSETId];
          MAP<id, Contact> contMap = new MAP<id, Contact>();
          if(!contList.isEmpty()){
            system.debug('str 254 ');
             for(Contact con:contList){
                contMap.put(con.Id, con);
             }
             for(Lead le: TriggerNew){
                if((contMap.keySet()).contains(le.ConvertedContactId)){
                    system.debug('str 260 ');
                    LeadSelectSetId.add(le.Id);
                    ConvertMapId.put(le.Id, le.ConvertedContactId);
                    bool1 = true;
                }
             }
             if(bool1) HelperD.transformStandAll(LeadSelectSetId, null, ConvertMapId, TransformName);
          }          
       }       
   } 
   
 //------------------------------------------------------------------------------------------------      
   
}