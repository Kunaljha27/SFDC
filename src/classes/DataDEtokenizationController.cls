public with sharing class DataDEtokenizationController {
    public String bulkClassName {get; set;}
    public Map<String, AsyncApexJob > bulkProcess;
    public Map<String, BulkJobWrapper> bulkJobMap {get; set;}
    public String language =  [SELECT LanguageLocaleKey  FROM User Where id=: userinfo.getUserId()][0].LanguageLocaleKey;
 
    public String selectedObject {get;set;} 
    public String selectedBulkSize {get;set;}
    public boolean showErrors {get;set;}
 
   
    public List<SelectOption> getSOList() {
    
        List<SelectOption> soList = new List<SelectOption>();
        soList.add(new SelectOption('','-None-'));
        List<ObjectSettings__c> objSettings =  ObjectSettings__c.getall().values();
        
        if (objSettings!=null && !objSettings.IsEmpty()) {
            for(ObjectSettings__c setting: objSettings){
                soList.add(new SelectOption(setting.Name,setting.Name));
            }
        }
 
        return soList;
    }

    public List<SelectOption> getBulkSizeOptions() {
    
        List<SelectOption> BulkSizeOptions = new List<SelectOption>();
        BulkSizeOptions.add(new SelectOption('1','1'));
        BulkSizeOptions.add(new SelectOption('10','10'));
        BulkSizeOptions.add(new SelectOption('50','50'));
        BulkSizeOptions.add(new SelectOption('100','100')); 
        BulkSizeOptions.add(new SelectOption('200','200'));
        //BulkSizeOptions.add(new SelectOption('5000','5000')); 
 
        
        return BulkSizeOptions;
    }


    @testvisible
    class BulkJobWrapper {
        public AsyncApexJob job {get; set; }
        public String name {get; private set;}
        public String title {get; set; }
        public String description {get; set;}
        public Integer bulkSize {get;set;}
        public Integer errorsCount {get;set;}
        public Boolean showErrors {get;set;}
        //public String language{get;set;}
        public String  language = [SELECT LanguageLocaleKey  FROM User Where id=: userinfo.getUserId()][0].LanguageLocaleKey;
        public BulkJobWrapper(String aName, AsyncApexJob aJob, String aTitle, String aDescription, String aSelectedBulkSize, Boolean aShowErrors) {
        system.debug('ajob '+ajob);
        system.debug('aName '+aName);
        system.debug('aTitle '+aTitle);
        system.debug('aDescription '+aDescription);
        
            job = aJob;
            name = aName;
            title = aTitle;
            description = aDescription;
            if (aSelectedBulkSize != null) bulkSize = Integer.valueOf(aSelectedBulkSize);
            else bulkSize = 1; 
            showErrors = aShowErrors;

        }
        
       @testVisible
        public String getProcessInfo() {
            String result = '';
            system.debug('language '+language);
            if(language=='ru'){
            if (job != null) {                 
                result += '<span><b>Начато:</b> ' + job.CreatedDate.format() + '</span><br/>';
                if (job.CompletedDate != null) {
                    result += '<span><b>Выполнено:</b> ' + job.CompletedDate.format() + '</span><br/>'; 
                } else {
                    result += '<span><b>Выполнено:</b> -</span><br/>';
                }           
                result += '<span><b>Запустил(а):</b> ' + job.CreatedBy.Name + '</span><br/>';
                result += '<span><b>Обработано:</b> ' + job.JobItemsProcessed + ' из ' + job.TotalJobItems + ' заданий' + '</span><br/>';
                //result += '<span><b>Обработано с ошибкой:</b> ' + job.NumberOfErrors + '</span><br/>';
                result += '<span><b>Статус:</b> ' + job.Status + '</span><br/>';
                /*if (job.ExtendedStatus == null) {
                    result += '<span><b>Текст последней ошибки:</b> -</span>';
                } else {
                    result += '<span><b>Текст последней ошибки:</b> ' + job.ExtendedStatus + '</span>';
                }*/
            }
            }else{
                if (job != null) {                 
                if (Test.isRunningTest()) result += '<span><b>Started:</b> ' + job.CreatedDate.format() + '</span><br/>';
                if (job.CompletedDate != null) {
                    result += '<span><b>Completed:</b> ' + job.CompletedDate.format() + '</span><br/>'; 
                } else {
                    result += '<span><b>Completed:</b> -</span><br/>';
                }           
                result += '<span><b>Submitted by :</b> ' + job.CreatedBy.Name + '</span><br/>';
                result += '<span><b>Batches Processed:</b> ' + job.JobItemsProcessed + ' out of ' + job.TotalJobItems + ' batches' + '</span><br/>';
                //result += '<span><b>Failures:</b> ' + job.NumberOfErrors + '</span><br/>';
                result += '<span><b>Status:</b> ' + job.Status + '</span><br/>';
                /*if (job.ExtendedStatus == null) {
                    result += '<span><b>Last error details:</b> -</span>';
                } else {
                    result += '<span><b>Last error details:</b> ' + job.ExtendedStatus + '</span>';
                }*/
            }
                
            }
            
            return result;
        }   
        
       @testvisible public Boolean getIsProcess() {
            if (job != null
                    && (job.Status == 'Processing'
                        || job.Status == 'Queued')) {
                return true;
            } else {
                return false;
            }
        }
        
      @testvisible  public void run(String selectedObj) {
            if (name == 'Batch_ObjectGetCrypto') {
            system.debug('str103 showErrors = ' + showErrors );
                Batch_ObjectGetCrypto bc = new Batch_ObjectGetCrypto(selectedObj);
                bc.SObjectName = selectedObj;
                bc.showErrors = showErrors;
                database.executeBatch(bc, bulkSize);
                        
            }       
        }
    }
    
    @testVisible
    private void loadBulkProcess() {
        bulkJobMap = new Map<String, BulkJobWrapper>();
        if(language=='ru'){
        bulkJobMap.put('Batch_ObjectGetCrypto', 
            new BulkJobWrapper('Batch_ObjectGetCrypto'
                , null
                , 'Пакетное детокенизирование персональных данных на записях  выбранного объекта'
                , 'При запуске функционала детокенизации, записи в бд будут токенизированы. Процесс может занять продолжительное время.'
                ,selectedBulkSize
                ,showErrors));
    }else{
        bulkJobMap.put('Batch_ObjectGetCrypto', 
            new BulkJobWrapper('Batch_ObjectGetCrypto'
                , null
                , 'Bulk de-tokenization of personal data in records of selected object'
                , 'Records in DB will be de-tokenized after launch tokenization. The process can take a long time.'
                ,selectedBulkSize
                ,showErrors));
        
    }                                          
        bulkProcess = new Map<String, AsyncApexJob >();
        bulkProcess.put('Batch_ObjectGetCrypto', null);
        
        AggregateResult[] groupedResults = [SELECT ApexClass.Name, Max(CreatedDate) 
                                              FROM AsyncApexJob 
                                             where ApexClass.Name = :bulkProcess.keySet() 
                                               and JobType = 'BatchApex'
                                             group by ApexClass.Name ];
        
        Map<String, Datetime> maxDates = new Map<String, Datetime>();
        for (AggregateResult ar : groupedResults)  {            
            maxDates.put((String)ar.get('Name'), (Datetime)ar.get('expr0'));
        }
        
        List<AsyncApexJob> jobs = [select TotalJobItems, JobItemsProcessed, Status, NumberOfErrors, 
                                          CreatedDate, CreatedBy.Name, CompletedDate, ExtendedStatus, ApexClass.Name
                                     from AsyncApexJob
                                    where ApexClass.Name in :bulkProcess.keySet() 
                                      and CreatedDate in :maxDates.values()
                                      and JobType = 'BatchApex'];   
                                    
        for(AsyncApexJob job : jobs) {
            if (maxDates.containsKey(job.ApexClass.Name) && maxDates.get(job.ApexClass.Name) == job.CreatedDate) {
                bulkProcess.put(job.ApexClass.Name, job);
                bulkJobMap.get(job.ApexClass.Name).job = job;
            } 
        }
    }   

    public DataDEtokenizationController(){
        showErrors = true;
        loadBulkProcess();       
    }


    
    public Boolean getIsProcess(String bulkName) {
        if (bulkProcess.containsKey(bulkName) 
                && bulkProcess.get(bulkName) != null
                && (bulkProcess.get(bulkName).Status == 'Processing'
                    || bulkProcess.get(bulkName).Status == 'Queued')) {
            return true;
        } else {
            return false;
        }
    }
    
    public Pagereference runBulk() {

        delete [select id from DFGError__c where Type__c = 'detokenization' and sObjectType__c =: selectedObject];

        try {
            String bulkType = apexpages.currentpage().getparameters().get('bulkType');
            bulkJobMap.get(bulkType).showErrors = showErrors;
            system.debug('bulkJobMap.get(bulkType).showErrors: ' + bulkJobMap.get(bulkType).showErrors);
            bulkJobMap.get(bulkType).run(selectedObject);
            loadBulkProcess();
            return null;
        } catch (exception e){
            Apexpages.Message msg = new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getMessage());
            Apexpages.addMessage(msg);
            return null;
        }
    }

    public void empty(){
        system.debug('in empty! selectedObject: ' + selectedObject);
        system.debug('electedBulkSize: ' + selectedBulkSize);
        system.debug('showErrors: ' + showErrors);
    }

    public PageReference gotoErrors(){
        PageReference ref = new PageReference('/apex/ErrorsD');//?SelectedObject='+selectedObject+'&OperType=' + 'detokenization');
        ref.setRedirect(true);
        return ref;
    }

    public String getErrors(){
        Integer errors = 0; 
        String result;
        if ( selectedObject == '' ) return result;

        String query = 'select count() from DFGError__c where Type__c = \'detokenization\' and sObjectType__c =: selectedObject';
        errors = Database.countquery(query);  

        List<DFGError__c> errorList = [select id, Message__c from DFGError__c
         where Type__c = 'detokenization'  
         and sObjectType__c =: selectedObject
         order by CreatedDate DESC limit 1];

        
        if (language=='ru'){
            result ='<apex><b>Обработано с ошибкой:</b>' + errors;
            if (errorList != null && !errorList.isEmpty()) 
                result += '<br/><span><b>Текст последней ошибки:</b>' + errorList.get(0).Message__c + ' </span>';
        } else {
            result ='<apex><b>Failures:</b>' + errors;
            if (errorList != null && !errorList.isEmpty()) 
                result += '<br/><span><b>Last error details:</b>' + errorList.get(0).Message__c + ' </span>';
        }


        return result;
    }
}