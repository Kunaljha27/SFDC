/**
@Classname :       M2O_AccountContactDataQualityDAOTest
@Description :     This test class is written to test the Apex class M2O_AccountContactDAO. 
@Author:           Meeta Pramanik 
@Last Modified:    10/06/2014
**/
@isTest(SeeAllData=true)
public class M2O_AccountContactDataQualityDAOTest {

/** @Description : This test method is used cover the updateMarketSector method of M2O_AccountContactDataQualityDAO class
    @Return type: void **/
    
    static TestMethod void Test_MarketAttribute(){
        User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
        M2O_AccountContactDataQualityDAO dAOHelper = new M2O_AccountContactDataQualityDAO();   
        
        System.runAs(runAsUser) {  
            Region__c regionData = New Region__c ();
            regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            
            List<Account> listUpdateAccount = New List<Account>();
            listUpdateAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert listUpdateAccount;
            
            M2O_AccountContactDataQualityDAO.updateAccount(listUpdateAccount); 
            listUpdateAccount[0].id = null;
            M2O_AccountContactDataQualityDAO.updateAccount(listUpdateAccount);
            System.assertNotEquals(listUpdateAccount,null);
            
        } 
    }
 }