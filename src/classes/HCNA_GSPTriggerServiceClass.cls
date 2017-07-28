/*
* @ClassName : HCNA_GSPTriggerServiceClass
* @Description : This class is the service class of HCNA_GSPTrigger.This class performes the bussiness logic (functionality) of the page 
* @Author : Albin Deni Arul
* @Last Modified : 23/06/2014
* @Discussionpoints : No Information
*/

public class HCNA_GSPTriggerServiceClass {
    HCNA_GSPTriggerDAOClass dAOClass = New HCNA_GSPTriggerDAOClass();
    
    /**
    * @Description : This method assigns data to the fields on GSP mapped to account fields.
    * @param       : Trigger Records of type Strategic Account Plan, map of type account and id.
    * @return      : void
    **/
    public void assignAccountInformation(list<Strategic_Account_Plan__c> listOfTriggerRecords, Map<Id,Account> mapOfIdWithAccount) {
        Account accountInformation = New Account();
        if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isempty())) {
            for(Strategic_Account_plan__c strategicAccountPlanRecord: listOfTriggerRecords) {
                if(mapOfIdWithAccount.get(strategicAccountPlanRecord.Account__c) != null) {
                    accountInformation = mapOfIdWithAccount.get(strategicAccountPlanRecord.Account__c);
                    strategicAccountPlanRecord.Parent_Account_lookup__c = accountInformation.Parent_IDN_of_Associated_IDN__c;
                    strategicAccountPlanRecord.EHR_Vendor__c = accountInformation.EHR_Vendor__c;
                    strategicAccountPlanRecord.Primary_Location_HQ__c = accountInformation.Region__c;
                }
            }
        }
    }
    /**
    * @Description : This method is used to retrieve all the children for the account associated to the gsp.
    * @param       : list of related accounts,list of final set of accounts.
    * @return      : list of all the children accounts.
    **/        
    public list<Account> retrieveAllChildrenAccountIds(list<Account> relatedAccountsList, list<Account> listOfFinalAccounts) {
        try{
            List<Account> childernAccountsList = New List<Account>();
            Boolean top= false;
            if((relatedAccountsList != null) && !(relatedAccountsList.isempty()) && (listOfFinalAccounts != null) && !(listOfFinalAccounts.isempty())){
                while(!top) {
                    String sQuery = ' Select Id, Name, Parent_IDN_of_Associated_IDN__c From Account  where  Parent_IDN_of_Associated_IDN__c IN: relatedAccountsList';
                    childernAccountsList = Database.query(sQuery);
                    if((childernAccountsList != null) && !(childernAccountsList .isEmpty())) {
                        listOfFinalAccounts.addall(childernAccountsList);
                        relatedAccountsList= childernAccountsList;
                    }                              
                    else {
                        top = true;
                    }
                }
            }
            return listOfFinalAccounts;
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
      
     /**
    * @Description : This method is used to construct a map between Strategic Account Plan and Account.
    * @param       : list of final set of accounts, map of type strategic account Plan Id and account id.
    * @return      : map of Strategic Account Plan and Account Id.
    **/  
    public Map<Id,Set<Id>> constructMapOfStrategicAccountPlanIdWithAccountId(list<Account> listOfFinalAccounts, Map<Id,set<Id>> mapOfStrategicAccountPlanIdWithAccountId) {
        Set<Account> setOfAccounts = new Set<Account>();
        List<Account> listOfAccounts = new List<Account>();
        try{
            for(Account accountData : listOfFinalAccounts){
                if(setOfAccounts.add(accountData)){
                    listOfAccounts.add(accountData);
                }
            }
            if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
                for(Account accountRecord: listOfFinalAccounts) {
                    if(mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Parent_IDN_of_Associated_IDN__c) != null) {
                        if(mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Id) != null) {
                            mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Id).addall(mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Parent_IDN_of_Associated_IDN__c)); 
                        }else {
                            mapOfStrategicAccountPlanIdWithAccountId.put(accountRecord.Id,mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Parent_IDN_of_Associated_IDN__c));
                        }
                    }
                }
            }   
            return mapOfStrategicAccountPlanIdWithAccountId;
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }   
    }
    
    /**
    * @Description : This method is used to retrieve the contacts of the account associated to the GSP.
    * @param       : list of final set of accounts.
    * @return      : list of contacts to be updated.
    **/  
    public list<Contact> retrieveAllRelatedContacts(list<Account> listOfFinalAccounts) {
        list<Contact> retrieveAllRelatedContactsList = New  list<Contact>();
        if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedContactsList = dAOClass.retrieveAllRelatedContacts(listOfFinalAccounts);
        }
        return retrieveAllRelatedContactsList;
    }
    
    /**
    * @Description : This method is used to retrieve the all the account and children account.
    * @param       : list of final set of accounts.
    * @return      : list of account to be updated.
    **/       
    public list<Account> retrieveAllRelatedAccounts(list<Account> listOfFinalAccounts) {
        list<Account> retrieveAllRelatedAccountsList= New  list<Account>();
        if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedAccountsList= dAOClass.retrieveAllRelatedAccounts(listOfFinalAccounts); 
        }
        return retrieveAllRelatedAccountsList ;
    }
    
    /**
    * @Description : This method is used to retrieve the asstes of the account associated to the GSP.
    * @param       : list of final set of accounts.
    * @return      : list of assets to be updated.
    **/     
    public list<Asset> retrieveAllRelatedAssets(list<Account> listOfFinalAccounts) {
        list<Asset> retrieveAllRelatedAssetsList = New  list<Asset>();
        if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedAssetsList= dAOClass.retrieveAllRelatedAssets(listOfFinalAccounts);
        }
        return retrieveAllRelatedAssetsList ;
    }
    
    /**
    * @Description : This method is used to retrieve the opportunity of the account associated to the GSP.
    * @param       : list of final set of accounts.
    * @return      : list of opportunities to be updated.
    **/
    public list<Opportunity> retrieveAllRelatedOpportunities(list<Account> listOfFinalAccounts) {
        list<Opportunity> retrieveAllRelatedOpportunitiesList = New  list<Opportunity>();
        if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedOpportunitiesList = dAOClass.retrieveAllRelatedOpportunities(listOfFinalAccounts);
        }
        return retrieveAllRelatedOpportunitiesList;      
    }
    
    /**
    * @Description : This method is used to retrieve the AccountTeamMember of the account associated to the GSP.
    * @param       : list of final set of accounts.
    * @return      : list of AccountTeamMember to be updated.
    **/
    public list<AccountTeamMember> retrieveAllRelatedAccountTeamMembers(list<Account> listOfFinalAccounts) {
        list<AccountTeamMember> retrieveAllRelatedAccountTeamMembersList  = New  list<AccountTeamMember>();
        if((listOfFinalAccounts != null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedAccountTeamMembersList= dAOClass.retrieveAllRelatedAccountTeamMembers(listOfFinalAccounts);
        }
        return retrieveAllRelatedAccountTeamMembersList;      
    }
    
    /**
    * @Description : This method is used to retrieve the records to be deleted on Contract Details.
    * @param       : Set of Ids of Account.
    * @return      : List of contract details records to be deleted.
    **/
    public List<Contract_Detail__c> retrieveListOfContractDetailRecordsToDelete(Set<Id> setOfToBeDeletedIds,Set<Id> setOfAccountToBeDeletedIds){
        List<Contract_Detail__c> listOfContractDetailRecordsToDelete = new List<Contract_Detail__c>();
        listOfContractDetailRecordsToDelete=dAOClass.retrieveListOfContractDetailRecordsToDelete(setOfToBeDeletedIds,setOfAccountToBeDeletedIds);
        return listOfContractDetailRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Contract Detail.
    * @param       : List of contract details records to be deleted.
    * @return      : void.
    **/
    public void contractDetailRecordsToDelete(List<Contract_Detail__c> listOfContractDetailRecords){
        if((listOfContractDetailRecords!= null) && !(listOfContractDetailRecords.isEmpty())){
            dAOClass.listOfContractDetailRecordsToDelete(listOfContractDetailRecords);
        }
    }
    
     /**
    * @Description : This method is used to retrieve the records to be deleted on People and Relationship.
    * @param       : Set of Ids of Account.
    * @return      : List of People and Relationship records to be deleted.
    **/
    public List<People_and_Relationship__c> retrieveListOfPeopleAndRelationshipRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<People_and_Relationship__c> listOfPeopleAndRelationshipRecordsToDelete = new List<People_and_Relationship__c>();
        listOfPeopleAndRelationshipRecordsToDelete=dAOClass.retrieveListOfPeopleAndRelationshipRecordsToDelete(setOfToBeDeletedIds);
        return listOfPeopleAndRelationshipRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on People & Relationship.
    * @param       : List of People & Relationships records to be deleted.
    * @return      : void.
    **/
    public void peopleAndRelationshipRecordsToDelete(List<People_and_Relationship__c> listOfPeopleAndRelationshipRecords){
        if((listOfPeopleAndRelationshipRecords!= null) && !(listOfPeopleAndRelationshipRecords.isEmpty())){
            dAOClass.listOfPeopleAndRelationshipRecordsToDelete(listOfPeopleAndRelationshipRecords);
        }
    }
    
    /**
    * @Description : This method is used to retrieve the records to be deleted on Hospital Locations.
    * @param       : Set of Ids of Account.
    * @return      : List of Hospital Locations records to be deleted.
    **/
    public List<Hospital_Locations__c> retrieveListOfHospitalLocationsRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Hospital_Locations__c> listOfHospitalLocationsRecordsToDelete = new List<Hospital_Locations__c>();
        listOfHospitalLocationsRecordsToDelete=dAOClass.retrieveListOfHospitalLocationsRecordsToDelete(setOfToBeDeletedIds);
        return listOfHospitalLocationsRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Hospital Locations.
    * @param       : List of hospital locations details records to be deleted.
    * @return      : void.
    **/
    public void hospitalLocationsRecordsToDelete(List<Hospital_locations__c> listOfHospitalLocationsRecords){
        if((listOfHospitalLocationsRecords!= null) && !(listOfHospitalLocationsRecords.isEmpty())){
            dAOClass.listOfHospitalLocationsRecordsToDelete(listOfHospitalLocationsRecords);
        }
    }

    /**
    * @Description : This method is used to retrieve the records to be deleted on Top Opportunities.
    * @param       : Set of Ids of Account.
    * @return      : List of Top Opportunities records to be deleted.
    **/
    public List<Top_Opportunities__c> retrieveListOfTopOpportunitiesRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToDelete = new List<Top_Opportunities__c>();
        listOfTopOpportunitiesRecordsToDelete=dAOClass.retrieveListOfTopOpportunitiesRecordsToDelete(setOfToBeDeletedIds);
        return listOfTopOpportunitiesRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Top Opportunities.
    * @param       : List of TopOpportunities records to be deleted.
    * @return      : void.
    **/
    public void topOpportunitiesRecordsToDelete(List<Top_Opportunities__c> listOfTopOpportunitiesRecords){
        if((listOfTopOpportunitiesRecords!= null) && !(listOfTopOpportunitiesRecords.isEmpty())){
            dAOClass.listOfTopOpportunitiesRecordsToDelete(listOfTopOpportunitiesRecords);
        }
    }
    
    /**
    * @Description : This method is used to retrieve the records to be deleted on Asset.
    * @param       : Set of Ids of Account.
    * @return      : List of Asset records to be deleted.
    **/
    public List<Asset__c> retrieveListOfAssetRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Asset__c> listOfAssetRecordsToDelete = new List<Asset__c>();
        listOfAssetRecordsToDelete=dAOClass.retrieveListOfAssetRecordsToDelete(setOfToBeDeletedIds);
        return listOfAssetRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Asset.
    * @param       : List of Asset records to be deleted.
    * @return      : void.
    **/
    public void assetRecordsToDelete(List<Asset__c> listOfAssetRecords){
        if((listOfAssetRecords!= null) && !(listOfAssetRecords.isEmpty())){
            dAOClass.listOfAssetRecordsToDelete(listOfAssetRecords);
        }
    }
    
    /**
    * @Description : This method is used to retrieve the records to be deleted on Key Transformational Win.
    * @param       : Set of Ids of Account.
    * @return      : List of Key Transformational Win records to be deleted.
    **/
    public List<Key_Transformational_Win__c>  retrieveListOfKeyTransformationalWinRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToDelete = new List<Key_Transformational_Win__c>();
        listOfKeyTransformationalWinRecordsToDelete=dAOClass.retrieveListOfKeyTransformationalWinRecordsToDelete(setOfToBeDeletedIds);
        return listOfKeyTransformationalWinRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Key Transformational Win.
    * @param       : List of Key Transformational Win records to be deleted.
    * @return      : void.
    **/
    public void keyTransformationalWinRecordsToDelete(List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecords){
        if((listOfKeyTransformationalWinRecords!= null) && !(listOfKeyTransformationalWinRecords.isEmpty())){
            dAOClass.listOfKeyTransformationalWinRecordsToDelete(listOfKeyTransformationalWinRecords);
        }
    }
    
    /**
    * @Description : This method is used to retrieve the records to be deleted on Key Transformational Loss.
    * @param       : Set of Ids of Account.
    * @return      : List of Key Transformational Loss records to be deleted.
    **/
    public List<Key_Transformational_Loss__c> retrieveListOfKeyTransformationalLossRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToDelete = new List<Key_Transformational_Loss__c>();
        listOfKeyTransformationalLossRecordsToDelete=dAOClass.retrieveListOfKeyTransformationalLossRecordsToDelete(setOfToBeDeletedIds);
        return listOfKeyTransformationalLossRecordsToDelete;
    }
    
    /**
    * @Description : This method is used to delete record on Key Transformational Loss.
    * @param       : List of Key Transformational Loss records to be deleted.
    * @return      : void.
    **/
    public void keyTransformationalLossRecordsToDelete(List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecords){
        if((listOfKeyTransformationalLossRecords!= null) && !(listOfKeyTransformationalLossRecords.isEmpty())){
            dAOClass.listOfKeyTransformationalLossRecordsToDelete(listOfKeyTransformationalLossRecords);
        }
    }
       
    /**
    * @Description : This method is used to delete record on Competitive Landscape.
    * @param       : Trigger Records of type Competitive Landscape.
    * @return      : void.
    **/
    public void toBeDeletedOnCompetitiveLandscape(List<Competitive_Landscape__c> listOfTriggerRecords){
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            dAOClass.toBeDeletedOnCompetitiveLandscape(listOfTriggerRecords);
        }
    }
    
    /**
    * @Description : This method is used to delete record on FinancialObjPerformanceMgmtProfit.
    * @param       : Trigger Records of type FinancialObjPerformanceMgmtProfi.
    * @return      : void.
    **/
    public void toBeDeletedOnFinancialObjPerformanceMgmtProfit(List<Financial_Obj_Performance_Mgmt_Profit__c> listOfTriggerRecords){
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            dAOClass.toBeDeletedOnFinancialObjPerformanceMgmtProfit(listOfTriggerRecords);
        }
    }
    
    /**
    * @Description : This method is used to Update the Fields on Account.
    * @param       : Trigger Records of type Competitive Landscape.
    * @return      : List of accounts to be updated.
    **/    
    public void toBeUpdatedOnCompetitiveLandscape(List<Competitive_Landscape__c> listOfTriggerRecords) {
        List<Account> listOfAccountsToUpdate = New List<Account>();
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            for(Competitive_Landscape__c record: listOfTriggerRecords) {
                Account accountToUpdate= new Account(Id=record.AccountId_lookup__c);               
                accountToUpdate.Consultants_IT__c = record.Consultants_IT__c;
                accountToUpdate.Consultants_Clinical__c = record.Consultants_Clinical__c;
                accountToUpdate.IHN__c = record.IHN_Lookup__c;
                accountToUpdate.Contracting_Vendor__c = record.Contracting_Vendor__c;
                accountToUpdate.EHR_Vendor__c = record.EHR_Supplier_Lookup__c;                
                listOfAccountsToUpdate.add(accountToUpdate);
            }         
            dAOClass.toBeUpdatedOnCompetitiveLandscape(listOfAccountsToUpdate);
        }
    }
 
   /**
    * @Description : This method is used to assign values to people and relationship from contact.
    * @param       : list of contacts for the account and the children accounts,map of type strategic account plan and account id
    * @return      : list of people and relationship to be inserted.
    **/
    public List<People_and_Relationship__c> createPeopleAndRelationship(list<Contact> retrieveAllRelatedContactsList,Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId ) {
        List<People_and_Relationship__c> listOfPeopleAndRelationship= New List<People_and_Relationship__c>();   
        People_and_Relationship__c peopleAndRelationship;
        if((retrieveAllRelatedContactsList!= null) && !(retrieveAllRelatedContactsList.isEmpty())){
            for(Contact contactRecord:retrieveAllRelatedContactsList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(contactRecord.AccountId) != null) {
                    for(Id strategicAccountplanId: mapOfStrategicAccountPlanIdWithAccountId.get(contactRecord.AccountId)) {
                        peopleAndRelationship = new People_and_Relationship__c();
                        peopleAndRelationship.Strategic_account_plan__c = strategicAccountplanId;
                        peopleAndRelationship.Contact_Id__c = contactRecord.Id;
                        listOfPeopleAndRelationship.add(peopleAndRelationship);
                    }
                }
            }
        }        
        return listOfPeopleAndRelationship;
    }
    
    /**
    * @Description : This method is used to assign values to hospital locations from account.
    * @param       : list of account and the children accounts,map of type strategic account plan and account id
    * @return      : list of hospital locations to be inserted.
    **/
    public List<Hospital_Locations__c> createHospitalLocation(list<Account> retrieveAllRelatedAccountsList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId ) {
        Hospital_Locations__c hospitalLocation;
        List<Hospital_Locations__c> listOfhospitalLocations = New List<Hospital_Locations__c>();    
        if((retrieveAllRelatedAccountsList!= null) && !(retrieveAllRelatedAccountsList.isEmpty())){
            for(Account accountRecord: retrieveAllRelatedAccountsList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Id) != null) {
                    for(Id strategicAccountplanId: mapOfStrategicAccountPlanIdWithAccountId.get(accountRecord.Id)) {
                        hospitalLocation = new Hospital_Locations__c(Strategic_account_plan__c = strategicAccountplanId, Account_Id__c = accountRecord.Id);
                        listOfhospitalLocations.add(hospitalLocation);
                    }
                }
            }
        }   
        return listOfhospitalLocations;
    }
    
    /**
    * @Description : This method is used to assign values to asset from Standard Asset object.
    * @param       : list of assets for the account and the children accounts,map of type strategic account plan and account id
    * @return      : list of assets to be inserted.
    **/
    public List<Asset__c> createAssets(list<Asset> retrieveAllRelatedAssetsList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId ) {
        Asset__c assets;
        List<Asset__c> listOfAssets = New List<Asset__c>();
        if((retrieveAllRelatedAssetsList!= null) && !(retrieveAllRelatedAssetsList.isEmpty())){
            for(Asset assetsRecord: retrieveAllRelatedAssetsList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(assetsRecord.AccountId) != null) {
                    for(Id strategicAccountplanId: mapOfStrategicAccountPlanIdWithAccountId.get(assetsRecord.AccountId)) {
                        assets = new Asset__c(Asset_Id__c = assetsRecord.Id, Strategic_account_plan__c = strategicAccountplanId);
                        listOfAssets.add(assets);
                    }
                }
            }
        }
        return listOfAssets;
    } 
    
    /**
    * @Description : This method is used to assign values to top opportunity from opportunity.
    * @param       : list of opportunity for the account and the children accounts,map of type strategic account plan and account id
    * @return      : list of op opportunity to be inserted.
    **/
    public list<Top_Opportunities__c> createTopOpportunities(list<Opportunity> retrieveAllRelatedOpportunitiesList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId ) {  
        Top_Opportunities__c topOpportunity;
        list<Top_Opportunities__c>  listOfTopOpportunities = New List<Top_Opportunities__c>();    
        if((retrieveAllRelatedOpportunitiesList!= null) && !(retrieveAllRelatedOpportunitiesList.isEmpty())){
            for(Opportunity opportunityRecord: retrieveAllRelatedOpportunitiesList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId) != null) {
                    for(Id strategicAccountplanId: mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId)){
                        topOpportunity = new Top_Opportunities__c(Strategic_account_plan__c =strategicAccountplanId, Opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunities.add(topOpportunity);
                    }
                }
            }
        }
        return listOfTopOpportunities;
    } 
    
    /**
    * @Description : This method is used to assign values to Account Team from AccountTeamMember.
    * @param       : list of AccountTeamMember for the account and the children accounts,map of type strategic account plan and account id
    * @return      : list of op AccountTeamMemberto be inserted.
    **/
    public list<Account_Team__c> createAccountTeam(list<AccountTeamMember> retrieveAllRelatedAccountTeamMembersList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId ) {  
        Account_Team__c accountTeam;
        list<Account_Team__c>  listOfAccountTeam = New List<Account_Team__c>(); 
        Set<Account_Team__c> setOfAccountTeam = new Set<Account_Team__c>();
        List<Account_Team__c> accountTeamList = new List<Account_Team__c>();   
        if((retrieveAllRelatedAccountTeamMembersList!= null) && !(retrieveAllRelatedAccountTeamMembersList.isEmpty())){
            for(AccountTeamMember accountTeamMemberRecord: retrieveAllRelatedAccountTeamMembersList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(accountTeamMemberRecord.AccountId) != null) {
                    for(Id strategicAccountplanId:mapOfStrategicAccountPlanIdWithAccountId.get(accountTeamMemberRecord.AccountId)) {
                        accountTeam= new Account_Team__c(Account_Team_Name__c = accountTeamMemberRecord.user.Id, Strategic_account_plan__c =strategicAccountplanId);
                        listOfAccountTeam.add(accountTeam);
                    }
                }   
            }
            setOfAccountTeam.addAll(listOfAccountTeam);
            accountTeamList.addAll(setOfAccountTeam);
            listOfAccountTeam = accountTeamList; 
        }
        return listOfAccountTeam;
    } 
     
    /**
    * @Description : This method is used to retrieve list of Hospital Locations to be updated.
    * @param       : trigger Records of type account,map of type account Id and account,set of account id.
    * @return      : list of hospital locations to be updated.
    **/
    public List<Hospital_Locations__c> retrieveListOfHospitalLocations(List<Account> listOfTriggerRecords,Map<Id, Account> mapOfAccountIdAndAccount,Set<Id> setOfAccountId){
        List<Hospital_Locations__c> listOfHospitalLocationsToUpdate = New  List<Hospital_Locations__c>();
        List<Hospital_Locations__c> listOfHospitalLocations=new List<Hospital_Locations__c>();
        List<Hospital_Locations__c> finalListOfHospitalLocations=new List<Hospital_Locations__c>();
        if((setOfAccountId!= null) && !(setOfAccountId.isEmpty()) && (listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())) {
            listOfHospitalLocations=dAOClass.retrieveListOfHospitalLocations(listOfTriggerRecords);
        }       
        if((listOfHospitalLocations!= null) && !(listOfHospitalLocations.isEmpty())) {   
            for(Hospital_Locations__c hospitalLocationsRecord: listOfHospitalLocations) {
                if(hospitalLocationsRecord.Account_Id__c != null && mapOfAccountIdAndAccount.get(hospitalLocationsRecord.Account_Id__c)!=null) {
                    Account accountRecord = (mapOfAccountIdAndAccount.get(hospitalLocationsRecord.Account_Id__c));          
                    hospitalLocationsRecord.Account_Id__c = accountRecord.Id;
                    listOfHospitalLocationsToUpdate.add(hospitalLocationsRecord);
                }   
            }
        }        
        if((listOfHospitalLocationsToUpdate!= null) && !(listOfHospitalLocationsToUpdate.isEmpty())) {
            finalListOfHospitalLocations.addall(listOfHospitalLocationsToUpdate);
        }
        return finalListOfHospitalLocations;              
    }
    /**
    * @Description : This method is used to retrieve list of strategic account plan fields to be updated.
    * @param       : trigger Records of type account,map of type account Id and account,set of account id.
    * @return      : list of Strategic account plan fields to be updated.
    **/
    public List<Strategic_Account_Plan__c> retrieveListOfStrategicAccountPlan(List<Account> listOfTriggerRecords,Map<Id, Account> mapOfAccountIdAndAccount,Set<Id> setOfAccountId){
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlanToUpdate=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfFinalStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        if((setOfAccountId!= null) && !(setOfAccountId.isEmpty()) && (listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())) {
            listOfStrategicAccountPlan=dAOClass.retrieveListOfStrategicAccountPlan(listOfTriggerRecords);
        }
        if((listOfStrategicAccountPlan!= null) && !(listOfStrategicAccountPlan.isEmpty())) {   
            for(Strategic_Account_plan__c straregicAccountPlanRecord: listOfStrategicAccountPlan ) {
                if(straregicAccountPlanRecord.Account__c != null) {
                    Account accountInformation= (mapOfAccountIdAndAccount.get(straregicAccountPlanRecord.Account__c));
                    straregicAccountPlanRecord.Parent_Account_lookup__c = accountInformation.Parent_IDN_of_Associated_IDN__c;
                    straregicAccountPlanRecord.Primary_Location_HQ__c = accountInformation.Region__c;
                    straregicAccountPlanRecord.EHR_Vendor__c = accountInformation.EHR_Vendor__c;
                    listOfStrategicAccountPlanToUpdate.add(straregicAccountPlanRecord);
                }   
            }
        }
        if((listOfStrategicAccountPlanToUpdate != null) && !(listOfStrategicAccountPlanToUpdate.isEmpty())) {
            listOfFinalStrategicAccountPlan.addall(listOfStrategicAccountPlanToUpdate);    
        }
        return listOfFinalStrategicAccountPlan;
    }
     /**
    * @Description : This method is used to retrieve list of strategic account plan fields to be updated.
    * @param       : trigger Records of type account,map of type account Id and account,set of account id.
    * @return      : list of Strategic account plan fields to be updated.
    **/
    public List<Strategic_Account_Plan__c> retrieveListOfStrategicAccountPlanForChangedHierarachy(List<Account> listOfTriggerRecords, Set<Id> setOfAccountId){
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlanToUpdate=new List<Strategic_Account_Plan__c>();
        List<Strategic_Account_Plan__c> listOfFinalStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())) {
            listOfStrategicAccountPlan=dAOClass.retrieveListOfStrategicAccountPlan(listOfTriggerRecords);
        }
        if((listOfStrategicAccountPlan!= null) && !(listOfStrategicAccountPlan.isEmpty())) {   
            for(Strategic_Account_plan__c straregicAccountPlanRecord: listOfStrategicAccountPlan) {
                if(straregicAccountPlanRecord.Account__c != null) {
                    straregicAccountPlanRecord.Account_Hierarchy_Changed__c = true;
                    listOfStrategicAccountPlanToUpdate.add(straregicAccountPlanRecord);
                }   
            }
        }
        if((listOfStrategicAccountPlanToUpdate!= null) && !(listOfStrategicAccountPlanToUpdate.isEmpty())) {
            listOfFinalStrategicAccountPlan.addall(listOfStrategicAccountPlanToUpdate);    
        }
        return listOfFinalStrategicAccountPlan;
    }
    
    /**
    * @Description : This method is used to retrieve list of competitive Landscape fields to be updated.
    * @param       : trigger Records of type account,map of type account Id and account,set of account id.
    * @return      : list of Competitive Landscape fields to be updated.
    **/
    public List<Competitive_Landscape__c> retrieveListOfCompetitiveLandscape(List<Account> listOfTriggerRecords,Map<Id, Account> mapOfAccountIdAndAccount,Set<Id> setOfAccountId){
        List<Competitive_Landscape__c> listOfCompetitiveLandscape=new List<Competitive_Landscape__c>();
        List<Competitive_Landscape__c> listOfCompetitiveLandscapeToUpdate=new List<Competitive_Landscape__c>();
        List<Competitive_Landscape__c> listOfFinalCompetitiveLandscape=new List<Competitive_Landscape__c>();
        if((setOfAccountId != null) && !(setOfAccountId.isEmpty()) && (listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())) {
            listOfCompetitiveLandscape=dAOClass.retrieveListOfCompetitiveLandscape(listOfTriggerRecords);           
        }
        if((listOfCompetitiveLandscape!= null) && !(listOfCompetitiveLandscape.isEmpty())) {   
            for(Competitive_Landscape__c competitiveLandscapeRecord: listOfCompetitiveLandscape) {
                if(competitiveLandscapeRecord.AccountId_lookup__c != null) {
                    Account accountInformation= (mapOfAccountIdAndAccount.get(competitiveLandscapeRecord.AccountId_lookup__c));
                    competitiveLandscapeRecord.IHN_Lookup__c = accountInformation.IHN__c;
                    competitiveLandscapeRecord.EHR_Supplier_Lookup__c = accountInformation.EHR_Vendor__c;
                    competitiveLandscapeRecord.Consultants_Clinical__c = accountInformation.Consultants_Clinical__c;
                    competitiveLandscapeRecord.Consultants_IT__c = accountInformation.Consultants_IT__c;
                    competitiveLandscapeRecord.Contracting_Vendor__c = accountInformation.Contracting_Vendor__c;
                    listOfCompetitiveLandscapeToUpdate.add(competitiveLandscapeRecord);
                }   
            }
        }
        if((listOfCompetitiveLandscapeToUpdate!= null) && !(listOfCompetitiveLandscapeToUpdate.isEmpty())) {
            listOfFinalCompetitiveLandscape.addall(listOfCompetitiveLandscapeToUpdate);
        }
        return listOfFinalCompetitiveLandscape;
    }

    /**
    * @Description : This method is used to insert list of people and relationship on the GSP.
    * @param       : list of people and relationship records to be inserted.
    * @return      : void.
    **/
    public void  insertPeopleAndRelationship(list<People_and_Relationship__c> createPeopleAndRelationshipList) {
        if((createPeopleAndRelationshipList!= null) && !(createPeopleAndRelationshipList.isEmpty())){
            dAOClass.insertPeopleAndRelationship(createPeopleAndRelationshipList);
        }
    }
    
    /**
    * @Description : This method is used to insert list of Hospital Locations on the GSP.
    * @param       : list of Hospital Locations records to be inserted.
    * @return      : void.
    **/
    public void  insertHospitalLocation(list<Hospital_Locations__c> createHospitalLocationList) {
        if((createHospitalLocationList!= null) && !(createHospitalLocationList.isEmpty())){
            dAOClass.insertHospitalLocation(createHospitalLocationList);
        }
    }
    
    /**
    * @Description : This method is used to insert list of Asset on the GSP.
    * @param       : list of asset records to be inserted.
    * @return      : void.
    **/
    public void  insertAssets(list<Asset__c> createAssetsList) {
        if((createAssetsList!= null) && !(createAssetsList.isEmpty())){
            dAOClass.insertAssets(createAssetsList);
        }
    }
    
    /**
    * @Description : This method is used to insert list of top opportunity on the GSP.
    * @param       : list of top opportunity records to be inserted.
    * @return      : void.
    **/
    public void  insertTopOpportunities(list<Top_Opportunities__c> createTopOpportunitiesList) {
        if((createTopOpportunitiesList!= null) && !(createTopOpportunitiesList.isEmpty())){
            dAOClass.insertTopOpportunities(createTopOpportunitiesList);
        }
    }
    
    /**
    * @Description : This method is used to insert list of Account Team on the GSP.
    * @param       : list of Account Team records to be inserted.
    * @return      : void.
    **/
    public void  insertAccountTeam(list<Account_Team__c> createAccountTeamList) {
        if((createAccountTeamList!= null) && !(createAccountTeamList.isEmpty())){
            dAOClass.insertAccountTeam(createAccountTeamList);
        }
    }

    /**
    * @Description : This method is used to update list of hosital locations on the GSP.
    * @param       : list of hospital locations records to be inserted.
    * @return      : void.
    **/
    public void  updateHospitalLocations(list<Hospital_Locations__c> listOfHospitalLocations) {
        if((listOfHospitalLocations!= null) && !(listOfHospitalLocations.isEmpty())){
            dAOClass.updateHospitalLocations(listOfHospitalLocations);
        }
    }
   
    /**
    * @Description : This method is used to update list of Strategic Account Plan fields on the GSP.
    * @param       : list of strategic account plan records to be inserted.
    * @return      : void.
    **/
    public void  updateStrategicAccountPlan(list<Strategic_Account_Plan__c> listOfStrategicAccountPlan) {
        if((listOfStrategicAccountPlan!= null) && !(listOfStrategicAccountPlan.isEmpty())){
            dAOClass.updateStrategicAccountPlan(listOfStrategicAccountPlan);
        }
    }
    
    /**
    * @Description : This method is used to update list of Competitive Landscape fields on the GSP.
    * @param       : list of competitive Landscape records to be inserted.
    * @return      : void.
    **/
    public void  updateCompetitiveLandscape(list<Competitive_Landscape__c> listOfCompetitiveLandscape) {
        if((listOfCompetitiveLandscape!= null) && !(listOfCompetitiveLandscape.isEmpty())){
            dAOClass.updateCompetitiveLandscape(listOfCompetitiveLandscape);
        }
    }
    
    /**
    * @Description : This method assigns data to the fields on Competitive Landscape mapped to account fields.
    * @param       : Trigger Records of typeCompetitive Landscape, map of type account and id,list of type strategic account plan.
    * @return      : void
    **/
    public void assignAccountValues(list<Competitive_Landscape__c> listOfTriggerRecords,Map<Id,Account> mapOfIdWithAccount,List<Strategic_Account_Plan__c> strategicAccountPlanList){
        Account accountInformation= New Account();
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty()) && (strategicAccountPlanList!= null) && !(strategicAccountPlanList.isEmpty())){
            for(Competitive_Landscape__c competitiveLandscapeRecord : listOfTriggerRecords) {
                for(Strategic_Account_Plan__c strategicAccountPlanId : strategicAccountPlanList){
                    accountInformation = mapOfIdWithAccount.get(strategicAccountPlanId.Account__c);
                    competitiveLandscapeRecord .Consultants_Clinical__c = accountInformation.Consultants_Clinical__c;
                    competitiveLandscapeRecord .Consultants_IT__c = accountInformation.Consultants_IT__c;
                    competitiveLandscapeRecord .Contracting_Vendor__c = accountInformation.Contracting_Vendor__c;
                    competitiveLandscapeRecord .EHR_Supplier_Lookup__c = accountInformation.EHR_Vendor__c ;
                    competitiveLandscapeRecord .IHN_Lookup__c = accountInformation.IHN__c;                 
                    competitiveLandscapeRecord .AccountId_lookup__c = accountInformation.Id;   
                }
            }
        }
    }
    
    /**
    * @Description : This method is used to retrieve the Win opportunity of the account associated to the GSP for competitive Landscape.
    * @param       : list of final set of accounts.
    * @return      : list of Win opportunities to be updated.
    **/
    public list<Opportunity> retrieveAllRelatedWinOpportunity(List<Account> listOfFinalAccounts) {
        list<Opportunity> retrieveAllRelatedWinOpportunitiesList = New  list<Opportunity>();
        if((listOfFinalAccounts!= null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedWinOpportunitiesList  = dAOClass.retrieveAllRelatedWinOpportunities(listOfFinalAccounts);
        }
        return retrieveAllRelatedWinOpportunitiesList ;
    }
    
    /**
    * @Description : This method is used to retrieve the Loss opportunity of the account associated to the GSP for competitive Landscape.
    * @param       : list of final set of accounts.
    * @return      : list of Loss opportunities to be updated.
    **/     
    public list<Opportunity> retrieveAllRelatedLossOpportunity(List<Account> listOfFinalAccounts) {
        list<Opportunity> retrieveAllRelatedLossOpportunitiesList = New  list<Opportunity>();
        if((listOfFinalAccounts!= null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllRelatedLossOpportunitiesList = dAOClass.retrieveAllRelatedLossOpportunities(listOfFinalAccounts);
        }
        return retrieveAllRelatedLossOpportunitiesList;
    }
    
    /**
    * @Description : This method is used to assign values to key transformational Win from opportunity.
    * @param       : list of opportunity for the account and the children accounts,map of type strategic account plan and account id,map of type strategic account plan and competitive Landscape.
    * @return      : list of Key Transformational Win to be inserted.
    **/
    public list<Key_Transformational_Win__c> createKeyTransformationalWin(list<Opportunity> retrieveAllRelatedWinOpportunitiesList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId,Map<Id,Id> mapOfCompetitiveLandscapeWithStrategicAccountPlanId ) {  
        Key_Transformational_Win__c keyTransformationalWins;
        list<Key_Transformational_Win__c>  listOfKeyTransformationalWin = New List<Key_Transformational_Win__c>();    
        if((retrieveAllRelatedWinOpportunitiesList!= null) && !(retrieveAllRelatedWinOpportunitiesList.isEmpty())){
            for(Opportunity opportunityRecord: retrieveAllRelatedWinOpportunitiesList) {
                for(Id strategicAccountPlanId: mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId)) {
                    if(mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId) != null) {                
                        keyTransformationalWins = new Key_Transformational_Win__c();
                        keyTransformationalWins.Competitive_Landscape__c = mapOfCompetitiveLandscapeWithStrategicAccountPlanId.get(strategicAccountPlanId);
                        keyTransformationalWins.Opportunity_Id__c = opportunityRecord.Id;
                        listOfKeyTransformationalWin .add(keyTransformationalWins);
                    }
                }
            }
        }
        return listOfKeyTransformationalWin ;
    }
    
    /**
    * @Description : This method is used to assign values to key transformational Loss from opportunity.
    * @param       : list of opportunity for the account and the children accounts,map of type strategic account plan and account id,map of type strategic account plan and competitive Landscape.
    * @return      : list of Key Transformational Loss to be inserted.
    **/ 
    public list<Key_Transformational_Loss__c> createKeyTransformationalLoss(list<Opportunity> retrieveAllRelatedLossOpportunitiesList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId,Map<Id,Id> mapOfCompetitiveLandscapeWithStrategicAccountPlanId ) {  
        Key_Transformational_Loss__c keyTransformationalLosses;
        list<Key_Transformational_Loss__c>  listOfKeyTransformationalLoss = New List<Key_Transformational_Loss__c>();    
        if((retrieveAllRelatedLossOpportunitiesList!= null) && !(retrieveAllRelatedLossOpportunitiesList.isEmpty())){
            for(Opportunity opportunityRecord: retrieveAllRelatedLossOpportunitiesList) {
                for(Id strategicAccountPlanId: mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId)){
                    if(mapOfStrategicAccountPlanIdWithAccountId.get(opportunityRecord.AccountId) != null) {                    
                        keyTransformationalLosses= new Key_Transformational_Loss__c();
                        keyTransformationalLosses.Competitive_Landscape__c = mapOfCompetitiveLandscapeWithStrategicAccountPlanId.get(strategicAccountPlanId);
                        keyTransformationalLosses.Opportunity_Id__c = opportunityRecord.Id;
                        listOfKeyTransformationalLoss.add(keyTransformationalLosses);
                    }
                }
            }
        }
        return listOfKeyTransformationalLoss;
    } 
    
    /**
    * @Description : This method is used to insert list of Key Transformational Win on Competitve Landscape.
    * @param       : list of Key transformational Win records to be inserted.
    * @return      : void.
    **/
    public void  insertKeyTransformationalWin(list<Key_Transformational_Win__c> createKeyTransformationalWinList ) {
        if((createKeyTransformationalWinList != null) && !(createKeyTransformationalWinList.isEmpty())){
            dAOClass.insertKeyTransformationalWin(createKeyTransformationalWinList );
        }
    }
    
    /**
    * @Description : This method is used to insert list of Key Transformational Loss on Competitve Landscape.
    * @param       : list of Key transformational Loss records to be inserted.
    * @return      : void.
    **/
    public void  insertKeyTransformationalLoss(list<Key_Transformational_Loss__c> createKeyTransformationalLossList) {
        if((createKeyTransformationalLossList!= null) && !(createKeyTransformationalLossList.isEmpty())){
            dAOClass.insertKeyTransformationalLoss(createKeyTransformationalLossList);
        }
    }
    
    /**
    * @Description : This method is used to retrieve the contract of the account associated to the GSP.
    * @param       : list of final set of accounts.
    * @return      : list of Contracts to be updated.
    **/
    public list<Contract_Account_Link__c> retrieveAllRelatedContractFromContractAccountLink(List<Account> listOfFinalAccounts) {
        list<Contract_Account_Link__c> retrieveAllContractList = New  list<Contract_Account_Link__c>();
        if((listOfFinalAccounts!= null) && !(listOfFinalAccounts.isEmpty())){
            retrieveAllContractList = dAOClass.retrieveAllRelatedContractFromContractAccountLink(listOfFinalAccounts);
        }
        return retrieveAllContractList;
    }
    
    /**
    * @Description : This method is used to assign values to Contract Detail from Contract.
    * @param       : list of contrat for the account and the children accounts,map of type strategic account plan and account id,map of type strategic account plan and contract summary.
    * @return      : list of contract details to be inserted.
    **/
    public list<Contract_Detail__c> createContractDetail(list<Contract_Account_Link__c> retrieveAllRelatedContractList, Map<Id,Set<Id>> mapOfStrategicAccountPlanIdWithAccountId) {  
        Contract_Detail__c contractDetails;
        list<Contract_Detail__c>  listOfContractDetail = New List<Contract_Detail__c>();    
        if((retrieveAllRelatedContractList != null) && !(retrieveAllRelatedContractList.isEmpty())){
            for(Contract_Account_Link__c contractAccountLinkRecord: retrieveAllRelatedContractList) {
                if(mapOfStrategicAccountPlanIdWithAccountId.get(contractAccountLinkRecord.Account_Name__c) != null) {
                    for(Id strategicAccountPlanId: mapOfStrategicAccountPlanIdWithAccountId.get(contractAccountLinkRecord.Account_Name__c)) {
                        contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlanId, Contract_Id__c = contractAccountLinkRecord.Contract_Name__c,AccountId_Lookup__c=contractAccountLinkRecord.Account_Name__c);
                        listOfContractDetail.add(contractDetails);
                    }
                }
            }   
        }
        return listOfContractDetail;
    }   

    /**
    * @Description : This method is used to insert list of Contract Deatil on GSP.
    * @param       : list of Contract Detail records to be inserted.
    * @return      : void.
    **/
    public void  insertContractDetail(list<Contract_Detail__c> createContractDetailList) {
        if((createContractDetailList != null) && !(createContractDetailList.isEmpty())){
            dAOClass.insertContractDetail(createContractDetailList);
        }
    }

    /**
    * @Description : This method is used to retrieve the Parent Accounts for which a new record has been created.
    * @param       : set of parent account ids to store the account ids.
    * @return      : set fo parent account ids.
    **/
    public Set<Id> retrieveParentAccounts(Set<Id> setOfParentAccountsId) {
        Set<Id> tempInsideLoop;
        List<Account> listOfParentAccounts = New List<Account>();
        Set<Id> tempSet;
        tempSet = setOfParentAccountsId;
        Boolean top= false;
        try{
            while(!top) {
                listOfParentAccounts=dAOClass.retrieveParentAccounts(tempSet);
                tempInsideLoop = New Set<Id>();
                if((listOfParentAccounts!= null) && !(listOfParentAccounts.isEmpty())) {
                    for(Account parentAccount: listOfParentAccounts) {
                        if(parentAccount.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                            tempInsideLoop.add(parentAccount.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c);
                        }
                    }
                }
                if(!(tempInsideLoop.isEmpty())) {
                    setOfParentAccountsId.addall(tempInsideLoop);
                    tempSet = tempInsideLoop;
                }
                else {
                    top = true;
                }            
            }     
            return setOfParentAccountsId;
        }
        catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
        }  
    }
    
    /**
    * @Description : This method is used to retrieve the map of parent accounts with id.
    * @param       : Set of parent Account Ids.
    * @return      : map of parent accounts.
    **/        
    public Map<Id,Account> retrieveMapOfParentAccounts(Set<Id> setOfParentAccountsId) {
        Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>();
        mapOfParentAccounts=dAOClass.retrieveParentIds(setOfParentAccountsId);
        return mapOfParentAccounts;
    }
    
    /**
    * @Description : This method is used to retrieve the set of consolidated account ids.
    * @param       : map of parent account and id.
    * @return      : set of consolidated account ids.
    **/
    public Set<Id> retriveSetOfConsolidatedAccountIds(Map<Id,Account> mapOfParentAccounts) {
        Set<Id> setOfConsolidatedAccountIds=new Set<Id>();
        for(Account accountRecord: mapOfParentAccounts.Values())    {
            setOfConsolidatedAccountIds.add(accountRecord.Id);
            if(accountRecord.Parent_IDN_of_Associated_IDN__c != null) {
                setOfConsolidatedAccountIds.add(accountRecord.Parent_IDN_of_Associated_IDN__c) ;
                if(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                    setOfConsolidatedAccountIds.add(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c);
                    if(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                        setOfConsolidatedAccountIds.add(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c);
                        if(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                            setOfConsolidatedAccountIds.add(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c );
                            if(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null) {
                                setOfConsolidatedAccountIds.add(accountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c);
                            }
                        }
                    }
                }
            }
        }            
        return setOfConsolidatedAccountIds;
    } 
      
    /**
    * @Description : This method is used to retrieve the map of List of strategic acoount type and Id.
    * @param       : set of consolidated account ids.
    * @return      : map of strategic account plan.
    **/     
    public Map<Id, List<Strategic_Account_Plan__c>> getListOfStrategicAccountPlan(Set<Id> setOfConsolidatedAccountIds) {
        List<Strategic_Account_Plan__c> tempAccountList;
        Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan=new Map<Id, List<Strategic_Account_Plan__c>>();
        List<Strategic_account_Plan__c> listOfStrategicAccountPlan=new List<Strategic_Account_Plan__c>();
        listOfStrategicAccountPlan = dAOClass.getListOfStrategicAccountPlan(setOfConsolidatedAccountIds);
        if((listOfStrategicAccountPlan != null) && !(listOfStrategicAccountPlan.isEmpty())){
            for(Id accountId :setOfConsolidatedAccountIds) {
                tempAccountList = New list<Strategic_Account_Plan__c>();
                for(Strategic_Account_Plan__c strategicAccountPlanRecord :listOfStrategicAccountPlan ) {
                    if(accountId == strategicAccountPlanRecord.Account__c){
                        tempAccountList.add(strategicAccountPlanRecord);
                    }
                    mapOfStrategicAccountPlan.put(accountId, tempAccountList);
                } 
            }
        }   
        return mapOfStrategicAccountPlan;
    }
    
    /**
    * @Description : This method is used to of people and relationship to insert.
    * @param       : Trigger records of type contacts,map of parent accounts,map of type id and list of strategic account plan.
    * @return      : list of peopleand relationship record to be inserted.
    **/
    public List<People_and_Relationship__c> getListOfPeopleAndRelationShipRecordsToInsert(List<Contact> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan) {
        List<People_and_Relationship__c> listOfPeopleAndRelationShipRecordsToInsert = New List<People_and_Relationship__c>();
        People_and_Relationship__c peopleAndRelationShipRecord ;
        if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())){
            for(contact contactRecord: listOfTriggerRecords) {
                if(mapOfParentAccounts.get(contactRecord.AccountId) != null) {
                    Account tempAccountRecord = mapOfParentAccounts.get(contactRecord.AccountId);
                    if(tempAccountRecord.iD != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Id) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Id))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan .Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }   
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfstrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan.Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan.Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan.Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan.Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null &&mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                                peopleAndRelationShipRecord = New People_and_Relationship__c(Strategic_account_plan__c = strategicAccountPlan.Id, Contact_Id__c = contactRecord.Id);
                                listOfPeopleAndRelationShipRecordsToInsert.add(peopleAndRelationShipRecord);
                        }
                    }
                }
            }
        }
        return listOfPeopleAndRelationShipRecordsToInsert;
    }
    /**
    * @Description : This method is used to insert the list of new records in people and relationship.
    * @param       : list of people and relationship to be inserted.
    * @return      : void
    **/  
    public void insertListOfPeopleAndRelationShipRecords(List<People_and_Relationship__c> listOfPeopleAndRelationShipRecordsToInsert) {
        if((listOfPeopleAndRelationShipRecordsToInsert != null) && !(listOfPeopleAndRelationShipRecordsToInsert.isEmpty())){
            dAOClass.insertPeopleAndrelationshipRecords(listOfPeopleAndRelationShipRecordsToInsert);
        }
    }  
            
    /**
    * @Description : This method is used to retrieve the listof contract details to insert.
    * @param       : Trigger records of type contacts,map of parent accounts,map of type id and list of strategic account plan.
    * @return      : list of contract details record to be inserted.
    **/
    public List<Contract_Detail__c> getListOfContractDetailRecordsOfAccountLinkToInsert(List<Contract_Account_Link__c> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan) {
        List<Contract_Detail__c> listOfContractDetailRecordsToInsert = New List<Contract_Detail__c>();
        Contract_Detail__c contractDetails;
        if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())){
            for(Contract_Account_Link__c contractRecord: listOfTriggerRecords) {
               Account tempAccountRecord = mapOfParentAccounts.get(contractRecord.Account_name__c);
               if(tempAccountRecord.iD != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Id) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Id))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
               if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
               if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
               if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null &&mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
               if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
               if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                   for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                       contractDetails = new Contract_Detail__c(Strategic_account_plan__c = strategicAccountPlan.id, Contract_Id__c = contractRecord.Contract_Name__c,AccountId_lookup__c=contractRecord.Account_Name__c);
                       listOfContractDetailRecordsToInsert.add(contractDetails);
                   }
               }
            }
        }
        return listOfContractDetailRecordsToInsert;
        }                
    /**
    * @Description : This method is used to insert the list of new records in contract details.
    * @param       : list of contract details to be inserted.
    * @return      : void
    **/  
    public void insertListOfContractDetailRecords(List<Contract_Detail__c> listOfContractDetailRecordsToInsert) {
        if((listOfContractDetailRecordsToInsert != null) && !(listOfContractDetailRecordsToInsert.isEmpty())){
            dAOClass.insertContractDetailRecords(listOfContractDetailRecordsToInsert);
        }
    } 
            
    /**
    * @Description : This method is used to retrieve the list of Top opportunites to insert.
    * @param       : Trigger records of type opportunity,map of parent accounts,map of type id and list of strategic account plan.
    * @return      : list of top opportunity record to be inserted.
    **/
    public List<Top_Opportunities__c> getListOfTopOpportunitiesRecordsToInsert(List<Opportunity> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan) {
        List<Top_Opportunities__c>  listOfTopOpportunitiesRecordsToInsert = New List<Top_Opportunities__c> ();
        Top_Opportunities__c topOpportunitiesRecord ;
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            for(Opportunity opportunityRecord: listOfTriggerRecords) {
                Account tempAccountRecord = mapOfParentAccounts.get(opportunityRecord.AccountId);
                if(tempAccountRecord.iD != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Id) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Id))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }   
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        topOpportunitiesRecord = New Top_Opportunities__c(Strategic_account_plan__c = strategicAccountPlan .Id, opportunity_Id__c = opportunityRecord.Id);
                        listOfTopOpportunitiesRecordsToInsert.add(topOpportunitiesRecord);
                    }   
                }              
            }
        }
        return listOfTopOpportunitiesRecordsToInsert;                       
    }
    /**
    * @Description : This method is used to insert the list of new records in top opportunities..
    * @param       : list of top opportunities to be inserted.
    * @return      : void
    **/  
    public void insertListOfTopOpportunitiesRecords(List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToInsert) {
        if((listOfTopOpportunitiesRecordsToInsert != null) && !(listOfTopOpportunitiesRecordsToInsert.isEmpty())){
            dAOClass.insertTopOpportunitiesRecords(listOfTopOpportunitiesRecordsToInsert);
        }
    }  
            
    /**
    * @Description : This method is used to retrieve the list of asset to insert.
    * @param       : Trigger records of type asset,map of parent accounts,map of type id and list of strategic account plan.
    * @return      : list of asset record to be inserted.
    **/
    public List<Asset__c> getListOfAssetsRecordsToInsert(List<Asset> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan) {
        List<Asset__c>  listOfAssetsRecordsToInsert = New List<Asset__c> ();
        Asset__c assetRecord ;
        if((listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            for(Asset assetSORecord: listOfTriggerRecords) {
                Account tempAccountRecord = mapOfParentAccounts.get(assetSORecord.AccountId);
                if(tempAccountRecord.iD != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Id) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Id))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }
                }
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }
                }   
                if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        assetRecord = New Asset__c(Strategic_account_plan__c = strategicAccountPlan.Id, Asset_Id__c = assetSORecord.Id);
                        listOfAssetsRecordsToInsert.add(assetRecord);
                    }   
                }   
            }
        }
        return listOfAssetsRecordsToInsert;
    }
    
    /**
    * @Description : This method is used to insert the list of new records in Asset.
    * @param       : list of asset to be inserted.
    * @return      : void
    **/  
    public void insertListOfAssetsRecords(List<Asset__c> listOfAssetsRecordsToInsert) {
        if((listOfAssetsRecordsToInsert != null) && !(listOfAssetsRecordsToInsert.isEmpty())){
            dAOClass.insertAssetsRecords(listOfAssetsRecordsToInsert);
        }
    }  

          
    /**
    * @Description : This method is used to retrieve the list of hospital locations to insert.
    * @param       : Trigger records of type accounts,map of parent accounts,map of type id and list of strategic account plan.
    * @return      : list of hospital locations record to be inserted.
    **/
    public List<Hospital_Locations__c> getListOfHospitalLocationsRecordsToInsert(List<Account> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id, List<Strategic_Account_Plan__c>> mapOfStrategicAccountPlan) {
        List<Hospital_Locations__c> listOfHospitalLocationsRecordsToInsert = New List<Hospital_Locations__c>();
        Hospital_Locations__c hospitalLocationsRecord ;
        list<Account> accountlist =dAOClass.retrieveAccountList(listOfTriggerRecords);
        if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty()) && (accountlist!= null) && !(accountlist.isEmpty())){
            for(Account accountRecord: accountlist ) {
                Account tempAccountRecord = mapOfParentAccounts.get(accountRecord.Id);
                if(tempAccountRecord != null && tempAccountRecord.iD != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Id) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Id))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfhospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);
                    }
                }
                if(tempAccountRecord != null && tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfhospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);                        
                    }   
                }   
                if(tempAccountRecord != null && tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfhospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);
                    }
                }
                if(tempAccountRecord != null && tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfhospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);                       
                    }
                }
                if(tempAccountRecord != null && tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfhospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);                            
                    }
                }
                if(tempAccountRecord != null && tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                    for(Strategic_Account_Plan__c strategicAccountPlan :(mapOfStrategicAccountPlan.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                        hospitalLocationsRecord = New Hospital_Locations__c(account_Id__c = accountRecord.Id, Strategic_account_plan__c = strategicAccountPlan .Id);
                        listOfHospitalLocationsRecordsToInsert.add(hospitalLocationsRecord);                            
                    }
                }
            }
        }
        return listOfHospitalLocationsRecordsToInsert;
    }
    
    /**
    * @Description : This method is used to insert the list of new records in Hospital Locations.
    * @param       : list of hospital loctions to be inserted.
    * @return      : void
    **/   
    public void insertListOfHospitalLocationsRecords(List<Hospital_Locations__c> listOfHospitalLocationsRecordsToInsert) {
        if((listOfHospitalLocationsRecordsToInsert != null) && !(listOfHospitalLocationsRecordsToInsert.isEmpty())){
            dAOClass.insertHospitalLocationsRecords(listOfHospitalLocationsRecordsToInsert);
        }
    } 
          
    /**
    * @Description : This method is used to retrieve the map of List of competitive Landscape and Id.
    * @param       : set of consolidated account ids.
    * @return      : map of Competitive Landscape.
    **/   
    public Map<Id, List<Competitive_Landscape__c>> getListOfCompetitiveLandscape(Set<Id> setOfConsolidatedAccountIds) {
        List<Competitive_landscape__c> tempLandscapeList;
        Map<Id, List<Competitive_Landscape__c>> mapOfCompetitiveLandscape=new Map<Id, List<Competitive_Landscape__c>>();
        List<Competitive_Landscape__c> listOfCompetitiveLandscape=new List<Competitive_Landscape__c>();
        listOfCompetitiveLandscape= dAOClass.getListOfCompetitiveLAndscape(setOfConsolidatedAccountIds);
        if((listOfCompetitiveLandscape != null) && !(listOfCompetitiveLandscape.isEmpty())){
            for(Id accountId :setOfConsolidatedAccountIds) {              
                tempLandscapeList=new List<Competitive_Landscape__c>();
                for(Competitive_Landscape__c competitiveLandscapeRecord : listOfCompetitiveLandscape)  {                              
                    if(accountId == competitiveLandscapeRecord.AccountId_lookup__c){
                        tempLandscapeList.add(competitiveLandscapeRecord);
                    }
                    mapOfCompetitiveLandscape.put(accountId,tempLandscapeList);           
                }   
            }
        }   
        return mapOfCompetitiveLandscape;      
    }  
     
    /**
    * @Description : This method is used to retrieve the list of Key Transformational WIn to insert.
    * @param       : Trigger records of type opportunity,map of parent accounts,map of type id and list of competitive Landscape.
    * @return      : list of Key Transformational Win record to be inserted.
    **/
    public List<Key_Transformational_Win__c> getListOfKeyTransformationalWinRecordsToInsert(List<Opportunity> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape) {
        List<Key_Transformational_Win__c>  listOfKeyWinRecordsToInsert = New List<Key_Transformational_Win__c> ();
        Key_Transformational_Win__c keyWinRecord ;
            if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())){
                for(Opportunity opportunityRecord: listOfTriggerRecords) {
                    Account tempAccountRecord = mapOfParentAccounts.get(opportunityRecord.AccountId);  
                    if(tempAccountRecord.iD != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Id) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Id))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);        
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);                  
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);                  
                        }
                    }   
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);                         
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);                 
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);          
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyWinRecord = New Key_Transformational_Win__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);                  
                            listOfKeyWinRecordsToInsert.add(keyWinRecord);          
                        }
                    }
                }
            }            
            return listOfKeyWinRecordsToInsert;
        }
    
    /**
    * @Description : This method is used to insert the list of new records in Key Transformational Win.
    * @param       : list of key transformational Win to be inserted.
    * @return      : void
    **/     
    public void insertListOfKeyTransformationalWinRecords(List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToInsert) {
        if((listOfKeyTransformationalWinRecordsToInsert != null) && !(listOfKeyTransformationalWinRecordsToInsert.isEmpty())){
            dAOClass.insertKeyTransformationalWinRecords(listOfKeyTransformationalWinRecordsToInsert);
        }
    }  
       
    /**
    * @Description : This method is used to retrieve the list of Key Transformational Loss to insert.
    * @param       : Trigger records of type opportunity,map of parent accounts,map of type id and list of competitive Landscape.
    * @return      : list of Key Transformational Loss record to be inserted.
    **/
    public List<Key_Transformational_Loss__c> getListOfKeyTransformationalLossRecordsToInsert(List<Opportunity> listOfTriggerRecords,Map<Id,Account> mapOfParentAccounts,Map<Id,List<Competitive_Landscape__c>> mapOfCompetitiveLandscape) {
        List<Key_Transformational_Loss__c>  listOfKeyLossRecordsToInsert = New List<Key_Transformational_Loss__c> ();
        Key_Transformational_Loss__c keyLossRecord ;
        if((listOfTriggerRecords != null) && !(listOfTriggerRecords.isEmpty())){
            for(Opportunity opportunityRecord: listOfTriggerRecords) {
                Account tempAccountRecord = mapOfParentAccounts.get(opportunityRecord.AccountId);
                    if(tempAccountRecord.iD != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Id) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Id))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);                     
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);            
                        }   
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__c))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);          
                        }
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c ) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);                  
                        }   
                    }
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);               
                        }   
                    }   
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c != null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);          
                        }
                    }   
                    if(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c!= null && mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c) != null) {
                        for(Competitive_Landscape__c competitiveLandscapeRecord :(mapOfCompetitiveLandscape.get(tempAccountRecord.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c))) {
                            keyLossRecord= New Key_Transformational_Loss__c(Opportunity_Id__c = opportunityRecord.Id, Competitive_Landscape__c = competitiveLandscapeRecord.Id);   
                            listOfKeyLossRecordsToInsert.add(keyLossRecord);              
                        }
                    }   
                }
            }
            return listOfKeyLossRecordsToInsert;
        }
        
    /**
    * @Description : This method is used to insert the list of new records in Key Transformational Loss.
    * @param       : list of key transformational Loss to be inserted.
    * @return      : void
    **/     
    public void insertListOfKeyTransformationalLossRecords(List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToInsert) {
        if((listOfKeyTransformationalLossRecordsToInsert != null) && !(listOfKeyTransformationalLossRecordsToInsert.isEmpty())){
            dAOClass.insertKeyTransformationalLossRecords(listOfKeyTransformationalLossRecordsToInsert);
        }
    }  
        
    /**
    * @Description : This method is update the field on the SAP if the Competitive Landscape,Financial objperformanceMgmtProfit record is deleted..
    * @param       : strategic account plan record.
    * @return      : void
    **/   
    public void updateStrategicAccountPlanRecord(List<Strategic_Account_Plan__c> strategicAccountPlanRecord){
        dAOClass.updateStrategicAccountPlanRecord(strategicAccountPlanRecord);
    }
        
    /**
    * @Description : This method update the Key Geographies field on the SAP              
    * @param       : set of strategic account plan id, list of Hospital location record,map Of StrategicAccountPlanIdWithId.
    * @return      : void
    **/   
    public void strategicAccountPlansToUpdate(Set<Id> setOFStrategicAccountPlanId,List<Hospital_Locations__c> listOFHospitalLocations,Map<Id,strategic_Account_plan__C> mapOfStrategicAccountPlanIdWithId){
        List<strategic_Account_plan__C> listOFStrategicAccountPlansToUpdate = New List<strategic_Account_plan__C>();
        if((listOFHospitalLocations != null) && !(listOFHospitalLocations.isEmpty())){
            for(Id strategicAccountPlanId :setOFStrategicAccountPlanId) {
                String collectKeyGoegraphies;
                for(Hospital_Locations__c hospitalLocationRecord:listOFHospitalLocations) {
                    if(hospitalLocationRecord.strategic_Account_plan__C == strategicAccountPlanId) {
                        if(collectKeyGoegraphies == '' || collectKeyGoegraphies == null && hospitalLocationRecord.State_Formula__c != null && hospitalLocationRecord.State_Formula__c != '') {
                            collectKeyGoegraphies = hospitalLocationRecord.State_Formula__c+' '+hospitalLocationRecord.Zip_Formula__c;
                        }
                        else{
                            if(hospitalLocationRecord.State_Formula__c != null && hospitalLocationRecord.State_Formula__c != '') {
                                collectKeyGoegraphies = collectKeyGoegraphies+','+hospitalLocationRecord.State_Formula__c+' '+hospitalLocationRecord.Zip_Formula__c;
                            }
                        }
                    }
                }
                mapOfStrategicAccountPlanIdWithId.get(strategicAccountPlanId);
                strategic_Account_plan__c updateStrategicAccountPlan= new strategic_Account_plan__C();
                updateStrategicAccountPlan = mapOfStrategicAccountPlanIdWithId.get(strategicAccountPlanId);
                if(collectKeyGoegraphies != null && collectKeyGoegraphies != ''){
                    updateStrategicAccountPlan.Key_Geographies__c = collectKeyGoegraphies;
                }
                listOFStrategicAccountPlansToUpdate.add(updateStrategicAccountPlan);
            }
            dAOClass.strategicAccountPlansToUpdate(listOFStrategicAccountPlansToUpdate);
        }
    }
    
    /**
    * @Description : This method retrieve list of people and relationship record to be deleted.
    * @param       : set of strategic account plan id.
    * @return      : list of people and relationship.
    **/ 
    public List<People_And_Relationship__c> retrieveRelatedPeopleAndRelations(Set<Id> setOfStrategicAccountPlanId){
        List<People_and_Relationship__c> peopleAndRelationshipToDelete = new List<People_And_Relationship__c>();
        peopleAndRelationshipToDelete=dAOClass.retrieveRelatedPeopleAndRelations(setOfStrategicAccountPlanId);        
        return peopleAndRelationshipToDelete;            
    }
    
    /**
    * @Description : This method delete list of PeopleAndRelations records.
    * @param       : list of PeopleAndRelations records to be deleted.
    * @return      : void
    **/
    public void deleteRelatedPeopleAndRelations(List<People_And_Relationship__c> retrieveRelatedPeopleAndRelations){ 
        if((retrieveRelatedPeopleAndRelations != null) && !(retrieveRelatedPeopleAndRelations.isEmpty())){
            dAOClass.deleteRelatedPeopleAndRelations(retrieveRelatedPeopleAndRelations);
        }
    }
    
    /**
    * @Description : This method retrieve list of HospitalLocations record to be deleted.
    * @param       : set of strategic account plan id.
    * @return      : list of HospitalLocations.
    **/ 
    public List<Hospital_Locations__c> retrieveRelatedHospitalLocations(Set<Id> setOfStrategicAccountPlanId){
        List<Hospital_Locations__c> hospitalLocationsToDelete = new List<Hospital_Locations__c>();
        hospitalLocationsToDelete =dAOClass.retrieveRelatedHospitalLocations(setOfStrategicAccountPlanId);
        return hospitalLocationsToDelete ;            
    }
    
    public void deleteRelatedHospitalLocations(List<Hospital_Locations__c> retrieveRelatedHospitalLocations){
        if((retrieveRelatedHospitalLocations != null) && !(retrieveRelatedHospitalLocations.isEmpty())){
            dAOClass.deleteRelatedHospitalLocations(retrieveRelatedHospitalLocations);
        }
    }
        
    public List<Contract_Detail__c> retrieveRelatedContractDetails(Set<Id> setOfStrategicAccountPlanId){
        List<Contract_Detail__c> contractDetailsToDelete = new List<Contract_Detail__c>();
        contractDetailsToDelete =dAOClass.retrieveRelatedContractDetails(setOfStrategicAccountPlanId);
        return contractDetailsToDelete ;            
    }
    
    public void deleteRelatedContractDetails(List<Contract_Detail__c> retrieveRelatedContractDetails){
        if((retrieveRelatedContractDetails != null) && !(retrieveRelatedContractDetails.isEmpty())){
            dAOClass.deleteRelatedContractDetails(retrieveRelatedContractDetails);
        }
    }
    
    public List<Top_opportunities__c> retrieveRelatedTopOpportunities(Set<Id> setOfStrategicAccountPlanId){
        List<Top_opportunities__c> topOpportunitiesToDelete = new List<Top_opportunities__c>();
        topOpportunitiesToDelete =dAOClass.retrieveRelatedTopOpportunities(setOfStrategicAccountPlanId);
        return topOpportunitiesToDelete ;            
    }
    
    public void deleteRelatedTopOpportunities(List<Top_opportunities__c> retrieveRelatedTopOpportunities){
        if((retrieveRelatedTopOpportunities != null) && !(retrieveRelatedTopOpportunities.isEmpty())){
            dAOClass.deleteRelatedTopOpportunities(retrieveRelatedTopOpportunities);
        }
    }
    
    public List<Asset__c> retrieveRelatedAssets(Set<Id> setOfStrategicAccountPlanId){
        List<Asset__c> assetToDelete = new List<Asset__c>();
        assetToDelete =dAOClass.retrieveRelatedAssets(setOfStrategicAccountPlanId);
        return assetToDelete ;            
    }
    
    public void deleteRelatedAssets(List<Asset__c> retrieveRelatedAssets){
        if((retrieveRelatedAssets != null) && !(retrieveRelatedAssets.isEmpty())){
            dAOClass.deleteRelatedAssets(retrieveRelatedAssets);
        }
    }
    
    public List<Account_Team__c> retrieveRelatedAccountTeam(Set<Id> setOfStrategicAccountPlanId){
        List<Account_Team__c> accountTeamToDelete = new List<Account_Team__c>();
        accountTeamToDelete =dAOClass.retrieveRelatedAccountTeam(setOfStrategicAccountPlanId);
        return accountTeamToDelete ;            
    }
    
    public void deleteRelatedAccountTeam(List<Account_Team__c> retrieveRelatedAccountTeam){
        if((retrieveRelatedAccountTeam != null) && !(retrieveRelatedAccountTeam.isEmpty())){
            dAOClass.deleteRelatedAccountTeam(retrieveRelatedAccountTeam);
        }
    }
    
    public List<Competitive_Landscape__c> retrieveListOfCompetitiveLandscape(Set<Id> setOfStrategicAccountPlanId){
        List<Competitive_Landscape__c> competitiveLandscapeList = new List<Competitive_Landscape__c>();
        competitiveLandscapeList=dAOClass.retrieveListOfCompetitiveLandscape(setOfStrategicAccountPlanId);
        return competitiveLandscapeList;
    }
    public List<Key_transformational_Win__c> retrieveRelatedKeyWinOpportunities(Set<Id> setOfCompetitiveLandscapeId){
        List<Key_transformational_Win__c> keyWinOpportunitiesToDelete = new List<Key_transformational_Win__c>();
        keyWinOpportunitiesToDelete =dAOClass.retrieveRelatedKeyWinOpportunities(setOfCompetitiveLandscapeId);
        return keyWinOpportunitiesToDelete ;            
    }
    
    public void deleteRelatedKeyWinOpportunities(List<Key_transformational_Win__c> retrieveRelatedKeyWinOpportunities){
        if((retrieveRelatedKeyWinOpportunities != null) && !(retrieveRelatedKeyWinOpportunities.isEmpty())){
            dAOClass.deleteRelatedKeyWinOpportunities(retrieveRelatedKeyWinOpportunities);
        }
    }
    public List<Key_transformational_Loss__c> retrieveRelatedKeyLossOpportunities(Set<Id> setOfCompetitiveLandscapeId){
        List<Key_transformational_Loss__c> keyLossOpportunitiesToDelete = new List<Key_transformational_Loss__c>();
        keyLossOpportunitiesToDelete =dAOClass.retrieveRelatedKeyLossOpportunities(setOfCompetitiveLandscapeId);
        return keyLossOpportunitiesToDelete ;            
    }
    
    public void deleteRelatedKeyLossOpportunities(List<Key_transformational_Loss__c> retrieveRelatedKeyLossOpportunities){
        if((retrieveRelatedKeyLossOpportunities != null) && !(retrieveRelatedKeyLossOpportunities.isEmpty())){
            dAOClass.deleteRelatedKeyLossOpportunities(retrieveRelatedKeyLossOpportunities);
        }
    }
        
    public void updateAccountOnCompetitiveLandscape(List<Competitive_Landscape__c> competitiveLandscapeList,List<Strategic_Account_Plan__c> listOfTriggerRecords){
        List<Competitive_Landscape__c> competitiveLandscapeToUpdate= new  List<Competitive_Landscape__c>();
        Competitive_Landscape__c competitiveLandscape;
        if((competitiveLandscapeList != null) && !(competitiveLandscapeList.isEmpty()) && (listOfTriggerRecords!= null) && !(listOfTriggerRecords.isEmpty())){
            for(Strategic_Account_Plan__c strategicAccountPlanRecord : listOfTriggerRecords){
                for(Competitive_Landscape__c competitiveLandscapeRecords: competitiveLandscapeList){
                    if(strategicAccountPlanRecord.Id == competitiveLandscapeRecords.Strategic_Account_Plan__c) {
                        competitiveLandscape=new Competitive_Landscape__c(Id=competitiveLandscapeRecords.Id);
                        competitiveLandscape.AccountId_lookup__c=strategicAccountPlanRecord .Account__c;
                        competitiveLandscapeToUpdate.add(competitiveLandscape); 
                    } 
                }
            }
            dAOClass.updateAccountOnCompetitiveLandscape(competitiveLandscapeToUpdate);   
            
        }
    }
}