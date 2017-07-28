/**
* @ClassName : HCNA_GSPTriggerDAOClass
* @Description : This class is the DAO class of HCNA_GSPTrigger Classes.This class performes database related action of the page(SOQL and DML)
* @Author : Albin Deni Arul
* @Last Modified : 
* @Discussionpoints :
*/
public class HCNA_GSPTriggerDAOClass {
    /**    
    * @Description : This method retrevies the existing Contacts associated to Account and Child Account which is associated to the Strategic Account plan    
    * @param       : List of Account for which contact list to retrieved    
    * @return      : List of Contacts records    
    **/
    public list<Contact> retrieveAllRelatedContacts(list<Account> finalSetOFAccountsList) {
        list<Contact> retrieveAllRelatedContactsList = New  list<Contact>();
        try {
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) {        
                retrieveAllRelatedContactsList = [select Id, Name,Primary_Contact__c,title,Department_Category__c,Role_of_Influence__c,Level_of_Influence__c,Advocacy__c, AccountId from Contact where AccountId In:finalSetOFAccountsList];       
                return retrieveAllRelatedContactsList ;
            }
            else {
                return null;
            }                        
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    
    /**   
    * @Description : This method retrevies the existing account details for hospital location from Account which is associated to the Strategic Account plan    
    * @param       : List of Account for which account details to retrieved    
    * @return      : List of Account records    
    **/
    public list<Account> retrieveAllRelatedAccounts(list<Account> finalSetOFAccountsList) {
        list<Account> retrieveAllRelatedAccountsList = New  list<Account>();
        try {
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) { 
                retrieveAllRelatedAccountsList = [select Id,Name,Street1_Local__c, City_Local__c,Region__c,Region__r.name, Zip_Postal_Code_Local__c, Facility_Type__c from Account where Id In:finalSetOFAccountsList];
                return retrieveAllRelatedAccountsList;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    
    /**
    * @Description : This method retrevies the existing Asset associated to Account and Child Account which is associated to the Strategic Account plan    
    * @param       : List of Account for which Asset list to retrieved    
    * @return      : List of Asset records    
    **/
    public list<Asset> retrieveAllRelatedAssets(list<Account> finalSetOFAccountsList) {
        list<Asset> retrieveAllRelatedAssetsList = New  list<Asset>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) { 
                retrieveAllRelatedAssetsList = [select Id,Name,UsageEndDate,Modality_lookup_product__c,Lease_Expiration_Date__c,Booking_Date__c,Vendor_on_product__c,Product__c,Ship_to_Account_City__c,Ship_to_Account_State__c,AccountID from Asset where AccountId In:finalSetOFAccountsList];            
                return retrieveAllRelatedAssetsList;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());        
            return null;
        }
    }
    
    /**  
    * @Description : This method retrevies the existing Opportunity associated to Account and Child Account which is associated to the Strategic Account plan    
    * @param       : List of Account for which Opportunity list to retrieved    
    * @return      : List of opportunity records    
    **/
    public list<Opportunity> retrieveAllRelatedOpportunities(list<Account> finalSetOFAccountsList) {
        list<Opportunity> retrieveAllRelatedOpportunitiesList = New  list<Opportunity>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) { 
                retrieveAllRelatedOpportunitiesList = [select Id,Name, AccountID from opportunity where Must_Win_flag__c = true and AccountId In:finalSetOFAccountsList];
                return retrieveAllRelatedOpportunitiesList;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    
    /**
    * @Description : This method retrevies the existing Account Team Member associated to Account and Child Account which is associated to the Strategic Account plan    
    * @param       : List of Account for which Account team member list to retrieved    
    * @return      : List of Account team member records    
    **/
    public list<AccountTeamMember> retrieveAllRelatedAccountTeamMembers(list<Account> finalSetOFAccountsList) {
        list<AccountTeamMember> retrieveAllRelatedAccountTeamMembersList = New  list<AccountTeamMember>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) { 
                retrieveAllRelatedAccountTeamMembersList = [select Id,user.name,TeamMemberRole,user.MobilePhone,user.Phone,user.Extension, user.fax, user.Email, user.title,AccountId from AccountTeamMember where AccountId In:finalSetOFAccountsList];     
                return retrieveAllRelatedAccountTeamMembersList;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }

    
    /**
    * @Description : This method retrevies the existing HospitalLocations record from custom object HospitalLocations
    * @param       : List of triggered account for which HospitalLocations to retrieved    
    * @return      : List of HospitalLocations records    
    **/
    public list<Hospital_Locations__c> retrieveListOfHospitalLocations(List<Account> triggerRecordsList){
        List<Hospital_Locations__c> listOfHospitalLocations=new List<Hospital_Locations__c>();
        try{
            if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) { 
                listOfHospitalLocations=[select Id,Account_Id__c from Hospital_Locations__c where Account_Id__c In: triggerRecordsList]; 
                return listOfHospitalLocations;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    
    /** 
    * @Description : This method retrevies the existing StrategicAccountPlan record from custom object StrategicAccountPlan
    * @param       : List of triggered account for which StrategicAccountPlan to retrieved    
    * @return      : List of StrategicAccountPlan records    
    **/
    public list<Strategic_Account_Plan__c> retrieveListOfStrategicAccountPlan(List<Account> triggerRecordsList){
        List<Strategic_Account_Plan__c> listOfStrategicAccountPlan= new List<Strategic_Account_Plan__c>();
        try{
            if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) { 
                listOfStrategicAccountPlan = [select Id,Account__c,Ehr_Vendor__c,Primary_Location_HQ__c,
                Key_Geographies__c,Parent_Account_lookup__c from Strategic_Account_Plan__c where Account__c In:triggerRecordsList];
                return listOfStrategicAccountPlan;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
    /**
    * @Description : This method retrevies the existing Competitive Landscape record from custom object StrategicAccountPlan
    * @param       : List of triggered account for which Competitive Landscape to retrieved    
    * @return      : List of Competitive Landscape records    
    **/
    public list<Competitive_Landscape__c> retrieveListOfCompetitiveLandscape(List<Account> triggerRecordsList){
        List<Competitive_Landscape__c> listOfCompetitiveLandscape= new List<Competitive_Landscape__c>();
        try{
            if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) { 
                listOfCompetitiveLandscape= [select Id,AccountId_lookup__c,IHN_lookup__c,Consultants_Clinical__c,Consultants_IT__c,Contracting_Vendor__c,EHR_Supplier_lookup__c from Competitive_Landscape__c where AccountId_lookup__c In : triggerRecordsList];
                return listOfCompetitiveLandscape;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }
     
    /** 
    * @Description : This method insert the PeopleAndRelationship list    
    * @param       : list of PeopleAndRelationship to be inserted    
    * @return      : Null    
    **/
    public void  insertPeopleAndRelationship(list<People_and_Relationship__c> createPeopleAndRelationshipList) {
        try{
            if((createPeopleAndRelationshipList != null) && !(createPeopleAndRelationshipList.isempty())) { 
                Database.insert (createPeopleAndRelationshipList,False); 
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }    
    }
    
    /**  
    * @Description : This method insert the HospitalLocation list    
    * @param       : list of HospitalLocation to be inserted    
    * @return      : Null    
    **/
    public void  insertHospitalLocation(list<Hospital_Locations__c> createHospitalLocationList) {
        try{
            if((createHospitalLocationList != null) && !(createHospitalLocationList.isempty())) { 
                Database.insert(createHospitalLocationList,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }                
    }
    
    /**
    * @Description : This method insert the Asset list    
    * @param       : list of Asset to be inserted    
    * @return      : Null    
    **/
    public void  insertAssets(list<Asset__c> createAssetsList) {
        try{
            if((createAssetsList != null) && !(createAssetsList.isempty())) {         
                Database.insert (createAssetsList,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }            
    }
    
    /** 
    * @Description : This method insert the TopOpportunities list    
    * @param       : list of TopOpportunities to be inserted    
    * @return      : Null    
    **/
    public void  insertTopOpportunities(list<Top_Opportunities__c> createTopOpportunitiesList) {
        try{
            if((createTopOpportunitiesList != null) && !(createTopOpportunitiesList.isempty())) {         
                Database.insert (createTopOpportunitiesList,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }    
    }
    
    /**
    * @Description : This method insert the AccountTeam list    
    * @param       : list of AccountTeam to be inserted    
    * @return      : Null    
    **/
    public void  insertAccountTeam(list<Account_Team__c> createAccountTeamList) {
        try{
            if((createAccountTeamList != null) &&  !(createAccountTeamList.isempty())) {         
                Database.insert (createAccountTeamList,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }    
    }

   
    /** 
    * @Description : This method update the HospitalLocations    
    * @param       : list of HospitalLocations to be updated    
    * @return      : Null    
    **/
    public void  updateHospitalLocations(list<Hospital_Locations__c> listOfHospitalLocations) {
        try{
            if((listOfHospitalLocations != null) && !(listOfHospitalLocations.isempty())) {         
                Database.Update (listOfHospitalLocations,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }            
    }
 
    /**  
    * @Description : This method update the StrategicAccountPlan    
    * @param       : list of StrategicAccountPlan to be updated    
    * @return      : Null    
    **/
    public void  updateStrategicAccountPlan(list<Strategic_Account_Plan__c> listOfStrategicAccountPlan) {
        try{
            if((listOfStrategicAccountPlan != null) && !(listOfStrategicAccountPlan.isempty())) {         
                Database.Update (listOfStrategicAccountPlan,false);
            }
        }    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }            
    }
    
    /**  
    * @Description : This method update the CompetitiveLandscape    
    * @param       : list of CompetitiveLandscape to be updated    
    * @return      : Null    
    **/
    public void  updateCompetitiveLandscape(list<Competitive_Landscape__c> listOfCompetitiveLandscape) {
        try{
            if((listOfCompetitiveLandscape != null) && !(listOfCompetitiveLandscape.isempty())) {         
                Database.Update (listOfCompetitiveLandscape,false);
            }
        }    
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }            
    }
    
    /** 
    * @Description : This method retrieves the record to be deleted on contract detail    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Contract detail records to be deleted.
    **/
    public List<Contract_Detail__c> retrieveListOfContractDetailRecordsToDelete(Set<Id> setOfToBeDeletedIds,Set<Id> setOfAccountToBeDeletedIds){
        List<Contract_Detail__c> listOfContractDetailRecordsToDelete = new List<Contract_Detail__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty()) && (setOfAccountToBeDeletedIds != null) && !(setOfAccountToBeDeletedIds.isempty()) ) {         
                listOfContractDetailRecordsToDelete=[select Id from Contract_Detail__c where Contract_Id__c In: setOfToBeDeletedIds AND AccountId_lookup__c In : setOfAccountToBeDeletedIds];
                return listOfContractDetailRecordsToDelete;
            }
            else{
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }    
    }
    
    /**
    * @Description : This method delete the Contract Detail Records    
    * @param       : list of Contract Detail Records to be deleted    
    * @return      : Null    
    **/
    public void listOfContractDetailRecordsToDelete(List<Contract_Detail__c> listOfContractDetailRecordsToDelete){
        try{
            if((listOfContractDetailRecordsToDelete != null) && !(listOfContractDetailRecordsToDelete.isempty())) {         
                Database.delete (listOfContractDetailRecordsToDelete,false);    
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }    
    }
    
    /**   
    * @Description : This method retrieves the record to be deleted on people and relationship    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of people and relationship records to be deleted.
    **/
    public List<People_and_Relationship__c> retrieveListOfPeopleAndRelationshipRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<People_and_Relationship__c> listOfPeopleAndRelationshipRecordsToDelete = new List<People_and_Relationship__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfPeopleAndRelationshipRecordsToDelete =[select Id from People_and_Relationship__c where Contact_Id__c In: setOfToBeDeletedIds];
                return listOfPeopleAndRelationshipRecordsToDelete ;    
            }
            else {
                return null;
            }    
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }    
    }
    
    /**   
    * @Description : This method retrieves the record to be deleted on Hospital Locations    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Hospital Locations records to be deleted.
    **/
    public List<Hospital_Locations__c> retrieveListOfHospitalLocationsRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Hospital_Locations__c> listOfHospitalLocationsRecordsToDelete = new List<Hospital_Locations__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfHospitalLocationsRecordsToDelete =[select Id from Hospital_Locations__c where Account_Id__c In: setOfToBeDeletedIds];
                return listOfHospitalLocationsRecordsToDelete ;
            }
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }            
    }
    
    /**
    * @Description : This method delete the People and relationship Records    
    * @param       : list of People and relationship Records to be deleted    
    * @return      : Null    
    **/
    public void listOfPeopleAndRelationshipRecordsToDelete (List<People_and_Relationship__c> listOfPeopleAndRelationshipRecordsToDelete ){
        try{
            if((listOfPeopleAndRelationshipRecordsToDelete != null) && !(listOfPeopleAndRelationshipRecordsToDelete.isempty())) {         
                Database.delete (listOfPeopleAndRelationshipRecordsToDelete,false);
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        } 
    }
    
    /**
    * @Description : This method delete the hospital locations Records    
    * @param       : list of hospital locations Records to be deleted    
    * @return      : Null    
    **/
    public void listOfHospitalLocationsRecordsToDelete(List<Hospital_Locations__c> listOfHospitalLocationsRecordsToDelete){
        try{
            if((listOfHospitalLocationsRecordsToDelete != null) && !(listOfHospitalLocationsRecordsToDelete.isempty())) {         
                Database.delete (listOfHospitalLocationsRecordsToDelete,false);    
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    
    /**  
    * @Description : This method retrieves the record to be deleted on Top Opportunities    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Top Opportunities records to be deleted.
    **/
    public List<Top_Opportunities__c> retrieveListOfTopOpportunitiesRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToDelete = new List<Top_Opportunities__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfTopOpportunitiesRecordsToDelete=[select Id from Top_Opportunities__c where Opportunity_Id__c In: setOfToBeDeletedIds];
                return listOfTopOpportunitiesRecordsToDelete; 
            }            
            else {
                return null;
            }   
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }     
    }
    
    /**
    * @Description : This method delete the Top Opportunities Records    
    * @param       : list of Top Opportunities Records to be deleted    
    * @return      : Null    
    **/
    public void listOfTopOpportunitiesRecordsToDelete(List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToDelete){
        try{
            if((listOfTopOpportunitiesRecordsToDelete != null) && !(listOfTopOpportunitiesRecordsToDelete.isempty())) {         
                Database.delete (listOfTopOpportunitiesRecordsToDelete,false);  
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    
    /**  
    * @Description : This method retrieves the record to be deleted on Asset    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Asset records to be deleted.
    **/
    public List<Asset__c> retrieveListOfAssetRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Asset__c> listOfAssetRecordsToDelete = new List<Asset__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfAssetRecordsToDelete=[select Id from Asset__c where Asset_Id__c In: setOfToBeDeletedIds];
                return listOfAssetRecordsToDelete;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }     
    }
    
    /** 
    * @Description : This method delete the Asset Records    
    * @param       : list of Asset Records to be deleted    
    * @return      : Null    
    **/
    public void listOfAssetRecordsToDelete(List<Asset__c> listOfAssetRecordsToDelete){
        try{
            if((listOfAssetRecordsToDelete != null) && !(listOfAssetRecordsToDelete.isempty())) {         
                Database.delete (listOfAssetRecordsToDelete,false);    
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    /**  
    * @Description : This method retrieves the record to be deleted on Key Transformational Win    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Key Transformational Win records to be deleted.
    **/
    public List<Key_Transformational_Win__c> retrieveListOfKeyTransformationalWinRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToDelete = new List<Key_Transformational_Win__c>();
        try{
            if((setOfToBeDeletedIds != null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfKeyTransformationalWinRecordsToDelete=[select Id from Key_Transformational_Win__c where Opportunity_Id__c In: setOfToBeDeletedIds];
                return listOfKeyTransformationalWinRecordsToDelete;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }     
    }
    
    /** 
    * @Description : This method delete the Key Transformational Win Records    
    * @param       : list of Key Transformational Win Records to be deleted    
    * @return      : Null    
    **/
    public void listOfKeyTransformationalWinRecordsToDelete(List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToDelete){
        try{
            if((listOfKeyTransformationalWinRecordsToDelete != null) && !(listOfKeyTransformationalWinRecordsToDelete.isempty())) {         
                Database.delete (listOfKeyTransformationalWinRecordsToDelete,false);
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    
    /**
    * @Description : This method retrieves the record to be deleted on Key Transformational Loss    
    * @param       : set of Account Ids to be deleted    
    * @return      : list of Key Transformational Loss records to be deleted.
    **/
    public List<Key_Transformational_Loss__c> retrieveListOfKeyTransformationalLossRecordsToDelete(Set<Id> setOfToBeDeletedIds){
        List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToDelete = new List<Key_Transformational_Loss__c>();
        try{
            if((setOfToBeDeletedIds!= null) && !(setOfToBeDeletedIds.isempty())) {         
                listOfKeyTransformationalLossRecordsToDelete=[select Id from Key_Transformational_Loss__c where Opportunity_Id__c In: setOfToBeDeletedIds];
                return listOfKeyTransformationalLossRecordsToDelete;
            }            
            else {
                return null;
            }    
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }     
    }
    
    /**   
    * @Description : This method delete the Key Transformational Loss Records    
    * @param       : list of Key Transformational Loss Records to be deleted    
    * @return      : Null    
    **/
    public void listOfKeyTransformationalLossRecordsToDelete(List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToDelete){
        try{
            if((listOfKeyTransformationalLossRecordsToDelete != null) && !(listOfKeyTransformationalLossRecordsToDelete.isempty())) {         
                Database.delete (listOfKeyTransformationalLossRecordsToDelete,false);    
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    
    /**   
    * @Description : This method delete the CompetitiveLandscape   
    * @param       : list of CompetitiveLandscape to be deleted    
    * @return      : Null    
    **/
    public void toBeDeletedOnCompetitiveLandscape(List<Competitive_Landscape__c> triggerRecordsList){
        try{
            if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {         
                Strategic_Account_Plan__c strategicAccountplanToUpdate= new Strategic_Account_Plan__c(Id = triggerRecordsList[0].Strategic_Account_Plan__c);
                strategicAccountplanToUpdate.Competitive_Landscape__c = '';
                Database.update (strategicAccountplanToUpdate,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }              
    }
  
    /** 
    * @Description : This method delete the FinancialObjPerformanceMgmtProfit   
    * @param       : list of FinancialObjPerformanceMgmtProfit to be deleted    
    * @return      : Null    
    **/
    public void toBeDeletedOnFinancialObjPerformanceMgmtProfit(List<Financial_Obj_Performance_Mgmt_Profit__c> triggerRecordsList){
        try{
            if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {         
                Strategic_Account_Plan__c strategicAccountplanToUpdate= new Strategic_Account_Plan__c(Id = triggerRecordsList[0].Strategic_Account_Plan__c);
                strategicAccountplanToUpdate.Financial_Objectives_Performance_Profi__c = '';
                Database.update (strategicAccountplanToUpdate,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }          
    }
    
    /** 
    * @Description : This method update the CompetitiveLandscape   
    * @param       : list of Account for which CompetitiveLandscape to be update    
    * @return      : Null    
    **/
    public void toBeUpdatedOnCompetitiveLandscape(list<Account> accountToUpdateList) {
        try{
            if((accountToUpdateList != null) && !(accountToUpdateList.isempty())) {         
                Database.update (accountToUpdateList,false);
            }
        }
        catch(DMLException exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }              
    }    
  
   /**
    * @Description : This method retrevies the Key Transformational Win opportunity record 
    * @param       : List of Account from which associated Key Transformational Win opportunity record  to be retrieved    
    * @return      : List of Key Transformational Win opportunity records    
    **/
   public list<Opportunity> retrieveAllRelatedWinOpportunities(list<Account> finalSetOFAccountsList) {
        list<Opportunity> retrieveAllRelatedWinOpportunitiesList = New  list<Opportunity>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) {         
                retrieveAllRelatedWinOpportunitiesList = [select Id,Name,OwnerId,StageName,Amount,NextStep,AccountID from opportunity where Must_Win_flag__c = true and AccountId In:finalSetOFAccountsList and (StageName='Order Booked' OR StageName='Order Promised')];            
                return retrieveAllRelatedWinOpportunitiesList;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    }  
    
    /**
    * @Description : This method retrevies the Key Transformational Loss opportunity record 
    * @param       : List of Account from which associated Key Transformational Loss opportunity record to be retrieved    
    * @return      : List of Key Transformational Win opportunity records    
    **/
    public list<Opportunity> retrieveAllRelatedLossOpportunities(list<Account> finalSetOFAccountsList) {
        list<Opportunity> retrieveAllRelatedLossOpportunitiesList = New  list<Opportunity>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) {         
                retrieveAllRelatedLossOpportunitiesList = [select Id,Name,OwnerId,StageName,Amount,NextStep,AccountID from opportunity where Must_Win_flag__c = true and AccountId In:finalSetOFAccountsList and (StageName='Lost')];
                return retrieveAllRelatedLossOpportunitiesList;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }        
    } 
    
    /**
    * @Description : This method insert the KeyTransformationalWin    
    * @param       : list of KeyTransformationalWin to be inserted    
    * @return      : Null    
    **/
    public void  insertKeyTransformationalWin(list<Key_Transformational_Win__c> createKeyTransformationalWinList) {
        try{
            if((createKeyTransformationalWinList != null) && !(createKeyTransformationalWinList.isempty())) {         
                Database.insert (createKeyTransformationalWinList,false);       
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }
    
    /**   
    * @Description : This method insert the KeyTransformationalLoss    
    * @param       : list of KeyTransformationalLoss to be inserted    
    * @return      : Null    
    **/
    public void  insertKeyTransformationalLoss(list<Key_Transformational_Loss__c> createKeyTransformationalLossList) {
        try{
            if((createKeyTransformationalLossList != null) && !(createKeyTransformationalLossList.isempty())) {                 
                Database.insert (createKeyTransformationalLossList,false);  
            }     
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        }     
    }

    /** 
    * @Description : This method retrevies the Contract record 
    * @param       : List of Account from which associated Contract record to be retrieved    
    * @return      : List of Contract records    
    **/
    public list<Contract_Account_Link__c> retrieveAllRelatedContractFromContractAccountLink(list<Account> finalSetOFAccountsList) {
        list<Contract_Account_Link__c> retrieveAllRelatedContractList = New  list<Contract_Account_Link__c>();
        try{
            if((finalSetOFAccountsList != null) && !(finalSetOFAccountsList.isempty())) {                 
                retrieveAllRelatedContractList = [select Id,Account_Name__c,Contract_Name__c from Contract_Account_Link__c where Account_Name__c In:finalSetOFAccountsList];     
                return retrieveAllRelatedContractList;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }
    } 
    
    /**  
    * @Description : This method insert the ContractDetail    
    * @param       : list of ContractDetail to be inserted    
    * @return      : Null    
    **/
    public void  insertContractDetail(list<Contract_Detail__c> createContractDetailList) {
        try{
            if((createContractDetailList != null) && !(createContractDetailList.isempty())) {                 
                Database.insert (createContractDetailList,false);
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
        } 
    }

    /**   
    * @Description : This method retrevies the ParentAccounts record 
    * @param       : set of AccountID from which associated ParentAccounts record to be retrieved    
    * @return      : List of ParentAccounts records    
    **/
    public List<Account> retrieveParentAccounts(set<Id> accountIdSet) {
        List<Account> parentAccountsList = new List<Account>();
        try{
            if((accountIdSet != null) && !(accountIdSet.isempty())) {                 
                parentAccountsList = [select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: accountIdSet];
                return parentAccountsList;
            }            
            else {
                return null;
            }
        }
        catch(Exception exceptionMessage) {
            system.debug(exceptionMessage.getmessage());
            return null;
        }             
    }
        
        /** 
        * @Description : This method retrevies the ParentIds record 
        * @param       : set of ParentAccountID from which associated map ParentAccounts to be retrieved    
        * @return      : map of ParentAccount    
        **/
        public Map<Id,Account> retrieveParentIds(Set<Id> setOfParentAccountsId) {
            try{
                Map<Id, Account> mapOfParentAccounts = New Map<Id, Account>([select id, Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c, Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__r.Parent_IDN_of_Associated_IDN__c from Account where Id In: setOfParentAccountsId]);                
                return  mapOfParentAccounts;                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }                 
        }
        
        /**   
        * @Description : This method retrevies the List Of Strategic Account Plan
        * @param       : set of Consolidated AccountId from which List Of Strategic Account Plan to be retrieved    
        * @return      : List Of Strategic Account Plan   
        **/
        public List<Strategic_Account_Plan__c> getListOfStrategicAccountPlan(Set<Id> setOfConsolidatedAccountIds) {
            List<Strategic_AccounT_Plan__c> listOfStrategicAccountPlan =new List<Strategic_Account_Plan__c>();
           try {
               if((setOfConsolidatedAccountIds != null) && !(setOfConsolidatedAccountIds.isempty())) {                 
                   listOfStrategicAccountPlan=[select Id, name, Account__c from Strategic_Account_Plan__c where Account__c In: setOfConsolidatedAccountIds];
                   return listOfStrategicAccountPlan;
               }               
               else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**
        * @Description : This method retrevies the List Of Contact record
        * @param       : List of Contact triggered for which Contact details to be retrieved    
        * @return      : List Of Contact record  
        **/
        public List<Contact> retrieveContactList(List<Contact> triggerRecordsList) {
            List<Contact> contactList =new List<Contact>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    contactList=[select Id, name, Department_Category__c,Primary_Contact__c,title,Role_of_Influence__c, Level_of_Influence__c, Advocacy__c , AccountId from Contact where Id In: triggerRecordsList];
                    return contactList;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }                 
        }
        
        /**    
        * @Description : This method insert the List Of PeopleAndrelationship record
        * @param       : List of PeopleAndrelationship to be inserted    
        * @return      : null  
        **/
        public void insertPeopleAndrelationshipRecords(List<People_and_Relationship__c> listOfPeopleAndRelationShipRecordsToInsert) {
            try{
                if((listOfPeopleAndRelationShipRecordsToInsert != null) && !(listOfPeopleAndRelationShipRecordsToInsert.isempty())) {                 
                    Database.insert (listOfPeopleAndRelationShipRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            }                 
        }               
    
        /**  
        * @Description : This method retrevies the List Of Top Opportunity(must win is checked) record from opportunity
        * @param       : List of Opportunity triggered for which Top Opportunity details to be retrieved    
        * @return      : List Of Opportunity record  
        **/
        public List<Opportunity> retrieveOpportunityList(List<Opportunity> triggerRecordsList) {
            List<Opportunity> opportunityList =new List<Opportunity>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    opportunityList =[select Id, name,Owner.name,Order_Status__c,StageName,Amount,NextStep,AccountID from Opportunity where Id In: triggerRecordsList and Must_Win_flag__c=true];
                    return opportunityList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**
        * @Description : This method insert the List Of TopOpportunities record
        * @param       : List of TopOpportunities to be inserted    
        * @return      : null  
        **/
        public void insertTopOpportunitiesRecords(List<Top_Opportunities__c> listOfTopOpportunitiesRecordsToInsert) {
            try{
                if((listOfTopOpportunitiesRecordsToInsert!= null) && !(listOfTopOpportunitiesRecordsToInsert.isempty())) {                 
                    Database.insert (listOfTopOpportunitiesRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            }             
        }
    
        /** 
        * @Description : This method retrevies the List Of Asset record
        * @param       : List of Asset triggered for which Asset details to be retrieved    
        * @return      : List Of Asset record  
        **/
        public List<Asset> retrieveAssetList(List<Asset> triggerRecordsList) {
            List<Asset> assetList =new List<Asset>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    assetList =[select Id,Name,UsageEndDate,Modality_lookup_product__c,Lease_Expiration_Date__c,Booking_Date__c,Vendor_on_product__c,Product__c,Ship_to_Account_City__c,Ship_to_Account_State__c,AccountID from Asset where Id In: triggerRecordsList];
                    return assetList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**   
        * @Description : This method insert the List Of Asset record
        * @param       : List of Asset to be inserted    
        * @return      : null  
        **/
        public void insertAssetsRecords(List<Asset__c> listOfAssetsRecordsToInsert) {
            try{
                if((listOfAssetsRecordsToInsert != null) && !(listOfAssetsRecordsToInsert.isempty())) {                 
                    Database.insert (listOfAssetsRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            }             
        }
         
        /**
        * @Description : This method retrevies the List Of Account for hospital loaction
        * @param       : List of Account triggered for which Account details for hopital location to be retrieved    
        * @return      : List Of Account record for hospital location  
        **/
         public List<Account> retrieveAccountList(List<Account> triggerRecordsList) {
            List<Account> accountList =new List<Account>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    accountList =[select Id, name, Street1_Local__c, City_Local__c,Region__c,Region__r.name, Zip_Postal_Code_Local__c, Facility_Type__c from Account where Id In: triggerRecordsList];
                    return accountList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**   
        * @Description : This method insert the List Of HospitalLocations record
        * @param       : List of HospitalLocations to be inserted    
        * @return      : null  
        **/
        public void insertHospitalLocationsRecords(List<Hospital_Locations__c> listOfHospitalLocationsRecordsToInsert) {
            try{
                if((listOfHospitalLocationsRecordsToInsert != null) && !(listOfHospitalLocationsRecordsToInsert.isempty())) {                 
                    Database.insert (listOfHospitalLocationsRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            }             
        }
        
        /**   
        * @Description : This method get the List Of CompetitiveLandscape 
        * @param       : List of Strategic Account Plan for which associated CompetitiveLandscape to be retrieved    
        * @return      : List Of CompetitiveLandscape  
        **/
        public List<Competitive_Landscape__c> getListOfCompetitiveLandscape(Set<Id> setOfConsolidatedAccountIds) {
            List<Competitive_Landscape__c> listOfCompetitiveLandscape =new List<Competitive_Landscape__c>();
            try{
                if((setOfConsolidatedAccountIds != null) && !(setOfConsolidatedAccountIds.isempty())) {                 
                    listOfCompetitiveLandscape=[select Id,AccountId_lookup__c,name from Competitive_Landscape__c where AccountId_lookup__c In : setOfConsolidatedAccountIds];
                    return listOfCompetitiveLandscape;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
         /**   
        * @Description : This method retrevies the List Of Opportunity for Key transformational Win(StageName='Order Booked' OR StageName='Order Promised' and must win is checked) 
        * @param       : List of Opportunity triggered for which Key transformational Win Opportunity to be retrieved    
        * @return      : List Of Opportunity for Key transformational Win
        **/
        public List<Opportunity> retrieveWinOpportunityList(List<Opportunity> triggerRecordsList) {
            List<Opportunity> opportunityList =new List<Opportunity>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    opportunityList =[select Id,Name,OwnerId,StageName,Amount,NextStep,AccountID from Opportunity where Id IN : triggerRecordsList and Must_Win_flag__c=true and (StageName='Order Booked' OR StageName='Order Promised')];
                    return opportunityList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**
        * @Description : This method insert the List Of Key Transformational Win opportunity record
        * @param       : List of Key Transformational Win to be inserted    
        * @return      : null  
        **/
        public void insertKeyTransformationalWinRecords(List<Key_Transformational_Win__c> listOfKeyTransformationalWinRecordsToInsert) {
            try{
                if((listOfKeyTransformationalWinRecordsToInsert != null) && !(listOfKeyTransformationalWinRecordsToInsert.isempty())) {                 
                    Database.insert (listOfKeyTransformationalWinRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());                
            }             
        }        
        
        /**  
        * @Description : This method retrevies the List Of Opportunity for Key transformational Loss(StageName='Lost' and must win is checked) 
        * @param       : List of Opportunity triggered for which Key transformational Loss Opportunity to be retrieved    
        * @return      : List Of Opportunity for Key transformational Loss
        **/
        public List<Opportunity> retrieveLossOpportunityList(List<Opportunity> triggerRecordsList) {
            List<Opportunity> opportunityList =new List<Opportunity>();
            try{
                if((triggerRecordsList != null) && !(triggerRecordsList.isempty())) {                 
                    opportunityList =[select Id,Name,OwnerId,StageName,Amount,NextStep,AccountID from Opportunity where Id IN : triggerRecordsList and Must_Win_flag__c=true and StageName='Lost'];
                    return opportunityList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        
        /**
        * @Description : This method insert the List Of Key Transformational Loss opportunity record
        * @param       : List of Key Transformational Loss to be inserted    
        * @return      : null  
        **/
        public void insertKeyTransformationalLossRecords(List<Key_Transformational_Loss__c> listOfKeyTransformationalLossRecordsToInsert) {
            try{
                if((listOfKeyTransformationalLossRecordsToInsert != null) && !(listOfKeyTransformationalLossRecordsToInsert.isempty())) {                 
                    Database.insert (listOfKeyTransformationalLossRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            } 
        }
        
        /**
        * @Description : This method update the Strategic Account Plan record
        * @param       : Record of Strategic Account Plan to be updated   
        * @return      : null  
        **/
        public void updateStrategicAccountPlanRecord(List<Strategic_Account_Plan__c> strategicAccountPlanRecord) {
            try{
                if((strategicAccountPlanRecord != null) && !(strategicAccountPlanRecord.isEmpty())) {                 
                    Database.update (strategicAccountPlanRecord,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
            }
        }           
     
        /**
        * @Description : This method retrevies the List Of Contract 
        * @param       : List of Contract triggered for which Contract details to be retrieved    
        * @return      : List Of Contract 
        **/
        public List<Contract> retrieveContractListForAccountLink(Set<Id> contractIds) {
            List<Contract> contractList =new List<Contract>();
            try{
                if((contractIds != null) && !(contractIds.isempty())) {                 
                    contractList =[select Id,ContractNumber,Contract_Type__c,Sales_Deal_Number__c,Purchasing_Ts_Cs__c,Purchasing_Compliance_Picklist__c,Master_Service__c,StartDate,EndDate,AccountId  from Contract where Id in: contractIds];
                    return contractList ;
                }                
                else {
                    return null;
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;
            }             
        }
        /**
        * @Description : This method insert the List Of Contract Detail record
        * @param       : List of ContractDetail to be inserted    
        * @return      : null  
        **/
        public void insertContractDetailRecords(List<Contract_Detail__c> listOfContractDetailRecordsToInsert) {
            try{
                if((listOfContractDetailRecordsToInsert != null) && !(listOfContractDetailRecordsToInsert.isempty())) {                                       
                    Database.insert (listOfContractDetailRecordsToInsert,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());          
            }             
        }

        /**
        * @Description : This method is update the Key Geography field on the SAP.
        * @param       : List of strategic account plan record.
        * @return      : void
        **/
        public void strategicAccountPlansToUpdate(List<Strategic_Account_Plan__c> listOFStrategicAccountPlansToUpdate){
            try{
                if((listOFStrategicAccountPlansToUpdate != null) && !(listOFStrategicAccountPlansToUpdate.isempty())) {                           
                    Database.Update (listOFStrategicAccountPlansToUpdate,false);
                }    
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }
        }
        
        /**
        * @Description : This method retrieve list of people and relationship record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of people and relationship.
        **/ 
        public List<People_And_Relationship__c> retrieveRelatedPeopleAndRelations(Set<Id> setOfStrategicAccountPlanId){
            List<People_and_Relationship__c> peopleAndRelationshipToDeleteList = new List<People_And_Relationship__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {               
                    peopleAndRelationshipToDeleteList =[Select Id from People_and_relationship__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return peopleAndRelationshipToDeleteList;
                }                    
                else {
                    return null;
                }            
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of PeopleAndRelations records.
        * @param       : list of PeopleAndRelations records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedPeopleAndRelations(List<People_And_Relationship__c> retrieveRelatedPeopleAndRelationsList){
            try{
                if((retrieveRelatedPeopleAndRelationsList != null) && !(retrieveRelatedPeopleAndRelationsList.isempty())) {                         
                    Database.Delete (retrieveRelatedPeopleAndRelationsList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of HospitalLocations record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of HospitalLocations.
        **/ 
        public List<Hospital_Locations__c> retrieveRelatedHospitalLocations(Set<Id> setOfStrategicAccountPlanId){
            List<Hospital_Locations__c> hospitalLocationsToDeleteList = new List<Hospital_Locations__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {             
                    hospitalLocationsToDeleteList =[Select Id from Hospital_Locations__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return hospitalLocationsToDeleteList;
                }                    
                else {
                    return null;
                }            
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        
        /**
        * @Description : This method delete list of Hospital Locations records.
        * @param       : list of Hospital Locations records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedHospitalLocations(List<Hospital_Locations__c> retrieveRelatedHospitalLocationsList){
            try{
                if((retrieveRelatedHospitalLocationsList != null) && !(retrieveRelatedHospitalLocationsList.isempty())) {                          
                    Database.Delete (retrieveRelatedHospitalLocationsList,false);
                }    
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of ContractDetails record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of ContractDetails.
        **/
        public List<Contract_Detail__c> retrieveRelatedContractDetails(Set<Id> setOfStrategicAccountPlanId){
            List<Contract_Detail__c> contractDetailsToDeleteList = new List<Contract_Detail__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {              
                    contractDetailsToDeleteList =[Select Id from Contract_Detail__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return contractDetailsToDeleteList; 
                }                    
                else {
                    return null;
                }           
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of ContractDetails records.
        * @param       : list of ContractDetails records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedContractDetails(List<Contract_Detail__c> retrieveRelatedContractDetailsList){
            try{
                if((retrieveRelatedContractDetailsList != null) && !(retrieveRelatedContractDetailsList.isempty())) {              
                Database.Delete (retrieveRelatedContractDetailsList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }
        
        }
        
        /**
        * @Description : This method retrieve list of TopOpportunities record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of TopOpportunities.
        **/
        public List<Top_opportunities__c> retrieveRelatedTopOpportunities(Set<Id> setOfStrategicAccountPlanId){
            List<Top_opportunities__c> topOpportunitiesToDeleteList = new List<Top_opportunities__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {                                                                                                                            
                    topOpportunitiesToDeleteList =[Select Id from Top_opportunities__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return topOpportunitiesToDeleteList; 
                }                   
                else {
                    return null;
                }           
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of TopOpportunities records.
        * @param       : list of TopOpportunities records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedTopOpportunities(List<Top_opportunities__c> retrieveRelatedTopOpportunitiesList){
            try{
                if((retrieveRelatedTopOpportunitiesList != null) && !(retrieveRelatedTopOpportunitiesList.isempty())) {                                                                                                                
                    Database.Delete (retrieveRelatedTopOpportunitiesList,false);
                }
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of Assets record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of Assets.
        **/
        public List<Asset__c> retrieveRelatedAssets(Set<Id> setOfStrategicAccountPlanId){
            List<Asset__c> assetToDeleteList = new List<Asset__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {                                                                                                    
                    assetToDeleteList =[Select Id from Asset__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return assetToDeleteList ;
                }                                
                else {
                    return null;
                }            
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of Assets records.
        * @param       : list of Assets records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedAssets(List<Asset__c> retrieveRelatedAssetsList){
            try{
                if((retrieveRelatedAssetsList != null) && !(retrieveRelatedAssetsList.isempty())) {                                                                                        
                    Database.Delete(retrieveRelatedAssetsList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of AccountTeam record to be deleted.
        * @param       : set of strategic account plan id.
        * @return      : list of AccountTeam.
        **/
        public List<Account_Team__c> retrieveRelatedAccountTeam(Set<Id> setOfStrategicAccountPlanId){
            List<Account_Team__c> accountTeamToDeleteList = new List<Account_Team__c>();           
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {                                                        
                    accountTeamToDeleteList =[Select Id from Account_Team__c where Strategic_Account_Plan__c in:setOfStrategicAccountPlanId];
                    return accountTeamToDeleteList ;
                }                                
                else {
                    return null;
                }            
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of AccountTeam records.
        * @param       : list of AccountTeam records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedAccountTeam(List<Account_Team__c> retrieveRelatedAccountTeamList){
            try{
                if((retrieveRelatedAccountTeamList != null) && !(retrieveRelatedAccountTeamList.isempty())) {                                            
                    Database.Delete (retrieveRelatedAccountTeamList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of Keytransformationalwin record to be deleted.
        * @param       : set of CompetitiveLandscapeId.
        * @return      : list of Keytransformationalwin.
        **/
        public List<Key_transformational_win__c> retrieveRelatedKeyWinOpportunities(Set<Id> setOfCompetitiveLandscapeId){
            List<Key_transformational_win__c> keyWinOpportunitiesToDeleteList = new List<Key_transformational_win__c>();           
            try{
                if((setOfCompetitiveLandscapeId != null) && !(setOfCompetitiveLandscapeId.isempty())) {                                
                    keyWinOpportunitiesToDeleteList =[Select Id from Key_transformational_win__c where Competitive_Landscape__c in:setOfCompetitiveLandscapeId];
                    return keyWinOpportunitiesToDeleteList ; 
                }                                
                else {
                    return null;
                }           
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of Keytransformationalwin records.
        * @param       : list of Keytransformationalwin records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedKeyWinOpportunities(List<Key_transformational_win__c> retrieveRelatedKeyWinOpportunitiesList){
            try{
                if((retrieveRelatedKeyWinOpportunitiesList != null) && !(retrieveRelatedKeyWinOpportunitiesList.isempty())) {                    
                    Database.Delete (retrieveRelatedKeyWinOpportunitiesList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of KeytransformationalLoss record to be deleted.
        * @param       : set of CompetitiveLandscapeId.
        * @return      : list of KeytransformationalLoss.
        **/
        public List<Key_transformational_Loss__c> retrieveRelatedKeyLossOpportunities(Set<Id> setOfCompetitiveLandscapeId){
            List<Key_transformational_Loss__c> keyLossOpportunitiesToDeleteList = new List<Key_transformational_Loss__c>();           
            try{
                if((setOfCompetitiveLandscapeId != null) && !(setOfCompetitiveLandscapeId.isempty())) {                        
                    keyLossOpportunitiesToDeleteList =[Select Id from Key_transformational_Loss__c where Competitive_Landscape__c in:setOfCompetitiveLandscapeId];
                    return keyLossOpportunitiesToDeleteList; 
                }                                
                else {
                    return null;
                }            
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method delete list of KeytransformationalLoss records.
        * @param       : list of KeytransformationalLoss records to be deleted.
        * @return      : void
        **/
        public void deleteRelatedKeyLossOpportunities(List<Key_transformational_Loss__c> retrieveRelatedKeyLossOpportunitiesList){
            try{
                if((retrieveRelatedKeyLossOpportunitiesList != null) && !(retrieveRelatedKeyLossOpportunitiesList.isempty())) {            
                    Database.Delete (retrieveRelatedKeyLossOpportunitiesList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }
        
        /**
        * @Description : This method retrieve list of CompetitiveLandscape record.
        * @param       : set of StrategicAccountPlanId.
        * @return      : list of CompetitiveLandscape.
        **/
        public List<Competitive_Landscape__c> retrieveListOfCompetitiveLandscape(Set<Id> setOfStrategicAccountPlanId){
            List<Competitive_Landscape__c> competitiveLandscapeList = new List<Competitive_Landscape__c>();
            try{
                if((setOfStrategicAccountPlanId != null) && !(setOfStrategicAccountPlanId.isempty())) {            
                    competitiveLandscapeList = [select Id,Strategic_Account_Plan__c from Competitive_Landscape__c where Strategic_Account_plan__c In : setOfStrategicAccountPlanId];
                    return competitiveLandscapeList ; 
                }                                
                else {
                    return null;
                }           
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());
                return null;                
            }
        }
        
        /**
        * @Description : This method update list of CompetitiveLandscape records.
        * @param       : list of CompetitiveLandscape records to be update.
        * @return      : void
        **/
        public void updateAccountOnCompetitiveLandscape(List<Competitive_Landscape__c> competitiveLandscapeToUpdateList){
            try{
                if((competitiveLandscapeToUpdateList!= null) && !(competitiveLandscapeToUpdateList.isempty())) {            
                    Database.Update (competitiveLandscapeToUpdateList,false);
                }                
            }
            catch(Exception exceptionMessage) {
                system.debug(exceptionMessage.getmessage());               
            }        
        }                
}