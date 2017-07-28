@isTest
  public class Test_superSort
  {
      static testMethod void sortAscendingTest(){
        Profile m2oSysAdminProfileId=[Select id from Profile where Name='M2O System Administrator'];
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.id);
       
        Validate_M2O_Profiles__c m2oProfileValidation = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(m2oSystemAdminUser.ProfileId);  
        Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;       
        List<Opportunity> opps = new List<Opportunity>();
        for(integer i = 0; i<1000; i++){
            opps.add(new Opportunity(Name = 'test' + i, Amount = 1000 * Math.random(),accountid=acc.id));
        }
        
        Test.startTest();
        Long start = system.currentTimeMillis();
        superSort.sortList(opps,'Amount','asc');
        superSort.sortList(opps,'accountid','asc');
        system.debug(system.currentTimeMillis() - start);
        Test.stopTest();
        
        //Assert the list was sorted correctly
        Decimal assertValue = -1;
        for(Opportunity o : opps) {
            System.debug('Opp value: ' + o.amount);
            System.assert(assertValue <= o.amount);
            assertValue = o.amount;
        }  
    }
    
    public static testMethod void sortDescendingTest(){
        
        List<Opportunity> opps = new List<Opportunity>();
        for(integer i = 0; i<1000; i++){
            opps.add(new Opportunity(Name = 'test' + i, Amount = 1000 * Math.random()));
        }
        
        Test.startTest();
        superSort.sortList(opps,'Amount','desc');
        Test.stopTest();
        
        //Assert the list was sorted correctly
        Decimal assertValue = 1001;
        for(Opportunity o : opps) {
            System.debug('Opp value: ' + o.amount);
            System.assert(assertValue >= o.amount);
            assertValue = o.amount;
        }  
    }
   }