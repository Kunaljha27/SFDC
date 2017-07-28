/**
@Classname :       M2O_UpdateNamesServiceTest
@Description :     This test class is written to test the trigger M2O_UpdateNamesService. 
@Author:           Vishal Kashyap
@Last Modified:    14/11/2014
**/

@isTest(SeeAllData=false)
public class M2O_UpdateNamesServiceTest{
    /**
    @Description:  This test Method is used to cover the M2O_UpdateNamesService Class
    @Return:       Void   
    **/  
    
    static testMethod void test_updateProductHierarchyNames() {
        M2O_UpdateNamesService serviceClass = new M2O_UpdateNamesService();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        System.runAs(runAsUser) {
            Product_Adjustment_ID__c custAdj = new Product_Adjustment_ID__c();
            custAdj.Name = 'tewww10';
            custAdj.Corresponding_Name__c='text1';
            custAdj.Type__c='Sector';
            insert custAdj;
            List<Product_Hierarchy__c> prodList = new List<Product_Hierarchy__c>();
            Product_Hierarchy__c prodHierRecord = new Product_Hierarchy__c();
            prodHierRecord.Name='hier1';
            prodHierRecord.Article_Group_ID__c ='tst1';
            prodHierRecord.Business_Group_ID__c ='tst3';
            prodHierRecord.Business_Group_Name__c ='Business Group';
            prodHierRecord.Business_Unit_ID__c ='Business Unit';
            prodHierRecord.Lifecycle_Status__c ='1 - Draft';
            prodHierRecord.Business_Unit_Name__c ='tst7';
            prodHierRecord.Main_Article_Group_ID__c ='te8';
            prodHierRecord.Sector_ID__c ='te10';
            prodHierRecord.Sector_Name__c='Sector';
            prodList.add(prodHierRecord);
            Product_Hierarchy__c prodHierRecord2 = new Product_Hierarchy__c();
            prodHierRecord2.Name='hier2';
            prodHierRecord2.Article_Group_Name__c='';
            prodHierRecord2.Main_Article_Group_Name__c='';
            prodList.add(prodHierRecord2);
            serviceClass.updateProductHierarchyNames(prodList,prodList);
            
            
            Product_Adjustment_ID__c custAdj1 = new Product_Adjustment_ID__c();
            custAdj1.Name = 'Business Unit';
            custAdj1.Corresponding_Name__c='text1';
            custAdj1.Type__c='Sector';
            insert custAdj1;
            List<Product_Hierarchy__c> prodList1 = new List<Product_Hierarchy__c>();
            Product_Hierarchy__c prodHierRecordt = new Product_Hierarchy__c();
            prodHierRecordt .Name='hier1';
            prodHierRecordt .Article_Group_ID__c ='tst1';
            prodHierRecordt .Business_Group_ID__c ='tst3';
            prodHierRecordt .Business_Group_Name__c ='Business Group';
            prodHierRecordt .Business_Unit_ID__c ='Business Unit';
            prodHierRecordt .Lifecycle_Status__c ='1 - Draft';
            prodHierRecordt .Business_Unit_Name__c ='tst7';
            prodHierRecordt .Main_Article_Group_ID__c ='te8';
            prodHierRecordt .Sector_ID__c ='te10';
            prodHierRecordt .Sector_Name__c='Sector';
            prodList.add(prodHierRecordt );
            Product_Hierarchy__c prodHierRecord21 = new Product_Hierarchy__c();
            prodHierRecord21 .Name='hier2';
            prodHierRecord21 .Article_Group_Name__c='';
            prodHierRecord21 .Main_Article_Group_Name__c='';
            prodList1 .add(prodHierRecord21 );
            serviceClass.updateProductHierarchyNames(prodList1 ,prodList1 );
            
            Product_Adjustment_ID__c custAdj2 = new Product_Adjustment_ID__c();
            custAdj2.Name = 'tst3';
            custAdj2.Corresponding_Name__c='text1';
            custAdj2.Type__c='Business Group';
            insert custAdj2;
            List<Product_Hierarchy__c> prodList3 = new List<Product_Hierarchy__c>();
            Product_Hierarchy__c prodHierRecord33 = new Product_Hierarchy__c();
            prodHierRecord33.Name='hier1';
            prodHierRecord33.Article_Group_ID__c ='tst1';
            prodHierRecord33.Business_Group_ID__c ='tst3';
            prodHierRecord33.Business_Group_Name__c ='Business Group';
            prodHierRecord33.Business_Unit_ID__c ='Business Unit';
            prodHierRecord33.Lifecycle_Status__c ='1 - Draft';
            prodHierRecord33.Business_Unit_Name__c ='tst7';
            prodHierRecord33.Main_Article_Group_ID__c ='te8';
            prodHierRecord33.Sector_ID__c ='te10';
            prodHierRecord33.Sector_Name__c='Sector';
            prodList3 .add(prodHierRecord33);
            Product_Hierarchy__c prodHierRecord42 = new Product_Hierarchy__c();
            prodHierRecord42 .Name='hier2';
            prodHierRecord42 .Article_Group_Name__c='';
            prodHierRecord42 .Main_Article_Group_Name__c='';
            prodList3 .add(prodHierRecord2);
            serviceClass.updateProductHierarchyNames(prodList3 ,prodList3 );
            
            Product_Adjustment_ID__c custAdjp = new Product_Adjustment_ID__c();
            custAdjp.Name = 'tst1';
            custAdjp.Corresponding_Name__c='text1';
            custAdjp.Type__c='grnam';
            insert custAdjp;
            List<Product_Hierarchy__c> prodListp = new List<Product_Hierarchy__c>();
            Product_Hierarchy__c prodHierRecordp = new Product_Hierarchy__c();
            prodHierRecordp .Name='hier1';
            prodHierRecordp .Article_Group_ID__c ='tst1';
            prodHierRecordp .Article_Group_Name__c ='grnam';
            prodHierRecordp .Business_Group_ID__c ='tst3';
            prodHierRecordp .Business_Group_Name__c ='Business Group';
            prodHierRecordp .Business_Unit_ID__c ='Business Unit';
            prodHierRecordp .Lifecycle_Status__c ='1 - Draft';
            prodHierRecordp .Business_Unit_Name__c ='tst7';
            prodHierRecordp .Main_Article_Group_ID__c ='te8';
            prodHierRecordp .Sector_ID__c ='te10';
            prodHierRecordp .Sector_Name__c='Sector';
            prodListp .add(prodHierRecordp );
            Product_Hierarchy__c prodHierRecordpr = new Product_Hierarchy__c();
            prodHierRecordpr .Name='hier2';
            prodHierRecordpr .Article_Group_Name__c='';
            prodHierRecordpr .Main_Article_Group_Name__c='';
            prodListp .add(prodHierRecordpr );
            serviceClass.updateProductHierarchyNames(prodListp ,prodListp );
        }
    }
}