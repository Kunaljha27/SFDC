@istest

public class Test_scheduleDeleteOpertaion_OppTeam {

   static testmethod void testscheduleDeleteOpertaion_OppTeam() {
 

test.starttest();
scheduleDeleteOpertaion_OppTeam sco = new scheduleDeleteOpertaion_OppTeam(); 
       String sch = '0 0 23 * * ?';  
      system.schedule('Contract Creates', sch, sco);
test.stopTest();
}
}