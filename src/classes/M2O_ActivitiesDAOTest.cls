/**
@Classname :       M2O_ActivitiesDAOTest
@Description :     This test class is written to test the Apex class M2O_ActivitiesDAO. 
@Author:           Ruchika Patil
@Last Modified:    19/3/2014
**/
@isTest(SeeAllData=false)
public class M2O_ActivitiesDAOTest{
 /* @Description : This test method covers the getTaskList() method of Dao class
  */ 
    static TestMethod void Test_getTaskList(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {  
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Task taskRecord = M2O_AccountContactTestDataUtility.getTaskRecord(accRecord.id);
        insert taskRecord;
        string sourceAccountID = accRecord.id;
        M2O_ActivitiesDAO.getTaskList(sourceAccountID);
        System.assertNotEquals(sourceAccountID,null);
        }  
    }
     /* @Description : This test method covers the getEventList() method of Dao class
  */ 
    static TestMethod void Test_getEventList(){
      Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Event eventRecord;
        eventRecord = M2O_AccountContactTestDataUtility.getEventRecord(accRecord.id);
        eventRecord.ActivityDate = null;
        insert eventRecord;
        string sourceAccountID = accRecord.id;
        List<Event> eventList = new List<Event>();
        eventList = M2O_ActivitiesDAO.getEventList(sourceAccountID);
        System.assertNotEquals(sourceAccountID,null);
        }  
    }
     /* @Description : This test method covers the getNoteList() method of Dao class
  */ 
    static TestMethod void Test_getNoteList(){
       Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Note noteRecord = M2O_AccountContactTestDataUtility.getNoteRecord(accRecord.id);
        insert noteRecord;
        string sourceAccountID = accRecord.id;
        M2O_ActivitiesDAO.getNoteList(sourceAccountID);
        System.assertNotEquals(sourceAccountID,null); 
        } 
    }
    /* @Description : This test method covers the getAttachmentList() method of Dao class
  */ 
    static TestMethod void Test_getAttachmentList(){
        Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Attachment attachmentRecord = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(accRecord.id);
        insert attachmentRecord;
        string sourceAccountID = accRecord.id;
        M2O_ActivitiesDAO.getAttachmentList(sourceAccountID);
        System.assertNotEquals(sourceAccountID,null);  
        }
    }

      /* @Description : This test method covers the setAttachments() method of Dao class
  */ 
    static TestMethod void Test_setAttachments(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Attachment testAttachmentRecord;
        Attachment testAttachmentRec;
        List<Attachment> testListAttachment = new List<Attachment>();
        testAttachmentRecord = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(accRecord.id);
        insert testAttachmentRecord;
        testListAttachment.add(testAttachmentRecord);
        M2O_ActivitiesDAO.setAttachments(testListAttachment);
        System.assertNotEquals(testListAttachment,null); 
        } 
    }
    /* @Description : This test method covers the setNotes() method of Dao class
  */ 
    static TestMethod void Test_setNotes(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        Account accRecord;
        Region__c rediondata;
        rediondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert rediondata;
        accRecord = M2O_AccountContactTestDataUtility.getSingleAccountRecord(rediondata);
        insert accRecord;
        Note testNoteRecord;
        Note testNoteRec;
        List<Note> testListNote = new List<Note>();
        testNoteRecord = M2O_AccountContactTestDataUtility.getNoteRecord(accRecord.id);
        insert testNoteRecord;
        testListNote.add(testNoteRecord);
        M2O_ActivitiesDAO.setNotes(testListNote);
        System.assertNotEquals(testListNote,null); 
        } 
    }
    /* @Description : This test method covers the setActivity() method of Dao class
  */ 
    static TestMethod void Test_setActivity(){
    Profile profileTest = M2O_UserTestDataUtility.getM2ODataManagementProfileId();
      UserRole roleTest = M2O_UserTestDataUtility.getGlobalRoleRecord();
      User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(profileTest.id,roleTest.id);
      insert runAsUser;
      System.runAs(runAsUser) {
        List<SObject> testSObjectlist= new List<SObject>();
        Region__c regiondata;
        regiondata = M2O_AccountContactTestDataUtility.getRegionData();
        insert regiondata;
        testSObjectlist = M2O_AccountContactTestDataUtility.getSObjectRecord(regiondata);
        insert testSObjectlist;
        M2O_ActivitiesDAO.setActivity(testSObjectlist);
        System.assertNotEquals(testSObjectlist,null);  
        }
    }
}