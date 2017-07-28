/**
@Classname :       M2O_CaptureDeleteRecordsServiceTest 
@Description :     This test class is written to cover the code of Apex class  M2O_CaptureDeleteRecordsService.
@Author:           Meeta Pramaniik
@Last Modified:    16/01/2014
**/

@isTest(SeeAllData=false)
private class M2O_CheckCDHAccountsServiceTest {
    public static testMethod void checkCDHAccounts(){
        List <Account> listAccount = new List<Account>();
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());  
        insert userRecordTest;
        System.runAs(userRecordTest) { 
            test.starttest();
            
            insert M2O_CaptureDeleteTestDataUtility.getValidateM2OData(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
            insert listAccount;
             M2O_CheckCDHAccountsService.checkCDHAccounts(listAccount);
        test.stoptest(); 
        } 
    }
}