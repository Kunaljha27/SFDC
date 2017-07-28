/**
* @ClassName         : HCNA_UserMappingOnDSRDAOClass_Test
* @Description       : This class is the test class which is covering the code of HCNA_InsertUserMappingOnDSRDAOClass.
* @Author            : Ramita Dutta
* @Last Modified     : 
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_UserMappingOnDSRDAOClass_Test {
    /**
    * @Description : This method is to test HCNA_UserMappingOnDSRDAO Class.
    **/
    static testMethod void test_InsertUserMappingOnDSRDAO(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId(); 
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        System.runAs(runAsUser){
            HCNA_UserMappingOnDSRDAOClass daoClass = new HCNA_UserMappingOnDSRDAOClass();
            Account apexAccount = HCNA_UtilityClass.getAccountRecord(); 
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount); 
            insert parentAccount;
            List<Opportunity> opportunity= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
            insert opportunity;
            test.startTest();
            Set<String> productFamilySet = new Set<String>();
            Set<String> gtmRegionSet = new Set<String>();
            productFamilySet.add('ECR');
            gtmRegionSet.add('CHI');
            daoClass.getDsrMappingRecords(productFamilySet,gtmRegionSet);
            system.assertNotEquals(daoClass.getDsrMappingRecords(productFamilySet,gtmRegionSet),null);
            Set<String> prodFamilySet = new Set<String>();
            Set<String> RegionSet = new Set<String>();
            prodFamilySet.add(';');
            RegionSet.add(';');
            daoClass.getDsrMappingRecords(prodFamilySet,RegionSet);
            system.assertNotEquals(daoClass.getDsrMappingRecords(prodFamilySet,RegionSet),null);
            test.stopTest();    
        }
    }
}