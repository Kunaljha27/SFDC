@isTest
private class DuplicateContactCheckupClass 
{
    static testMethod void validate() 
    {
        /**Region__c r = M2O_OpportunityTestDataUtility.getRegionData();
    insert r;
    Account a =M2O_OpportunityTestDataUtility.getAccountRecord(r);
    insert a;
        contact b = new contact(Salutation='Mr.',FirstName='abc',LastName='cd',AccountID=a.id,Phone='1234',Email='abc@wipro.com',Business_Phone_Extension__c='abcd');
        insert b;
        contact c = new contact(Salutation='Mr.',FirstName='abc',LastName='cd',AccountID=a.id,Phone='12345',Email='abcd@wipro.com',Business_Phone_Extension__c='abcd');
        insert c;

        c.Phone='1234'; 
        c.Email='abc@wipro.com';
        //update c;
        try
        {
            update c;
        }
        catch(System.DMLException e)
        {
            //System.assert(e.getMessage().contains('Duplicate Contact'));
        }
     **/
    }
}