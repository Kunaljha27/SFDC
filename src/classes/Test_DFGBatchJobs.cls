@isTest
public with sharing class Test_DFGBatchJobs{
public static testmethod void dotest(){
        DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests();

    ObjectSettings__c objSet = new  ObjectSettings__c();
    objSet.Name = 'Contact';
    objSet.FieldName__c = 'LastName,FirstName';
    objSet.Active__c = true;
    insert objSet;
            
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
        ts.isTokenization__c = false;
        
        ts.FieldForLocalizationLead__c = 'Ru';
        ts.NameForLocalizationLead__c = 'MailingCountry';
        
        ts.FieldForLocalizationAcc__c = 'Ru';
        ts.NameForLocalizationAccount__c = 'MailingCountry';
        
        ts.NameForTransaction__c = 'phone';
        insert ts; 
                
        List <Account> accounts = new List <Account>();
        Account acc = new Account();
        acc.Name = 'TestAcc';
        accounts.add(acc);
        insert accounts;
    
        Contact contact = new Contact();
        contact.FirstName='$TestName$';
        contact.LastName = '$LastName$';
        contact.AccountId = accounts[0].id;
        contact.put(ts.FieldForLocalization__c, 'Ru'); 
        contact.phone = '1234';      
        insert contact;
        
        Test.startTest();
        mock.createTokenResponse();
        Test.setMock(HttpCalloutMock.class, mock);      
        mock.createTokenResponse();
        Batch_ObjectSendToCrypto c = new Batch_ObjectSendToCrypto('Contact');
        Database.executeBatch(c);
        
        DFGBatchJobs bj=new DFGBatchJobs();
        
        bj.getHasBatches();
        bj.getBatchJobs();
        system.assertequals(bj.hasJobs, false);  

        Test.stopTest();
}

public static testmethod void dotest2(){
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
        ts.isLocalize__c = true;
        ts.SignLocalization__c = 'Ru';
        ts.NameForTransaction__c = 'SysDFG__c';
        insert ts;         
        
        List <Account> accounts = new List <Account>();
        Account acc = new Account();
        acc.Name = 'TestAcc';
        accounts.add(acc);
        insert accounts;
    
        Contact contact = new Contact();
        contact.FirstName='TestName';
        contact.LastName = 'LastName';
        contact.AccountId = accounts[0].id;
        contact.put(ts.FieldForLocalization__c, 'Ru');      
        insert contact;
        
        Test.startTest();
        mock.createTokenResponse();
        Test.setMock(HttpCalloutMock.class, mock);      
        mock.createTokenResponse();
        Batch_ObjectSendToCrypto c = new Batch_ObjectSendToCrypto('Contact');
        Database.executeBatch(c);
        
        DFGBatchJobs bj=new DFGBatchJobs();
        
        bj.getHasBatches();
        bj.getBatchJobs();
        system.assertequals(bj.hasJobs, false);  
 
        DFGBatchJobs bj2 =new DFGBatchJobs();
        bj2.bulkClassName = 'Batch_ObjectSendToCrypto';
        bj2.getBatchJobs();
        bj2.getHasBatches();


        Test.stopTest();
}
}