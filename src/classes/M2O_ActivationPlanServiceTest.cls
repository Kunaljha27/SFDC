/**
* @ClassName         : M2O_ActivationPlanServiceTest
* @Description       : This is the test class which is covering the code of M2O_ActivationPlanService class.
* @Author            : Albin Deni Arul
* @Last Modified     : 28/11/2013
* @Discussionpoints  : No Information
*/
@isTest(SeeAllData=true)
private class M2O_ActivationPlanServiceTest{
  /* 
  * @Description : This test method covers the initialAction() method of M2O_ActivationPlanController class
  */   
    @isTest static void test_initialAction(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        insert activationPlanTestInsertedRecord;
        activationPlanTestInsertedRecordId=activationPlanTestInsertedRecord.Id;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTestId));
        
        system.RunAs(userRecordTest) {
        
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.initialAction();
            system.assertequals(activationPlanTestInsertedRecord.Activity_Detail__c, 'Test Activity');
            test.stoptest();
        }
    }
  
  /* 
  * @Description : This test method covers the retriveActivationPlans() method of M2O_ActivationPlanController class
  */     
        @isTest static void test_retriveActivationPlans(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;

        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        insert activationPlanTestInsertedRecord;
       
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.initialAction();
            serviceClassTest.retriveActivationPlans(strategicAccountPlanTestId);
            system.assertequals(activationPlanTestInsertedRecord.Activity_Detail__c, 'Test Activity');
            test.stoptest();
        }
    }

  /* 
  * @Description : This test method covers the retriveCurrentUserAccess() method of M2O_ActivationPlanController class
  */     
    @isTest static void test_retriveCurrentUserAccess(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;

        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        insert activationPlanTestInsertedRecord;
       
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.retriveCurrentUserAccess(userId,strategicAccountPlanTest.id);
            system.assertequals(userId, userInfo.getUserId());       
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the retriveAttachmentRecord() method of M2O_ActivationPlanController class
  */       
    @isTest static void test_retriveAttachmentRecord(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        insert activationPlanTestInsertedRecord;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTestId));

        activationPlanToPass = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanRecordDiff = M2O_ActivationPlanTestDataUtility.getActivationPlanRecordDiff(strategicAccountPlanTest.id);
        insert activationPlanToPass ;
        insert activationPlanRecordDiff;
       
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.retriveAttachmentRecord(strategicAccountPlanTestid);
            system.assertequals(activationPlanToPass.Strategic_account_plan__r.From_date__c, null);
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the addActivity() method of M2O_ActivationPlanController class
  */    
    @isTest static void test_addActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
       
        insert activationPlanTestInsertedRecord;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTest.id));
        
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.initialAction();
            serviceClassTest.retriveActivationPlans(strategicAccountPlanTest.id);
            serviceClassTest.retriveAttachmentRecord(strategicAccountPlanTestId);
            serviceClassTest.addActivity(activationPlanTestInsertedRecord);
            system.assertequals(activationPlanTestInsertedRecord.Activity_Detail__c, 'Test Activity');
            test.stoptest();
        }
    }

  /* 
  * @Description : This test method covers the updateActivity() method of M2O_ActivationPlanController class
  */    
  @isTest static void test_updateActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        Date toDate = Date.newInstance(2013,10,8);
        Date fromDate = Date.newInstance(2013,10,8);
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTest.From_date__c=system.today();
        strategicAccountPlanTest.To_date__c=system.today();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
        
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        activationPlanTestInsertedRecord.Activity_Start_date__c=system.today();
        activationPlanTestInsertedRecord.Activity_End_date__c=system.today();
        insert activationPlanTestInsertedRecord;
        activationPlanTestInsertedRecordId=activationPlanTestInsertedRecord.Id;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTest.id));
        activationPlanToPass = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanRecordDiff= M2O_ActivationPlanTestDataUtility.getActivationPlanRecordDiff(strategicAccountPlanTest.id);
        insert activationPlanToPass ;
        insert activationPlanRecordDiff;
           
            M2O_ActivationPlanService serviceClassTest = new M2O_ActivationPlanService(); 
            id testing = serviceClassTest.retriveAttachmentRecord(strategicAccountPlanTest.id);
            M2O_ActivationPlanWrapperTypCatActivity wrap = new M2O_ActivationPlanWrapperTypCatActivity('Promotion','Disney');
            M2O_ActivationPlanWrapperActDetails activity = new M2O_ActivationPlanWrapperActDetails('abc',system.today(),system.today(),'Proposed','Promotion','Disney',activationPlanTestInsertedRecordId);
            
            
            test.starttest();
            serviceClassTest.attachmentrecord = activationPlanTestInsertedRecord;
            serviceClassTest.initialAction();
            serviceClassTest.retriveActivationPlans(strategicAccountPlanTest.id);
            serviceClassTest.retriveAttachmentRecord(strategicAccountPlanTestId);              
            serviceClassTest.updateActivity(activationPlanTestInsertedRecord,  'test', 'test', 'test', activationPlanTestInsertedRecordId);
            serviceClassTest.updateActivity(activationPlanTestInsertedRecord,  'Above the line activities', 'Personal Care', 'test', activationPlanTestInsertedRecordId);
            serviceClassTest.updateActivity(activationPlanTestInsertedRecord,  'Above the line activities', 'Personal Care', 'test', activationPlanTestInsertedRecordId);
            system.assertequals(activationPlanTestInsertedRecord.Activity_Detail__c, 'Test Activity');
            test.stoptest();
        }
    }

  /* 
  * @Description : This test method covers the deleteActivity() method of M2O_ActivationPlanController class
  */    
    @isTest static void test_deleteActivity(){
   
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        Id activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanToPass;
        Activation_Plan__C activationPlanTestInserted;
        Activation_Plan__C activationPlanRecordDiff;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;

        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        insert activationPlanTestInsertedRecord;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTestId));
        activationPlanToPass = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanRecordDiff = M2O_ActivationPlanTestDataUtility.getActivationPlanRecordDiff(strategicAccountPlanTest.id);
        insert activationPlanRecordDiff;
        insert activationPlanToPass ;
        
        activationPlanTestInsertedRecordId=activationPlanTestInsertedRecord.Id;
        
     
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.initialAction();
            serviceClassTest.retriveActivationPlans(strategicAccountPlanTest.id);
            serviceClassTest.deleteActivity(activationPlanToPass, activationPlanToPass.id);
            system.assertequals(activationPlanToPass.Category__c, 'Personal Care');
            
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the cancel() method of M2O_ActivationPlanController class
  */
    @isTest static void test_cancel(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanTestInsertedRecord;
     
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.cancel();
            system.assertnotequals(activationPlanTestInsertedRecord.Category__c, '');
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the monthsToAdd() method of M2O_ActivationPlanController class
  */    
    @isTest static void test_monthsToAdd(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, activationPlanTestInsertedRecordId;
        string profileName= 'M2O KAM Lighting';
        Date startDate = Date.newInstance(2013,10,8);
        Date endDate = Date.newInstance(2013,10,9);
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;

        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanTestInsertedRecord;
 
            M2O_ActivationPlanService serviceClassTest=new M2O_ActivationPlanService(); 
            test.starttest();
            serviceClassTest.monthsToAdd(startDate ,endDate);
            system.assertnotequals(startDate, system.now());
            test.stoptest();
        }
    }
}