/**
* @ClassName         : HCNA_GSPTriggerDAOClassTest
* @Description       : This class is the test class which is covering the code of HCNA_GSPTriggerDAOClass Class.
* @Author            : Noor Ali Khan
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/

@isTest
public class HCNA_GSPTriggerDAOClassTest{ 
    /* 
    * @Description : Test coverage for method retrieveAllRelatedContacts()
    */
    @isTest static void test_retrieveAllRelatedContacts(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;                
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            list <Account> AccountList = new list<Account>();
            AccountList = HCNA_UtilityClass.getListOfAccountRecord2();
            insert AccountList;       
            list <Account> AccountEmptyList = new list<Account>();
            doaClassTest.retrieveAllRelatedContacts(AccountList);
            doaClassTest.retrieveAllRelatedContacts(AccountEmptyList);
            doaClassTest.retrieveAllRelatedAccounts(AccountList);
            doaClassTest.retrieveAllRelatedAccounts(AccountEmptyList);
            doaClassTest.retrieveAllRelatedOpportunities(AccountList);
            doaClassTest.retrieveAllRelatedOpportunities(AccountEmptyList);
            doaClassTest.retrieveAllRelatedAssets(AccountList); 
            doaClassTest.retrieveAllRelatedAssets(AccountEmptyList);
            doaClassTest.retrieveAllRelatedAccountTeamMembers(AccountList);
            doaClassTest.retrieveAllRelatedAccountTeamMembers(AccountEmptyList);
            doaClassTest.retrieveListOfHospitalLocations(AccountList);
            doaClassTest.retrieveListOfHospitalLocations(AccountEmptyList);
            doaClassTest.retrieveListOfStrategicAccountPlan(AccountList);
            doaClassTest.retrieveListOfStrategicAccountPlan(AccountEmptyList);
            doaClassTest.retrieveListOfCompetitiveLandscape(AccountList);
            doaClassTest.retrieveListOfCompetitiveLandscape(AccountEmptyList);
            doaClassTest.toBeUpdatedOnCompetitiveLandscape(AccountList);
            doaClassTest.retrieveAllRelatedWinOpportunities(AccountEmptyList);
            doaClassTest.retrieveAllRelatedWinOpportunities(AccountList);
            doaClassTest.retrieveAllRelatedLossOpportunities(AccountEmptyList);
            doaClassTest.retrieveAllRelatedLossOpportunities(AccountList);
            doaClassTest.retrieveAllRelatedContractFromContractAccountLink(AccountEmptyList);
            doaClassTest.retrieveAllRelatedContractFromContractAccountLink(AccountList);
            doaClassTest.retrieveAccountList(AccountList);
            doaClassTest.retrieveAccountList(AccountEmptyList);
            test.stopTest();
        }
    }
                   
    
    /* 
    * @Description : Test coverage for method insertPeopleAndRelationship
    */
    @isTest static void test_insertPeopleAndRelationship(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;            
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            list <People_and_Relationship__c> peopleAndRelationshipList = new list<People_and_Relationship__c>();            
            peopleAndRelationshipList = HCNA_UtilityClass.getPeopleAndRelationshipRecord(sap);            
            insert peopleAndRelationshipList;
            doaClassTest.insertPeopleAndRelationship(peopleAndRelationshipList);
            list <Hospital_Locations__c> insertHospitalLocationList = new list<Hospital_Locations__c>();
            insertHospitalLocationList = HCNA_UtilityClass.getHospitalLocationRecord(sap);            
            insert insertHospitalLocationList;
            doaClassTest.insertHospitalLocation(insertHospitalLocationList );
            list <Asset__c> insertAssetsList= new list<Asset__c>();
            insertAssetsList = HCNA_UtilityClass.getAssetRecord(sap);            
            insert insertAssetsList;
            doaClassTest.insertAssets(insertAssetsList);
            list <Top_Opportunities__c> topOpportunitiesList= new list<Top_Opportunities__c>();
            topOpportunitiesList = HCNA_UtilityClass.getTopOpportunitiesRecord(sap);            
            insert topOpportunitiesList;
            doaClassTest.insertTopOpportunities(topOpportunitiesList);
            list<Account_Team__c> accountTeamList= new list<Account_Team__c>();
            accountTeamList = HCNA_UtilityClass.getAccountTeamRecord(sap);            
            insert accountTeamList;            
            doaClassTest.insertAccountTeam(accountTeamList);
            List<Account_Team__c> retrieveRelatedAccountTeamCatchList= new List<Account_Team__c>();
            retrieveRelatedAccountTeamCatchList.add(new Account_Team__c(id=null));                              
            doaClassTest.deleteRelatedAccountTeam(accountTeamList);
            doaClassTest.deleteRelatedAccountTeam(retrieveRelatedAccountTeamCatchList);
            list<Hospital_Locations__c> listOfHospitalLocations= new list<Hospital_Locations__c>();
            listOfHospitalLocations = HCNA_UtilityClass.getHospitalLocationRecord(sap);            
            insert listOfHospitalLocations;            
            doaClassTest.updateHospitalLocations(listOfHospitalLocations);
            test.stopTest();
        }
    }

   /* 
    * @Description : Test coverage for method updateStrategicAccountPlan
    */
    @isTest static void test_updateStrategicAccountPlan(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();            
            list<Strategic_Account_Plan__c> listOfStrategicAccountPlan = new list<Strategic_Account_Plan__c>();
            listOfStrategicAccountPlan = HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(acc);
            insert listOfStrategicAccountPlan;
            doaClassTest.updateStrategicAccountPlan(listOfStrategicAccountPlan );
            doaClassTest.updateStrategicAccountPlanRecord(listOfStrategicAccountPlan);
            doaClassTest.strategicAccountPlansToUpdate(listOfStrategicAccountPlan );
            test.stopTest();
        }
    }   

    /* 
    * @Description : Test coverage for method updateCompetitiveLandscape
    */
    @isTest static void test_updateCompetitiveLandscape(){
       Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            insert acc;
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            list<Competitive_Landscape__c> listOfCompetitiveLandscape = new list<Competitive_Landscape__c>();
            listOfCompetitiveLandscape = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(sap);
            insert listOfCompetitiveLandscape;            
            doaClassTest.updateCompetitiveLandscape(listOfCompetitiveLandscape);
            test.stopTest();
        }
    }  

    /* 
    * @Description : Test coverage for method retrieveListOfContractDetailRecordsToDelete
    */
    @isTest static void test_retrieveListOfContractDetailRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            insert acc;
            Contract contractRecord = new Contract();
            contractRecord = HCNA_UtilityClass.getListOfContractRecord(acc);
            insert contractRecord;
            Set<Id> setOfContractToBeDeletedIds = new Set<Id>();
            setOfContractToBeDeletedIds.add(contractRecord.id);
            Set<Id> setOfContractToBeDeletedEmptyIds = new Set<Id>();            
            Set<Id> setOfAccountToBeDeletedIds = New Set<Id>(); 
            setOfAccountToBeDeletedIds.add(acc.id);    
            Set<Id> setOfAccountToBeDeletedEmptyIds = New Set<Id>(); 
            doaClassTest.retrieveListOfContractDetailRecordsToDelete(setOfContractToBeDeletedIds,setOfAccountToBeDeletedIds);
            doaClassTest.retrieveListOfContractDetailRecordsToDelete(setOfContractToBeDeletedEmptyIds,setOfAccountToBeDeletedEmptyIds);
            doaClassTest.retrieveContractListForAccountLink(setOfContractToBeDeletedIds);
            doaClassTest.retrieveContractListForAccountLink(setOfAccountToBeDeletedEmptyIds);
            test.stopTest();
        }
    }   

    /* 
    * @Description : Test coverage for method listOfContractDetailRecordsToDelete
    */
    @isTest static void test_listOfContractDetailRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Contract_Detail__c> listOfContractDetailRecordsToDelete = new List<Contract_Detail__c>();                    
            listOfContractDetailRecordsToDelete = HCNA_UtilityClass.getContractDetailRecord(sap);            
            insert listOfContractDetailRecordsToDelete;
            List<Contract_Detail__c> retrieveRelatedContractDetailsCatchList= new List<Contract_Detail__c>();
            retrieveRelatedContractDetailsCatchList.add(new Contract_Detail__c(id=null));                               
            doaClassTest.listOfContractDetailRecordsToDelete(listOfContractDetailRecordsToDelete);
            doaClassTest.insertContractDetail(listOfContractDetailRecordsToDelete);
            doaClassTest.insertContractDetailRecords(listOfContractDetailRecordsToDelete);
            doaClassTest.deleteRelatedContractDetails(listOfContractDetailRecordsToDelete);
            doaClassTest.deleteRelatedContractDetails(retrieveRelatedContractDetailsCatchList);
            test.stopTest();
        }
    }  

    /* 
    * @Description : Test coverage for method retrieveListOfPeopleAndRelationshipRecordsToDelete
    */
    @isTest static void test_retrieveListOfPeopleAndRelationshipRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;           
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();  
            insert acc;
            list<Contact> conlist = new list<Contact>();
            conlist = HCNA_UtilityClass.getContactRecord(acc);
            insert conlist ;
            Set<Id> setOfToBeDeletedIds = New Set<Id>();
            setOfToBeDeletedIds.add(conlist[0].id);  
            Set<Id> setOfToBeDeletedEmptyIds = New Set<Id>();                      
            doaClassTest.retrieveListOfPeopleAndRelationshipRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveListOfPeopleAndRelationshipRecordsToDelete(setOfToBeDeletedIds);            
            List<Contact> contactRecordsEmptyList = new list<Contact>();                                            
            doaClassTest.retrieveContactList(conlist);
            doaClassTest.retrieveContactList(contactRecordsEmptyList);            
            test.stopTest();
        }
    } 

    /* 
    * @Description : Test coverage for method retrieveListOfHospitalLocationsRecordsToDelete
    */
    @isTest static void test_retrieveListOfHospitalLocationsRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;          
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();  
            insert acc;
            Set<Id> setOfToBeDeletedIds = New Set<Id>();
            setOfToBeDeletedIds.add(acc.id);
            Set<Id> setOfToBeDeletedEmptyIds = New Set<Id>();
            Set<Id> setOfConsolidatedAccountIdsEmpty = New Set<Id>();
            Set<Id> setOfConsolidatedAccountIds = New Set<Id>();
            setOfConsolidatedAccountIds.add(acc.id);
            doaClassTest.retrieveListOfHospitalLocationsRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveListOfHospitalLocationsRecordsToDelete(setOfToBeDeletedIds);
            doaClassTest.retrieveParentAccounts(setOfToBeDeletedIds);
            doaClassTest.retrieveParentAccounts(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveParentIds(setOfToBeDeletedIds);
            doaClassTest.getListOfStrategicAccountPlan(setOfConsolidatedAccountIds);
            doaClassTest.getListOfStrategicAccountPlan(setOfConsolidatedAccountIdsEmpty);
            doaClassTest.getListOfCompetitiveLandscape(setOfConsolidatedAccountIds);
            doaClassTest.getListOfCompetitiveLandscape(setOfConsolidatedAccountIdsEmpty);
            test.stopTest();
        }
    } 

    /* 
    * @Description : Test coverage for method listOfPeopleAndRelationshipRecordsToDelete 
    */
    @isTest static void test_listOfPeopleAndRelationshipRecordsToDelete (){
       Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<People_and_Relationship__c> listOfPeopleAndRelationshipRecordsToDelete = new List<People_and_Relationship__c>();
            listOfPeopleAndRelationshipRecordsToDelete = HCNA_UtilityClass.getPeopleAndRelationshipRecord(sap);            
            insert listOfPeopleAndRelationshipRecordsToDelete;            
            List<People_and_Relationship__c> listOfPeopleAndRelationshipRecordsToDeleteCatch = new List<People_and_Relationship__c>();
            listOfPeopleAndRelationshipRecordsToDeleteCatch.add(new People_and_Relationship__c(id=null));        
            doaClassTest.listOfPeopleAndRelationshipRecordsToDelete (listOfPeopleAndRelationshipRecordsToDelete);
            doaClassTest.listOfPeopleAndRelationshipRecordsToDelete (listOfPeopleAndRelationshipRecordsToDeleteCatch);            
            doaClassTest.insertPeopleAndrelationshipRecords(listOfPeopleAndRelationshipRecordsToDelete);
            doaClassTest.deleteRelatedPeopleAndRelations(listOfPeopleAndRelationshipRecordsToDelete);
            doaClassTest.deleteRelatedPeopleAndRelations(listOfPeopleAndRelationshipRecordsToDeleteCatch);
            test.stopTest();
        }
    } 

    /* 
    * @Description : Test coverage for method listOfHospitalLocationsRecordsToDelete
    */
    @isTest static void test_listOfHospitalLocationsRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Hospital_Locations__c> listOfHospitalLocationsRecordsToDelete = new List<Hospital_Locations__c>();
            listOfHospitalLocationsRecordsToDelete = HCNA_UtilityClass.getHospitalLocationRecord(sap);            
            insert listOfHospitalLocationsRecordsToDelete;            
            List<Hospital_Locations__c> listOfHospitalLocationsRecordsToDeleteCatch = new List<Hospital_Locations__c>();        
            listOfHospitalLocationsRecordsToDeleteCatch.add(new Hospital_Locations__c(id=null));        
            doaClassTest.listOfHospitalLocationsRecordsToDelete(listOfHospitalLocationsRecordsToDelete);
            doaClassTest.listOfHospitalLocationsRecordsToDelete(listOfHospitalLocationsRecordsToDeleteCatch );            
            doaClassTest.insertHospitalLocationsRecords(listOfHospitalLocationsRecordsToDelete);
            doaClassTest.deleteRelatedHospitalLocations(listOfHospitalLocationsRecordsToDelete);
            doaClassTest.deleteRelatedHospitalLocations(listOfHospitalLocationsRecordsToDeleteCatch);
            test.stopTest();
        }
    }                                           

    /* 
    * @Description : Test coverage for method retrieveListOfTopOpportunitiesRecordsToDelete
    */
    @isTest static void test_retrieveListOfTopOpportunitiesRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;          
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();  
            insert acc;
            list<Opportunity> listOpportunity = new list<Opportunity>();
            listOpportunity = HCNA_UtilityClass.getListOfOpportunityRecord(acc);
            insert listOpportunity;
            Set<Id> setOfToBeDeletedEmptyIds = New Set<Id>();
            Set<Id> setOfToBeDeletedIds = New Set<Id>();
            setOfToBeDeletedIds.add(listOpportunity[0].id);
            doaClassTest.retrieveListOfTopOpportunitiesRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveListOfTopOpportunitiesRecordsToDelete(setOfToBeDeletedIds);
            test.stopTest();
        }
    }     

    /* 
    * @Description : Test coverage for method listOfTopOpportunitiesRecordsToDelete
    */
    @isTest static void test_listOfTopOpportunitiesRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToDelete = new List<Top_Opportunities__c>();
            listOfTopOpportunitiesRecordsToDelete = HCNA_UtilityClass.getTopOpportunitiesRecord(sap);            
            insert listOfTopOpportunitiesRecordsToDelete;            
            List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToDeleteCatch = new List<Top_Opportunities__c>();
            listOfTopOpportunitiesRecordsToDeleteCatch.add(new Top_Opportunities__c(id=null));        
            doaClassTest.listOfTopOpportunitiesRecordsToDelete(listOfTopOpportunitiesRecordsToDelete);
            doaClassTest.listOfTopOpportunitiesRecordsToDelete(listOfTopOpportunitiesRecordsToDeleteCatch );            
            doaClassTest.insertTopOpportunitiesRecords(listOfTopOpportunitiesRecordsToDelete);
            doaClassTest.deleteRelatedTopOpportunities(listOfTopOpportunitiesRecordsToDelete);
            doaClassTest.deleteRelatedTopOpportunities(listOfTopOpportunitiesRecordsToDeleteCatch );
            test.stopTest();
        }
    }    

    /* 
    * @Description : Test coverage for method retrieveListOfAssetRecordsToDelete
    */    
    @isTest static void test_retrieveListOfAssetRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;           
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();  
            insert acc;
            List<Asset> listAsset = new List<Asset>();
            listAsset = HCNA_UtilityClass.getListOfAssetRecord(acc);
            insert listAsset;
            Set<Id> setOfToBeDeletedEmptyIds = New Set<Id>();
            Set<Id> setOfToBeDeletedIds = New Set<Id>();
            setOfToBeDeletedIds.add(listAsset[0].id);            
            doaClassTest.retrieveListOfAssetRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveListOfAssetRecordsToDelete(setOfToBeDeletedIds);
            doaClassTest.retrieveAssetList(listAsset);
            doaClassTest.retrieveAssetList(listAsset);
            test.stopTest();
        }
    }     

    /* 
    * @Description : Test coverage for method listOfAssetRecordsToDelete
    */
    @isTest static void test_listOfAssetRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc= new Account();
            acc = HCNA_UtilityClass.getAccountRecord();
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Asset__c> listOfAssetRecordsToDelete = new List<Asset__c>();
            listOfAssetRecordsToDelete  = HCNA_UtilityClass.getAssetRecord(sap);            
            insert listOfAssetRecordsToDelete;            
            List<Asset__c> listOfAssetRecordsToDeleteCatch = new List<Asset__c>();
            listOfAssetRecordsToDeleteCatch.add(new Asset__c(id=null));        
            doaClassTest.listOfAssetRecordsToDelete(listOfAssetRecordsToDelete);
            doaClassTest.listOfAssetRecordsToDelete(listOfAssetRecordsToDeleteCatch );
            doaClassTest.insertAssetsRecords(listOfAssetRecordsToDelete);
            doaClassTest.deleteRelatedAssets(listOfAssetRecordsToDelete);
            doaClassTest.deleteRelatedAssets(listOfAssetRecordsToDeleteCatch);
            test.stopTest();
        }
    }  
 
    /* 
    * @Description : Test coverage for method listOfKeyTransformationalWinRecordsToDelete
    */
    @isTest static void test_listOfKeyTransformationalWinRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;              
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Competitive_Landscape__c> competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
            competitiveLandscapePlanRecord = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(sap);
            insert competitiveLandscapePlanRecord;
            List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToDelete = new List<Key_Transformational_Win__c>();
            listOfKeyTransformationalWinRecordsToDelete = HCNA_UtilityClass.getKeytransformationalWinRecord(competitiveLandscapePlanRecord[0]);
            List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToDeleteCatch = new List<Key_Transformational_Win__c>();
            listOfKeyTransformationalWinRecordsToDeleteCatch.add(new Key_Transformational_Win__c(id=null));
            doaClassTest.listOfKeyTransformationalWinRecordsToDelete(listOfKeyTransformationalWinRecordsToDelete);
            doaClassTest.listOfKeyTransformationalWinRecordsToDelete(listOfKeyTransformationalWinRecordsToDeleteCatch );            
            doaClassTest.insertKeyTransformationalWin(listOfKeyTransformationalWinRecordsToDelete);
            doaClassTest.insertKeyTransformationalWinRecords(listOfKeyTransformationalWinRecordsToDelete);
            doaClassTest.deleteRelatedKeyWinOpportunities(listOfKeyTransformationalWinRecordsToDelete);
            doaClassTest.deleteRelatedKeyWinOpportunities(listOfKeyTransformationalWinRecordsToDeleteCatch);
            test.stopTest();
        }
    }

    /* 
    * @Description : Test coverage for method retrieveListOfKeyTransformationalLossRecordsToDelete
    */
    @isTest static void test_retrieveListOfKeyTransformationalLossRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;           
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            list<Opportunity> listOpportunity = new list<Opportunity>();                      
            listOpportunity = HCNA_UtilityClass.getListOfOpportunityRecord(acc); 
            insert  listOpportunity;
            Set<Id> setOfToBeDeletedIds = New Set<Id>();
            setOfToBeDeletedIds.add(listOpportunity[0].id); 
            Set<Id> setOfToBeDeletedEmptyIds = New Set<Id>();          
            doaClassTest.retrieveListOfKeyTransformationalWinRecordsToDelete(setOfToBeDeletedIds);
            doaClassTest.retrieveListOfKeyTransformationalWinRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveListOfKeyTransformationalLossRecordsToDelete(setOfToBeDeletedIds);
            doaClassTest.retrieveListOfKeyTransformationalLossRecordsToDelete(setOfToBeDeletedEmptyIds);
            doaClassTest.retrieveOpportunityList(listOpportunity);
            doaClassTest.retrieveOpportunityList(listOpportunity);            
            doaClassTest.retrieveWinOpportunityList(listOpportunity);
            doaClassTest.retrieveWinOpportunityList(listOpportunity);
            doaClassTest.retrieveLossOpportunityList(listOpportunity);
            doaClassTest.retrieveLossOpportunityList(listOpportunity);
            test.stopTest();
        }
    }     

    /* 
    * @Description :  Test coverage for method listOfKeyTransformationalLossRecordsToDelete
    */
    @isTest static void test_listOfKeyTransformationalLossRecordsToDelete(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Competitive_Landscape__c> competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
            competitiveLandscapePlanRecord = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(sap);
            insert competitiveLandscapePlanRecord;
            List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToDelete = new List<Key_Transformational_Loss__c>();
            listOfKeyTransformationalLossRecordsToDelete = HCNA_UtilityClass.getKeytransformationalLossRecord(competitiveLandscapePlanRecord[0]);
            List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToDeleteCatch = new List<Key_Transformational_Loss__c>();
            listOfKeyTransformationalLossRecordsToDeleteCatch.add(new Key_Transformational_Loss__c(id=null));        
            doaClassTest.listOfKeyTransformationalLossRecordsToDelete(listOfKeyTransformationalLossRecordsToDelete);
            doaClassTest.listOfKeyTransformationalLossRecordsToDelete(listOfKeyTransformationalLossRecordsToDeleteCatch );            
            doaClassTest.toBeDeletedOnCompetitiveLandscape(competitiveLandscapePlanRecord);
            doaClassTest.insertKeyTransformationalLoss(listOfKeyTransformationalLossRecordsToDelete);
            doaClassTest.insertKeyTransformationalLossRecords(listOfKeyTransformationalLossRecordsToDelete);
            doaClassTest.deleteRelatedKeyLossOpportunities(listOfKeyTransformationalLossRecordsToDelete);
            doaClassTest.deleteRelatedKeyLossOpportunities(listOfKeyTransformationalLossRecordsToDeleteCatch);
            test.stopTest();
        }
    }       
   
    /* 
    * @Description :  Test coverage for method toBeDeletedOnFinancialObjPerformanceMgmtProfit
    */
    @isTest static void test_toBeDeletedOnFinancialObjPerformanceMgmtProfit(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;           
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c sap = new Strategic_Account_Plan__c();
            sap = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert sap;
            List<Financial_Obj_Performance_Mgmt_Profit__c> financialObjPerformanceMgmtProfitRecordsList = new List<Financial_Obj_Performance_Mgmt_Profit__c>();        
            financialObjPerformanceMgmtProfitRecordsList = HCNA_UtilityClass.getListOfFinancialObjPerformanceMgmtProfitRecord(sap);
            doaClassTest.toBeDeletedOnFinancialObjPerformanceMgmtProfit(financialObjPerformanceMgmtProfitRecordsList);
            test.stopTest();
        }
    }    
           
    /* 
    * @Description : Test coverage for method retrieveRelatedPeopleAndRelations
    */
    @isTest static void test_retrieveRelatedPeopleAndRelations(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;                  
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c strategicAccountPlanRecord=new Strategic_Account_Plan__c();
            strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert strategicAccountPlanRecord;
            Set<Id> setOfStrategicAccountPlanId= New Set<Id>();
            setOfStrategicAccountPlanId.add(strategicAccountPlanRecord.id); 
            Set<Id> setOfStrategicAccountPlanEmptyId= New Set<Id>();
            doaClassTest.retrieveRelatedPeopleAndRelations(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedPeopleAndRelations(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveRelatedHospitalLocations(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedHospitalLocations(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveRelatedContractDetails(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedContractDetails(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveRelatedTopOpportunities(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedTopOpportunities(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveRelatedAssets(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedAssets(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveRelatedAccountTeam(setOfStrategicAccountPlanId);
            doaClassTest.retrieveRelatedAccountTeam(setOfStrategicAccountPlanEmptyId);
            doaClassTest.retrieveListOfCompetitiveLandscape(setOfStrategicAccountPlanEmptyId);
            test.stopTest();
        }
    }       
  
   
        
   
    /* 
    * @Description : Test coverage for method retrieveRelatedKeyWinOpportunities
    */
    @isTest static void test_retrieveRelatedKeyWinOpportunities(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c strategicAccountPlanRecord=new Strategic_Account_Plan__c();
            strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert strategicAccountPlanRecord;
            List<Competitive_Landscape__c> competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
            competitiveLandscapePlanRecord = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(strategicAccountPlanRecord); 
            insert competitiveLandscapePlanRecord;
            Set<Id> setOfCompetitiveLandscapeId= New Set<Id>();
            setOfCompetitiveLandscapeId.add(strategicAccountPlanRecord.id); 
            Set<Id> setOfCompetitiveLandscapeEmptyId= New Set<Id>();                                                
            doaClassTest.retrieveRelatedKeyWinOpportunities(setOfCompetitiveLandscapeId);
            doaClassTest.retrieveRelatedKeyWinOpportunities(setOfCompetitiveLandscapeEmptyId);
            test.stopTest();
        }
    }       
   
    /* 
    * @Description : Test coverage for method retrieveRelatedKeyLossOpportunities
    */
    @isTest static void test_retrieveRelatedKeyLossOpportunities(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;   
        system.runas(userRecordTest) {
            HCNA_GSPTriggerDAOClass doaClassTest = new HCNA_GSPTriggerDAOClass();
            test.startTest();
            Account acc = new  Account();
            acc =HCNA_UtilityClass.getAccountRecord();
            insert acc; 
            Strategic_Account_Plan__c strategicAccountPlanRecord=new Strategic_Account_Plan__c();
            strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(acc);
            insert strategicAccountPlanRecord;
            List<Competitive_Landscape__c> competitiveLandscapePlanRecord=new List<Competitive_Landscape__c>();
            competitiveLandscapePlanRecord = HCNA_UtilityClass.getListOfCompetitiveLandscapeRecord(strategicAccountPlanRecord); 
            insert competitiveLandscapePlanRecord;
            Set<Id> setOfCompetitiveLandscapeId= New Set<Id>();
            setOfCompetitiveLandscapeId.add(strategicAccountPlanRecord.id); 
            Set<Id> setOfCompetitiveLandscapeEmptyId= New Set<Id>();                                                            
            doaClassTest.retrieveRelatedKeyLossOpportunities(setOfCompetitiveLandscapeId);
            doaClassTest.retrieveRelatedKeyLossOpportunities(setOfCompetitiveLandscapeEmptyId);
            doaClassTest.updateAccountOnCompetitiveLandscape(competitiveLandscapePlanRecord);
            test.stopTest();
        }
    }       
      
  }