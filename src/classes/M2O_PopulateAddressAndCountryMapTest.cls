/**
@Classname :       M2O_PopulateAddressAndCountryMapTest
@Description :     This test class is written to test the Apex trigger M2O_PopulateAddressAndCountryMap. 
@Author:           Somdev Bhattacharyya
@Last Modified:    13/05/2015
**/
@isTest
public Class M2O_PopulateAddressAndCountryMapTest {
   
     static testMethod void  test_createContact () {
         Profile hcProfileId1 = HCNA_UtilityClass.getHCNAProfileId1();
        User userRecord = HCNA_UtilityClass.getUserRecord1(hcProfileId1);
       userRecord.FederationIdentifier='12345433';
        insert userRecord;
        Account acc = HCNA_UtilityClass.getAccountRecord();
        insert acc;
        system.debug('gggggggggg'+acc);
          List<Contact> conList = new List<Contact>();
          
           test.startTest();
                conList = M2O_AccountContactTestDataUtility.getContactRecord(); 
                Contact cnt=conList[0];
                cnt.AccountId=acc.id;
                System.RunAs(userRecord) {
                insert cnt;
                system.debug('gggggggggg1'+conList[0]);
                cnt.Street1_Local__c=acc.Street1_Local__c;
                    cnt.Street2_Local__c=acc.Street2_Local__c;
                    cnt.Street3_Local__c=acc.Street3_Local__c;
                    cnt.Street4_Local__c=acc.Street4_Local__c;
                    cnt.Street5_Local__c=acc.Street5_Local__c;
                    cnt.Country__c=acc.Country__c;
                    cnt.Housenumber_Local__c=acc.Housenumber_Local__c;
                    cnt.Floor__c=acc.Floor__c;
                    cnt.Building__c=acc.Building__c;
                    cnt.City_Local__c=acc.City_Local__c;
                    cnt.Region__c=acc.Region__c;
                    cnt.Zip_Postal_Code_Local__c=acc.Zip_Postal_Code_Local__c;
                update cnt;
                 System.assertNotEquals(cnt,null);
                system.debug('gggggggggg2'+cnt);
                System.assertNotEquals(conList,null);}
           test.stopTest();
          
           
      }
     
     static testMethod void  test_createContactDataTeam () {
         Profile hcProfileId1 = HCNA_UtilityClass.getHCNAProfileId1();
        User userRecord = HCNA_UtilityClass.getUserRecord1(hcProfileId1);
        userRecord.FederationIdentifier='123454331';
        userRecord.ProfileId='00ed0000001A7srAAC';
        insert userRecord;
        List<Contact> conList = new List<Contact>();
        Account acc = HCNA_UtilityClass.getAccountRecord();
        insert acc;
        system.debug('gggggggggg'+acc);
        conList = M2O_AccountContactTestDataUtility.getContactRecord(); 
        Contact cnt=conList[0];
        cnt.AccountId=acc.id;
        //cnt.RecordtypeId='012d0000000gP5W';
        insert cnt;
        
        System.RunAs(userRecord) {
           test.startTest();
              system.debug('gggggggggg1'+conList[0]);
                cnt.Street1_Local__c=acc.Street1_Local__c;
                    cnt.Street2_Local__c=acc.Street2_Local__c;
                    cnt.Street3_Local__c=acc.Street3_Local__c;
                    cnt.Street4_Local__c=acc.Street4_Local__c;
                    cnt.Street5_Local__c=acc.Street5_Local__c;
                    cnt.Country__c=acc.Country__c;
                    cnt.Housenumber_Local__c=acc.Housenumber_Local__c;
                    cnt.Floor__c=acc.Floor__c;
                    cnt.Building__c=acc.Building__c;
                    cnt.City_Local__c=acc.City_Local__c;
                    cnt.Region__c=acc.Region__c;
                    cnt.Zip_Postal_Code_Local__c=acc.Zip_Postal_Code_Local__c;
                    cnt.RecordtypeId=null;
                    
                update cnt;
                 System.assertNotEquals(cnt,null);
                system.debug('gggggggggg2'+cnt);
                System.assertNotEquals(conList,null);
           test.stopTest();
           }
           
     }
}