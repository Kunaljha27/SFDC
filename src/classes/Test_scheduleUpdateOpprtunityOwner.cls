@istest

public class Test_scheduleUpdateOpprtunityOwner {

   static testmethod void testscheduleUpdateOpprtunityOwner() {
 

test.starttest();
scheduleUpdateOpprtunityOwner sco = new scheduleUpdateOpprtunityOwner(); 
       String sch = '0 0 23 * * ?';  
      system.schedule('Contract Creates', sch, sco);
test.stopTest();
}
}