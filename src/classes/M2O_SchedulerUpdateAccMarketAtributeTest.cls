/**
@Classname :       M2O_SchedulerUpdateAccMarketAtributeTest
@Description :     The scheduler class schedules the batch class  M20_BatchUpdateAccountMarketAttribute.
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/
@istest(SeeAllData=false)
public class M2O_SchedulerUpdateAccMarketAtributeTest {
    
    /**
    @Description: This test method covers the execute method of Scheduler class.
    **/ 
    static testmethod void testscheduleUpdate_AccountAttribute() {     
        Datetime sysTime = System.now();
        sysTime = sysTime.addMinutes(2);
        String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() 
        + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        M2O_SchedulerUpdateAccMarketAttribute scheduleUpdate = new M2O_SchedulerUpdateAccMarketAttribute();
        test.starttest();        
        System.schedule('Acc11 Attribute11', chron_exp, scheduleUpdate);
         System.assertNotEquals(chron_exp,null);
        test.stoptest ();   
        
    }
}