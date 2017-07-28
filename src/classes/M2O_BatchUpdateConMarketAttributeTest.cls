/**
@Classname :       M20_BatchUpdateConMarketAttributeTest
@Description :     This test class is written to cover the code of Batch class M20_BatchUpdateContactMarketAttribute. 
@Author:           Meeta Pramanik
@Last Modified:    29/11/2013
**/

@isTest(SeeAllData=false)
public class M2O_BatchUpdateConMarketAttributeTest {

    /**
    @Description :     This test method is used to test the M20_BatchUpdateContactMarketAttribute batch class.
    @Return type:      void
    **/ 

    static testMethod void test_batchContactAttribute() {
        //This is used to get the user record.
        string profileName = 'M2O Sales Healthcare';  
        User runAsUser = M2O_UserTestDataUtility.getUserRecord(profileName); 
        insert runAsUser;
        System.runAs(runAsUser) {       
            list<Contact> listContact= new list<Contact>(M2O_AccountContactTestDataUtility.getContactRecord());
            insert listContact;
            Test.startTest();            
            M2O_BatchUpdateContactMarketAttribute batchUpdate = new M2O_BatchUpdateContactMarketAttribute();
            Database.executeBatch(batchUpdate, 200);
            System.assertNotEquals(listContact,null);
            Test.stopTest();
            Integer i = [SELECT COUNT() FROM Contact_Market_Sector_Attributes__c];
            System.assertNotEquals(i, 0);
            
        }
    }
}