/**
@Classname :       M2O_TriggerToStopMaliciousFilesTest 
@Description :     This test class is written to test the Apex Trigger M2O_TriggerToStopMaliciousFiles 
@Author:           Somdev Bhattacharyya
@Last Modified:    07/11/2014
**/

@isTest(SeeAllData=false)
public Class M2O_TriggerToStopMaliciousFilesTest {
   
    /**
    @Description: Here in this test method the Trigger M2O_TriggerToStopMaliciousFiles is tested.
    @Return: null 
    **/
    
    static testMethod void test_m2O_TriggerToStopMaliciousFiles(){
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
            extValues.Name ='csv';
            insert extValues;
            Attachment attachmentRecord = new Attachment();
            attachmentRecord = M2O_ActivationPlanTestDataUtility.getAttachmentRecord(opp.id);
            attachmentrecord.name ='xyz.csv';
            insert attachmentrecord;
            System.assertNotEquals(attachmentRecord,null);
        }
    }
}