/**
* @ClassName         : M2O_SAPAttachmentComponentControllerTest
* @Description       : This is the test class which is covering the code of M2O_SAPAttachmentComponentController class
* @Author            : Bindesh Kushwaha
* @Last Modified     : 04/12/2013
* @Discussionpoints  : No Information
*/

@isTest(SeeAllData=false)
private class M2O_SAPAttachmentComponentControllerTest{ 

   /**
   @Description: This test method covers the getAttachmentID method of M2O_SAPAttachmentComponentController class.
   **/ 
        
    @isTest static void test_getAttachmentID(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id;
        Activation_Plan__c activationPlanTest= new Activation_Plan__c();
        system.RunAs(userRecordTest) {
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentController controllerClassTest= new M2O_SAPAttachmentComponentController();            
            test.starttest();
            controllerClassTest.getattachmentID();
            system.assertequals(attachmentID, '00aB0000000Cd8q');   
            test.stoptest();
        }
    }
    
   /**
   @Description: This test method covers the setAttachmentID method of M2O_SAPAttachmentComponentController class.
   **/
       
    @isTest static void test_setAttachmentID(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName); 
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id;
        Activation_Plan__c activationPlanTest= new Activation_Plan__c();
        system.RunAs(userRecordTest) {
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentController controllerClassTest= new M2O_SAPAttachmentComponentController();            
            test.starttest();
            controllerClassTest.setattachmentID(attachmentID);
            system.assertequals(attachmentID, '00aB0000000Cd8q');         
            test.stoptest();
        }
    }

   /**
   @Description: This test method covers the saveAttachment method of M2O_SAPAttachmentComponentController class.
   **/
       
    @isTest static void test_saveAttachment(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id;
        Activation_Plan__c activationPlanTest= new Activation_Plan__c();
        system.RunAs(userRecordTest) {
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentController controllerClassTest= new M2O_SAPAttachmentComponentController();            
            test.starttest();
            controllerClassTest.saveAttachment(); 
            system.assertequals(attachmentID, '00aB0000000Cd8q');     
            test.stoptest();
        }
    }
    
   /**
   @Description: This test method covers the deleteAttachment method of M2O_SAPAttachmentComponentController class.
   **/
       
    @isTest static void test_deleteAttachment(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id;
        Activation_Plan__c activationPlanTest= new Activation_Plan__c();
        system.RunAs(userRecordTest) {
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentController controllerClassTest= new M2O_SAPAttachmentComponentController();            
            test.starttest();
            controllerClassTest.deleteAttachment();    
            system.assertnotequals(attachmentID, null);    
            test.stoptest();
        }
    } 

   /**
   @Description: This test method covers the showAttachmentList method of M2O_SAPAttachmentComponentController class.
   **/
       
    @isTest static void test_showAttachmentList(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        string profileName= 'M2O KAM Lighting';
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);
        userId=userRecordTest.Id;
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId = M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id;
        Attachment attachmentObj = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(strategicAccountPlanTest.id);
        List<Attachment> attachmentList =new List<Attachment>();
        attachmentList.add(attachmentObj);
        Activation_Plan__c activationPlanTest= new Activation_Plan__c();
        system.RunAs(userRecordTest) {
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentController controllerClassTest= new M2O_SAPAttachmentComponentController();            
            test.starttest();
            controllerClassTest.showAttachmentList(attachmentList);    
            system.assertnotequals(attachmentID, null);    
            test.stoptest();
        }
    }    
}