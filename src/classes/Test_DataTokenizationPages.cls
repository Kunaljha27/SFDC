@isTest
private class Test_DataTokenizationPages {
    
    public static testmethod void test_dataTokenization(){

        ObjectSettings__c objSet = new  ObjectSettings__c();
        objSet.Name = 'Contact';
        objSet.FieldName__c = 'LastName,FirstName';
        objSet.Active__c = true;
        insert objSet;


        DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests();

        IntegrationSettingsMaster__c dfgIS =  new IntegrationSettingsMaster__c();
        dfgIs.Name = 'Param';
        dfgIs.EndPoint__c='https://app.dfg152.ru:7084/dfg-test';
        dfgIs.UserName__c ='user';
        dfgIS.Password__c='user';
        insert dfgIs; 

        TokenizationSettings__c ts = new TokenizationSettings__c();
        ts.Name = 'Param';
        ts.CheckToken__c = true;
        ts.FieldForLocalization__c = 'DFGLocal__c';
        ts.NameForLocalization__c = '';
        
        ts.isLocalize__c = true;
        ts.SignLocalization__c = 'Ru';
        ts.NameForTransaction__c = 'MailingCountry';
        ts.isTokenization__c = true;
        
        ts.FieldForLocalizationLead__c = 'Name';
        ts.NameForLocalizationLead__c = 'MailingCountry';
        
        ts.FieldForLocalizationAcc__c = 'Name';
        ts.NameForLocalizationAccount__c = 'MailingCountry';
        insert ts; 
         
        List <Account> accounts = new List <Account>();
        Account acc = new Account();
        acc.Name = 't$TestAcc$';
        accounts.add(acc);
        insert accounts;

        Contact contact = new Contact();
        contact.FirstName='t$TestName$';
        contact.LastName = 'l$LastName$';
        contact.AccountId = accounts[0].id;        
        contact.put(ts.FieldForLocalization__c, 'Ru');      
        insert contact;

        Test.startTest();

        mock.createTokenResponse();
        Test.setMock(HttpCalloutMock.class, mock);      
        mock.createTokenResponse();
        DataTokenizationController dtc = new DataTokenizationController();
        dtc.language='ru';
        dtc.loadBulkProcess();
        dtc.selectedObject = 'Account'; 
        dtc.empty();
        dtc.runBulk();
        dtc.getSOList();
        dtc.getBulkSizeOptions();


        String key  = new List<string>(dtc.bulkJobMap.keySet())[0];

        DataTokenizationController.BulkJobWrapper job = dtc.bulkJobMap.get(key);
        ApexPages.currentPage().getParameters().put('bulkType', job.name);
        dtc.runBulk();
        dtc.getIsProcess(null);
        dtc.getIsProcess(job.name);
        dtc.language='ru';
        job.language='ru'; 
        dtc.getErrors(); 
        job.getProcessInfo();
        job.getIsProcess();

        dtc.language='en_US';
        job.language='en_US';
        dtc.getErrors();
        job.getProcessInfo();
        job.getIsProcess();

        dtc = new DataTokenizationController();
        dtc.language='en_US';
        dtc.loadBulkProcess();
        system.debug('!!!!! bulkJobMap = ' + dtc.bulkJobMap);
        key  = new List<string>(dtc.bulkJobMap.keySet())[0];
        job = dtc.bulkJobMap.get(key);
        job.getProcessInfo();

        dtc = new DataTokenizationController();
        dtc.language='ru';
        dtc.loadBulkProcess();
        system.debug('!!!!! bulkJobMap = ' + dtc.bulkJobMap);
        key  = new List<string>(dtc.bulkJobMap.keySet())[0];
        job = dtc.bulkJobMap.get(key);
        job.language = 'ru';
        job.getProcessInfo();



        dtc.bulkClassName = 'aaa';
        dtc.gotoErrors();
        Test.stopTest(); 

    }
    

    public static testmethod void test_dataDeTokenization(){ 
        TokenizationSettings__c ts = new TokenizationSettings__c();
        ts.Name = 'Param';
        insert ts;
        
        ObjectSettings__c objSet = new  ObjectSettings__c();
        objSet.Name = 'Account';
        objSet.FieldName__c = 'LastName,FirstName';
        objSet.Active__c = true;
        insert objSet;

        DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests();

        IntegrationSettingsMaster__c dfgIS =  new IntegrationSettingsMaster__c();
        dfgIs.Name = 'Param';
        dfgIs.EndPoint__c='https://app.dfg152.ru:7084/dfg-test';
        dfgIs.UserName__c ='user';
        dfgIS.Password__c='user';
        insert dfgIs; 


        List <Account> accounts = new List <Account>();
        Account acc = new Account();
        acc.Name = 's$TestAcc$';
        accounts.add(acc);
        insert accounts;

        Contact contact = new Contact();
        contact.FirstName='f$TestName$';
        contact.LastName = 's$LastName$';
        contact.AccountId = accounts[0].id;
        insert contact;

        Test.startTest();
        mock.createTokenResponse();
        Test.setMock(HttpCalloutMock.class, mock);      
        mock.createTokenResponse();


        DataDeTokenizationController dtc = new DataDeTokenizationController();
        dtc.language='ru';
        dtc.loadBulkProcess();
        dtc.selectedObject = 'Account'; 
        dtc.empty();
        dtc.runBulk();
        dtc.getSOList();
        dtc.getBulkSizeOptions();


        String key  = new List<string>(dtc.bulkJobMap.keySet())[0];

        /*AsyncApexJob job = new AsyncApexJob();
        Batch_ObjectGetCrypto b=new Batch_ObjectGetCrypto('Contact');*/
        DataDeTokenizationController.BulkJobWrapper job = dtc.bulkJobMap.get(key);
        ApexPages.currentPage().getParameters().put('bulkType', job.name);
        dtc.runBulk();
        dtc.getIsProcess(null);
        dtc.getIsProcess(job.name);
        dtc.language='ru';
        job.language='ru'; 
        job.getProcessInfo();
        job.getIsProcess();
        dtc.getErrors();
        
        dtc.language='en_US';
        job.language='en_US';
        job.getProcessInfo();
        job.getIsProcess();
        dtc.getErrors();
        

        dtc = new DataDeTokenizationController();
        dtc.language='en_US';
        dtc.loadBulkProcess();
        system.debug('!!!!! bulkJobMap = ' + dtc.bulkJobMap);
        key  = new List<string>(dtc.bulkJobMap.keySet())[0];
        job = dtc.bulkJobMap.get(key);
        job.getProcessInfo();

        dtc = new DataDeTokenizationController();
        dtc.language='ru';
        dtc.loadBulkProcess();
        system.debug('!!!!! bulkJobMap = ' + dtc.bulkJobMap);
        key  = new List<string>(dtc.bulkJobMap.keySet())[0];
        job = dtc.bulkJobMap.get(key);
        job.language = 'ru';
        job.getProcessInfo();



        /*DataDeTokenizationController.BulkJobWrapper blop = new DataDeTokenizationController.BulkJobWrapper('Batch_ObjectGetCrypto', job, 'Bulk tokenization of personal data in contact records', 'Records in DB will be tokenized after launch tokenization. The process can take a long time.','1');
        blop.run('Contact');
        dtc.loadBulkProcess();
        dtc.getIsProcess('Batch_ObjectGetCrypto');*/






        dtc.bulkClassName = 'Account';
        dtc.gotoErrors();
        Test.stopTest();
        system.debug('AAAA '+[SELECT Id, LastName From Contact where id=:contact.id]);
    }

}