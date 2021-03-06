/** Class name :HCNA_UpdateForCompLandscpeTest
    Description : This is a test class for HCNA_UpdateForCompLandscpe batch class.
    Created By : Somdev Bhattacharyya
    Date : 11/02/2015.
**/
@isTest
Public class HCNA_UpdateForCompLandscpeTest {
    static testMethod void test_UpdateForCompLandscpe () {
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
            Account acc3 = HCNA_UtilityClass.getAccountRecord();
            acc3.name='done';
            insert acc3;
            acc2.Associated_IDN__c=acc3.Id;
            update acc2;
            accountList.add(acc1);
            accountList.add(acc2);
            accountList.add(acc3);
            accIdSet.add(acc1.id);
            accIdSet.add(acc2.id);
            accIdSet.add(acc3.id);
            accountMap.put(acc1.id,acc1);
            accountMap.put(acc2.id,acc2);
            accountMap.put(acc3.id,acc3);
            Strategic_Account_Plan__c stpln = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc3);
            insert stpln;
            list<Hospital_Locations__c> hospList =HCNA_UtilityClass.getHospitalLocationRecord(stpln);
            insert hospList;
            stpln.Account__c=acc3.Id;
            update stpln;
            List<Competitive_Landscape__c> compLndscpList = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(stpln);
            insert compLndscpList;
            HCNA_UpdateForCompLandscpe batch = new HCNA_UpdateForCompLandscpe(accountList,accountMap,accIdSet);
             Database.executeBatch(batch,200);
            System.assertNotEquals(acc1,null);
            Test.stopTest();
        }
    }  
}