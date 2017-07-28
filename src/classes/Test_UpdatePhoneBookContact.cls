@isTest
  public class Test_UpdatePhoneBookContact
  {
@isTest static void UpdatePhoneBookContact_TestMethod()
 { 
 
 Region__c regiondata=M2O_AccountContactTestDataUtility.getRegionData();
        insert regiondata;
        Account a=M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
         insert a;   
        
        Contact c = new Contact();
        c= new contact(accountId=a.id,lastname='test contact',Salutation='Mr.',FirstName='test',Phone='1111',MobilePhone='5555',Email='test.wip@wipro.com');
        insert c;
       }
       
       }