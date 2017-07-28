/**
* @ClassName         : HCNA_IdentiferTriggerDAOClassTest
* @Description       : This class is the test class which is covering the code of HCNA_IdentiferTriggerDAOClass 
* @Author            : Noor Ali Khan
* @Last Modified     : 29/03/2014
* @Discussionpoints  :No Information
*/

@isTest
public class HCNA_IdentiferTriggerDAOClassTest{ 
    /* 
    * @Description : Test coverage for method updateOpportunity()
    */
    @isTest static void test_updateOpportunity(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;        
        list<Opportunity> listOfOpportunityToUpdate = new list<Opportunity>();        
        system.runas(userRecordTest) {
            HCNA_IdentiferTriggerDAOClass doaClassTest = new HCNA_IdentiferTriggerDAOClass();
            test.startTest();
            doaClassTest.updateOpportunity(listOfOpportunityToUpdate);            
            test.stopTest();
        }
    }
    /* 
    * @Description : Test coverage for method retrieveAllOpportunityLineItems()
    */
    @isTest static void test_retrieveAllOpportunityLineItems(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;        
        set<Id> opportunityIds = new set<Id>();        
        system.runas(userRecordTest) {
            HCNA_IdentiferTriggerDAOClass doaClassTest = new HCNA_IdentiferTriggerDAOClass();
            test.startTest();
            doaClassTest.retrieveAllOpportunityLineItems(opportunityIds);            
            test.stopTest();
        }
    }        
}