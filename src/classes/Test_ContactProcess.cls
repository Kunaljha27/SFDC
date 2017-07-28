@isTest
global class Test_ContactProcess{
    public static testmethod void dotest(){
    	
    ObjectSettings__c objSetCon = new  ObjectSettings__c();
    objSetCon.Name = 'Contact';
    objSetCon.FieldName__c = 'LastName,FirstName';
    objSetCon.Active__c = true;
    insert objSetCon;

    ObjectSettings__c objSetAcc = new  ObjectSettings__c();
    objSetAcc.Name = 'Account';
    objSetAcc.FieldName__c = 'LastName,FirstName';
    objSetAcc.Active__c = true;
    insert objSetAcc;

    ObjectSettings__c objSetLead = new  ObjectSettings__c();
    objSetLead.Name = 'Lead';
    objSetLead.FieldName__c = 'LastName,FirstName';
    objSetLead.Active__c = true;
    insert objSetLead;

    TokenizationSettings__c ts = new TokenizationSettings__c();
    ts.Name = 'Param';
    ts.CheckToken__c = true;
    ts.FieldForLocalization__c = 'DFGLocal__c';
    ts.NameForLocalization__c = '';
    
    ts.isLocalize__c = true;
    ts.SignLocalization__c = 'Ru';
    ts.NameForTransaction__c = 'DFGTransactionId__c';
    ts.isTokenization__c = true;
    
    ts.FieldForLocalizationLead__c = 'Ru';
    ts.NameForLocalizationLead__c = 'DFGTransactionId__c';
    
    ts.FieldForLocalizationAcc__c = 'Ru';
    ts.NameForLocalizationAccount__c = 'DFGTransactionId__c';
    insert ts; 
            
    List <Account> accounts = new List <Account>();
    Account acc = new Account();
    acc.Name = 's$TestAcc$';
    accounts.add(acc); 
    insert accounts;
    accounts.get(0).Name = 's$edited$';
    update accounts;

    Lead lead = new Lead();
    lead.FirstName='f$TestName$';
    lead.LastName = 's$LastName$';
    lead.Company = 'Company';
    insert lead;
    lead.Description = 'Desc';
    update lead;
    
    Contact contact = new Contact();
    contact.FirstName='f$TestName$';
    contact.LastName = 's$LastName$';
    contact.AccountId = accounts[0].id;
    insert contact;
    contact.Description = 'Desc';
    update contact;
    List <Contact> cons = [Select Id, FirstName, LastName from Contact where id=:contact.id];
    system.debug('Con '+cons[0]);
    system.assertequals(cons[0].FirstName,'f$TestName$');
    
    system.assertequals(cons[0].LastName,'s$LastName$');
    }
}