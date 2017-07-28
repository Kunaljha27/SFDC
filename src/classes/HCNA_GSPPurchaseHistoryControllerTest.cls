/**
* @ClassName         : HCNA_GSPPurchaseHistoryControllerTest
* @Description       : This class is the test class which is covering the code of HCNA_GSPPurchaseHistoryController Class.
* @Author            : Harmeet Kaur
* @Last Modified     : 26/06/2014
*/

@isTest
public class HCNA_GSPPurchaseHistoryControllerTest{ 
    
    /**    
    * @Description : This method to test the HCNA_GSPPurchaseHistoryControllerTest Class      
    **/
    @isTest static void test_getPurchaseHistoryDetails(){
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
            insert povRecord;
            
            PageReference pageRef = Page.HCNA_GSPAdventistHealthSystem;       
            Test.setCurrentPage(pageRef);  
            ApexPages.currentPage().getParameters().put('SAPID',sapRecord.Id);
            
            HCNA_GSPPurchaseHistoryController.loadAreaChartData(sapRecord.id);
            system.assertNotEquals(HCNA_GSPPurchaseHistoryController.loadAreaChartData(sapRecord.id),null);
            HCNA_GSPPurchaseHistoryController.loadPieChartData(sapRecord.id);
            system.assertNotEquals(HCNA_GSPPurchaseHistoryController.loadPieChartData(sapRecord.id),null);
            HCNA_GSPPurchaseHistoryController purchaseHistoryClass = new HCNA_GSPPurchaseHistoryController();
            purchaseHistoryClass.getTotalTable();
            System.assertNotEquals(purchaseHistoryClass.getTotalTable(), null);
            purchaseHistoryClass.getTotalForTable();
            System.assertNotEquals(purchaseHistoryClass.getTotalForTable(), null);
            purchaseHistoryClass.getPieChartTable();
            System.assertNotEquals(purchaseHistoryClass.getPieChartTable(), null);
        }
        test.stopTest();     
    }
}