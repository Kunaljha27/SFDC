@isTest(SeeAllData=false)
public class  M2O_AccountShareUpdateBatchSchedulerTest {

    private static testMethod void testBatch() {
   
 
 
    Datetime sysTime = System.now();
        sysTime = sysTime.addMinutes(9);
        String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() 
        + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
         Test.StartTest();
    M2O_AccountShareUpdateBatchScheduler asubs = new M2O_AccountShareUpdateBatchScheduler();
     System.schedule('testSchledApex', chron_exp, asubs);

        System.assertNotEquals(chron_exp,null);
    
Test.stopTest();
}
}