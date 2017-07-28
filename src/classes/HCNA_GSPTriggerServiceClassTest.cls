/**
* @ClassName         : HCNA_GSPTriggerServiceClassTest 
* @Description       : This class is the test class which is covering the code of HCNA_GSPTriggerServiceClass.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_GSPTriggerServiceClassTest {
    /*
    * @Description : This method is used to assign account Information and delete Account Team Records. 
    */
    static testMethod void  test_AccountTeam(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Strategic_Account_plan__c strategicAccountPlanRecord = new Strategic_Account_plan__c();
            strategicAccountPlanRecord.Account__c = parentAccount.Id;
            Insert strategicAccountPlanRecord;
            List<Strategic_Account_Plan__c> strategicPlanList =HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanList;
            List<Account_Team__c> accountTeamList =HCNA_UtilityClass.getAccountTeamRecord(strategicAccountPlanRecord);
            Insert accountTeamList;
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            Map<Id,Account> mapOfIdWithAccount = New Map<Id,Account>();
            mapOfIdWithAccount.put(ParentAccount.Id,ParentAccount);
            serviceClass.deleteRelatedAccountTeam(accountTeamList);
            serviceClass.assignAccountInformation(strategicPlanList,mapOfIdWithAccount);      
            test.stopTest();
        }        
    }
    /*
    * @Description : This method is used to create, retrieve and delete contract Detail record from Strategic Account Plan.
    */
    static testMethod void  test_Contract(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Contract contractRecord= HCNA_UtilityClass.getListOfContractRecord(parentAccount);
            Insert contractRecord;
            List<Contract_Account_Link__c> contractAccountLinkList=HCNA_UtilityClass.getListOfContractAccountLinkRecord(parentAccount,contractRecord);
            Insert contractAccountLinkList;
            Strategic_Account_plan__c strategicPlanRecord = new Strategic_Account_plan__c();
            strategicPlanRecord.Account__c = parentAccount.Id;
            Insert strategicPlanRecord;
            List<Strategic_Account_Plan__c> strategicPlanList=HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanList;
            test.startTest();
            Set<Id>  setOfToBeDeletedIds = new Set<Id>();
            Set<Id>  setOfAccountToBeDeletedIds= new Set<Id>();
            Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId = New Map<Id,Set<Id>>();
            List<Contract_Detail__c> contractDetailList = HCNA_UtilityClass.getContractDetailRecord(strategicPlanRecord);
            Insert contractDetailList;
            for(Contract_Account_Link__c contractLinkRecord :contractAccountLinkList){
                setOfToBeDeletedIds.add(contractLinkRecord.Contract_Name__c);
                setOfAccountToBeDeletedIds.add(contractLinkRecord.Account_Name__c);
            }
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                if(mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c) != null) { 
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
                else{
                    mapOfStrategicAccountPlanIdWithAccountId.put(strategicAccountPlanRecord.Account__c,New Set<Id>());
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
            }
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.insertListOfContractDetailRecords(contractDetailList);
            serviceClass.contractDetailRecordsToDelete(contractDetailList);
            serviceClass.retrieveListOfContractDetailRecordsToDelete(setOfToBeDeletedIds,setOfAccountToBeDeletedIds);       
            serviceClass.createContractDetail(contractAccountLinkList,mapOfStrategicAccountPlanIdWithAccountId);
            serviceClass.deleteRelatedContractDetails(contractDetailList);
            test.stopTest(); 
        }
    }
    /*
    * @Description : This method is used to create, retrieve and delete People and relationship record from Strategic Account Plan.
    */   
    static testMethod void  test_Contact(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            List<Contact> contactList = HCNA_UtilityClass.getContactRecord(parentAccount);
            Insert contactList;
            Strategic_Account_plan__c strategicPlanRecord = new Strategic_Account_plan__c();
            strategicPlanRecord.Account__c = parentAccount.Id;
            Insert strategicPlanRecord;
            List<Strategic_Account_Plan__c> strategicPlanList=HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanList;
            test.startTest();
            Set<Id>  setOfToBeDeletedIds = new Set<Id>();
            Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId = New Map<Id,Set<Id>>();
            List<People_And_Relationship__c> peopleAndRelationshipList =HCNA_UtilityClass.getPeopleAndRelationshipRecord(strategicPlanRecord);
            Insert peopleAndRelationshipList;
            for(Contact contactRecord :contactList){
                setOfToBeDeletedIds.add(contactRecord.Id);
            }
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                if(mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c) != null) { 
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
                else{
                    mapOfStrategicAccountPlanIdWithAccountId.put(strategicAccountPlanRecord.Account__c,New Set<Id>());
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
            }
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.insertListOfPeopleAndRelationShipRecords(peopleAndRelationshipList);
            serviceClass.peopleAndRelationshipRecordsToDelete(peopleAndRelationshipList);
            serviceClass.retrieveListOfPeopleAndRelationshipRecordsToDelete(setOfToBeDeletedIds);       
            serviceClass.createPeopleAndRelationship(contactList,mapOfStrategicAccountPlanIdWithAccountId);
            serviceClass.updateStrategicAccountPlan(strategicPlanList);
            serviceClass.deleteRelatedPeopleAndRelations(peopleAndRelationshipList);
            test.stopTest(); 
        }
    }
    /*
    * @Description :  This method is used to create, retrieve and delete hospitl locations record from Strategic Account Plan.
    */
    static testMethod void  test_Account(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            List<Account> accountList= new List<Account>();
            accountList.add(parentAccount);
            Strategic_Account_Plan__c strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlanRecord;
            Competitive_Landscape__c competitiveLandsacpeRecord = new Competitive_Landscape__c();
            competitiveLandsacpeRecord.Name='testCLT';
            competitiveLandsacpeRecord.Strategic_Account_Plan__c = strategicAccountPlanRecord.id;
            competitiveLandsacpeRecord.AccountId_lookup__c= strategicAccountPlanRecord.Account__c;
            Insert competitiveLandsacpeRecord;
            test.startTest();
            Map<Id,Account> mapOfAccountIdAndAccount= new Map<Id,Account>();
            Set<Id>  setOfToBeDeletedIds = new Set<Id>();
            Set<Id> setOfStrategicAccountPlanId = new Set<Id>();
            Set<Id> setOfCompetitiveLandscapeId = new Set<Id>();
            setOfStrategicAccountPlanId.add(strategicAccountPlanRecord.id);
            setOfCompetitiveLandscapeId.add(competitiveLandsacpeRecord.id);
            List<Hospital_Locations__c> hospitalLocationsList = HCNA_UtilityClass.getHospitalLocationRecord(strategicAccountPlanRecord);
            Insert hospitalLocationsList;
            for(Account accountRecord :accountList){
                setOfToBeDeletedIds.add(accountRecord.Id);
                mapOfAccountIdAndAccount.put(accountRecord.Id,accountRecord);
            }
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.hospitalLocationsRecordsToDelete(hospitalLocationsList);
            serviceClass.retrieveListOfHospitalLocationsRecordsToDelete(setOfToBeDeletedIds);       
            serviceClass.retrieveListOfHospitalLocations(accountList,mapOfAccountIdAndAccount,setOfToBeDeletedIds);
            serviceClass.retrieveListOfStrategicAccountPlan(accountList,mapOfAccountIdAndAccount,setOfToBeDeletedIds);
            serviceClass.retrieveListOfCompetitiveLandscape(accountList,mapOfAccountIdAndAccount,setOfToBeDeletedIds);
            serviceClass.retrieveListOfStrategicAccountPlanForChangedHierarachy(accountList,setOfToBeDeletedIds);
            serviceClass.updateHospitalLocations(hospitalLocationsList);
            serviceClass.retrieveRelatedPeopleAndRelations(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedHospitalLocations(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedContractDetails(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedTopOpportunities(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedAssets(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedAccountTeam(setOfStrategicAccountPlanId);
            serviceClass.retrieveRelatedKeyWinOpportunities(setOfCompetitiveLandscapeId);
            serviceClass.retrieveRelatedKeyLossOpportunities(setOfCompetitiveLandscapeId);
            serviceClass.deleteRelatedHospitalLocations(hospitalLocationsList);
            serviceClass.insertListOfHospitalLocationsRecords(hospitalLocationsList);
            test.stopTest(); 
        }
    }
    /*
    * @Description : This method is used to create, retrieve and delete top opportunities record from Strategic Account Plan.
    */   
    static testMethod void  test_Opportunity(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            List<Opportunity> opportunityList= HCNA_UtilityClass.getListOfOpportunityRecord(parentAccount);
            insert opportunityList;
            List<Opportunity> childOpportunityList= HCNA_UtilityClass.getListOfChildOpportunityRecord(parentAccount);
            insert childOpportunityList;
            Strategic_Account_plan__c strategicPlanRecord = new Strategic_Account_plan__c();
            strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_Account_Plan__c> strategicPlanList= new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            Competitive_Landscape__c competitiveLandsacpeRecord= new Competitive_Landscape__c();
            competitiveLandsacpeRecord.Name='testCLT';
            competitiveLandsacpeRecord.Strategic_Account_Plan__c = strategicPlanRecord.id;
            competitiveLandsacpeRecord.AccountId_lookup__c= strategicPlanRecord.Account__c;
            Insert competitiveLandsacpeRecord;
            List<Competitive_Landscape__c> compeitiveLandscapeList = new List<Competitive_Landscape__c>();
            compeitiveLandscapeList.add(competitiveLandsacpeRecord);
            test.startTest();
            Set<Id>  setOfToBeDeletedIds = new Set<Id>();
            Set<Id>  setOfConsolidatedAccountIds = new Set<Id>();
            Set<Id>  setOfToBeDeletedLossIds = new Set<Id>();
            Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId = New Map<Id,Set<Id>>();
            Map<Id,Id> mapOfCompetitiveLandscapeWithStrategicAccountPlanId= New Map<Id,Id>();
            List<Top_Opportunities__c> topOpporunitiesList= HCNA_UtilityClass.getTopOpportunitiesRecord(strategicPlanRecord);
            Insert topOpporunitiesList;
            List<Key_Transformational_Win__c> keyTransformationalWinList = HCNA_UtilityClass.getKeytransformationalWinRecord(competitiveLandsacpeRecord);
            Insert keyTransformationalWinList;
            List<Key_Transformational_Loss__c> keyTransformationalLossList = HCNA_UtilityClass.getKeytransformationalLossRecord(competitiveLandsacpeRecord);
            Insert keyTransformationalLossList;
            for(Opportunity opportunityRecord : opportunityList){
                setOfToBeDeletedIds.add(opportunityRecord.Id);
            }
            for(Opportunity childOpportunityRecord : childOpportunityList){
                setOfToBeDeletedLossIds.add(childOpportunityRecord.Id);
                setOfConsolidatedAccountIds.add(childOpportunityRecord.AccountId);
            }
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                if(mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c) != null) { 
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
                else{
                    mapOfStrategicAccountPlanIdWithAccountId.put(strategicAccountPlanRecord.Account__c,New Set<Id>());
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
            }
            for(Competitive_Landscape__c competitiveRecord :compeitiveLandscapeList){
                mapOfCompetitiveLandscapeWithStrategicAccountPlanId.put(competitiveRecord.Strategic_account_plan__c,competitiveRecord.Id);
            }
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.insertKeyTransformationalLoss(keyTransformationalLossList);
            serviceClass.topOpportunitiesRecordsToDelete(topOpporunitiesList);
            serviceClass.retrieveListOfTopOpportunitiesRecordsToDelete(setOfToBeDeletedIds);       
            serviceClass.keyTransformationalWinRecordsToDelete(keyTransformationalWinList);
            serviceClass.retrieveListOfKeyTransformationalWinRecordsToDelete(setOfToBeDeletedIds);       
            serviceClass.keyTransformationalLossRecordsToDelete(keyTransformationalLossList);
            serviceClass.retrieveListOfKeyTransformationalLossRecordsToDelete(setOfToBeDeletedLossIds);       
            serviceClass.createTopOpportunities(opportunityList,mapOfStrategicAccountPlanIdWithAccountId);
            serviceClass.createKeyTransformationalWin(opportunityList,mapOfStrategicAccountPlanIdWithAccountId,mapOfCompetitiveLandscapeWithStrategicAccountPlanId);
            serviceClass.createKeyTransformationalLoss(opportunityList,mapOfStrategicAccountPlanIdWithAccountId,mapOfCompetitiveLandscapeWithStrategicAccountPlanId);
            serviceClass.deleteRelatedTopOpportunities(topOpporunitiesList);
            serviceClass.deleteRelatedKeyWinOpportunities(keyTransformationalWinList);
            serviceClass.deleteRelatedKeyLossOpportunities(keyTransformationalLossList);
            serviceClass.insertListOfKeyTransformationalLossRecords(keyTransformationalLossList);
            serviceClass.insertListOfKeyTransformationalWinRecords(keyTransformationalWinList);
            serviceClass.insertListOfTopOpportunitiesRecords(topOpporunitiesList);
            serviceClass.getListOfCompetitiveLandscape(setOfConsolidatedAccountIds);
            test.stopTest(); 
        }
    }
    /*
    * @Description : This method is used to create, retrieve and delete Asset record from Strategic Account Plan.
    */   
    static testMethod void  test_Asset(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            List<Asset> assetList = HCNA_UtilityClass.getListOfAssetRecord(parentAccount);
            Insert assetList;
            Strategic_Account_plan__c strategicPlanRecord = new Strategic_Account_plan__c();
            strategicPlanRecord.Account__c = parentAccount.Id;
            Insert strategicPlanRecord;
            List<Strategic_Account_Plan__c> strategicPlanList =HCNA_UtilityClass.getListOfStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanList;
            test.startTest();
            Set<Id>  setOfToBeDeletedIds = new Set<Id>();
            Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId = New Map<Id,Set<Id>>();
            List<Asset__c> assetsList = HCNA_UtilityClass.getAssetRecord(strategicPlanRecord);
            for(Asset assetRecord : assetList){
                setOfToBeDeletedIds.add(assetRecord.Id);
            }
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                if(mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c) != null) { 
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
                else{
                    mapOfStrategicAccountPlanIdWithAccountId.put(strategicAccountPlanRecord.Account__c,New Set<Id>());
                    (mapOfStrategicAccountPlanIdWithAccountId.get(strategicAccountPlanRecord.Account__c)).add(strategicAccountPlanRecord.Id);
                }
            }
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.insertListOfAssetsRecords(assetsList);
            serviceClass.assetRecordsToDelete(assetsList);
            serviceClass.retrieveListOfAssetRecordsToDelete(setOfToBeDeletedIds);       
            serviceClass.createAssets(assetList,mapOfStrategicAccountPlanIdWithAccountId);
            serviceClass.deleteRelatedAssets(assetsList);
            test.stopTest(); 
        }
    }
    /*
    * @Description : This method is used to update Competitive Landscape Recordand Account Record, delete Competitive Landscape record.
    */
    static testMethod void  test_CompetitiveLandscape(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert parentAccount;
            Strategic_Account_plan__c strategicAccountPlanRecord = new Strategic_Account_plan__c();
            strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlanRecord;
            List<Strategic_Account_plan__c> strategicPlanListList = new List<Strategic_Account_plan__c>();
            strategicPlanListList.add(strategicAccountPlanRecord);
            Competitive_Landscape__c competitiveLandsacpeRecord= new Competitive_Landscape__c();
            competitiveLandsacpeRecord.Name='testCLT';
            competitiveLandsacpeRecord.Strategic_Account_Plan__c = strategicAccountPlanRecord.id;
            competitiveLandsacpeRecord.AccountId_lookup__c= strategicAccountPlanRecord.Account__c;
            Insert competitiveLandsacpeRecord;
            List<Competitive_Landscape__c> compeitiveLandscapeList = new List<Competitive_Landscape__c>();
            compeitiveLandscapeList.add(competitiveLandsacpeRecord);
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.toBeDeletedOnCompetitiveLandscape(compeitiveLandscapeList);
            serviceClass.toBeUpdatedOnCompetitiveLandscape(compeitiveLandscapeList);
            serviceClass.updateCompetitiveLandscape(compeitiveLandscapeList);
            serviceClass.updateAccountOnCompetitiveLandscape(compeitiveLandscapeList,strategicPlanListList);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to delete Financial Objective Performance management and Profitablity Management record.
    */
    static testMethod void test_FinancialObjPerformanceMgmt(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){
            Account apexAccount = HCNA_UtilityClass.getAccountRecord();
            insert apexAccount;
            Account accountRecord = HCNA_UtilityClass.getAccountRecord2(apexAccount);
            insert accountRecord;
            Strategic_Account_plan__c strategicAccountPlanRecord = new Strategic_Account_plan__c();
            strategicAccountPlanRecord.Account__c = accountRecord.Id;
            Insert strategicAccountPlanRecord;
            Financial_Obj_Performance_Mgmt_Profit__c financialObjectiveRecord = new Financial_Obj_Performance_Mgmt_Profit__c();
            financialObjectiveRecord.Name='testFPP';
            financialObjectiveRecord.Strategic_Account_Plan__c = strategicAccountPlanRecord.Id;
            StaticVariableClass.firstRun = true;
            Insert financialObjectiveRecord;
            List<Financial_Obj_Performance_Mgmt_Profit__c> financialObjectiveList = new List<Financial_Obj_Performance_Mgmt_Profit__c>();
            financialObjectiveList.add(financialObjectiveRecord);
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.toBeDeletedOnFinancialObjPerformanceMgmtProfit(financialObjectiveList);
            test.stopTest();
        }      
    }
    /*
    * @Description : This method is used to insert Top opportunities record till six hierarchy levels on Strategic Account Plan.
    */
    static testMethod void test_TopOpportunities() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Set<Id> setOfParentAccountsId= new Set<Id>();
            Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            List<Opportunity> opportunityList= HCNA_UtilityClass.getListOfOpportunityRecord(accChild6);
            insert opportunityList;
            Strategic_Account_plan__c strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_account_plan__c> strategicPlanList = new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                mapOfStrategicAccountPlan.put(strategicAccountPlanRecord.Account__c,strategicPlanList);
            } 
            for(Account accountRecord : accountList){
                setOfParentAccountsId.add(accountRecord.id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.retriveSetOfConsolidatedAccountIds(mapOfParentAccounts);
            serviceClass.getListOfTopOpportunitiesRecordsToInsert(opportunityList,mapOfParentAccounts,mapOfStrategicAccountPlan);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert Key Transformational Win record till six hierarchy levels on Competitive Landscape.
    */
    static testMethod void test_KeyTransformationalWin() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            List<Opportunity> opportunityList= HCNA_UtilityClass.getListOfOpportunityRecord(accChild6);
            insert opportunityList;
            test.startTest();
            Strategic_Account_plan__c strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlanRecord;
            Competitive_Landscape__c competitiveLandsacpeRecord = new Competitive_Landscape__c();
            competitiveLandsacpeRecord.Name='testCLT';
            competitiveLandsacpeRecord.Strategic_Account_Plan__c = strategicAccountPlanRecord.id;
            competitiveLandsacpeRecord.AccountId_lookup__c= strategicAccountPlanRecord.Account__c;
            Insert competitiveLandsacpeRecord;
            List<Competitive_Landscape__c> compeitiveLandscapeList = new List<Competitive_Landscape__c>();
            compeitiveLandscapeList.add(competitiveLandsacpeRecord);
            for(Competitive_Landscape__c competitiveRecord : compeitiveLandscapeList){
                mapOfCompetitiveLandscape.put(competitiveRecord.AccountId_lookup__c,compeitiveLandscapeList);
            }
            Set<Id> setOfParentAccountsId= new Set<Id>();
            for(Account accountRecord : accountList) {
                setOfParentAccountsId.add(accountRecord.Id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfKeyTransformationalWinRecordsToInsert(opportunityList,mapOfParentAccounts,mapOfCompetitiveLandscape);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert Key Transformational Loss record till six hierarchy levels on Competitive Landscape.
    */
    static testMethod void test_KeyTransformationalLoss() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount= HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            List<Opportunity> childOpportunityList= HCNA_UtilityClass.getListOfChildOpportunityRecord(accChild6);
            insert childOpportunityList;
            test.startTest();
            Strategic_Account_plan__c strategicAccountPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlanRecord;
            Competitive_Landscape__c competitiveLandsacpeRecord = new Competitive_Landscape__c();
            competitiveLandsacpeRecord.Name='testCLT';
            competitiveLandsacpeRecord.Strategic_Account_Plan__c = strategicAccountPlanRecord.id;
            competitiveLandsacpeRecord.AccountId_lookup__c= strategicAccountPlanRecord.Account__c;
            Insert competitiveLandsacpeRecord;
            List<Competitive_Landscape__c> compeitiveLandscapeList = new List<Competitive_Landscape__c>();
            compeitiveLandscapeList.add(competitiveLandsacpeRecord);
            for(Competitive_Landscape__c competitiveRecord : compeitiveLandscapeList){
                mapOfCompetitiveLandscape.put(competitiveRecord.AccountId_lookup__c,compeitiveLandscapeList);
            }
            Set<Id> setOfParentAccountsId= new Set<Id>();
            for(Account accountRecord : accountList) {
                setOfParentAccountsId.add(accountRecord.Id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfKeyTransformationalLossRecordsToInsert(childOpportunityList,mapOfParentAccounts,mapOfCompetitiveLandscape);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert Asset record till six hierarchy levels on Strategic Account Plan.
    */
    static testMethod void test_Assets() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Set<Id> setOfParentAccountsId= new Set<Id>();
            Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            List<Asset> assetList = HCNA_UtilityClass.getListOfAssetRecord(accChild6);
            Insert assetList;
            Strategic_Account_plan__c strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_account_plan__c> strategicPlanList = new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            for(Strategic_Account_Plan__c strategicAccountPlanRecord : strategicPlanList){
                mapOfStrategicAccountPlan.put(strategicAccountPlanRecord.Account__c,strategicPlanList);
            } 
            for(Account accountRecord : accountList){
                setOfParentAccountsId.add(accountRecord.id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfAssetsRecordsToInsert(assetList,mapOfParentAccounts,mapOfStrategicAccountPlan);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert Hospital Locations record till six hierarchy levels on Strategic Account Plan.
    */
    static testMethod void test_HospitalLocations() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Set<Id> setOfParentAccountsId= new Set<Id>();
            Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            Strategic_Account_plan__c strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_account_plan__c> strategicPlanList = new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                mapOfStrategicAccountPlan.put(strategicAccountPlanRecord.Account__c,strategicPlanList);
            } 
            for(Account accountRecord: accountList){
                setOfParentAccountsId.add(accountRecord.id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfHospitalLocationsRecordsToInsert(accountList,mapOfParentAccounts,mapOfStrategicAccountPlan);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert Contract Details record till six hierarchy levels on Strategic Account Plan.
    */ 
    static testMethod void test_ContractDetail() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Set<Id> setOfParentAccountsId= new Set<Id>();
            Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            Contract contractRecord= HCNA_UtilityClass.getListOfContractRecord(accChild6);
            Insert contractRecord;
            List<Contract_Account_Link__c> contractAccountLinkList=HCNA_UtilityClass.getListOfContractAccountLinkRecord(accChild6,contractRecord);
            Insert contractAccountLinkList;
            Strategic_Account_plan__c strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_account_plan__c> strategicPlanList = new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                mapOfStrategicAccountPlan.put(strategicAccountPlanRecord.Account__c,strategicPlanList);
            } 
            for(Account accountRecord: accountList){
                setOfParentAccountsId.add(accountRecord.id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfContractDetailRecordsOfAccountLinkToInsert(contractAccountLinkList,mapOfParentAccounts,mapOfStrategicAccountPlan);
            test.stopTest();
        }
    }
    /*
    * @Description : This method is used to insert People and Relationship record till six hierarchy levels on Strategic Account Plan.
    */
    static testMethod void test_PeopleAndRelationship() {
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId();
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID);
        insert runAsUser;
        System.runAs(runAsUser){        
            Account apexAcc = HCNA_UtilityClass.getAccountRecord();
            insert apexAcc;
            Account parentAccount= HCNA_UtilityClass.getAccountRecord2(apexAcc);
            insert parentAccount;
            Account accChild1 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,parentAccount);
            insert accChild1;
            Account accChild2 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild1);
            insert accChild2;
            Account accChild3 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild2);
            insert accChild3;
            Account accChild4 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild3);
            insert accChild4;
            Account accChild5 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild4);
            insert accChild5;
            Account accChild6 = HCNA_UtilityClass.getChildAccountRecord(apexAcc,accChild5);
            insert accChild6;
            List<Account> accountList = new List<Account>();
            accountList.add(accChild1);
            accountList.add(accChild2);
            accountList.add(accChild3);
            accountList.add(accChild4);
            accountList.add(accChild5);
            accountList.add(accChild6);
            Set<Id> setOfParentAccountsId= new Set<Id>();
            Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
            Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape = new Map<Id,List<Competitive_Landscape__c>>();
            List<Contact> contactList= HCNA_UtilityClass.getContactRecord(accChild6);
            Insert contactList;
            Strategic_Account_plan__c strategicPlanRecord = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicPlanRecord;
            List<Strategic_account_plan__c> strategicPlanList = new List<Strategic_Account_Plan__c>();
            strategicPlanList.add(strategicPlanRecord);
            for(Strategic_Account_Plan__c strategicAccountPlanRecord :strategicPlanList){
                mapOfStrategicAccountPlan.put(strategicAccountPlanRecord.Account__c,strategicPlanList);
            } 
            for(Account accountRecord: accountList){
                setOfParentAccountsId.add(accountRecord.id);
            }
            Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);  
            test.startTest();
            HCNA_GSPTriggerServiceClass serviceClass = New HCNA_GSPTriggerServiceClass();
            serviceClass.getListOfPeopleAndRelationShipRecordsToInsert(contactList,mapOfParentAccounts,mapOfStrategicAccountPlan);
            test.stopTest();
        }
    }               
}