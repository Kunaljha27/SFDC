/**
* @ClassName         : M2O_ActivationPlanDAOTest
* @Description       : This class is the test class which is covering the code of M2O_ActivationPlan_DOAClass.
* @Author            : Albin Deni Arul
* @Last Modified     : 28/11/2013
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
private class M2O_ActivationPlanDAOTest{
  /* 
  * @Description : This test method covers the code of retrevieActivationPlans() method of M2O_ActivationPlanDAO class
  */
    @isTest static void test_retrevieActivationPlans(){
        Strategic_Account_Plan__c strategicAccountPlanTest = new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        ID exceptionID='00aB0000000Cd8q';
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName = 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass= M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();

        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest = new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.retrevieActivationPlans(strategicAccountPlanTestId);
            doaClassTest.retrevieActivationPlans(userId);
            doaClassTest.retrevieActivationPlans(exceptionID);
            doaClassTest.retrevieActivationPlans(exceptionID);
            system.assertequals(activationPlanToPass.Activity_Detail__c, 'Test Activity');
            test.stopTest();
        }
    }
  /* 
  * @Description : This test method covers the code of retriveAttachmentRecord() method of M2O_ActivationPlanDAO class
  */    
    @isTest static void test_retriveAttachmentRecord(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass= M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();

        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest = new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.retriveAttachmentRecord(strategicAccountPlanTestId);
            doaClassTest.retriveAttachmentRecord(userId);
            system.assertequals(activationPlanToPass.Strategic_account_plan__r.From_date__c, null);
            test.stopTest();
        }
    }
  /* 
  * @Description : This test method covers the code of retrieveCurrentUserAccess() method of M2O_ActivationPlanDAO class
  */     
    @isTest static void test_retrieveCurrentUserAccess(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest = M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();
        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest=new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.retriveCurrentUserAccess(userId,strategicAccountPlanTestId);
            doaClassTest.retriveCurrentUserAccess(strategicAccountPlanTestId,userId); 
            system.assertequals(userId, userInfo.getUserId());       
            test.stopTest();
        }
    }
  /* 
  * @Description : This test method covers the code of addActivityToDatabase() method of M2O_ActivationPlanDAO class
  */     
    @isTest static void test_addActivityToDatabase(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName = 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass= M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();

        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest=new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.addActivityToDatabase(activationPlanToPass);
            doaClassTest.addActivityToDatabase(activationPlanWithoutRequiredFields);
            system.assertequals(activationPlanToPass.Activity_Detail__c, 'Test Activity');
            test.stopTest();
        }
    }
  /* 
  * @Description : This test method covers the code of updateActivityToDatabase() method of M2O_ActivationPlanDAO class
  */         
    @isTest static void test_updateActivityToDatabase(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass= M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();

        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest=new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.updateActivityToDatabase(activationPlanToPass);
            doaClassTest.updateActivityToDatabase(activationPlanWithoutRequiredFields);
            system.assertequals(activationPlanToPass.Isdummyrecord__c, false);
            test.stopTest();
        }
    }
  /* 
  * @Description : This test method covers the code of deleteActivityFromDatabase() method of M2O_ActivationPlanDAO class
  */     
    @isTest static void test_deleteActivityFromDatabase(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id strategicAccountPlanTestId, userId;
        Activation_Plan__c activationPlanToPass; 
        Activation_Plan__c activationPlanWithoutRequiredFields;
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert userRecordTest;
        userId=userRecordTest.id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        insert strategicAccountPlanTest;
        strategicAccountPlanTestId=strategicAccountPlanTest.id;
   
        activationPlanToPass= M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id);
        insert activationPlanToPass;
        activationPlanWithoutRequiredFields= M2O_ActivationPlanTestDataUtility.getActivationPlanWithoutRequiredFields();

        system.runas(userRecordTest) {
            M2O_ActivationPlanDAO doaClassTest=new M2O_ActivationPlanDAO();
            test.startTest();
            doaClassTest.deleteActivityFromDatabase(activationPlanToPass);
            doaClassTest.deleteActivityFromDatabase(activationPlanToPass);
            system.assertequals(activationPlanToPass.Category__c, 'Personal Care');
            test.stopTest();
        }
    }
    /* 
      * @Description : This test method covers the querySapRecord() method of M2O_FinancialBridgeRevenueDAO class 
     */      
      
    @isTest static void test_QuerySapRecord(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId;
        Id strategicAccountPlanTestId;
        ID exceptionID='00aB0000000Cd8q';
        //string profileName= 'M2O KAM Lighting';
        profile prof = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.id);
        insert runAsUser;
        userId=runAsUser.Id;
        system.RunAs(runAsUser) {
            strategicAccountPlanTest=M2O_FinancialBridgeTestDataUtility.getStrategicAccountPlanRecord();
            insert strategicAccountPlanTest;

            strategicAccountPlanTestId=strategicAccountPlanTest.Id;
      
            test.starttest();
            M2O_ActivationPlanDAO.querySapRecord(strategicAccountPlanTestId);
            M2O_ActivationPlanDAO.querySAPRecord(exceptionID);
            system.assertEquals(strategicAccountPlanTest.name,'Test');    
            test.stoptest();
            
        }
    
    }
}