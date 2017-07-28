@istest

public class Test_scheduleDeleteOpertaion_AffAcc {

   static testmethod void testscheduleDeleteOpertaion_AffAcc() {
 

test.starttest();
scheduleDeleteOpertaion_AffAcc sco = new scheduleDeleteOpertaion_AffAcc(); 
       String sch = '0 0 23 * * ?';  
      system.schedule('Contract Creates', sch, sco);
test.stopTest();
}
}