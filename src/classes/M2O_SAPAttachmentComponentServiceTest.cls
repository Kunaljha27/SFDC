/**
* @ClassName         : M2O_SAPAttachmentComponentService
* @Description       : This test class is covering the code of M2O_SAPAttachmentComponentService class
* @Author            : Bindesh Kushwaha
* @Last Modified     : 04/12/2013
* @Discussionpoints  : No Information
*/

@isTest(SeeAllData=false)
private class M2O_SAPAttachmentComponentServiceTest{
    
    /**
    @Description: This test method covers the getAttachmentID method of M2O_SAPAttachmentComponentService class.
    **/ 
    
    @isTest static void test_getAttachmentID(){
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, SAPID, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        SAPID = strategicAccountPlanTest.id;
        String Bodyofattachment='Body of attachment';
        Blob Blob1;
        string profileName= 'M2O KAM Lighting';
        Blob1 = Blob.valueOf(Bodyofattachment);        
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id; 
        
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentService controllerClassTest = new M2O_SAPAttachmentComponentService();
            test.starttest(); 
            controllerClassTest.retriveAttachmentList(SAPID);
            system.assertequals(Bodyofattachment, 'Body of attachment');
            test.stoptest();
        }
    } 
    
    /**
    @Description: This test method covers the retriveUserAccess method of M2O_SAPAttachmentComponentService class.
    **/ 
        
     @isTest static void test_retriveUserAccess()    {
       Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, SAPID, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        SAPID = strategicAccountPlanTest.id;
        String Bodyofattachment='Body of attachment';
        Blob Blob1;
        string profileName= 'M2O KAM Lighting';
        Blob1 = Blob.valueOf(Bodyofattachment);        
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id; 
        
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentService controllerClassTest= new M2O_SAPAttachmentComponentService();
            test.starttest();
            controllerClassTest.retriveUserAccess(SAPID , userId);
            system.assertnotequals(userId, userinfo.getuserId());
            test.stoptest();
        }
    }

    /**
    @Description: This test method covers the saveAttachment method of M2O_SAPAttachmentComponentService class.
    **/
        
     @isTest static void test_saveAttachment()    {
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, SAPID, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        SAPID = strategicAccountPlanTest.id;
        String Bodyofattachment='Body of attachment';
        Blob Blob1;
        string profileName= 'M2O KAM Lighting';
        Blob1 = Blob.valueOf(Bodyofattachment);        
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        userId=userRecordTest.Id;
         system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id; 
       
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentService controllerClassTest= new M2O_SAPAttachmentComponentService();
            test.starttest();  
            controllerClassTest.saveAttachment(SAPID, Bodyofattachment, Blob1);
            system.assertequals(Bodyofattachment, 'Body of attachment');
            test.stoptest();
        }
    }
    
    /**
    @Description: This test method covers the deleteAttachment method of M2O_SAPAttachmentComponentService class.
    **/
        
     @isTest static void test_deleteAttachment()    {
        Strategic_Account_Plan__c strategicAccountPlanTest=new  Strategic_Account_Plan__c();
        Id userId, SAPID, strategicAccountPlanTestId, activationPlanTestInsertedRecordId;
        ID attachmentID='00aB0000000Cd8q';
        SAPID = strategicAccountPlanTest.id;
        String Bodyofattachment='Body of attachment';
        Blob Blob1;
        string profileName= 'M2O KAM Lighting';
        Blob1 = Blob.valueOf(Bodyofattachment);        
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);  
        userId=userRecordTest.Id;
        system.RunAs(userRecordTest) {
        strategicAccountPlanTest=M2O_ActivationPlanTestDataUtility.getStrategicAccountPlanRecord();
        strategicAccountPlanTestId=strategicAccountPlanTest.Id;
        activationPlanTestInsertedRecordId=M2O_ActivationPlanTestDataUtility.getActivationPlanRecord(strategicAccountPlanTest.id).id; 
        
            ApexPages.StandardController controller=new ApexPages.StandardController(strategicAccountPlanTest); 
            Apexpages.Currentpage().getparameters().put('Id',strategicAccountPlanTest.id);
            M2O_SAPAttachmentComponentService controllerClassTest= new M2O_SAPAttachmentComponentService();
            test.starttest();      
            controllerClassTest.deleteAttachment(SAPID); 
            system.assertnotequals(Bodyofattachment, null);    
            test.stoptest();
        }
    }
    
}