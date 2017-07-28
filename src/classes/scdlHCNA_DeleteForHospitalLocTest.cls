/**
@Classname :      scdlHCNA_DeleteForHospitalLocTest
@Description :    Below test class is used to execute the schedulable class 'scdlHCNA_DeleteForHospitalLoc' 
                  based on dummy data created below.
@Author:          Somdev bhattacharyya
@Last Modified:    12/02/2015
**/
@istest(SeeAllData=false)
public class scdlHCNA_DeleteForHospitalLocTest {
    /**
    @Description: This test method covers the execute method of Scheduler class.
    **/ 

    static testmethod void testDeleteForHospitalLoc() {
        list<Account>accountList = new list<Account>();
        map<Id,Account>accountMap = new map<Id,Account>();
        Set<Id> accIdSet=new Set<Id>();
        Profile pf = HCNA_UtilityClass.getHCNAProfileId2 ();
        User us=HCNA_UtilityClass.getUserRecord(pf);
        insert us;
        System.runAs(us) { 
            
            Account acc1=HCNA_UtilityClass.getAccountRecord();
            insert acc1;
            Account acc2 = HCNA_UtilityClass.getAccountRecord2(acc1);
            insert acc2;
            accIdSet.add(acc1.id);
            accIdSet.add(acc2.id);
            Strategic_Account_Plan__c stpln = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc1);
            insert stpln;
            list<Hospital_Locations__c> hosList = HCNA_UtilityClass.getHospitalLocationRecord(stpln);
            insert hosList;
            Datetime sysTime = System.now();
            sysTime = sysTime.addMinutes(2);
            String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() 
            + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
            scdlHCNA_DeleteForHospitalLoc scheduleUpdate = new scdlHCNA_DeleteForHospitalLoc(accIdSet);
            test.starttest();
            System.schedule('Con11 Attribute11', chron_exp, scheduleUpdate);
            System.assertNotEquals(chron_exp,null);
            test.stoptest();
        }     
    }
}