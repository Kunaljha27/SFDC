/**
@Classname :       M2O_TriggerToStopMaliciousFilesServiceTest
@Description :     This test class is written to test the Apex Class M2O_TriggerToStopMaliciousFilesService
@Author:           Somdev Bhattacharyya
@Last Modified:    07/11/2014
**/

@isTest(SeeAllData=false)
public Class M2O_TriggerToStopMaliciousFileServiceTst{
   
    /**
    @Description: Here in this test method the method stopMaliciousFileUpload is tested.
    @Return: null 
    **/
    
    static testMethod void test_stopMaliciousFileUpload(){
        profile prof = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(prof.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            M2O_MalaciousFileExtensionValues__c extValues = new M2O_MalaciousFileExtensionValues__c();
            extValues.Name ='pdf';
            insert extValues;
            List<Attachment> attachmentsList = new List<Attachment>();
            Attachment attachmentRecord = new Attachment();
            attachmentRecord = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(opp.id);
            attachmentrecord.name ='xyz.pdf';
            attachmentsList.add(attachmentrecord);
            insert attachmentsList;
            System.assertNotEquals(attachmentsList,null);
            M2O_TriggerToStopMaliciousFilesService serviceClass = new M2O_TriggerToStopMaliciousFilesService();
            serviceClass.stopMaliciousFileUpload(attachmentsList);
        }
    }
}