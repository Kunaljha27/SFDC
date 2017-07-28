/**
@Classname :       M2O_ForecastCategoryUpdateDAOTest
@Description :     This test class is written to test the Apex class M2O_ForecastCategoryUpdateDAO. 
@Author:           Ramita
@Last Modified:    9/17/2013
**/
@isTest(SeeAllData=false)
public class M2O_ForecastCategoryUpdateDAOTest{
    static TestMethod void test_updateForecasteCategory(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesLIProfileId();
        UserRole roleId = M2O_UserTestDataUtility.getGlobalRoleRecord();
        User runAsUser = M2O_UserTestDataUtility.getHCRoleUserRecord(hcProfileId.Id,roleId.id);
        insert runAsUser;
        Profile hcProfileId1 = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser1 = M2O_UserTestDataUtility.getHCRoleUserRecord(hcProfileId1.Id,roleId.id);
        runAsUser1.Username = 'Atest222.user.philips2@abc.com';
        runAsUser1.CommunityNickname= 'test1';
        insert runAsUser1;
        System.runAs(runAsUser) {
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            test.startTest();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            List<Contact> conList = M2O_AccountContactTestDataUtility.getContactRecord(acc.Id);
            insert conList[0];
        
            System.runAs(runAsUser1) {
                    Profile hcProfileId2 = M2O_UserTestDataUtility.getM2OPotalProfileId();
                    runAsUser.ProfileId = hcProfileId2.id;
                    //update runAsUser;
            }
        
            M2O_ForecastCategoryUpdateDAO.updateForecasteCategory(opp);
            M2O_ForecastCategoryUpdateDAO.roleBasedForcasteChange(opp.id,runAsUser.id);
            M2O_ForecastCategoryUpdateDAO.roleBasedForcasteChange(acc.id,acc.id);
            Set<Id> userRoleIdSet = new Set<Id>();
            userRoleIdSet.add(runAsUser.userRoleId);
            M2O_ForecastCategoryUpdateDAO.getAllSubRoleIds(userRoleIdSet);
            userRoleIdSet.add(acc.id);
            M2O_ForecastCategoryUpdateDAO.getAllSubRoleIds(userRoleIdSet);
            test.stopTest();
        }
    }
}