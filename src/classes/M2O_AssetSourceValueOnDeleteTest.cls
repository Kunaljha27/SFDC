/**
@Classname :       M2O_AssetSourceValueOnDeleteTest
@Description :     This test class is written to test the Apex Trigger M2O_AssetSourceValueOnDelete. 
@Author:           Navaneet Pujar
@Last Modified:    15 June 2015
**/
@isTest(SeeAllData=true)
public Class M2O_AssetSourceValueOnDeleteTest {
    static testMethod void  createAsset() {
        
        List<Asset> updateAssetList = new List<Asset>();
        List<Asset> updateAssetList1 = new List<Asset>();
        Test.startTest();
        Account apexAccount = HCNA_UtilityClass.getAccountRecord();
        insert apexAccount;
        Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
        insert parentAccount;
        List<Asset> assetList = HCNA_UtilityClass.getListOfAssetRecord(parentAccount);
        Insert assetList;
        for(Asset asst : assetList){
            asst.Asset_Source__c = 'Other';
            updateAssetList.add(asst);
        }
        update updateAssetList;
        delete updateAssetList;
        
        List<Asset> assetList1 = HCNA_UtilityClass.getListOfAssetRecord(parentAccount);
        Insert assetList1;
        for(Asset asst : assetList1){
            asst.Asset_Source__c = 'SAP';
            updateAssetList1.add(asst);
        }
        update updateAssetList1;
        //delete updateAssetList1;
      Test.stopTest();
    }
}