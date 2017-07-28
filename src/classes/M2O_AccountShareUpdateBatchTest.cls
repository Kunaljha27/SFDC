@isTest(SeeAllData=false)
public Class M2O_AccountShareUpdateBatchTest
{
    static testMethod void test_AccountShareUpdate()
    {
    
  accountshare accsh = new accountshare();
    
  account acc = new account(name = 'testacc');
  insert acc ;
  
  contact con = new contact(Salutation='Mr.',FirstName='abc',LastName='cd',AccountID=acc.id,Phone='1234',Email='abc@wipro.com',Business_Phone_Extension__c='abcd');
       
  insert con;
  
  accountteammember atm = new accountteammember(accountid = acc.id ,userid = userinfo.getuserid());
  insert atm;
  
  M2O_AccountShareUpdateBatch asup = new M2O_AccountShareUpdateBatch();
  //Database.executeBatch(asup, 200);
  
    }
}