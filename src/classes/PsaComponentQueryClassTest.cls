@isTest(SeeAllData=true)
global without sharing class PsaComponentQueryClassTest {
  static PsaTestHarness testHarness = new PsaTestHarness();
  private static final Date REFERENCE_DATE = DateTime.valueOfGmt('2009-03-8 00:00:00').dateGMT();
  private enum dayOfWeek {SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY}
  static Date refMonDate;
 
  private static testmethod void timecardTest(){
    testHarness.disableGeoTriggers();
    
    Date refMonDateStart = getMonday(Date.today());
    refMonDate = getMonday(Date.today().addDays(6));
    if(refMonDateStart.Month() != refMonDate.Month()){
      refMonDate -= 6;
    } 
    
    List<Region__c> crmRegions = [
      SELECT Id
        FROM Region__c
       WHERE Country__c = 'United States'
       LIMIT 1
    ];
    Region__c crmRegion1 = crmRegions[0];
    
    Account account1 = testHarness.newAccount(false);
    account1.Housenumber_Local__c = '1';
    account1.Street1_Local__c = '1';
    account1.City_Local__c = '1';
    account1.Country__c = 'United States';
    account1.Region__c = crmRegion1.Id;
    account1.Zip_Postal_Code_Local__c = '40390';
    account1.BillingPostalCode = '40390';
    insert account1; 
    
    User user1 = testHarness.newUserSysAdmin(true);
    
    pse__Region__c region1 = testHarness.getRegionMaster();
    pse__Work_Calendar__c workcalendar1 = testHarness.newWorkCalender(true);
    Contact resource1 = testHarness.newResource(false,account1.Id, user1.Id, region1.Id, workcalendar1.Id);
    resource1.FirstName = 'Bob';
    resource1.LastName = 'Jones';
    resource1.Phone = '8595521111';
    resource1.MobilePhone = '8595521111';
    resource1.MailingPostalCode = '40390';
    resource1.Salutation = 'Mr.';
    insert resource1;
    
    pse__Proj__c project1 = testHarness.newProject(true,region1.Id,null,true,null);
    pse__Permission_Control__c permissionControl1 = TestHarness.newPermissionControl(true,UserInfo.getUserId(),region1.Id);
    
    Test.startTest();

    pse__Timecard_Header__c timecardHeader1 = testHarness.newTimecardHeader(true, resource1.Id, project1.Id, null, null, refMonDate, refMonDate + 6);
    List<pse__Timecard_Header__c> lstTCH = new List<pse__Timecard_Header__c>([
      SELECT Id, Name
        FROM pse__Timecard_Header__c 
       WHERE Id = :timecardHeader1.Id
    ]);
    
    PsaComponentQueryClass component = new PsaComponentQueryClass();
    component.queryString = 'SELECT id, Name FROM pse__timecard_header__c WHERE id = \''+ timecardHeader1.Id +'\'';
    system.debug('Timecard found is ' + timecardHeader1.name);
    List<sObject> result = component.results;
     
    System.assertEquals(1,result.size(),'Expected a single timecard record');
    System.assertEquals(lstTCH[0].Name,(String)result.get(0).get('Name') );
  }
  
  private static Date getMonday(Date dt) {
  // get the number of days between the given date and the reference date (Sunday)
  Integer daysBetween = REFERENCE_DATE.daysBetween(dt);
  
  // get the remainder from dividing by the # of days in a week
  Integer remainder = Math.mod(daysBetween, 7);
  // NOTE: a negative remainder indicates a past date from the reference
  if(remainder == 0) 
    return dt.addDays(-6); // Sunday
  else if (remainder == 1 || remainder == -6)
    return dt; // MONDAY
  else if (remainder == 2 || remainder == -5)
    return dt.addDays(-1); //TUESDAY
  else if (remainder == 3 || remainder == -4)
    return dt.addDays(-2); //WEDNESDAY
  else if (remainder == 4 || remainder == -3)
    return dt.addDays(-3); //THURSDAY
  else if (remainder == 5 || remainder == -2)
    return dt.addDays(-4); //FRIDAY
  else // remainder = 6 || remainder == -1
    return dt.addDays(-5); //SATURDAY
  }
  
} // End Class