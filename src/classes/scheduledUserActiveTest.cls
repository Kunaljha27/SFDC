@isTest(seeALLdata =true)
private class scheduledUserActiveTest {
    static testMethod void myUnitTest() {
    User_Inactive UsrInactive = new User_Inactive();
    
    Account acc = new Account(Name='sneha',Archived_Record__c=FALSE,
    billingState = 'West Bengal',Street1_Local__c='test',City_Local__c='Kolkata',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA',Zip_Postal_Code_Local__c ='00123444');
    Insert acc;
    Profile pf1= [select id from Profile where name = 'System Administrator'];
        User u1 = new User(LastName = 'Test Usser',Username = 'tuu1@test.com',
        Email = 'testuser@test.com',Alias = 'tu1' ,IsActive = True,
        CommunityNickname= 'tu1' ,TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
        ProfileId = pf1.Id, LanguageLocaleKey = 'en_US',    Previous_User_Status__c = true);
     insert u1;
     User u2 = new User(LastName = 'Test User',Username = 'tuu120@test.com',
        Email = 'testuser2@test.com',Alias = 'tu12' ,IsActive = True,
        CommunityNickname= 'tu12' ,TimeZoneSidKey = 'America/Los_Angeles',
        LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
        ProfileId = pf1.Id, LanguageLocaleKey = 'en_US',    Previous_User_Status__c = true);
     insert u2;
     Account_Team_Member__c Atm = new Account_Team_Member__c(Account__c=acc.id,User__c=u1.id,Team_Role__c='lead qualifier');
     insert Atm;
     Account_Team_Member__c Atm2 = new Account_Team_Member__c(Account__c=acc.id,User__c=u2.id,Team_Role__c='lead qualifier');
     insert Atm2;
     
    user Sample = [select id from user where Alias = 'tu12'];
    sample.isactive = false ;
    
    
    UsrInactive.Check_User_Status(); 
    test.startTest();
    UserActive nightlyUpdate = new UserActive();
    String schedule = '0 0 23 * * ?';
    system.schedule('Nightly Update', schedule, nightlyUpdate);
    test.stopTest();
    }
}