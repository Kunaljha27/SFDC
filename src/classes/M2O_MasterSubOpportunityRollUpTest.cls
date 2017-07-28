/**
@Classname :        M2O_MasterSubOpportunityRollUpTest 
@Description :      This test class is written to test the trigger M2O_MasterSubOpportunityRollUp. 
@Author:            Piyali Saha
@Last Modified:     17/12/2013
**/

@isTest(SeeAllData=true)
public class M2O_MasterSubOpportunityRollUpTest { 

    /**
    @Description:  This test Method is used to insert Account , Opportunity , Master Opportunity and Sub Opportunity records by inserting two different users 
                  and using those users to insert records and by that triggering the M2O_MasterSubOpportunityRollUp.
    @Return:       null   
    **/ 
      
    static testMethod void test_rollUp() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        Validate_M2O_Profiles__c validateM2OProfile = M2O_OpportunityTestDataUtility.deleteValidateM2OProfiles();
        insert validateM2OProfile;        
        Region__C regionData;
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
                acc.ownerId = runAsUser.id;
                update acc;
            }
            Set<id> setOpportunityID = new Set<id>();
            List<Opportunity> listMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.id);
            insert listMasterOpportunity;
            List<Opportunity> listSubOpportunity = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id, listMasterOpportunity);
            insert listSubOpportunity;
            for(Opportunity opp : listSubOpportunity) {
                setOpportunityID.add(opp.id);
            }
            Opportunity opp = [SELECT ExpectedRevenue FROM Opportunity WHERE id =: listSubOpportunity[0].id];
            system.debug('oooooooooooooo'+opp);
            //System.assertEquals(opp.ExpectedRevenue, 600.00);
            PriceBook2 priceBook = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 product = M2O_OpportunityTestDataUtility.getProductRecord();
            insert product;
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(product.id, priceBook.id);
            insert pbe;
            List<OpportunityLineItem> listOpportunityLineItem = M2O_OpportunityTestDataUtility.getListOfOppLineItemRecord(setOpportunityID, pbe.id);
            insert listOpportunityLineItem;
            //listSubOpportunity[0].Opportunity_Hierarchy_Link__c = null;
            //update listSubOpportunity[0];
            Opportunity updatedOpportunity = [SELECT ExpectedRevenue FROM Opportunity WHERE id =: listSubOpportunity[0].id];
            //System.assertEquals(updatedOpportunity.ExpectedRevenue, 180);            
            delete listSubOpportunity;
        }
    }
}