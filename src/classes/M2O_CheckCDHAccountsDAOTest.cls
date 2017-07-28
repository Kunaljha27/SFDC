/**
@Classname :       M2O_CheckCDHAccountsDAOTest
@Description :     This test class is written to cover the code of Apex class  M2O_CaptureDeleteRecordsService.
@Author:           Meeta Pramaniik
@Last Modified:    23/01/2014
**/

@isTest(SeeAllData=false)
Public class M2O_CheckCDHAccountsDAOTest{
     public static testMethod void dataMigrationID() {
        test.startTest();
            M2O_CheckCDHAccountsDAO.dataMigrationID();
        test.stopTest();
           
       
    }
}