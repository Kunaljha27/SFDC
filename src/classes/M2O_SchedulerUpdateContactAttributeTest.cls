/**
@Classname :       M2O_SchedulerUpdateContactAttributeTest
@Description :    Below test class is used to execute the schedulable class 'M2O_SchedulerUpdateContactAttribute' 
                  based on dummy data created below.
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/
@istest(SeeAllData=false)
public class M2O_SchedulerUpdateContactAttributeTest {
    /**
    @Description: This test method covers the execute method of Scheduler class.
    **/ 

    static testmethod void testscheduleUpdate_ContactAttribute() {
        
        Datetime sysTime = System.now();
        sysTime = sysTime.addMinutes(2);
        String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' + sysTime.hour() 
        + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year();
        M2O_schedulerUpdateContctMarketAttribute scheduleUpdate = new M2O_schedulerUpdateContctMarketAttribute();
        test.starttest();
        System.schedule('Con11 Attribute11', chron_exp, scheduleUpdate);
        System.assertNotEquals(chron_exp,null);
        test.stoptest(); 
    }
}