/**
@Classname :       M2O_CalculateAmountOnOptyRollUpTest  
@Description :     This test class is written to to cover the code of class M2O_CalculateAmountOppRollUpService.
@Author:           Piyali Saha
@Last Modified:    20/12/2013
**/
@isTest(SeeAllData=true)
public class M2O_CalculateAmountOppRollUpServiceTest { 

     /**
    @Description:  To test the method insertOpportunityMasterAmount of M2O_CalculateAmountOppRollUpServiceclass. 
    **/
            
    static testMethod void test_insertOpportunityMasterAmount() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        Set<id> setOpportunityID = new Set<id>();
        M2O_CalculateAmountOppRollUpService calcAmountOptyRollup = new M2O_CalculateAmountOppRollUpService();
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
            List<Opportunity> listMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.id);
            insert listMasterOpportunity;
            List<Opportunity> listSubOpportunity = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id, listMasterOpportunity);
            insert listSubOpportunity;
            for(Opportunity opp : listSubOpportunity) {
                setOpportunityID.add(opp.id);
            }           
            Map<id, opportunity> mapNewOpportunity = new Map<id, Opportunity>([SELECT id, ExpectedRevenue, CurrencyIsoCode, 
                                                                               Opportunity_Hierarchy_Link__c FROM Opportunity 
                                                                               WHERE id in: setOpportunityID]);
            test.startTest();
            calcAmountOptyRollup.insertOpportunityMasterAmount(mapNewOpportunity);
            //System.assertEquals(mapNewOpportunity.get(listSubOpportunity[0].id).ExpectedRevenue, 600.00);
            test.stopTest();
        }
    }
    
    /**
    @Description:  To test the method updateOpportunityMasterAmount of M2O_CalculateAmountOppRollUpServiceclass. 
    **/
    
    /*static testMethod void test_updateOpportunityMasterAmount() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        M2O_CalculateAmountOppRollUpService calcAmountOptyRollup = new M2O_CalculateAmountOppRollUpService();
        Validate_M2O_Profiles__c delcs = M2O_OpportunityTestDataUtility.deleteValidateM2OProfiles();
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
            Map<id, opportunity> mapOldOpportunity = new Map<id, Opportunity>([SELECT id, Opportunity_Hierarchy_Link__c, CurrencyIsoCode,
                                                                               ExpectedRevenue, Amount FROM Opportunity 
                                                                               WHERE id in: setOpportunityID]);
            PriceBook2 priceBook = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 product = M2O_OpportunityTestDataUtility.getProductRecord();
            insert product;
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(product.id, priceBook.id);
            insert pbe;
            List<OpportunityLineItem> listOpportunityLineItem = M2O_OpportunityTestDataUtility.getListOfOppLineItemRecord(setOpportunityID, pbe.id);
            insert listOpportunityLineItem;
            Map<id, opportunity> mapNewOpportunity = new Map<id, Opportunity>([SELECT id, ExpectedRevenue,Opportunity_Hierarchy_Link__c,
                                                                               CurrencyIsoCode FROM Opportunity 
                                                                               WHERE id in: setOpportunityID]);
            test.startTest();
            calcAmountOptyRollup.updateOpportunityMasterAmount(mapOldOpportunity, mapNewOpportunity);
            System.assertNotEquals(mapNewOpportunity.get(listSubOpportunity[0].id).ExpectedRevenue, mapOldOpportunity.get(listSubOpportunity[0].id).ExpectedRevenue);
            test.stopTest();
        }
    }
    */
    
    /**
    @Description:  To test the method deductOpportunityMasterAmount of M2O_CalculateAmountOppRollUpServiceclass. 
    **/
    
    static testMethod void test_deductOpportunityMasterAmount() {
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        M2O_CalculateAmountOppRollUpService calcAmountOptyRollup = new M2O_CalculateAmountOppRollUpService();
        Validate_M2O_Profiles__c delcs = M2O_OpportunityTestDataUtility.deleteValidateM2OProfiles();
        Set<id> setOpportunityID = new Set<id>();
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
            List<Opportunity> listMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.id);
            insert listMasterOpportunity;
            test.startTest();
            List<Opportunity> listSubOpportunity = M2O_OpportunityTestDataUtility.getListSubOpportunity(acc.id, listMasterOpportunity);
            insert listSubOpportunity;
            for(Opportunity opp : listSubOpportunity) {
                setOpportunityID.add(opp.id);
            }
            PriceBook2 priceBook = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 product = M2O_OpportunityTestDataUtility.getProductRecord();
            insert product;
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(product.id, priceBook.id);
            insert pbe;
            List<OpportunityLineItem> listOpportunityLineItem = M2O_OpportunityTestDataUtility.getListOfOppLineItemRecord(setOpportunityID, pbe.id);
            insert listOpportunityLineItem;
            Map<id, opportunity> mapOldOpportunity = new Map<id, Opportunity>([SELECT id, Opportunity_Hierarchy_Link__c, CurrencyIsoCode,
                                                                               ExpectedRevenue, Amount 
                                                                               FROM Opportunity WHERE id in: setOpportunityID]);
            delete listSubOpportunity;
            calcAmountOptyRollup.deductOpportunityMasterAmount(mapOldOpportunity);
            Opportunity masterUpdatedOpportunity = [SELECT id, Sub_Opportunities_Total_Amounts__c FROM Opportunity
                                                    WHERE id =: listMasterOpportunity[0].id];
            System.debug('tttttttttttt'+listMasterOpportunity[0].Sub_Opportunities_Total_Amounts__c);
            system.assertEquals(listMasterOpportunity[0].Sub_Opportunities_Total_Amounts__c, 0.0);
            test.stopTest();
        }
    }
}