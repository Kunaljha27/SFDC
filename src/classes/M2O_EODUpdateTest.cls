/**
@Classname :       M2O_EODUpdateTest 
@Description :     This test class is written to test the Apex trigger M2O_EODUpdate. 
@Author:           Somdev Bhattacharyya
@Last Modified:    20/05/2014
**/
@isTest(SeeAllData=true)
public Class M2O_EODUpdateTest {
   
    /**
    @Description: Here in this test method the M2O_EODUpdate trigger .
    @Return: null 
    **/
    
     static testMethod void  test_M2O_EODUpdate() {
          Profile m2oSysAdmProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdmProfileId.Id);
        insert runAsUser;
      //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(m2oSysAdmProfileId.Id);
       //insert validateM2OProfile; 
       System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account acc = new Account ();
            acc = M2O_OpportunityTestDataUtility.getAccountRecord (regionData);
            insert acc;
            opportunity oppty = new opportunity ();
            oppty= M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            insert oppty;
            PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
            insert prod;
            
            PricebookEntry pbe1 = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            insert pbe1;
            //PricebookEntry pbe2 = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            //insert pbe2;
            OpportunityLineItem optyLineItem1 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            OpportunityLineItem optyLineItem2 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            Test.startTest();
            insert optyLineItem1;
            insert optyLineItem2;
            System.assertNotEquals(oppty.Id,null);
            Test.stopTest();
            optyLineItem1.Quantity =4;
            update optyLineItem1;
            delete optyLineItem1;
            
            
            

         }
     }
}