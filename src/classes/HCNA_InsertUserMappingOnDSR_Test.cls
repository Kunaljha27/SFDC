/**
* @ClassName         : HCNA_InsertUserMappingOnDSR_Test
* @Description       : This class is the test class which is covering the code ofHCNA_InsertUserMappingOnDSR Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_InsertUserMappingOnDSR_Test {
    
    /**    
    * @Description : This method to test the HCNA_InsertUserMappingOnDSR Trigger.      
    **/
    static testMethod void test_InsertUserMappingOnDSR(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId(); 
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord(); 
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount); 
            insert parentAccount;
            List<Opportunity> opportunity= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
            insert opportunity;
            test.startTest();
            DSR_User_Mapping__c dsrMappingRecord = HCNA_UtilityClass.getDSRMappingRecord(runAsUser);
            insert dsrMappingRecord;
            DSR_User_Mapping__c dsrUserMappingRecord = HCNA_UtilityClass.getDSRMappingRecord2(runAsUser);
            insert dsrUserMappingRecord;
            List<Deal_Support_Request_del__c> dealSupportRecordsList= HCNA_UtilityClass.getDealSupportRecord(parentAccount,opportunity[0]);
            StaticVariableClass.firstRun=true;
            insert dealSupportRecordsList;
            System.assertNotEquals('dealSupportRecordsList',null);
            dealSupportRecordsList[0].GTM_Region__c= 'CHI';
            dealSupportRecordsList[0].Product_Family__c = 'ECR';
            StaticVariableClass.firstRun=true;
            Update dealSupportRecordsList[0];
            System.assertNotEquals('dealSupportRecordsList[0]',null);
            dealSupportRecordsList[0].GTM_Region__c= '--None--';
            StaticVariableClass.firstRun=true;
            Update dealSupportRecordsList[0];
            System.assertNotEquals('dealSupportRecordsList[0]',null);
            test.stopTest();
        }
    }
}