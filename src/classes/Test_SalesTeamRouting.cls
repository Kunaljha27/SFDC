@isTest 
public class Test_SalesTeamRouting  {
 @isTest  static void SalesTeamRouting_TestMethod () 
    {
    User u;
    User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
    System.runAs (thisUser) {
    Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    List<UserRole> r = [SELECT Id FROM UserRole WHERE Name='Philips Global'];
    u = new User(alias = 'jsmtih', email='jsmith@acme124.com', 
                emailencodingkey='UTF-8', lastname='Smith', 
                languagelocalekey='en_US', 
                localesidkey='en_US', profileid = p.Id, userroleid = r[0].Id,
                timezonesidkey='America/Los_Angeles', 
                username='jsmith@acme112.com');
        insert u;   
   
      Region__c regiondata=M2O_AccountContactTestDataUtility.getRegionData();
      insert regiondata;
      Account acc=M2O_AccountContactTestDataUtility.getSingleAccountRecord(regiondata);
      insert acc;
    /*Opportunity_Routing_Table__c ort = New Opportunity_Routing_Table__c();
    
    ort.Routing_Medical_Services__c ='Patient Monitoring';
    ort.Routing_Department__c = 'Critical Care';
    ort.Routing_Active__c = True;
    ort.Routing_Functional_Role__c = 'Primary';
    ort.Routing_Roles__c = 'Lakes';
    
    insert ort;
    */
    
    AccountTeamMember atm = New AccountTeamMember();
       atm.TeamMemberRole = 'Great Lakes AM';
       atm.UserId = u.id;
       atm.AccountId = acc.id;
     insert atm;
    
     Opportunity opp=new Opportunity();
     opp.Name='Test2';
     opp.AccountId=acc.id;
     opp.Medical_Services__c = 'Ultrasound';
     opp.Department__c = 'Critical Care';
     opp.CloseDate=System.today();
     opp.Vendor_of_Choice__c='Philips';
     opp.Funding_Status__c='Confident';
     opp.StageName='P1';
     insert opp;
     
     Opportunity o = New Opportunity();
       o.Id = opp.Id;
       o.Medical_Services__c = 'Patient Monitoring';
       o.Department__c = 'Critical Care';
      update o;
    }
  }
}