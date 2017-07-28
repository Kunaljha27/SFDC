/**
* @ClassName     : M2O_ActivationPlanControllerTest
* @Description   : This class is the test class which is covering the code of M2O_ActivationPlanController class.
* @Author        : Albin Deni Arul
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/
@isTest(SeeAllData=true)
private class M2O_ActivationPlanControllerTest{ 
  /* 
  * @Description : This test method covers the addActivity method of M2O_ActivationPlanController class
  */
  @isTest static void test_addActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId = userRecordKAM.Id;

        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
       
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest = new M2O_ActivationPlanController(controller);
            test.starttest();
            controllerClassTest.activationPlan = activationPlanTest;
            controllerClassTest.currentUserId = userId;
            controllerClassTest.addActivity();
             system.assertequals(activationPlanTest.Activity_Detail__c, 'Test Activity');
           
            test.stoptest();
        }   
    }  
    /* 
  * @Description : This test method covers the addActivity method of M2O_ActivationPlanController class
  */
  @isTest static void test_addActivityException(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId = userRecordKAM.Id;

        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
       
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest = new M2O_ActivationPlanController(controller);
            test.starttest();
            controllerClassTest.activationPlan = null;
            controllerClassTest.currentUserId = userId;
            controllerClassTest.addActivity();
             system.assertequals(activationPlanTest.Activity_Detail__c, 'Test Activity');
           
            test.stoptest();
        }   
    }  
  /* 
  * @Description : This test method covers the updateActivity method of M2O_ActivationPlanController class
  */    
    @isTest static void test_updateActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId= userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        Activation_Plan__c activationPlanTestInsertedRecord=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTestId);
        activationPlanTestInsertedRecord.Activity_Start_date__c=system.today();
        activationPlanTestInsertedRecord.Activity_End_date__c=system.today();
        insert activationPlanTestInsertedRecord;
        activationPlanTestInsertedRecordId=activationPlanTestInsertedRecord.Id;
        insert(M2O_ActivationPlanTestDataUtility.getActivationPlanAttachmentRecord(strategicAccountPlanTest.id));
        
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest = new M2O_ActivationPlanController(controller);
            M2O_ActivationPlanService serviceClassTest = new M2O_ActivationPlanService(); 
            serviceClassTest.wrapperTypCatActivity = new M2O_ActivationPlanWrapperTypCatActivity (activationPlanTestInserted.type__c,activationPlanTestInserted.category__c);
            test.starttest();
            controllerClassTest.activationPlan = activationPlanTest;
            controllerClassTest.currentUserId = userId;
            controllerClassTest.activityId=activationPlanTestInsertedRecordId;
            serviceClassTest.updateActivity(activationPlanTestInsertedRecord,  'test', 'test', 'test', activationPlanTestInsertedRecordId);
            controllerClassTest.updateActivity();
            system.assertequals(activationPlanTest.Activity_Detail__c, 'Test Activity');
            test.stoptest();
        }
    }    
  /* 
  * @Description : This test method covers the deleteActivity method of M2O_ActivationPlanController class
  */       
    @isTest static void test_deleteActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId =  userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest= new M2O_ActivationPlanController(controller);
            test.starttest();           
            controllerClassTest.deleteActivity();
            system.assertnotequals(activationPlanTest.Activity_Detail__c, null);
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the Cancel method of M2O_ActivationPlanController class
  */     
    @isTest static void test_cancel(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId=userRecordKAM.Id;

        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest= new M2O_ActivationPlanController(controller);
            test.starttest();            
            controllerClassTest.cancel();
            system.assertnotequals(activationPlanTest.Activity_Detail__c, '');
            test.stoptest();
        }
    }
  /* 
  * @Description : This test method covers the showEditActivity method of M2O_ActivationPlanController class
  */     
    @isTest static void test_showEditActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId =  userRecordKAM.Id;
        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
 
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest= new M2O_ActivationPlanController(controller);
            test.starttest();
            controllerClassTest.showEditActivity();
            system.assertequals(controllerClassTest.showEditActivity , true);
            test.stoptest();
        }
    }
     
  
  
  
  /** @Description : This test method covers the showAddActivity method of M2O_ActivationPlanController class
  */     
    @isTest static void test_showAddActivity(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
        Id userId, userIdKAM, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        Activation_Plan__c activationPlanTest;
        Activation_Plan__C activationPlanTestInserted;
        string profileName = 'M2O KAM Lighting';  
        User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordKAM;
        userId =  userRecordKAM.Id;

        system.RunAs(userRecordKAM) {
        strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId = strategicAccountPlanTest.Id;
        activationPlanTestInserted = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        activationPlanTestInsertedRecordId = activationPlanTestInserted.Id; 
        activationPlanTest = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        
            ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest= new M2O_ActivationPlanController(controller);
            test.starttest();            
            controllerClassTest.showAddActivity();
            system.assertequals(controllerClassTest.showEditActivity , false);
            test.stoptest();
        }
    }
    
     @isTest static void test_showErrorMessage(){
          Strategic_Account_Plan__c strategicAccountPlanTest = new Strategic_Account_Plan__c();
          string profileName = 'M2O KAM Lighting';  
          User userRecordKAM=M2O_UserTestDataUtility.getUserRecord(profileName); 
          insert userRecordKAM;
       
          system.RunAs(userRecordKAM) {
          strategicAccountPlanTest = M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
          insert strategicAccountPlanTest;
             ApexPages.StandardController controller = new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_ActivationPlanController controllerClassTest= new M2O_ActivationPlanController(controller);
            test.starttest();  
            controllerClassTest.showErrorMessage('test');
             test.stoptest();  
            }          
     }
}