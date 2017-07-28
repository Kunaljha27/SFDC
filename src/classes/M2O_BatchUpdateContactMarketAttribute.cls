/**
@Classname :       M2O_BatchUpdateContactMarketAttribute
@Description :     It retrieves the contact id and Market sector attribute field values from the Contact object and then 
                   inserts a Contact market-sector attribute and updates the field Market sector attribute on Contact
                   object. This class is scheduled by M2O_SchedulerUpdateContctMarketAttribute.
@Author:           Piyali Saha
@Last Modified:    26/11/2013
**/
global class M2O_BatchUpdateContactMarketAttribute implements Database.Batchable<sObject> {
  
   public String query;
   /**@Description: This method is used to fetch the contact records created by m2o user. 
      @return: list of contact
    **/     
   global Database.QueryLocator start(Database.BatchableContext BC){
   
       return Database.getQueryLocator([SELECT Salutation,FirstName,LastName,id, Market_Sector_Attribute__c,ownerId, SHR_Predominantly_Scripts__c FROM Contact 
                                        WHERE Market_Sector_Attribute__c = null AND recordtypeID = :label.Contact_M2O_Record_Type_ID AND OwnerId in:[SELECT id, profileID FROM User 
                                        WHERE profileID in:[SELECT id, name FROM Profile 
                                        WHERE name like '%M2O%' and name !='M2O System Administrator']]]);
   }
   /**
    @Description: This method is used to process the data. It creates a Contact market-sector attribute. It calls the 
                  method createContactMarketSectorAttribute() in class M2O_AccountContactMarketAttribute to perform the operation.
    @return: Null
    **/  
   global void execute(Database.BatchableContext BC, List<sObject> scope){
   
    M2O_AccountContactMarketAttributeService instanceAccountContact= new M2O_AccountContactMarketAttributeService();
       List<Contact> listContact = scope; 
       system.debug('@@@listContact '+listContact );
       instanceAccountContact.createContactMarketSectorAttributeForBatch(listContact);
   }
   
   global void finish(Database.BatchableContext BC){   
   }
}