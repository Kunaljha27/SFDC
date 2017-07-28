/**
* @ClassName         : M2O_DSRMasterOpptyUpdateForHCNATest
* @Description       : This class is the test class which is covering the code of M2O_DSRMasterOpptyUpdateForHCNA Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 11/10/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=true)
public Class M2O_DSRMasterOpptyUpdateForHCNATest {
     /* 
    * @Description : This test method covers the code of M2O_DSRMasterOpptyUpdateForHCNA Trigger
    */
    static testMethod void test_M2O_DSRMasterOpptyUpdateForHCNA(){
        Profile sysAdmin = M2O_UserTestDataUtility.getSystemAdminProfileId();
        User u = M2O_UserTestDataUtility.getHCUserRecord(sysAdmin.Id);
        insert u;
        System.runAs(u) { 
            Deal_Support_Request_del__c  dSR = M2O_OpportunityTestDataUtility.getDSRRecord();
            test.startTest() ;
            insert dSR;
            System.assertNotEquals(dSR,null);
            test.stopTest();
        }
    }
}