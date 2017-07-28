/**
@Classname :       M2O_EODAndStageUpdateServiceTest
@Description :     This class is written to cover the code of M2O_EODAndStageUpdateService class.
@Author:           Ramita Dutta
@Last Modified:    9/3/2014
**/

@isTest(SeeAllData=false)
public class  M2O_EODAndStageUpdateServiceTest {

    /**
    @Description:  To test the EODAndStageUpdate method. 
    **/ 
    static testMethod void test_EODAndStageUpdate(){
        Profile hcProfile  = [select id from Profile where name = 'HC NA Account Manager'];
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfile.Id);
        insert runAsUser;
        Region__c regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;
            List<Opportunity> masterOpportunityList2 = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord2(acc.id);
            insert masterOpportunityList2;
            Set<Id> setOfOppIds2 = new Set<Id>();
            for(Opportunity opportunityRecord : masterOpportunityList2){
                    setOfOppIds2.add(opportunityRecord.Opportunity_Hierarchy_Link__c);
            }
            M2O_EODAndStageUpdateService serviceClassObject = new M2O_EODAndStageUpdateService();
            serviceClassObject.EODAndStageUpdate(masterOpportunityList2,setOfOppIds2);
            
            List<Opportunity> masterOpportunityList3 = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord3(acc.id);
            insert masterOpportunityList3;
            Set<Id> setOfOppIds3 = new Set<Id>();
            for(Opportunity opportunityRecord : masterOpportunityList3){
                    setOfOppIds3.add(opportunityRecord.Opportunity_Hierarchy_Link__c);
            }
            serviceClassObject.EODAndStageUpdate(masterOpportunityList3,setOfOppIds3);
            
            List<Opportunity> masterOpportunityList4 = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord4(acc.id);
            insert masterOpportunityList4;
            Set<Id> setOfOppIds4 = new Set<Id>();
            for(Opportunity opportunityRecord : masterOpportunityList4){
                    setOfOppIds4.add(opportunityRecord.Opportunity_Hierarchy_Link__c);
            }
            serviceClassObject.EODAndStageUpdate(masterOpportunityList4,setOfOppIds4);       
        }
    }
    
    /**
    @Description:  To test the EODAndStageUpdateThroughMaster  method. 
    **/ 
    static testMethod void test_EODAndStageUpdateThroughMaster (){
    Profile hcProfile  = [select id from Profile where name = 'HC NA Account Manager'];
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfile.Id);
        insert runAsUser;
        Region__c regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;
            List<Opportunity> masterOpportunityList = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord3(acc.id);
            insert masterOpportunityList;
            List<Opportunity> subOpportunityList = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id,masterOpportunityList);
            insert subOpportunityList ;
            Set<Id> setOfOppIds = new Set<Id>();
            for(Opportunity opportunityRecord : subOpportunityList){
                    setOfOppIds.add(opportunityRecord.id);
            }
            M2O_EODAndStageUpdateService serviceClassObject = new M2O_EODAndStageUpdateService();
            serviceClassObject.EODAndStageUpdateThroughMaster(masterOpportunityList,setOfOppIds);
        }
    }
}