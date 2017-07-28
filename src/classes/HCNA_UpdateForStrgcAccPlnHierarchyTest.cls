/** Class name :HCNA_UpdateForStrgcAccPlnHierarchyTest
    Description : This is a test class for HCNA_UpdateForStrgcAccPlnHierarchy batch class.
    Created By : Somdev Bhattacharyya
    Date : 11/02/2015.
**/
@isTest
Public class HCNA_UpdateForStrgcAccPlnHierarchyTest {
    static testMethod void test_UpdateForStrgcAccPlnHierarchy () {
        Set<Id> accIdSet=new Set<Id>();
        Profile pf = HCNA_UtilityClass.getHCNAProfileId2 ();
        User us=HCNA_UtilityClass.getUserRecord(pf);
        us.UserName='gsagyusa@shs.com';
        us.alias='fbc';
        insert us;
        System.runAs(us) { 
            Test.startTest();
            Account acc1=HCNA_UtilityClass.getAccountRecord();
            insert acc1;
            Account acc2 = HCNA_UtilityClass.getAccountRecord2(acc1);
            insert acc2;
            accIdSet.add(acc1.id);
            accIdSet.add(acc2.id);
            Strategic_Account_Plan__c stpln = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc1);
            insert stpln;
            HCNA_UpdateForStrgcAccPlnHierarchy batch = new HCNA_UpdateForStrgcAccPlnHierarchy(accIdSet);
            Database.executeBatch(batch,200);
            System.assertNotEquals(acc1,null);
            Test.stopTest();
        }
    }  
}