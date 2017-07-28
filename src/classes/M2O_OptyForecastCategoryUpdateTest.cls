/**
@Classname :       M2O_OptyForecastCategoryUpdateTest
@Description :     This test class is written to test the Apex Trigger / Class  M2O_OptyForecastCategoryUpdate. 
@Author:           Rupsa Hore
@Last Modified:    18/02/2014
**/

@isTest(SeeAllData=false)
private Class M2O_OptyForecastCategoryUpdateTest{
    
     @isTest static void test_getVocFundingMatrixVal() {
         Map<Id, String> optyForecastCategoryIdMap = new Map<Id, String>();         
         string profileName = 'M2O Sales Healthcare';  
         User runAsUser = M2O_UserTestDataUtility.getUserRecord(profileName); 
         insert runAsUser;
         Validate_M2O_Profiles__c m2oProfileValidation = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(runAsUser.ProfileId);
         Boolean isInsert = true;  
         System.runAs(runAsUser){
             OM_VOC_FDR_Matrix__c matrixObj = M2O_OpportunityTestDataUtility.getVOCFDRMatrixRecord();
             insert matrixObj;
             List<Opportunity> opportunityList = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord();
             system.debug(opportunityList[0]);
             insert opportunityList;
             for(Opportunity oppObj : opportunityList){
                 optyForecastCategoryIdMap.put(oppObj.Id, oppObj.ForecastCategoryName);
             } 
             test.startTest(); 
             M2O_OptyForecastCategoryUpdateService.getVocFundingMatrixVal();
             system.assertequals(matrixObj.Name, 'Matrix1');
             test.stopTest();   
         }
     }
     
     @isTest static void test_updateForecastCategory() {
         Map<Id, String> optyForecastCategoryIdMap = new Map<Id, String>();         
         string profileName = 'M2O Sales Healthcare';  
         User runAsUser = M2O_UserTestDataUtility.getUserRecord(profileName); 
         insert runAsUser;
         Validate_M2O_Profiles__c m2oProfileValidation = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(runAsUser.ProfileId);
         Boolean isInsert = true;  
         System.runAs(runAsUser){
             OM_VOC_FDR_Matrix__c matrixObj = M2O_OpportunityTestDataUtility.getVOCFDRMatrixRecord();
             insert matrixObj;
             List<Opportunity> opportunityList = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord();
             insert opportunityList;
             for(Opportunity oppObj : opportunityList){
                 optyForecastCategoryIdMap.put(oppObj.Id, oppObj.ForecastCategoryName);
             }
             test.starttest(); 
             M2O_OptyForecastCategoryUpdateService.updateForecastCategory(opportunityList, isInsert, optyForecastCategoryIdMap);
             system.assertequals(isInsert, true);
             test.stoptest();   
         }
     } 
     
     @isTest static void test_checkProbability() {
         Map<Id, String> optyForecastCategoryIdMap = new Map<Id, String>();         
         string profileName = 'M2O Sales Healthcare';  
         User runAsUser = M2O_UserTestDataUtility.getUserRecord(profileName); 
         insert runAsUser;
         Validate_M2O_Profiles__c m2oProfileValidation = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(runAsUser.ProfileId);
         system.debug('>>>>>>>>>>>>>>>>>>>>>>> '+runAsUser);
         Boolean isInsert = true; 
         System.runAs(runAsUser){
             system.debug('>>>>>>>>>>>>>>>>>>>>>>> '+runAsUser);
             OM_VOC_FDR_Matrix__c matrixObj = M2O_OpportunityTestDataUtility.getVOCFDRMatrixRecord();
             insert matrixObj;
             List<Opportunity> opportunityList = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord();
             insert opportunityList;
             for(Opportunity oppObj : opportunityList){
                 optyForecastCategoryIdMap.put(oppObj.Id, oppObj.ForecastCategoryName);
             }
             test.starttest(); 
             M2O_OptyForecastCategoryUpdateService.checkProbability(matrixObj.Probability__c, opportunityList[0]);
             system.assertequals(matrixObj.Probability__c, 40);
             test.stoptest();   
        }
    } 
    
    @isTest static void test_updateupdateForecastCategoryForPartner() {
         Map<Id, String> optyForecastCategoryIdMap = new Map<Id, String>();        
         string profileName = 'M2O Sales Healthcare';  
         User runAsUser = M2O_UserTestDataUtility.getUserRecord(profileName); 
         insert runAsUser;
         Validate_M2O_Profiles__c m2oProfileValidation = M2O_OpportunityTestDataUtility.getValidateM2OProfiles(runAsUser.ProfileId);
         Boolean isInsert = true;   
         System.runAs(runAsUser){
             OM_VOC_FDR_Matrix__c matrixObj = M2O_OpportunityTestDataUtility.getVOCFDRMatrixRecord();
             insert matrixObj;
             List<Opportunity> opportunityList = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord();
             insert opportunityList;
             for(Opportunity oppObj : opportunityList){
                 optyForecastCategoryIdMap.put(oppObj.Id, oppObj.ForecastCategoryName);
             }
             test.starttest(); 
             M2O_OptyForecastCategoryUpdateService.updateForecastCategoryForPartner(opportunityList);
             system.assertequals(opportunityList[0].Name, 'Test Master Opty0');
             test.stoptest();   
        }
    } 
}