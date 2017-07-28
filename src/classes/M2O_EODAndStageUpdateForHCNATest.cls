/**
@Classname :       M2O_EODAndStageUpdateForHCNATest
@Description :     This class is written to cover the code of M2O_EODAndStageUpdateForHCNA trigger.
@Author:           Ramita Dutta
@Last Modified:    9/3/2014
**/

@isTest(SeeAllData=false)
public class  M2O_EODAndStageUpdateForHCNATest {

    /**
    @Description:  To test the trigger EODAndStageUpdateForHCNA. 
    **/ 
    static testMethod void test_EODAndStageUpdateForHCNA(){
        Profile hcProfile  = [select id from Profile where name = 'HC NA Account Manager'];
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfile.Id);
        insert runAsUser;
        Region__c regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
        }
    }    
}