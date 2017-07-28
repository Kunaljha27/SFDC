/**
@Classname :       M2O_BatchUpdateAccountMarketAttribute
@Description :     It retrieves the account id and Market sector attribute field values from the Account object and then 
                   inserts a Account market-sector attribute and updates the field Market sector attribute on Account
                   object. This class is scheduled by M2O_SchedulerUpdateAccMarketAttribute.
@Author:           Piyali Saha
@Last Modified:    26/11/2013
**/
global class M2O_BatchUpdateAccountMarketAttribute implements Database.Batchable<sObject> {

   M2O_AccountContactMarketAttributeService instanceAccountContact = new M2O_AccountContactMarketAttributeService();
   
   public User userId; 
   Set<id> setAccountRecordTypeID = new Set<id>();
   
   global Database.QueryLocator start(Database.BatchableContext BC){
   
       setAccountRecordTypeID .add(label.Account_Prospect_Record_Type_Id);
       setAccountRecordTypeID .add(label.Account_Customer_Record_Type_ID);
       setAccountRecordTypeID .add(label.Account_Influencer_Record_Type_Id);
       /*return Database.getQueryLocator([SELECT id, Market_Sector_Attributes__c, ownerId FROM Account WHERE recordtypeID 
                                        in: setAccountRecordTypeID AND ownerId in:[SELECT id, profileID FROM User 
                                        WHERE profileID in: [SELECT id, name FROM Profile WHERE name like '%M2O%' and name !='M2O System Administrator']]]);
      */
            
    
            
      return Database.getQueryLocator([SELECT Name,id, Market_Sector_Attributes__c, ownerId, Hospital_Level__c, Hospital_Grade__c, Strategic_Top_40__c, Previous_Strategic_Account__c,
                                            Current_Strategic_Account__c, Speciality__c, LL_Business_Segment__c,
                                            LL_Program_Code__c, LL_Inactive_Flag__c, LL_Parent_Code__c,
                                            LL_Parent_Business_Offering__c, LL_Program_Business_Offering__c,
                                            RCS_Account_Number__c, RCS_Inactive_Flag__c, MedAxiom_Member__c,
                                            Hospital_System__c, PTS_Program_Code__c, PTS_Inactive_Flag__c, 
                                            SHR_Of_OSA_Patients_2_Night_Study__c, SHR_Of_OSA_Patients_Split_Night_Study__c,
                                            NABH_Accredited__c, JCI_Accredited__c FROM Account WHERE country__c LIKE '%United States%' AND Market_Sector_Attributes__c = null AND recordtypeID 
                                        in: setAccountRecordTypeID AND ownerId in:[SELECT id, profileID FROM User 
                                        WHERE profileID in: [SELECT id, name FROM Profile WHERE name like '%M2O%' and name !='M2O System Administrator']]]);

   } 
    /**
    @Description: This method is used to process the data. It creates a Account market-sector attribute and updates the 
                  field Market sector attribute on Account object. It call the method createAccountMarketSectorAttribute() in 
                  class M2O_AccountContactMarketAttributeService to perform the operation.
    @return: Null
    **/   
   global void execute(Database.BatchableContext BC, List<sObject> scope){
   system.debug('@@@@@@VALUE OF SCOPE  '+scope);  
       List<Account> listAccount= new list<Account>();
       listAccount = scope;
   system.debug('@@@@@@Value OF ACCOUNT LIST ' + listAccount); 
       instanceAccountContact.createAccountMarketSectorAttributeForBatch(listAccount);
   }
   global void finish(Database.BatchableContext BC){   
   }
}