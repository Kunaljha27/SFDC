@isTest
private class scheduledUserActive {
    static testMethod void myUnitTest() {
    test.startTest();
    UserActive nightlyUpdate = new UserActive();
    String schedule = '0 0 23 * * ?';
    system.schedule('Nightly Update', schedule, nightlyUpdate);
    test.stopTest();
    }
}