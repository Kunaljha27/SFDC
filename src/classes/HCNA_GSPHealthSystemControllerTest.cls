/**
* @ClassName         : HCNA_GSPAdvHealthSystemControllerTest
* @Description       : This class is covering the code of HCNA_GSPAdventistHealthSystemController Class.
* @Author            : Alok Bhakat
* @Last Modified     : 26/06/2014
*/

@isTest
public class HCNA_GSPHealthSystemControllerTest{ 
    /**
    * @Description : This method is to test loadAverageData() method.
    **/
    @isTest static void test_loadAverageData(){
        Profile profileid = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_ChartUtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        
        test.startTest();
        system.runAs(userRecordTest){
            Account accountRecord = new Account();
            accountRecord = HCNA_ChartUtilityClass.getAccountRecord();
            insert accountRecord;
            
            Strategic_Account_Plan__c sapRecord = new Strategic_Account_Plan__c();
            sapRecord = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecord;
            
            Philips_Order_Value__c povRecord = new Philips_Order_Value__c();
            povRecord = HCNA_ChartUtilityClass.getPhilipsOrderValueRecord(sapRecord);
            povRecord.Year__c = '2013';
            insert povRecord;
            
            System.assertNotEquals(HCNA_GSPAdventistHealthSystemController.loadAverageData(sapRecord.id), null);       
        }
        test.stopTest();     
    }
    
    /**
    * @Description : This method is to test loadOpportunityData() method.
    **/
    @isTest static void test_loadOpportunityData(){
        Profile profileid = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_ChartUtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        
        test.startTest();
        system.runAs(userRecordTest){
            Account accountRecord = new Account();
            accountRecord = HCNA_ChartUtilityClass.getAccountRecord();
            insert accountRecord;
            
            Account ascAccountRecord = HCNA_ChartUtilityClass.getAssociatedAccountRecord(accountRecord);
            insert ascAccountRecord;
            
            List<Opportunity> opportunityList = new List<Opportunity>();
            Opportunity opptyRecordUS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opportunityList.add(opptyRecordUS);
                       
            Opportunity opptyRecordPCMS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordPCMS.Business_Group_HCNA__c='PCMS';
            opportunityList.add(opptyRecordPCMS);
            
            Opportunity opptyRecordIS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordIS.Business_Group_HCNA__c='IS';
            opportunityList.add(opptyRecordIS);
            
            Opportunity opptyRecordHISS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordHISS.Business_Group_HCNA__c='HISS';
            opportunityList.add(opptyRecordHISS);                        
            
            Opportunity opptyRecordPOS = HCNA_ChartUtilityClass.getOpportunityRecord(accountRecord, userRecordTest);
            opptyRecordPOS.Business_Group_HCNA__c='POS';
            opportunityList.add(opptyRecordPOS); 
            
            insert opportunityList;
            
            Strategic_Account_Plan__c sapRecord = new Strategic_Account_Plan__c();
            sapRecord = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecord;            
                      
            System.assertNotEquals(HCNA_GSPAdventistHealthSystemController.loadOpportunityData(accountRecord.id), null);                   
        } 
        test.stopTest();        
    }
    
    /**
    * @Description : This method is to test getFinancials() method.
    **/
    @isTest static void test_getFinancials(){
        Profile profileid = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_ChartUtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        system.runAs(userRecordTest){
            Account accountRecord = new Account();
            accountRecord = HCNA_ChartUtilityClass.getAccountRecord();
            insert accountRecord;
            
            Strategic_Account_Plan__c sapRecord = new Strategic_Account_Plan__c();
            sapRecord = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecord;
            
            Strategic_Account_Plan__c sapRecordWithoutCFD = new Strategic_Account_Plan__c();
            sapRecordWithoutCFD = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecordWithoutCFD;
            
            List<Customer_Financial_Detail__c> financialDataList = new List<Customer_Financial_Detail__c>();
            Customer_Financial_Detail__c financialData1 = HCNA_ChartUtilityClass.getFinancialDetailRecord(sapRecord.Id);
            financialDataList.add(financialData1);
          
            Customer_Financial_Detail__c financialData2 = HCNA_ChartUtilityClass.getFinancialDetailRecord(sapRecord.Id);
            financialData2.year__c = '2013';
            financialDataList.add(financialData2);
            
            Customer_Financial_Detail__c financialData3 = HCNA_ChartUtilityClass.getFinancialDetailRecord(sapRecord.Id);
            financialData3.year__c = '2012';
            financialDataList.add(financialData3);
            
            
            Customer_Financial_Detail__c financialData4 = HCNA_ChartUtilityClass.getFinancialDetailRecord(sapRecord.Id);
            financialData4.year__c = '2011';
            financialDataList.add(financialData4);
            
            insert financialDataList;            
             
            PageReference pageRef = Page.HCNA_GSPAdventistHealthSystem;       
            Test.setCurrentPage(pageRef);  
            ApexPages.currentPage().getParameters().put('SAPID',sapRecord.Id);
            HCNA_GSPAdventistHealthSystemController controllerObject = new HCNA_GSPAdventistHealthSystemController();
            System.assertNotEquals(controllerObject.getFinancials(), null);              
            ApexPages.currentPage().getParameters().put('SAPID',sapRecordWithoutCFD.Id);
            System.assertNotEquals(controllerObject.getFinancials(), null);           
        }
        test.stopTest();     
    }
    
    /**
    * @Description : This method is to test getScorecard() method.
    **/
    @isTest static void test_getScorecard(){
        Profile profileid = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_ChartUtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        system.runAs(userRecordTest){
            Account accountRecord = new Account();
            accountRecord = HCNA_ChartUtilityClass.getAccountRecord();
            insert accountRecord;
            
            Strategic_Account_Plan__c sapRecord = new Strategic_Account_Plan__c();
            sapRecord = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecord;
                       
            PageReference pageRef = Page.HCNA_GSPAdventistHealthSystem;       
            Test.setCurrentPage(pageRef);  
            ApexPages.currentPage().getParameters().put('SAPID',sapRecord.Id);
            HCNA_GSPAdventistHealthSystemController controllerObject = new HCNA_GSPAdventistHealthSystemController();
            System.assertNotEquals(controllerObject.getScorecard(), null);       
            System.assertNotEquals(HCNA_GSPAdventistHealthSystemController.loadBenchmark(sapRecord.id), null);                   
        }
        test.stopTest();     
    }
}