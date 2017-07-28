@isTest
global class Test_TriggerHelperD {
  
  public static testmethod void dotest(){
      Test.startTest();
      

        TriggerHelperD.checkPersonalRFBefore(new Contact(FirstName='n$ame$',LastName='rf'), new Set<String> {'LastName'}, 'RF', new Contact(LastName='rf'));
        
        TriggerHelperD.checkNotRFAfter(new Contact(FirstName='n$ame$',LastName='rf'), 
                                       new Set<String> {'LastName'}, 
                                       'RF', 
                                       new Contact(LastName='canada')
        );
        
        TriggerHelperD.checkNotRFAfter(new Contact(FirstName='n$ame$',LastName='bbb'), 
                                       new Set<String> {'LastName'}, 
                                       'RF', 
                                       new Contact(LastName='rf')
        );

        TriggerHelperD.checkNotRFAfter(new Contact(FirstName='n$ame$'), 
                                       new Set<String> {'LastName'}, 
                                       'rf', 
                                       new Contact(LastName='rf')
        );

        TriggerHelperD.checkNotRFAfter(new Contact(FirstName='n$ame$',LastName='rf'), 
                                       new Set<String> {'LastName'}, 
                                       'rf', 
                                       new Contact(FirstName='n$ame$')
        );
        

        Boolean result = TriggerHelperD.checkBoolean(new User(isActive=TRUE), new Set<String>{'isActive'});
       
        system.debug('result = ' + result);
        System.assertEquals(true, result);
        Test.stopTest();
  

  }


  public static testmethod void dotest2(){
      Test.startTest();

      Boolean result = TriggerHelperD.checkBoolean(new User(isActive=TRUE), new Set<String>{'isActive'});
       
      system.debug('result = ' + result);
      System.assertEquals(true, result);
      Test.stopTest();
  }

  public static testmethod void convertingTest(){

        IntegrationSettingsMaster__c dfgIs =  new IntegrationSettingsMaster__c();  
        dfgIs.Name = 'Param';
        dfgIs.EndPoint__c='https://app.dfg152.ru:7084/dfg-test';
        dfgIs.UserName__c ='user';
        dfgIS.Password__c='user';   
        insert dfgIs;
        DFG_HTTPMocksForTests mock = new DFG_HTTPMocksForTests(); 
        mock.createTokenResponse();
        Test.setMock(HttpCalloutMock.class, mock);
 
        TokenizationSettings__c ts = new TokenizationSettings__c(Name='Param'); 
        ts.CheckToken__c = true; 
        ts.isLocalize__c = true;
        ts.FieldForLocalization__c = 'DFGLocal__c';
        ts.NameForLocalization__c = 'ru';
        ts.SignLocalization__c = 'Country';
        ts.NameForTransaction__c = 'DFGTransactionId__c';
        ts.isTokenization__c = true;
        ts.FieldForLocalizationLead__c = 'Country';
        ts.NameForLocalizationLead__c = 'ru'; 
        ts.IsUserProperty__c = true;
        insert ts;   

        ObjectSettings__c objSet = new  ObjectSettings__c(Name = 'Lead',FieldName__c = 'LastName,FirstName',Active__c = true);
        insert objSet; 

        Lead testLead = new Lead(FirstName='t$Test First$',LastName='t$Test Last$',Company='Test Co',Country='ru');
        insert testLead;
        Id leadId = testLead.Id;    
        Account acc = new Account(Name='t$Test First$');  
        insert acc;
        Contact contact = new Contact(FirstName='t$Test First$',LastName='t$Test Last$');
        contact.AccountId = acc.id;        
        contact.put(ts.FieldForLocalization__c, 'ru');      
        insert contact;

        test.startTest();
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(testLead.id);
        lc.setContactId(contact.id);
        lc.setAccountId(acc.id);
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
        try{
            lc.setConvertedStatus(convertStatus.MasterLabel);
            Database.LeadConvertResult lcr = Database.convertLead(lc); //expecting error 
        }catch(Exception ex){
            system.debug('ex :' + ex);
        }


        /*другое условие (isUserProperty__c = false) */
        ts.isUserProperty__c = false;
        update ts;

        Lead testLead2 = new Lead(FirstName='t$Test First2$',LastName='t$Test Last2$',Company='Test Co2',Country='ru');
        insert testLead2;   
        Account acc2 = new Account(Name='t$Test First2$');  
        insert acc2;
        Contact contact2 = new Contact(FirstName='t$Test First2$',LastName='t$Test Last2$');
        contact2.AccountId = acc2.id;        
        contact2.put(ts.FieldForLocalization__c, 'ru');      
        insert contact2;
 
        Database.LeadConvert lc2 = new database.LeadConvert();
        lc2.setLeadId(testLead2.id);
        lc2.setContactId(contact2.id);
        lc2.setAccountId(acc2.id);
        try{
            lc2.setConvertedStatus(convertStatus.MasterLabel);
            Database.LeadConvertResult lcr2 = Database.convertLead(lc2); //expecting error 
        }catch(Exception ex2){
            system.debug('ex2 :' + ex2);
        }

        test.stopTest();

  }

    public static testmethod void Test_CheckToken(){

        TokenizationSettings__c ts = new TokenizationSettings__c(Name='Param'); 
        ts.IsTokenization__c = true;
        ts.IsLocalize__c = true;
        ts.CheckToken__c = true; 
        ts.FieldForLocalization__c = 'Description';
        ts.NameForLocalization__c = 'ru';
        ts.SignLocalization__c = 'Description';
        ts.NameForTransaction__c = 'DFGTransactionId__c';
        ts.FieldForLocalizationLead__c = 'Description';
        ts.NameForLocalizationLead__c = 'ru'; 
        ts.IsUserProperty__c = true;
        insert ts;   

        ObjectSettings__c oSettings = new ObjectSettings__c(name='Contact',FieldName__c='FirstName,LastName', Active__c=true);
        insert oSettings;

        Contact con = new Contact(FirstName='a$test$', LastName='b$test$', Description ='ru');
        insert con; 
 
        test.startTest();
        con.FirstName = 'r$newName$';
        con.Description = 'usa';
        try { 
            update con;
        } catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains(Label.DFG_Plugin_Error) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 

        ts.IsTokenization__c = false;
        update ts;

        TriggerHelperD.isFirstRun = true;
        con.FirstName = 'r$newNameAgain$';
        con.Description = 'ru'; 
        update con;


        system.debug('Меняем страну без плагина, токенизация есть, локализация по записи');
        TriggerHelperD.isFirstRun = true;
        ts.IsTokenization__c = true;
        ts.IsUserProperty__c = false;
        update ts;

        con.Description = 'usa';
        try { 
            update con;
        } catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains(Label.DFG_Plugin_Error) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 


        TriggerHelperD.isFirstRun = true;
        ts.IsTokenization__c = false;
        update ts; 
        con.FirstName = 'b$again123';
        con.Description = 'ru';
        try { 
            update con;
        } catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains(Label.DFG_Plugin_Error) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 


        ts.IsLocalize__c = false;
        ts.IsTokenization__c = true;
        update ts;

        system.debug('токенизация без локализации');
        TriggerHelperD.isFirstRun = true;
        con.FirstName = 'a$12asdf33$'; 
        update con;
 

        system.debug('без токенизации и без локализации');
        TriggerHelperD.isFirstRun = true;
        ts.IsLocalize__c = false;
        ts.IsTokenization__c = false;
        update ts;

        con.FirstName = 'f$asdf$';
        try { 
            update con;  
        } catch(Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains(Label.DFG_Plugin_Error) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 

        //TriggerHelperD.CheckToken(accList, 'Account', mapka);

        
        test.stopTest();

    }

}