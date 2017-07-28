@istest

public class Test_scheduleDeleteOpertaion_Opp {

   static testmethod void testscheduleDeleteOpertaion_Opp() {
 

test.starttest();
scheduleDeleteOpertaion_Opp sco = new scheduleDeleteOpertaion_Opp(); 
       String sch = '0 0 23 * * ?';  
      system.schedule('Contract Creates', sch, sco);
test.stopTest();
}
}