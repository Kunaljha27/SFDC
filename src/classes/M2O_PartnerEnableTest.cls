/**
@Classname :       M2O_PartnerEnableTest
@Description :     This test class is written to test the Trigger M2O_PartnerEnable.
@Author:           Somdev Bhattacharyya
@Last Modified:    9/03/2014
**/
@isTest(SeeAllData=true)
public class M2O_PartnerEnableTest{

/** @Description : This test method is used cover the Trigger
**/
    
    static TestMethod void Test_PartnerEnableTrigger(){
   
       User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
        test.starttest();  
        System.runAs(runAsUser) {  
        Region__c regionData = New Region__c();
        
        regionData= M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
  
        List<Account> listAccount = New List<Account>();
        List<Account> listAccount2 = New List<Account>();
        listAccount=M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
        listAccount[0].Name='test';
        listAccount[0].Market__c='test';
        listAccount[0].region__c=regionData.id;
        insert listAccount[0];
        test.stoptest(); 
        
       } 
    }
}