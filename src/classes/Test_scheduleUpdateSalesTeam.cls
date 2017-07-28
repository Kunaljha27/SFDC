@istest
public class Test_scheduleUpdateSalesTeam {
static testmethod void testscheduleupdatesalesTeam() {
test.starttest();
scheduleUpdateSalesTeam sut = new scheduleUpdateSalesTeam ();
String schs = '0 0 23 * * ?';  
      system.schedule('sales team', schs, sut);
test.stopTest();
}
}