@isTest(SeeAllData=false)
private class Test_Batch_DFGAssignnPermissions {
    
    public static testmethod void test_method_one() {


        Test.startTest();

        String aQuery = 'select Id, Name, Country FROM User WHERE (FirstName = \'russia12\' or FirstName = \'usa123\')';
        Batch_DFGAssignPermissions batch = new Batch_DFGAssignPermissions();
        batch.query = aQuery;
        batch.command = 'add';


        Id batchJobId;
        List<AsyncApexJob> numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        
        /*system.debug('step 1');
        if(numBatchJobs.isEmpty()){
          batchJobId = Database.executeBatch(batch, 2);
          system.assertequals(batch.command,'add');
        }  */      

        system.debug('numBatchJobs = ' + numBatchJobs + ';step 2');
        
        batch.params = new Map<String,String>();
        batch.params.put('UserField__c', 'Country');
        batch.params.put('SimpleAccess__c','DFGPermissionsOther');
        batch.params.put('TokenizationAccess__c','DFGPermissionsRus');
        
        numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        if(numBatchJobs.isEmpty()){
           batchJobId = Database.executeBatch(batch, 2);
        }
        
        system.debug('numBatchJobs = ' + numBatchJobs + '; step 3');


        DFGPermissions__c permissionsSettings = new DFGPermissions__c(name='Param',UserField__c = 'Country', TokenizationAccess__c='DFGPermissionsRus', SimpleAccess__c='DFGPermissionsOther');
        insert permissionsSettings;

        TokenizationSettings__c tokenSettings = new TokenizationSettings__c(name='Param',SignLocalization__c='Russia');
        insert tokenSettings;


        numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        if(numBatchJobs.isEmpty()){
          batchJobId = Database.executeBatch(batch, 2);
        }  
        
        system.debug('numBatchJobs = ' + numBatchJobs + ';step 4');
        
        batch.command = 'del';      
        
        numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        if(numBatchJobs.isEmpty()){
          batchJobId = Database.executeBatch(batch, 2);
        }
        
        Test.stopTest();

    } 

    public static testmethod void test_method_two() {

        Test.startTest();

        String aQuery = 'select Id, Name, Country FROM User WHERE (FirstName = \'russia12\' or FirstName = \'usa123\')';
        Batch_DFGAssignPermissions batch = new Batch_DFGAssignPermissions();
        batch.query = aQuery;
        batch.command = 'del';


        Id batchJobId;
        List<AsyncApexJob> numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        
        batch.params = new Map<String,String>();
        batch.params.put('UserField__c', 'Country');
        batch.params.put('SimpleAccess__c','DFGPermissionsOther');
        batch.params.put('TokenizationAccess__c','DFGPermissionsRus');
        DFGPermissions__c permissionsSettings = new DFGPermissions__c(name='Param',UserField__c = 'Country', TokenizationAccess__c='DFGPermissionsRus', SimpleAccess__c='DFGPermissionsOther');
        insert permissionsSettings; 
        TokenizationSettings__c tokenSettings = new TokenizationSettings__c(name='Param',SignLocalization__c='Russia');
        insert tokenSettings;
        
        numBatchJobs = [SELECT Id, Status FROM AsyncApexJob WHERE (Status = 'Queued' OR Status = 'Processing') and ApexClass.Name = 'Batch_DFGAssignPermissions'];
        if(numBatchJobs.isEmpty()){
           batchJobId = Database.executeBatch(batch, 2);
        }
        
        Test.stopTest();

    } 

    @testSetup static void setup() { 
        Profile platformUser = [select id from Profile where Name = 'Standard Platform User'];
        User templateUser = [select id, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey from User limit 1];
        User testUser_RU =  new User(
                                FirstName = 'russia12',
                                LastName = 'russia12',
                                Email = 'russia@test.com',
                                Username = 'russia@test.com',
                                ProfileId = platformUser.Id,
                                Country = 'Russia',
                                Alias = 'russia12'.substring(0,5),
                                CommunityNickname = 'russia12'.substring(0,5), 
                                TimeZoneSidKey=templateUser.TimeZoneSidKey,
                                LocaleSidKey=templateUser.LocaleSidKey,
                                EmailEncodingKey=templateUser.EmailEncodingKey,
                                LanguageLocaleKey=templateUser.LanguageLocaleKey 
                                );
        insert testUser_RU;


        User testUser_USA =  new User(
                                    FirstName = 'usa123',
                                    LastName = 'usa123',
                                    Email = 'usa123@test.com',
                                    Username = 'usa123@test.com',
                                    ProfileId = platformUser.Id,
                                    Country = 'usa123',
                                    Alias = 'usa123'.substring(0,5),
                                    CommunityNickname = 'usa123'.substring(0,5), 
                                    TimeZoneSidKey=templateUser.TimeZoneSidKey,
                                    LocaleSidKey=templateUser.LocaleSidKey,
                                    EmailEncodingKey=templateUser.EmailEncodingKey,
                                    LanguageLocaleKey=templateUser.LanguageLocaleKey 
                                    );
        insert testUser_USA;

    }
 
}