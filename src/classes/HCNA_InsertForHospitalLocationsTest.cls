/** Class name :HCNA_InsertForHospitalLocationsTest
    Description : This is a test class for HCNA_InsertForHospitalLocations batch class.
    Created By : Somdev Bhattacharyya
    Date : 11/02/2015.
**/
@isTest
Public class HCNA_InsertForHospitalLocationsTest {
    static testMethod void test_InsertForHospitalLocations () {
        Set<Id> accIdSet=new Set<Id>();
        Profile pf = HCNA_UtilityClass.getHCNAProfileId2 ();
        User us=HCNA_UtilityClass.getUserRecord(pf);
        insert us;
        System.runAs(us) { 
            Test.startTest();
            Account acc1=HCNA_UtilityClass.getAccountRecord();
            insert acc1;
            Account acc2 = HCNA_UtilityClass.getAccountRecord2(acc1);
            insert acc2;
            accIdSet.add(acc1.id);
            accIdSet.add(acc2.id);
            HCNA_InsertForHospitalLocations batch = new HCNA_InsertForHospitalLocations(accIdSet);
            Database.executeBatch(batch,200);
            System.assertNotEquals(acc1,null);
            Test.stopTest();
        }
    }  
}