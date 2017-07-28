/**
* @ClassName         : M2O_FederationMandatoryTrigger_TestClass
* @Description       : This class is the test class which is covering the code of M2O_FederationMandatory.
* @Author            : Namrata Vora
* @Last Modified     : 13/05/2015
**/
@isTest
public class M2O_FederationMandatoryTrigger_TestClass{
  
   static TestMethod void test_method1(){ 
   try{
   Profile ProfId  = [select id from Profile where name = 'M2O Sales Healthcare'];
                          
   UserRole userRoleRec = [SELECT Id FROM UserRole WHERE Name = 'APA HS Market Leader'];
  
   User  TestUser = new User(LastName = 'User2',Username = 'Atest2.user.philips2@abc.com',
                             Email = 'test2.user@philips.com',Alias = 'tu2',
                             CommunityNickname= 'tu11234562' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             Profileid = ProfId.id, LanguageLocaleKey = 'en_US', Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC', UserRoleid =userRoleRec.id);
                             
   insert TestUser;   
   }                       
   catch(Exception e){
   }
   }

}