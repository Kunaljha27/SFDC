/**
* @ClassName         : HCNA_GSPAdventistHealthSystemDAOTest
* @Description       : This class is the test class which is covering the code of HCNA_GSPAdventistHealthSystemDAO Class.
* @Author            : Harmeet Kaur
* @Last Modified     : 26/06/2014
*/

@isTest
public class HCNA_GSPAdventistHealthSystemDAOTest{ 
    /**
    * @Description : This method is to test HCNA_GSPAdventistHealthSystemDAOTest class methods.
    **/
    @isTest(seeAllData=true)
    static void test_daoClassMethods(){
        HCNA_GSPAdventistHealthSystemDAO ahsDAOObject = new HCNA_GSPAdventistHealthSystemDAO();
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
                        
            System.assertNotEquals(ahsDAOObject.getAreaChart(sapRecord.id), null);
            System.assertNotEquals(ahsDAOObject.getPieChart(sapRecord.id), null);
            System.assertNotEquals(ahsDAOObject.getOrderValueList(sapRecord.id), null);
            System.assertNotEquals(ahsDAOObject.getAccountList(accountRecord.Id), null);
            System.assertNotEquals(ahsDAOObject.getOpportunityList(new List<ID>{accountRecord.Id}), null);
            System.assertNotEquals(ahsDAOObject.getOpportunityList(new List<ID>{accountRecord.Id}, 'US'), null);
            System.assertNotEquals(ahsDAOObject.getOpportunityLineItemList(opportunityList), null);
            System.assertNotEquals(ahsDAOObject.getFinancialDetails(sapRecord.id), null);
            System.assertNotEquals(ahsDAOObject.getSAPRecord(sapRecord.id), null);
            System.assertNotEquals(ahsDAOObject.getAccountName(accountRecord.id), '');
            /*ahsDAOObject.getAreaChart('01pm00000000Io7');
            ahsDAOObject.getPieChart('01pm00000000Io7');
            ahsDAOObject.getOrderValueList('01pm00000000Io7');
            ahsDAOObject.getAccountList('01pm00000000Io7');
            ahsDAOObject.getOpportunityList(new List<ID>{'01pm00000000Io7'});
            ahsDAOObject.getOpportunityList(new List<ID>{'01pm00000000Io7'}, 'US');
            ahsDAOObject.getFinancialDetails('01pm00000000Io7');
            ahsDAOObject.getSAPRecord('01pm00000000Io7');*/
            
            ahsDAOObject.getAreaChart(sapRecord.id);
            ahsDAOObject.getPieChart(sapRecord.id);
            ahsDAOObject.getOrderValueList(sapRecord.id);
            ahsDAOObject.getAccountList(sapRecord.id);
            ahsDAOObject.getOpportunityList(new List<ID>{ascAccountRecord.id});
            ahsDAOObject.getOpportunityList(new List<ID>{ascAccountRecord.id}, 'US');
            ahsDAOObject.getFinancialDetails(sapRecord.id);
           // ahsDAOObject.getSAPRecord(sapRecord.id);
        }
        test.stopTest();
    }
    
    
}