/**
@Classname :       M2O_AccountContactMarketAttribute
@Description :     It inserts Account Market sector attribute and Contact Market sector attribute into the database whenever
                   an Account or Contact record is created. After creation of Account Market sector attribute 
                   and Contact Market sector attribute it updates the lookup field: Market Sector Attribute in account 
                   and contact with the newly created records of Account Market sector attribute and Contact Market sector 
                   attribute respectively.
@author:           Somdev Bhattacharyya
@Last Modified:    13/11/2013
**/

public class M2O_AccountContactMarketAttributeService {

    /**@Description: This method is used to update the Account record with the attribute data after creating market sector attribute for the same Account with help of the DAO class 
       @Param1:      List of Accounts.
       @Return:      Void.
    **/
    
    public void createAccountMarketSectorAttribute(Set<Id> newAccountToBeUpdatedId, list<Account> trigListAccounts) {
        
        
        list<Account_Market_Sector_Attribute__c> insertedAccountMarketSectorAttribute = new list<Account_Market_Sector_Attribute__c>();
        list<Account_Market_Sector_Attribute__c> listAccountMarketAttribute = new list<Account_Market_Sector_Attribute__c>();        
        list<Account> listAccounts = new list<Account>();
        list<Account> listAccountUpdated = new list<Account>();
                     
        M2O_AccountContactDAO dAOHelper = new  M2O_AccountContactDAO();  
             
        Account_Market_Sector_Attribute__c accountMarkertSectorAttribute;
        if(listAccounts != null) {
            for(Account acc : trigListAccounts) {
                accountMarkertSectorAttribute = new Account_Market_Sector_Attribute__c();
                accountMarkertSectorAttribute.Name = acc.Name+' '+'Attribute';
                accountMarkertSectorAttribute.OwnerId = acc.OwnerId;
                accountMarkertSectorAttribute.AccountId__c = acc.Id;
                listAccountMarketAttribute.add(accountMarkertSectorAttribute);
                
            }
        }System.debug('@@@@@@@@@@@listAccountMarketAttribute: '+listAccountMarketAttribute);
        Account instanceAccount;      
        insertedAccountMarketSectorAttribute = dAOHelper.insrtaccMrktSectrAttribute(listAccountMarketAttribute);
        if(insertedAccountMarketSectorAttribute != null) {
            for(Account_Market_Sector_Attribute__c accMarket : insertedAccountMarketSectorAttribute) {
                instanceAccount = new Account();          
                instanceAccount.Id = accMarket.AccountId__c;             
                instanceAccount.Market_Sector_Attributes__c = accMarket.Id;
                listAccountUpdated.add(instanceAccount);    
            }
        }
        System.debug('@@@@@@@@listAccountUpdated: '+listAccountUpdated);
        // Method used to update Account Market Sector attribute.
        if(listAccountUpdated !=null && listAccountUpdated.size() > 0)
            dAOHelper.updateMarketSector(listAccountUpdated);
    } 
    
        public void createAccountMarketSectorAttributeForBatch(List<Account> newAccountToBeUpdated) {

        list<Account_Market_Sector_Attribute__c> insertedAccountMarketSectorAttribute = new list<Account_Market_Sector_Attribute__c>();
        list<Account_Market_Sector_Attribute__c> listAccountMarketAttribute = new list<Account_Market_Sector_Attribute__c>();        
        list<Account> listAccounts = new list<Account>();
        list<Account> listAccountUpdated = new list<Account>();
            
        M2O_AccountContactDAO dAOHelper = new  M2O_AccountContactDAO();        
        
        Account_Market_Sector_Attribute__c accountMarkertSectorAttribute;
        if(newAccountToBeUpdated!= null) {
            for(Account acc : newAccountToBeUpdated) {
                accountMarkertSectorAttribute = new Account_Market_Sector_Attribute__c();
                accountMarkertSectorAttribute.Name = acc.Name+' '+'Attribute';
                accountMarkertSectorAttribute.OwnerId = acc.OwnerId;
                accountMarkertSectorAttribute.AccountId__c = acc.Id;
                accountMarkertSectorAttribute.GRC_HC_Hospital_Grade__c = acc.Hospital_Grade__c;
                accountMarkertSectorAttribute.GRC_HC_Hospital_Level__c = acc.Hospital_Level__c;
                accountMarkertSectorAttribute.NAM_HC_NAM_HHS_Strategic_Top_40__c = acc.Strategic_Top_40__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_Specialty__c = acc.Speciality__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_Strategic_Account_Curent_year__c = acc.Current_Strategic_Account__c;
                accountMarkertSectorAttribute.NAM_HHS_Strategic_Account_Previous_Year__c = acc.Previous_Strategic_Account__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Program_Business_Offering__c = acc.LL_Program_Business_Offering__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Program_Code__c = acc.LL_Program_Code__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Inactive_Flag__c = acc.LL_Inactive_Flag__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Parent_Business_Offering__c = acc.LL_Parent_Business_Offering__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Parent_Code__c = acc.LL_Parent_Code__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_LL_Business_Segment__c = acc.LL_Business_Segment__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_RCS_Account_Number__c = acc.RCS_Account_Number__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_RCS_Hospital_System__c = acc.Hospital_System__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_RCS_Inactive_Flag__c = acc.RCS_Inactive_Flag__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_RCS_Medaxiom_Member__c = acc.MedAxiom_Member__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_PTS_Inactive_Flag__c = acc.PTS_Inactive_Flag__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_PTS_Program_Code__c = acc.PTS_Program_Code__c;
                accountMarkertSectorAttribute.NAM_HC_HHS_SHR_Of_OSA_Patients__c = acc.SHR_Of_OSA_Patients_2_Night_Study__c;
                accountMarkertSectorAttribute.NAM_HC_OSA_Patient_Split_Night_Study__c = acc.SHR_Of_OSA_Patients_Split_Night_Study__c;
                accountMarkertSectorAttribute.ISC_HC_JCI_Accredited__c = acc.JCI_Accredited__c;
                accountMarkertSectorAttribute.ISC_HC_NABH_Accredited__c = acc.NABH_Accredited__c;
                 
                listAccountMarketAttribute.add(accountMarkertSectorAttribute);
                system.debug('@@@@@@listAccountMarketAttribute: '+listAccountMarketAttribute);
                
            }
        }System.debug('@@@@@@@@@@@listAccountMarketAttribute: '+listAccountMarketAttribute);
        Account instanceAccount;      
        insertedAccountMarketSectorAttribute = dAOHelper.insrtaccMrktSectrAttribute(listAccountMarketAttribute);
        if(insertedAccountMarketSectorAttribute != null) {
            for(Account_Market_Sector_Attribute__c accMarket : insertedAccountMarketSectorAttribute) {
                instanceAccount = new Account();          
                instanceAccount.Id = accMarket.AccountId__c;             
                instanceAccount.Market_Sector_Attributes__c = accMarket.Id;
                listAccountUpdated.add(instanceAccount);    
            }
        }
        System.debug('@@@@@@@@listAccountUpdated: '+listAccountUpdated);
        // Method used to update Account Market Sector attribute.
        if(listAccountUpdated !=null && listAccountUpdated.size() > 0)
            dAOHelper.updateMarketSector(listAccountUpdated);
    } 
/**@Description: This method is used to update the contact record with the attribute data after creating market sector attribute for the same contact with help of the DAO class 
       @Param1:      List of Contact.
       @Return:      Void.
    **/

    
    public void createContactMarketSectorAttribute (Set<Id> newContactToBeUpdated,List<Contact>trigListContact) {
        
        
        list<Contact_Market_Sector_Attributes__c> insertedContactMarketSectorAttribute = new list<Contact_Market_Sector_Attributes__c>();
        List<Contact> listContactsToBeUpdated = new list<Contact>();
        List<Contact_Market_Sector_Attributes__c> listContactMarketAttribute = new List<Contact_Market_Sector_Attributes__c>();       
        List<Contact> listContacts = new List<Contact>();
        M2O_AccountContactDAO dAOHelper = new  M2O_AccountContactDAO();        
         
        Contact_Market_Sector_Attributes__c instanceContactMarketSectorAttribute;
        Map<id, String> mapIdContactMarketName = new Map<id, String>();
        System.debug('@@@@TRigger ValUe:'+trigListContact);
        if(trigListContact != null) {
            for (Contact cntct : trigListContact) {
                System.debug('@@@@Contact details: '+cntct);           
                instanceContactMarketSectorAttribute = new Contact_Market_Sector_Attributes__c();
                instanceContactMarketSectorAttribute.Name = cntct.Salutation+cntct.FirstName+cntct.LastName+' '+'Attribute';
                instanceContactMarketSectorAttribute.OwnerId = cntct.OwnerId;
                instanceContactMarketSectorAttribute.ContactId__c = cntct.id;
                listContactMarketAttribute.add(instanceContactMarketSectorAttribute);         
            }
        }
        // Method used to insert Contact Market Sector Attribute record.
        if(listContactMarketAttribute != null && listContactMarketAttribute.size() > 0)
            insertedContactMarketSectorAttribute = dAOHelper.insrtcntctMarktSctrAttribute(listContactMarketAttribute);       
        Contact instanceContact;
        if (insertedContactMarketSectorAttribute != null) {     
            for (Contact_Market_Sector_Attributes__c contactMarket : insertedContactMarketSectorAttribute) {
                instanceContact = new Contact();
                instanceContact.Id = contactMarket.ContactId__c;
                instanceContact.Market_Sector_Attribute__c = contactMarket.Id;
                listContactsToBeUpdated.add(instanceContact); 
            }
        }
        // Method used to update Contact Market Sector Attribute.
        if(listContactsToBeUpdated !=null && listContactsToBeUpdated.size() > 0)
            dAOHelper.updateMarketSectorContact(listContactsToBeUpdated); 
    } 
    public void createContactMarketSectorAttributeForBatch (List <Contact> newContactToBeUpdated) {
    system.debug('@@@@In Service Class method createContactMarketSectorAttributeForBatch ');
    
        list<Contact_Market_Sector_Attributes__c> insertedContactMarketSectorAttribute = new list<Contact_Market_Sector_Attributes__c>();
        List<Contact> listContactsToBeUpdated = new list<Contact>();
        List<Contact_Market_Sector_Attributes__c> listContactMarketAttribute = new List<Contact_Market_Sector_Attributes__c>();       
        List<Contact> listContacts = new List<Contact>();
        M2O_AccountContactDAO dAOHelper = new  M2O_AccountContactDAO();        
         
        Contact_Market_Sector_Attributes__c instanceContactMarketSectorAttribute;
        Map<id, String> mapIdContactMarketName = new Map<id, String>();
        if(newContactToBeUpdated!= null) {
            for (Contact cntct : newContactToBeUpdated) {
                instanceContactMarketSectorAttribute = new Contact_Market_Sector_Attributes__c();
                instanceContactMarketSectorAttribute.Name = cntct.Salutation+cntct.FirstName+cntct.LastName+' '+'Attribute'; 
                instanceContactMarketSectorAttribute.OwnerId = cntct.OwnerId;
                instanceContactMarketSectorAttribute.ContactId__c = cntct.id;
                instanceContactMarketSectorAttribute.NAM_HC_HHS_SHR_Predominantly_scripts__c = cntct.SHR_Predominantly_Scripts__c;

                listContactMarketAttribute.add(instanceContactMarketSectorAttribute);         
            }
        }
        System.debug('@@@@@@@@@@@listContactMarketAttribute: '+listContactMarketAttribute);
        // Method used to insert Contact Market Sector Attribute record.
        if(listContactMarketAttribute != null && listContactMarketAttribute.size() > 0)
            insertedContactMarketSectorAttribute = dAOHelper.insrtcntctMarktSctrAttribute(listContactMarketAttribute);
            System.debug('@@@@@@@@@@@insertedContactMarketSectorAttribute:'+insertedContactMarketSectorAttribute);       
        Contact instanceContact;
        if (insertedContactMarketSectorAttribute != null) {     
            for (Contact_Market_Sector_Attributes__c contactMarket : insertedContactMarketSectorAttribute) {
                instanceContact = new Contact();
                instanceContact.Id = contactMarket.ContactId__c;
                instanceContact.Market_Sector_Attribute__c = contactMarket.Id;
                listContactsToBeUpdated.add(instanceContact); 
            }
        }
        System.debug('@@@@@@@@@@@listContactsToBeUpdated:'+listContactsToBeUpdated);
        // Method used to update Contact Market Sector Attribute.
        if(listContactsToBeUpdated !=null && listContactsToBeUpdated.size() > 0)
            dAOHelper.updateMarketSectorContact(listContactsToBeUpdated); 
    } 
      
}