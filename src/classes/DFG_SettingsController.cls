public with sharing class DFG_SettingsController {

    public IntegrationSettingsMaster__c masterSett {get;set;}
    
    public Boolean localizationError {get;set;}
    public String selectedObject {get;set;}
    public String selectedUserField {get;set;}
    public Set<String> existSettingsObj {get;set;}

    public SelectOption[] objectOptionsObj {get;set;}
    public SelectOption[] fieldNames {get;set;}
    public SelectOption[] openFieldNames {get;set;}
    public SelectOption[] selFieldNames {get;set;}
    public SelectOption[] selOpenedFieldNames {get;set;}
    public SelectOption[] userFields {get;set;}
    public Boolean showOnlyExistObj {get;set;}
    public Boolean isActiveTrigger {get;set;}
    
    public String showField_for_localization {get;set;}
    public String showNameForLocalization {get;set;}
    public String showIsUserProperty {get;set;}
    public String showSignLocalization {get;set;}
    public String showPermissionsSettings {get;set;}
    
    public String selectedObjectTrigger {get;set;}
    public Set<String> existTriggerObj {get;set;}
    public SelectOption[] objectOptionsTrigger {get;set;}
    //public TriggerSettingsD__c triggerSetting {get;set;}
    public Boolean showOnlyExistTrigg {get;set;}

    public TokenizationSettings__c tokenSettings {get;set;}

    public DFGPermissions__c permissionsSettings {get;set;}

    String  language = [SELECT LanguageLocaleKey  FROM User Where id=: userinfo.getUserId()][0].LanguageLocaleKey;

    public DFG_SettingsController() 
    {   
        localizationError = true;

        getIntegrationSettings(); 


        initExistingSettings();


        showOnlyExistObj = false;
        getObjectOptionsObj();
        if (objectOptionsObj.size() > 0) {
            selectedObject = objectOptionsObj.get(0).getValue();
            if (ObjectSettings__c.getValues(selectedObject) != null) 
                    isActiveTrigger = ObjectSettings__c.getValues(selectedObject).Active__c;
        }
        getFieldsNames();
        getOpenFieldsNames();
        getFieldNamesForSelectedObject();
        getOpenFieldNamesForSelectedObject(); 
        getUserFields();
        

        showOnlyExistTrigg = false;
        getObjectOptionsTrigger();
        if (objectOptionsTrigger.size() >0) selectedObjectTrigger = objectOptionsTrigger.get(0).getValue();  
        

        initTokenSettings();
 
        initPermissionsSettings();
    }

    public selectOption[] getUserFields(){
        if (userFields == null){
            userFields = new List<SelectOption>();
            userFields.add(new SelectOption('sObject',Label.dfgSet_sObject)); 
            userFields.add(new SelectOption('user',Label.dfgSet_User)); 
        }
        return userFields;
    }

    //инициализация настроект полномочий
    public void initPermissionsSettings()
    {
        permissionsSettings = DFGPermissions__c.getValues('Param');
        if (permissionsSettings == null) 
            permissionsSettings = new DFGPermissions__c(Name='Param');

        initVisibilitySettings();

    }

    //сохранение настроек полномочий
    public void applyPermissionsSettings()
    { 
            upsert permissionsSettings;
    }

    //удаление настроек полномочий (Permissions Set's)
    public void delPermissionsSettings(){

        Batch_DFGAssignPermissions batch = new Batch_DFGAssignPermissions();
        String aQuery = 'select Id, Name, Country FROM User WHERE IsActive = TRUE and profile.UserLicense.Name = \'salesforce\'';
        batch.query = aQuery;
        batch.params = new Map<String, String>();

        batch.params.put('UserField__c',permissionsSettings.UserField__c);
        batch.params.put('SimpleAccess__c',permissionsSettings.SimpleAccess__c);
        batch.params.put('TokenizationAccess__c',permissionsSettings.TokenizationAccess__c); 

        batch.command = 'del';
        Id batchJobId = Database.executeBatch(batch, 200);


        if (DFGPermissions__c.getValues('Param') != null)
            delete DFGPermissions__c.getValues('Param');


        initPermissionsSettings();    


    }

    //метод устанавливает видимость для настроек полномочий (Permissions Set's)
    public void initVisibilitySettings(){

        if ( 
                (tokenSettings != null && tokenSettings.isLocalize__c != null && tokenSettings.isLocalize__c) 
                ||  
                (permissionsSettings != null && (permissionsSettings.UserField__c != null || permissionsSettings.SimpleAccess__c != null || permissionsSettings.TokenizationAccess__c != null)) 
            ) 
            showPermissionsSettings = '';
        else 
            showPermissionsSettings = 'none';

    }

    //инициализирует существующие настройки объекта и триггера
    public void initExistingSettings()
    {
        existSettingsObj = new Set<String>();
        existTriggerObj = new Set<String>();

        List<ObjectSettings__c> osList = ObjectSettings__c.getall().values();
        for (ObjectSettings__c setting: osList){
            existSettingsObj.add(setting.Name);
        } 

    }


    //инициализирует настройки токенизации
    public void initTokenSettings()
    {
        tokenSettings = TokenizationSettings__c.getValues('Param');
        if (tokenSettings == null) tokenSettings = new TokenizationSettings__c(Name='Param');

        if (tokenSettings.isUserProperty__c == true)
            selectedUserField = 'user';
        else if (tokenSettings.isUserProperty__c == false)
            selectedUserField = 'sobject';

        
        setDisplayProperties(tokenSettings);

    }

    //сохраняет настроки токенизации, а также устанавливает видимость полей
    public void applyTokenizationSettingsLocalization()
    { 
        if (tokenSettings.NameForTransaction__c == null)
            localizationError = true;

        /*if (tokenSettings != null && tokenSettings.isLocalize__c != null && tokenSettings.isLocalize__c ==false)
            tokenSettings.isUserProperty__c = false;*/

        if (selectedUserField == 'user' ) 
            tokenSettings.isUserProperty__c = true;
        else
            tokenSettings.isUserProperty__c = false;

        //else 
            upsert tokenSettings;
    }

    //метод устанавливает видимость полей
    //см. setDisplayStyle()   на странице
    public void setDisplayProperties(TokenizationSettings__c tokenSettings){
        if(tokenSettings != null){
            if (tokenSettings.isLocalize__c != null && tokenSettings.isLocalize__c == true){
                showField_for_localization = '';
                if (selectedUserField == 'sObject'){
                    showNameForLocalization = '';
                } else {
                    showNameForLocalization = 'none';
                }

            }
            else {
                showField_for_localization = 'none';
                showNameForLocalization = 'none';
            }

            if ((tokenSettings.isLocalize__c != null && tokenSettings.isLocalize__c == true)){
                showIsUserProperty = '';
            }
            else {
                showIsUserProperty = 'none';
            }

            if ((tokenSettings.isLocalize__c != null && tokenSettings.isLocalize__c == true) && selectedUserField == 'user' ){
                showSignLocalization = '';
            }
            else {
                showSignLocalization = 'none';
            }
        } else {
            showField_for_localization = 'none';
            showIsUserProperty = 'none';
            showSignLocalization = 'none';
        }
    }

    //сохранение настроек токенизации
    public void applyTokenizationSettings()
    {
        system.debug('tokenSettings = ' + tokenSettings);
        
        setDisplayProperties(tokenSettings);
        initVisibilitySettings();
        
        if (tokenSettings.NameForTransaction__c == null) {
              localizationError = true;
            String errorStr = Label.dfgSet_Error_EmptyField;
            if(language=='ru')
                errorStr += ' Имя для транзакции';
            else 
                errorStr +=  ' Name for transaktion';

              tokenSettings.addError(errorStr);
        }
           
        else {

            if (selectedUserField == 'user' ) 
                tokenSettings.isUserProperty__c = true;
            else
                tokenSettings.isUserProperty__c = false;
                
            upsert tokenSettings;
            localizationError = false;
        }
    }


    //метод инициализирует доступные объекты для триггера
    public List<SelectOption> getObjectOptionsTrigger()
    { 
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
        ObjectOptionsTrigger = new List<SelectOption>();
        
            for(Schema.SObjectType f : gd)
            {

                if (f.getDescribe().fields.getMap().keySet().contains('ownerid')){
                    if (!showOnlyExistTrigg)
                      ObjectOptionsTrigger.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel())); 
                    else 
                      if (existTriggerObj.contains(f.getDescribe().getName()))
                          ObjectOptionsTrigger.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel())); 
                }
            }  

        ObjectOptionsTrigger.sort(); 

        return ObjectOptionsTrigger;
    }
 

    //сохранение настроек триггера
    public void applyTriggerSettings()
    {
        //upsert triggerSetting;
        
        
        initExistingSettings();
        getObjectOptionsTrigger(); 
        
        changeObject();
    }

    //метод инициализирует доступные объекты для токенизации
    public List<SelectOption> getObjectOptionsObj()
    { 
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();     
        objectOptionsObj = new List<SelectOption>();
        
        for(Schema.SObjectType f : gd)
        {
            if (f.getDescribe().fields.getMap().keySet().contains('ownerid'))
                {
                   if (!showOnlyExistObj) 
                        objectOptionsObj.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel())); 
                    else 
                        if (existSettingsObj.contains(f.getDescribe().getName())) 
                            objectOptionsObj.add(new SelectOption(f.getDescribe().getName(),f.getDescribe().getLabel())); 
                }
        }  
        objectOptionsObj.sort(); 

        return objectOptionsObj;
    }
 //инициализирует SelectOptions для токенизируемых полей, которые будут отправляться в DFG
    public List<SelectOption> getFieldsNames()
    {

        Set<String> selectedOpt = new Set<String>();
        for (SelectOption opt: getFieldNamesForSelectedObject()){
            selectedOpt.add(opt.getValue());
        } 

        system.debug('in getFieldsName');
        fieldNames = new SelectOption[0];
        try{
            SObjectType sobjectType = Schema.getGlobalDescribe().get(selectedObject);//(selectedObject);
            Map<String,Schema.SObjectField> mfields = sobjectType.getDescribe().fields.getMap();

            for (Schema.SObjectField f: mfields.Values())
            {
                Schema.DescribeFieldResult DescField = f.getDescribe();
                if (!selectedOpt.contains(DescField.getName()) && DescField.isAccessible()) // && DescField.isCreateable()
                    fieldNames.add(new SelectOption(DescField.getName(), DescField.getLabel()));
            }
        } catch (Exception ex){system.debug('!!!Exception ' + ex);}

        System.debug('fieldNames.size = ' + fieldNames.size());

        fieldNames.sort();

        return fieldNames;
    }

    //инициализирует SelectOptions для нетокенизируемых полей, которые будут отправляться в DFG
    public List<SelectOption> getOpenFieldsNames()
    {
 
        Set<String> selectedOpt = new Set<String>();
        for (SelectOption opt: getOpenFieldNamesForSelectedObject()){
            selectedOpt.add(opt.getValue());
        } 
        
        
        system.debug('in getFieldsName');
        openFieldNames = new SelectOption[0];
        try{
            SObjectType sobjectType = Schema.getGlobalDescribe().get(selectedObjectTrigger);//(selectedObject);
            Map<String,Schema.SObjectField> mfields = sobjectType.getDescribe().fields.getMap();

            for (Schema.SObjectField f: mfields.Values())
            {
                Schema.DescribeFieldResult DescField = f.getDescribe();
                 if (!selectedOpt.contains(DescField.getName())) openFieldNames.add(new SelectOption(DescField.getName(), DescField.getLabel()));
            }
        } catch (Exception ex){system.debug('!!!Exception ' + ex);}
        
        System.debug('openFieldNames.size = ' + openFieldNames.size());
        return openFieldNames;
    }

    //инициализирует выбранные FieldNames для объекта
    public List<SelectOption> getFieldNamesForSelectedObject()
    {
        system.debug('in getFieldNamesForSelectedObject');
        if (selFieldNames == null){

            selFieldNames = new SelectOption[0]; 

           try 
            {
                String[] selectedFields = ObjectSettings__c.getValues(selectedObject).FieldName__c.replaceAll(' ','').split(',');
               
                if (ObjectSettings__c.getValues(selectedObject).FieldName2__c != null)
                    selectedFields.addAll(ObjectSettings__c.getValues(selectedObject).FieldName2__c.replaceAll(' ','').split(','));
                
        
                SObjectType sobjectType = Schema.getGlobalDescribe().get(selectedObject);
                Map<String,Schema.SObjectField> mfields = sobjectType.getDescribe().fields.getMap();
        
                for (Schema.SObjectField f: mfields.Values())
                {
                    Schema.DescribeFieldResult DescField = f.getDescribe();
                    for (String selFields: selectedFields)
                    {
                        if (selFields == DescField.getName()) selFieldNames.add(new SelectOption(DescField.getName(), DescField.getLabel()));
                    }
                    
                }
            } catch (Exception ex) {
                system.debug('Exception!!! ' + ex); //empty custom settings
            }
        }                      

        System.debug('fieldNames.size = ' + selFieldNames.size());
        return selFieldNames;
    }
    
    //инициализирует выбранные OpenFieldNames для объекта
    public List<SelectOption> getOpenFieldNamesForSelectedObject()
    {
        if (selOpenedFieldNames == null){
            system.debug('in getFieldNamesForSelectedObject');
            selOpenedFieldNames = new SelectOption[0];
        
           try 
            {
                String[] selectedFields = ObjectSettings__c.getValues(selectedObject).OpenfieldName__c.replaceAll(' ','').split(',');
                               
                if (ObjectSettings__c.getValues(selectedObject).OpenfieldName2__c != null)
                    selectedFields.addAll(ObjectSettings__c.getValues(selectedObject).OpenfieldName2__c.replaceAll(' ','').split(','));
                
                
        
                SObjectType sobjectType = Schema.getGlobalDescribe().get(selectedObject);
                Map<String,Schema.SObjectField> mfields = sobjectType.getDescribe().fields.getMap();
        
                for (Schema.SObjectField f: mfields.Values())
                {
                    Schema.DescribeFieldResult DescField = f.getDescribe();
                    for (String selFields: selectedFields)
                    {
                        if (selFields == DescField.getName()) selOpenedFieldNames.add(new SelectOption(DescField.getName(), DescField.getLabel()));
                    }
                    
                }
            } catch (Exception ex) {
                system.debug('Exception!!! ' + ex); //empty custom settings
            }
                              
        }
        System.debug('fieldNames.size = ' + selOpenedFieldNames.size());
        return selOpenedFieldNames;
    }
    

    //показывает выбранные записи для настроек объекта    
    public void showOnlySelectedObj()
    {
        System.debug('in showOnlySelectedObj');
    
    
        selFieldNames = null;
        selOpenedFieldNames = null;
        
        getObjectOptionsObj();
        if (objectOptionsObj.size() > 0) {
            selectedObject = objectOptionsObj.get(0).getValue();
            if (selectedObject != null)
                if (ObjectSettings__c.getValues(selectedObject) != null)
                    isActiveTrigger = ObjectSettings__c.getValues(selectedObject).Active__c;

            else 
                isActiveTrigger = false;
        }
        getFieldsNames();
        getOpenFieldsNames();
        getFieldNamesForSelectedObject();
        getOpenFieldNamesForSelectedObject(); 
    
    }
    

    //показывает выбранные записи для настроек триггера
     public void showOnlySelectedTrigg()
    {
        System.debug('in showOnlySelectedTrigg');

        getObjectOptionsTrigger();
        if (objectOptionsTrigger.size() >0) selectedObjectTrigger = objectOptionsTrigger.get(0).getValue();  
    
    }

    //вызывается при смене объекта (ObjectSettings), тащит его поля
    public void changeObject()
    {
        System.debug('in changeObject, selectedObject = ' + selectedObject);
        
        selFieldNames = null;
        selOpenedFieldNames = null;
        getFieldsNames();
        getOpenFieldsNames();
        getFieldNamesForSelectedObject();
        getOpenFieldNamesForSelectedObject();
        initIsActive();
    
    }

    public void initIsActive(){
        isActiveTrigger = false;
        try{
            isActiveTrigger = ObjectSettings__c.getValues(selectedObject).Active__c;
        } catch(Exception ex){System.debug('!!!Exception ' + ex);}
    }
    
    //удаляет настройки ObjectSettings для выбранного объекта
    public void delObjectSettings(){
        if (ObjectSettings__c.getValues(selectedObject) != null)
            delete  ObjectSettings__c.getValues(selectedObject);
        
        initExistingSettings();
        //showOnlyExistObj = false;
        getObjectOptionsObj();
        if (objectOptionsObj.size() > 0) {
            selectedObject = objectOptionsObj.get(0).getValue(); 
            isActiveTrigger = ObjectSettings__c.getValues(selectedObject).Active__c;
        }
        getFieldsNames();
        getOpenFieldsNames();
        getFieldNamesForSelectedObject();
        getOpenFieldNamesForSelectedObject();
        
        changeObject();
    }
    
    
    //удаляет настройки TriggerSettings для объекта
    public void delTriggerSettings(){ 
            
        initExistingSettings();
        showOnlyExistTrigg = false;
        getObjectOptionsTrigger();
        if (objectOptionsTrigger.size() >0) selectedObjectTrigger = objectOptionsTrigger.get(0).getValue();  
        
        changeObject();
    }
    
    
    //сохраняет настройки для ObjectSettings
    public void applyObjectSettings()
    {
        System.debug('in applyObjectSettings');
        
        ObjectSettings__c finalSett; 
        if (ObjectSettings__c.getValues(selectedObject) == null) 
        {
           finalSett = new ObjectSettings__c(); 
           finalSett.Name = selectedObject;   
        }
        else 
           finalSett = ObjectSettings__c.getValues(selectedObject);
         
        
        putFields(finalSett);

        upsert finalSett;
        system.debug('finalSett = ' + finalSett);
        
        
        initExistingSettings();
        getObjectOptionsObj();
        getFieldsNames();
        getOpenFieldsNames();
        getFieldNamesForSelectedObject();
        getOpenFieldNamesForSelectedObject();
    
    }

   //метод заполняет ObjectSettings__c полями, выбранными на странице 
    public void putFields(ObjectSettings__c finalSett){
        system.debug('in putFields');

        finalSett.Active__c =  isActiveTrigger;

        finalSett.FieldName__c = '';
        finalSett.FieldName2__c = '';
        finalSett.OpenfieldName__c = '';
        finalSett.OpenfieldName2__c = '';


        Integer fieldLenght = 0;
        for(SelectOption opt: selFieldNames){
            fieldLenght = fieldLenght + 1 + String.valueOf(opt.getValue()).length();
            if (fieldLenght < 255)
                finalSett.FieldName__c += opt.getValue() + ',';
            else 
                finalSett.FieldName2__c += opt.getValue() + ',';

        }   

        fieldLenght = 0;
        for(SelectOption opt: selOpenedFieldNames){
            fieldLenght = fieldLenght + 1 + String.valueOf(opt.getValue()).length();
            if (fieldLenght < 255)
                finalSett.OpenfieldName__c += opt.getValue() + ',';
            else 
                finalSett.OpenfieldName2__c += opt.getValue() + ',';
        } 
         

         finalSett.FieldName__c         = delComma(finalSett.FieldName__c);
         finalSett.FieldName2__c        = delComma(finalSett.FieldName2__c);
         finalSett.OpenfieldName__c     = delComma(finalSett.OpenfieldName__c);
         finalSett.OpenfieldName2__c    = delComma(finalSett.OpenfieldName2__c);

    }

    //удаляет запятые
    public string delComma(String field){ 
        system.debug('in delComma');

        if (field != null){
            if (field.length() >= 2) field = field.substring(0, field.length() - 1); 
        }

        return field;
    }
    

    //метод инициализирует основные настройки (endpoint, username, password) 
    public void getIntegrationSettings()
    {
        
        masterSett =  IntegrationSettingsMaster__c.getValues('Param'); 
        
        if (masterSett == null) { 
            masterSett = new IntegrationSettingsMaster__c();
            masterSett.Name = 'Param';
        } 

    }

    public void applyIntegrationSettings()
    {       
        upsert masterSett; 
        
    }
    
    public void empty(){
        system.debug('tokenSettings = ' + tokenSettings);
    }

    public void runAssigningBatch(){

        upsert permissionsSettings; 



        String aQuery = 'select Id, Name ';
        if (permissionsSettings.UserField__c != null) 
            aQuery +=  ', ' + permissionsSettings.UserField__c + ' '; 
        aQuery += ' FROM User WHERE IsActive = TRUE and profile.UserLicense.Name != \'Chatter Free\' and profile.UserLicense.Name != \'Salesforce Platform\' ';

        Batch_DFGAssignPermissions batch = new Batch_DFGAssignPermissions();
        batch.params = new Map<String, String>();

        batch.params.put('UserField__c',permissionsSettings.UserField__c);
        batch.params.put('SimpleAccess__c',permissionsSettings.SimpleAccess__c);
        batch.params.put('TokenizationAccess__c',permissionsSettings.TokenizationAccess__c);
        
        batch.query = aQuery;
        batch.command = 'add';
        if(!Test.isRunningTest()){
           Id batchJobId = Database.executeBatch(batch, 200);
        }
    }

}