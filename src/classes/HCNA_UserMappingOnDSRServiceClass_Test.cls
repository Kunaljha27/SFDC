/**
* @ClassName         : HCNA_UserMappingOnDSRServiceClass_Test
* @Description       : This class is the test class which is covering the code of HCNA_InsertUserMappingOnDSRServiceClass.
* @Author            : Ramita Dutta
* @Last Modified     : 
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_UserMappingOnDSRServiceClass_Test {
    
    /**
    * @Description : This method is to test HCNA_InsertUserMappingOnDSRServiceClass.
    **/
    static testMethod void test_InsertUserMappingOnDSRService(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId(); 
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        System.runAs(runAsUser){
            HCNA_UserMappingOnDSRServiceClass serviceClass = new HCNA_UserMappingOnDSRServiceClass();
            Account apexAccount = HCNA_UtilityClass.getAccountRecord(); 
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount); 
            insert parentAccount;
            List<Opportunity> opportunity= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
            insert opportunity;
            test.startTest();
            DSR_User_Mapping__c dsrMappingRecord = HCNA_UtilityClass.getDSRMappingRecord(runAsUser);
            insert dsrMappingRecord;
            List<Deal_Support_Request_del__c> dealSupportRecordsList= HCNA_UtilityClass.getDealSupportRecord(parentAccount,opportunity[0]);
            insert dealSupportRecordsList;
            system.assertNotEquals(dealSupportRecordsList,null);
            String uniqueCombination='CHMV'+'CHE';
            Set<String> productFamilySet = new Set<String>();
            Set<String> gtmRegionSet = new Set<String>();
            Map<String,DSR_User_Mapping__c> mapOfDealUser = new Map<String,DSR_User_Mapping__c>();
            mapOfDealUser.put(uniqueCombination,dsrMappingRecord);
            system.assertNotEquals(mapOfDealUser,null);
            productFamilySet.add('CHMV');
            gtmRegionSet.add('CHE');
            serviceClass.getDsrMappingRecords(productFamilySet,gtmRegionSet);
            system.assertNotEquals(serviceClass.getDsrMappingRecords(productFamilySet,gtmRegionSet),null);
            serviceClass.assignValuesToDSR(dealSupportRecordsList,mapOfDealUser);
            dealSupportRecordsList[0].Product_Family__c = 'test';
            serviceClass.assignValuesToDSR(dealSupportRecordsList,mapOfDealUser);
            test.stopTest();
        }
    }
}