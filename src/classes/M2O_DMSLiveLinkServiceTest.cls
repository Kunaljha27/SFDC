/**
* @ClassName         : M2O_DMSLiveLinkServiceTest
* @Description       : This is the test class which is covering the code of M2O_DMSLiveLinkService class.
* @Author            : Vishal Kashyap
* @Last Modified     : 04/16/2014
* @Discussionpoints  : No Information
*/
@isTest(SeeAllData=false)
private class M2O_DMSLiveLinkServiceTest{
    
    /**
    * @Description : This function covers updateOpportunity
    * @param       : null
    * @return      : null
    **/ 
    @isTest static void test_updateOpportunity() {
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        insert userRecordTest;
        System.runAs(userRecordTest) {
            test.starttest();
                M2O_DMSLiveLinkService.updateOpportunity('006110000034seC','0298767','url');
                M2O_DMSLiveLinkService.updateOpportunity('006110000034seC','','');
            test.stoptest();
        }
    }
    
    /**
    * @Description : This function covers checkForOppProduct
    * @param       : null
    * @return      : null
    **/ 
    @isTest static void test_checkForOppProduct() {
        User userRecordTest=M2O_CaptureDeleteTestDataUtility.getUserRecord(M2O_CaptureDeleteTestDataUtility.getM2OSalesLIProfileId());
        insert userRecordTest;
        System.runAs(userRecordTest) {
            test.starttest();
                M2O_DMSLiveLinkService.checkForOppProduct('006110000034seC');
            test.stoptest();
        }
    }
}