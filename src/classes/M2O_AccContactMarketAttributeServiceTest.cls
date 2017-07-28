/**
@Classname :       M2O_AccContactMarketAttributeServiceTest
@Description :     This test class is written to test the Apex class M2O_AccountContactMarketAttributeService. 
@Author:           Meeta Pramanik
@Last Modified:    2/12/2013
**/
@isTest(SeeAllData=true)
public Class M2O_AccContactMarketAttributeServiceTest {
   
    /**
    @Description: Here in this test method the AccMarketAttribute method of the M2O_AccountContactMarketAttributeService is tested.
    @Return: null 
    **/
      @isTest
     static void  test_createAccountMarketSectorAttribute() { 
      
        M2O_AccountContactMarketAttributeService accCntctMarktAttr = new M2O_AccountContactMarketAttributeService();  
        List<Account> accountList = new List<Account>();
        set<id> idAccnt= new set<id>();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);  
        //insert validateM2OProfile; 
        System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            accountList = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert accountList;
            for(Account acc : accountList) {
                idAccnt.add(acc.id);
            }
        System.assertNotEquals(accountList,null);
        accCntctMarktAttr.createAccountMarketSectorAttribute(idAccnt,accountList);
        }
    }

    /**
    @Description: Here in this test method the CntctMarketAttribute method of the M2O_AccountContactMarketAttributeService class is tested.
    @Return: null
    **/
 
    public static testmethod void  test_createContactMarketSectorAttribute() {  
        M2O_AccountContactMarketAttributeService accCntctMarktAttr = new M2O_AccountContactMarketAttributeService();  
        List<Contact> conList = new List<Contact>();
        set<id> idCntct= new set<id>();
        //Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        //User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        //insert runAsUser;
        //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);  
        //insert validateM2OProfile; 
        //System.runAs(runAsUser) { 
            test.startTest();
            conList = M2O_AccountContactTestDataUtility.getContactRecord(); 
            insert conList;
            for(Contact con : conList) {
                idCntct.add(con.id);
            }
            //System.assertNotEquals(conList,null);
            accCntctMarktAttr.createContactMarketSectorAttribute(idCntct,conList);
            test.stopTest();
        //}
    }
    
    /**
    @Description: Here in this test method the createAccountMarketSectorAttributeForBatch method of the M2O_AccountContactMarketAttributeService class is tested.
    @Return: null
    **/
     @isTest
    static  void  test_createAccountMarketSectorAttributeForBatch() { 
        M2O_AccountContactMarketAttributeService  accCntctMarktAttr = new M2O_AccountContactMarketAttributeService();       
        List<Account> accList = new List<Account>();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);
        //insert validateM2OProfile;   
        System.runAs(runAsUser) {  
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            accList = M2O_AccountContactTestDataUtility.getAccountRecord(regionData);
            insert accList;
            test.startTest();
            //System.assertNotEquals(accList,null);    
            accCntctMarktAttr.createAccountMarketSectorAttributeForBatch(accList);
            test.stopTest();
        }
    }
    
    /**
    @Description: Here in this test method the createAccountMarketSectorAttributeForBatch method of the M2O_AccountContactMarketAttributeService class is tested.
    @Return: null
    **/
    @isTest 
   static  void  test_createContactMarketSectorAttributeForBatch() {
        M2O_AccountContactMarketAttributeService accCntctMarktAttr = new M2O_AccountContactMarketAttributeService();  
        List<Contact> conList = new List<Contact>();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        //User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        //insert runAsUser;
        //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(hcProfileId.Id);  
        //insert validateM2OProfile; 
        //System.runAs(runAsUser) { 
            test.startTest();
            conList = M2O_AccountContactTestDataUtility.getContactRecord(); 
            insert conList;
            //System.assertNotEquals(conList,null);
            accCntctMarktAttr.createContactMarketSectorAttributeForBatch(conList);
            test.stopTest();
        //}
    }
    
}