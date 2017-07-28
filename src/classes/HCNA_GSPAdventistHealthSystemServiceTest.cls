/**
* @ClassName         : HCNA_GSPAdventistHealthSystemServiceTest
* @Description       : This class is the test class which is covering the code of HCNA_GSPAdventistHealthSystemService Class.
* @Author            : Harmeet Kaur
* @Last Modified     : 26/06/2014
*/

@isTest
public class HCNA_GSPAdventistHealthSystemServiceTest{ 
    /**
    * @Description : This method is to test HCNA_GSPAdventistHealthSystemService class methods.
    **/
    @isTest(seeAllData=true)
    static void test_serviceClassMethods(){
        HCNA_GSPAdventistHealthSystemService ahsServiceObject = new HCNA_GSPAdventistHealthSystemService();
        Profile profileid = HCNA_ChartUtilityClass.getHCNAProfileId();
        User userRecordTest = HCNA_ChartUtilityClass.getUserRecord(profileid); 
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
            insert opptyRecordUS;
            opportunityList.add(opptyRecordUS);
            
            OpportunityLineItem opportunityLineItem = HCNA_ChartUtilityClass.getOpportunityLineItem(opptyRecordUS);
            insert opportunityLineItem;
            
            Strategic_Account_Plan__c sapRecord = new Strategic_Account_Plan__c();
            sapRecord = HCNA_ChartUtilityClass.getStrategicAccountPlanRecord(accountRecord);
            insert sapRecord;
            
            Philips_Order_Value__c povRecord = new Philips_Order_Value__c();
            povRecord = HCNA_ChartUtilityClass.getPhilipsOrderValueRecord(sapRecord);
            insert povRecord;
            
            List<Customer_Financial_Detail__c> financialDataList = new List<Customer_Financial_Detail__c>();
            Customer_Financial_Detail__c financialData = HCNA_ChartUtilityClass.getFinancialDetailRecord(sapRecord.Id);
            insert financialData;
                        
            System.assertNotEquals(ahsServiceObject.getAreaChart(sapRecord.id), null);
            System.assertNotEquals(ahsServiceObject.getPieChart(sapRecord.id), null);
            System.assertEquals(ahsServiceObject.getAreaChart(null), null);
            System.assertEquals(ahsServiceObject.getPieChart(null), null);
            System.assertNotEquals(ahsServiceObject.doNullCheckForPhilipsOrderValueRecord(new Philips_Order_Value__c()), null);
            System.assertNotEquals(ahsServiceObject.getOrderValueList(sapRecord.id), null);
            System.assertNotEquals(ahsServiceObject.getAccountList(accountRecord.Id), null);
            System.assertNotEquals(ahsServiceObject.getOpportunityList(new List<ID>{accountRecord.Id}), null);
            System.assertNotEquals(ahsServiceObject.getOpportunityList(new List<ID>{accountRecord.Id}, 'US'), null);
            System.assertNotEquals(ahsServiceObject.getOpportunityLineItemList(opportunityList), null);
            System.assertNotEquals(ahsServiceObject.getFinancialDetails(sapRecord.id), null);
            System.assertNotEquals(ahsServiceObject.doNullCheckForFinancialDetailRecord(new Customer_Financial_Detail__c()), null);
            System.assertNotEquals(ahsServiceObject.doNullCheckForSAPRecord(new Strategic_Account_Plan__c()), null);
            System.assertNotEquals(ahsServiceObject.getSAPRecord(sapRecord.id), null);
            System.assertNotEquals(ahsServiceObject.getAccountName(accountRecord.id), '');
            System.assertEquals(ahsServiceObject.getOrderValueList(null), null);
            System.assertEquals(ahsServiceObject.getAccountList(null), null);
            System.assertEquals(ahsServiceObject.getOpportunityList(null), null);
            System.assertEquals(ahsServiceObject.getOpportunityList(null, 'US'), null);
            System.assertEquals(ahsServiceObject.getOpportunityLineItemList(null), null);
            System.assertEquals(ahsServiceObject.getFinancialDetails(null), null);
            System.assertEquals(ahsServiceObject.getSAPRecord(null), null);
        }   System.assertEquals(ahsServiceObject.getAccountName(null), '');
            
        test.stopTest();
    }
    
    
}