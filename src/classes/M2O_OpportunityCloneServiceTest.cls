/**
@Classname :       M2O_OpportunityCloneServiceTest
@Description :     This class is written to cover the code of M2O_OpportunityCloneService.
@Author:           Meeta Pramanik
@Last Modified:    29/12/2013
**/

@isTest(SeeAllData=true)
public class  M2O_OpportunityCloneServiceTest {
    M2O_OpportunityCloneService OpportunityClone = new M2O_OpportunityCloneService();
    
    /**
    @Description:  To test the method cloneOpportunity of M2O_OpportunityCloneService class. 
    **/ 
    
    static testMethod void test_cloneOpportunity() {
        M2O_OpportunityCloneService OpportunityClone = new M2O_OpportunityCloneService();
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        User user = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
        Region__c regionData;
        System.runAs(runAsUser) {
        regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
                Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(runAsUser.id, acc.id);
                update accountToUpdate;
            }
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            Test.startTest();
            OpportunityClone.cloneOpportunity(opp.Id);
            System.assertNotEquals(opp,null);
            Test.stopTest();          
        }
    }
  
    /**
    @Description:  To test the method cloneOpportunityEcoSystem of M2O_OpportunityCloneService class. 
    **/
    
    static testMethod void test_cloneOpportunityEcoSystem() {
        M2O_OpportunityCloneService OpportunityClone = new M2O_OpportunityCloneService();
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();    
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();    
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        User user = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id); 
        Region__c regionData;  
        System.runAs(runAsUser) { 
        regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;   
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
                Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(runAsUser.id, acc.id);
                update accountToUpdate;
            }
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            Opportunity_Ecosystem__c OppEcosystem = M2O_OpportunityTestDataUtility.getOptyEcosystemRecord(opp.id, acc.id);   
            insert OppEcosystem;
            Test.startTest();
            OpportunityClone.cloneOpportunityEcoSystem(opp.Id,opp);
            System.assertNotEquals(opp,null);
            Test.stopTest();          
        }
    }
  
    /**
    @Description:  To test the method cloneOpportunityTeamMember of M2O_OpportunityCloneService class. 
    **/
    
    static testMethod void test_cloneOpportunityTeamMember() {
        M2O_OpportunityCloneService OpportunityClone = new M2O_OpportunityCloneService();
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser; 
        Region__c regiondata;    
        System.runAs(runAsUser) {
            regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
                Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(runAsUser.id, acc.id);
                update accountToUpdate;
            }
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            List <OpportunityTeamMember> listOtm = new List<OpportunityTeamMember>();
            listOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert listOtm;
            delete listOtm;
            Test.startTest();
            OpportunityClone.cloneOpportunityTeamMember(opp.Id,opp);
            System.assertNotEquals(opp,null);
            Test.stopTest();
        }
    }
  
    /**
    @Description:  To test the method cloneOpportunityLineItem of M2O_OpportunityCloneService class. 
    **/
    
    static testMethod void test_cloneOpportunityLineItem() {
        M2O_OpportunityCloneService OpportunityClone = new M2O_OpportunityCloneService();
        M2O_OpportunityTestDataUtility leadOptyTest = new M2O_OpportunityTestDataUtility();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        Region__c regionData;
        System.runAs(runAsUser) {
        regionData= M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData); 
            insert acc;             
            System.runAs(m2oSystemAdminUser) {
            Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(runAsUser.id, acc.id);
            update accountToUpdate;
            }
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert opp;
            OpportunityTeamMember optyTeamMember = M2O_OpportunityTestDataUtility.getOptyTeamMemberRecord(opp.Id,runAsUser.id);
            PriceBook2 priceBook = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 product = M2O_OpportunityTestDataUtility.getProductRecord();
            insert product;
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(product.id, priceBook.id);
            insert pbe;
            OpportunityLineItem optyLineItem = M2O_OpportunityTestDataUtility.getOppLineItemRecord(opp.Id, pbe.Id); 
            insert optyLineItem;
            List<OpportunityLineItem > listOpptyLineItem = new List<OpportunityLineItem >();
            listOpptyLineItem.add(optyLineItem);
            Test.startTest();
            OpportunityClone.cloneOpportunityLineItem(opp.Id,opp);
            System.assertNotEquals(opp,null);
            Test.stopTest();
        }
    }
}