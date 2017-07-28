/** Class name :HCNA_UpdateForHospitalLocTest
    Description : This is a test class for HCNA_UpdateForHospitalLoc batch class.
    Created By : Somdev Bhattacharyya
    Date : 11/02/2015.
**/
@isTest
Public class HCNA_UpdateForHospitalLocTest {
    static testMethod void test_UpdateForStrgcAccPln () {
        list<Account>accountList = new list<Account>();
        map<Id,Account>accountMap = new map<Id,Account>();
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
            accountList.add(acc1);
            accountList.add(acc2);
            accIdSet.add(acc1.id);
            accIdSet.add(acc2.id);
            accountMap.put(acc1.id,acc1);
            accountMap.put(acc2.id,acc2);
            Strategic_Account_Plan__c stpln = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc1);
            insert stpln;
            list<Hospital_Locations__c> hospList =HCNA_UtilityClass.getHospitalLocationRecord(stpln);
            insert hospList;
            HCNA_UpdateForHospitalLoc batch = new HCNA_UpdateForHospitalLoc(accountList,accountMap,accIdSet);
             Database.executeBatch(batch,200);
            System.assertNotEquals(acc1,null);
            Test.stopTest();
        }
    }  
}