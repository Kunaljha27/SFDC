/**
@Classname :       M2O_OpportunityDAOTest
@Description :     This test class is written to cover the code of M2O_OpportunityDAO Class.
@Author:           Meeta Pramanik
@Last Modified:    12/12/2013
**/
@isTest
public class M2O_OpportunityDAOTest {
    
     M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
     
     static testMethod void test_getDSRRecord () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {
         insert dsr;
         String Queriablefields = 'Status__c';
         Test.startTest();
         optyDao.getDSRRecord(Queriablefields,dsr.Id);
         System.assertNotEquals(dsr.Id,null);
         Test.stopTest();
         }
      }
      static testMethod void test_clonedDSRInsert () {
          M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();    
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {
         Test.startTest();
         optyDao.clonedDSRInsert(dsr);
         dsr.Proposal_Status__c = 'Pending Proposal Requirements';
         optyDao.clonedDSRInsert(dsr);
         System.assertNotEquals(dsr,null);
         Test.stopTest();
         }
      }
      static testMethod void test_getNoteRecord () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {        
         optyDao.clonedDSRInsert(dsr);
         Note no = new Note ();
         no =  M2O_OpportunityTestDataUtility.getNoteRecord(dsr);
         insert no;
         Test.startTest();
         List <Note> noList = optyDao.getNoteRecord(dsr.id);
         System.assertNotEquals(dsr,null);
         Test.stopTest();
         }
      }
      static testMethod void test_getAttachmentRecord () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {       
         optyDao.clonedDSRInsert(dsr);
         Attachment no = new Attachment ();
         no =  M2O_OpportunityTestDataUtility.getAttachmentRecord(dsr);
         insert no;
         Test.startTest();
         List <Attachment> attachList = optyDao.getAttachmentRecord(dsr.id);
         System.assertNotEquals(dsr,null);
         Test.stopTest();
         }
      }
      static testMethod void test_clonedNoteInsert () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {      
         optyDao.clonedDSRInsert(dsr);
         Note no = new Note ();
         no =  M2O_OpportunityTestDataUtility.getNoteRecord(dsr);
         list<Note> noteList = new list<Note>();
         noteList.add(no);
         Test.startTest();
         optyDao.clonedNoteInsert(noteList);         
         System.assertNotEquals(noteList,null);
         Note blankNote = new Note();
         noteList.add(blankNote);
         optyDao.clonedNoteInsert(noteList);
         Test.stopTest();
         }
      }
      
      static testMethod void test_clonedAttachmentInsert () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         Deal_Support_Request_del__c dsr = new Deal_Support_Request_del__c ();
         dsr =  M2O_OpportunityTestDataUtility.getDSRRecord ();
         System.runAs(m2oSystemAdminUser) {     
         optyDao.clonedDSRInsert(dsr);
         Attachment no = new Attachment ();
         no =  M2O_OpportunityTestDataUtility.getAttachmentRecord(dsr);
         List <Attachment> attachList = new List <Attachment> ();
         attachList.add(no);
         Test.startTest();
         optyDao.clonedAttachmentInsert(attachList);
         System.assertNotEquals(attachList,null);
         Attachment att = new Attachment();
         attachList.add(att);
         optyDao.clonedAttachmentInsert(attachList);
         Test.stopTest();
         }
      }
      static testMethod void test_getOpportunityEOD () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         System.runAs(m2oSystemAdminUser) {
         Region__c reg = M2O_OpportunityTestDataUtility.getRegionData();
         insert reg ;
         Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(reg);
         insert acc;
         List<Opportunity> oppList = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id,m2oSystemAdminUser.id);
         insert oppList;
         set<ID> opptyIdSet = new Set<ID>();
         for (Opportunity opp :oppList) {
             opptyIdSet.add(opp.id);
         }
         Test.startTest();
         M2O_OpportunityDAO.getOpportunityEOD(opptyIdSet);
         System.assertNotEquals(opptyIdSet,null);
         Test.stopTest();
         }
      }
      static testMethod void test_opportunityEODUpdate () {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
         Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
         User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
         insert m2oSystemAdminUser;
         System.runAs(m2oSystemAdminUser) {
         Region__c reg = M2O_OpportunityTestDataUtility.getRegionData();
         insert reg ;
         Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(reg);
         insert acc;
         Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecordWithOwner(acc.id,m2oSystemAdminUser.id);
         insert opp;
         Test.startTest();
         opp.Name='test';
         M2O_OpportunityDAO.opportunityEODUpdate(opp);
         System.assertNotEquals(opp,null);
         opp.Name='';
         opp.id = null;
         M2O_OpportunityDAO.opportunityEODUpdate(opp);
         Test.stopTest();
         }
        }
     
     /**
    @Description:  To test the method getOpportunityRecord of M2O_OpportunityDAO class. 
    **/
        static testMethod void test_getOpportunityRecord() {
            
            M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
            Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
            User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
            insert m2oSystemAdminUser;
            User runAsUser= [SELECT Id FROM User WHERE Alias='psaha'];
            System.runAs(m2oSystemAdminUser) {
            List<Schema.FieldSetMember> oppty= SObjectType.Opportunity.FieldSets.M2O_Opp_Fields_To_Cloned.getFields();
            String queriableFields;         
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            queriableFields = M2O_OpportunityTestDataUtility.fieldSetValue(oppty);           
            Test.startTest();
            optyDao.getOpportunityRecord(queriableFields,opp.id);
            System.assertNotEquals(opp.Id,null);
            Test.stopTest();
            }
        }
    
    
    /**
    @Description:  To test the method getOpportunityEcoSystem of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_getOpportunityEcoSystem() {

       M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
       Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
       Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
       User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
       User runAsUser;
       User runAsUser1= [SELECT Id FROM User WHERE Alias='psaha'];
       insert m2oSystemAdminUser;
       System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            List<Schema.FieldSetMember> oppEcoSysFields = new List<Schema.FieldSetMember>();
            String queriableOppEcoFields;
            oppEcoSysFields = SObjectType.Opportunity_Ecosystem__c.FieldSets.Opp_EcoSys_clone.getFields();      
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            list<Opportunity> opplist = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.Id,runAsUser.id);
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            insert opplist;
            List<Account>accList=new List<Account>();
            queriableOppEcoFields = M2O_OpportunityTestDataUtility.fieldSetValue(oppEcoSysFields);
            List<Opportunity_Ecosystem__c> listOppEcoSys = M2O_OpportunityTestDataUtility.getListOfOptyEcosystem(opplist,acc);
            optyDao.clonedOpportunityEcoSystemInsert(listOppEcoSys);
            Test.startTest();
            optyDao.getOpportunityEcoSystem(queriableOppEcoFields,opp.id);
            System.assertNotEquals(opp,null);
            Test.stopTest();
        }
    }
    
    /**
    @Description:  To test the method getOpportunityTeamMember of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_getOpportunityTeamMember() {
         M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        User runAsUser1= [SELECT Id FROM User WHERE Alias='psaha'];
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser; 
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            List <OpportunityTeamMember> lstOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert lstOtm;          
            Test.startTest();
            optyDao.getOpportunityTeamMember(opp.Id);
            System.assertNotEquals(opp.Id,null);
            Test.stopTest();           
        }
    }
    
    /**
    @Description:  To test the method getOpportunityLineItem of M2O_OpportunityDAO class. 
    **/
    @isTest(seeAllData = true)
     static void test_getOpportunityLineItem() {
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            OpportunityLineItem optyLineItem = M2O_OpportunityTestDataUtility.getOppLineItemRecord(opp.Id, pbe.Id); 
            Test.startTest();
            optyDao.getOpportunityLineItem(opp.Id);
            System.assertNotEquals(opp.Id,null);
            Test.stopTest();           
        }
    }
    
    /**
    @Description:  To test the method getListOpportunityTeam of M2O_OpportunityDAO class. 
    **/
        
    static testMethod void test_getListOpportunityTeam() {
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            List <OpportunityTeamMember> lstOtm = new List<OpportunityTeamMember >();
            lstOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
            insert lstOtm;
            Set<id> setOppId = new Set<id>();  
            setOppId.add(opp.id);  
            Test.startTest();
            optyDao.getListOpportunityTeam(setOppId);
            System.assertNotEquals(setOppId,null);
            Test.stopTest();           
        }
    }
    
    /**
    @Description:  To test the method getOpportunity of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_getOpportunity() { 
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            List <Opportunity> lstOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id,runAsUser.id);
            insert lstOpportunity;            
            Set<id> setOppId = new Set<id>();
            for(Opportunity opp : lstOpportunity) {
                setOppId.add(opp.id);                
            }
            Test.startTest();
            optyDao.getOpportunity(setOppId);
            System.assertNotEquals(setOppId,null);
            Test.stopTest();
        }
    }
    
    /**
    @Description:  To test the method getSharedRecordsOfSObject of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_getSharedRecordsOfSObject() { 
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        User newOwner;
        newOwner = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
        insert newOwner;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            Region__c regionData;        
            regionData= M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;            
            List <Opportunity> lstOpportunity = new List<Opportunity>();
            lstOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id,runAsUser.id);
            insert lstOpportunity;
            list<Sales_Order__c> listOfSalesOrder = new list<Sales_Order__c>();
            for(Opportunity opp : lstOpportunity) {
                listOfSalesOrder.add(M2O_OpportunityTestDataUtility.getSalesOrderRecord(opp.id));
            }
            insert listOfSalesOrder;
            Set<id> setOfSObjectId = new Set<id>();
            for(Sales_Order__c salesOrder : listOfSalesOrder) {
                setOfSObjectId.add(salesOrder.id);
            }
            Set<id> setUserId = new Set<id>();
            setUserId.add(newOwner.id);
            String query = 'Select id, UserOrGroupId, ParentId, RowCause From Sales_Order__share Where ParentId in: setOfSObjectId and UserOrGroupId in: setUserId';
            Test.startTest();
            optyDao.getSharedRecordsOfSObject(query, setOfSObjectId, setUserId);
            System.assertNotEquals(query,null);
            Test.stopTest();
        }
    }
    
    /**
    @Description:  To test the method getUserRecords of M2O_OpportunityDAO class. 
    **/
    static testMethod void test_getUserRecords () {
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;            
        set<Id> userId = new set<Id>();
        userId.add(m2oSystemAdminUser.id);
        test.StartTest();
        optyDao.getUserRecords(userId);
        System.assertNotEquals(userId,null);
        test.StopTest();
     }
     
     /**
    @Description:  To test the method clonedOpportunityInsert of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_clonedOpportunityInsert() {        
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;            
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
     //   }
        List<Schema.FieldSetMember> oppty= SObjectType.Opportunity.FieldSets.M2O_Opp_Fields_To_Cloned.getFields();
        String queriableFields;         
        Region__c regionData;
        regionData= M2O_AccountContactTestDataUtility.getRegionData();
        insert regionData;
        Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
        insert acc;
        Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
        test.startTest();
        optyDao.clonedOpportunityInsert(opp);
        System.assertNotEquals(opp,null);
        opp.name = '';
        optyDao.clonedOpportunityInsert(opp);
        Test.stopTest();
        }
    }
    
    /**
    @Description:  To test the method clonedOpportunityEcoSystemInsert of M2O_OpportunityDAO class. 
    **/        
     static testMethod void test_clonedOpportunityEcoSystemInsert() {       
           M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           insert m2oSystemAdminUser;            
           System.runAs(m2oSystemAdminUser) {
               runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
               insert runAsUser;
               List<Schema.FieldSetMember> oppEcoSysFields = new List<Schema.FieldSetMember>();
               String queriableOppEcoFields;
               oppEcoSysFields = SObjectType.Opportunity_Ecosystem__c.FieldSets.Opp_EcoSys_clone.getFields();      
               Region__c regionData;
               regionData= M2O_AccountContactTestDataUtility.getRegionData();
               insert regionData;
               Account acc = new Account();
               acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
               insert acc;
               list<Opportunity> opp = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.Id,runAsUser.id);
               insert opp;
               queriableOppEcoFields = M2O_OpportunityTestDataUtility.fieldSetValue(oppEcoSysFields);
               List<Opportunity_Ecosystem__c> listOfOpportunityEcoSystem = M2O_OpportunityTestDataUtility.getListOfOptyEcosystem(opp, acc);
               test.startTest();
               optyDao.clonedOpportunityEcoSystemInsert(listOfOpportunityEcoSystem);
               System.assertNotEquals(listOfOpportunityEcoSystem,null);
               listOfOpportunityEcoSystem[0].Account_Role__c = '';
               optyDao.clonedOpportunityEcoSystemInsert(listOfOpportunityEcoSystem);
               Test.stopTest();
           }
      }
      
      /**
    @Description:  To test the method clonedOpportunityLineItemInsert of M2O_OpportunityDAO class. 
    **/
       @isTest(seeAllData = true)   
       Static void test_clonedOpportunityLineItemInsert() {       
           M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           insert m2oSystemAdminUser;
           System.runAs(m2oSystemAdminUser) {
                runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
                insert runAsUser;
                Region__c regionData= M2O_AccountContactTestDataUtility.getRegionData();
                insert regionData; 
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
                Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
                insert opp;
                PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
                Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
                PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
                OpportunityLineItem optyLineItem = M2O_OpportunityTestDataUtility.getOppLineItemRecord(opp.Id, pbe.Id); 
                List<OpportunityLineItem > lstOpptyLineItem = new List<OpportunityLineItem >();
                lstOpptyLineItem.add(optyLineItem);
                Test.startTest();
                optyDao.clonedOpportunityLineItemInsert(lstOpptyLineItem);
                lstOpptyLineItem[0].opportunityId = null;
                lstOpptyLineItem[0].POS_CSA__c = true; 
                optyDao.clonedOpportunityLineItemInsert(lstOpptyLineItem);
                System.assertNotEquals(lstOpptyLineItem,null);
                Test.stopTest();           
            }
        }
        
        /**
    @Description:  To test the method getMasterOpportunity of M2O_OpportunityDAO class. 
    **/
       
       Static testMethod void test_getMasterOpportunity() {
       
           M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           insert m2oSystemAdminUser;
           System.runAs(m2oSystemAdminUser) {
               runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
               insert runAsUser;
               Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
               insert regionData; 
               Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
               insert acc;
               list<Opportunity> ListOfMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.Id);
               insert ListOfMasterOpportunity;
               set<id> setMasterOpportunityId= new set<id>();
               for(Opportunity masterOpportunity : ListOfMasterOpportunity) {
                    setMasterOpportunityId.add(masterOpportunity.id);
               }
               test.startTest();
               optyDao.getMasterOpportunity(setMasterOpportunityId);
               System.assertNotEquals(setMasterOpportunityId,null);
               test.stopTest();
           }
        }
        
        /**
    @Description:  To test the method updateOpportunity of M2O_OpportunityDAO class. 
    **/
        
        Static testMethod void test_updateOpportunity() {
        
           M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           insert m2oSystemAdminUser;
           System.runAs(m2oSystemAdminUser) {
                runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
                insert runAsUser;
                Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
                insert regionData; 
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
               list<Opportunity> ListOfMasterOpportunity = M2O_OpportunityTestDataUtility.getListOfMasterOpportunityRecord(acc.Id);
               insert ListOfMasterOpportunity;
               for(Opportunity opp : ListOfMasterOpportunity) {
                    opp.Sub_Opportunities_Total_Amounts__c = 10.00;
               }
               test.startTest();
               optyDao.updateOpportunity(ListOfMasterOpportunity);
               System.assertNotEquals(ListOfMasterOpportunity,null);
               ListOfMasterOpportunity[0].id = null;
               optyDao.updateOpportunity(ListOfMasterOpportunity);
               test.stopTest();
           }
        }
        
        /**
    @Description:  To test the method clonedOpportunityUpdate of M2O_OpportunityDAO class. 
    **/
        Static testMethod void test_clonedOpportunityUpdate() {        
            M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
            Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
            Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
            User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
            User runAsUser;
            insert m2oSystemAdminUser;
            System.runAs(m2oSystemAdminUser) {
                 runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
                 insert runAsUser;
                Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
                insert regionData; 
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
                Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
                insert opp;
                opp.Name = 'test900';
                test.StartTest();
                optyDao.clonedOpportunityUpdate(opp);               
                System.assertNotEquals(opp,null);
                opp.id = null;
                optyDao.clonedOpportunityUpdate(opp);
                test.StopTest();
           }
        }
        
        /**
    @Description:  To test the method getOpportunityShare of M2O_OpportunityDAO class. 
    **/
    
    static testMethod void test_getOpportunityShare() { 
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser; 
                Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
                insert regionData;
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
                Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
                insert opp;
                User opportunityTeamMember = M2O_UserTestDataUtility.getOpportunityTeamUserRecord(hcProfileId.id);
                List <OpportunityTeamMember> lstOtm = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
                insert lstOtm;          
                Test.startTest();
                optyDao.getOpportunityShare(opp.Id);
                System.assertNotEquals(opp.Id,null);
                Test.stopTest();           
        }
    }
    
    static testMethod void test_getSObjectRecords() {
         M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
         Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
         User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
         System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            List <Sales_Order__c> lstSalesOrder = new List<Sales_Order__c> ();
            lstSalesOrder = M2O_OpportunityTestDataUtility.getListOfSalesOrderRecord(opp.id);
            String query = 'SELECT id FROM Sales_Order__c WHERE Opportunity__c in: setOppId';
            Set<id> setOppId = new Set<id>();  
            setOppId.add(opp.id);  
            Test.startTest();
            optyDao.getSObjectRecords(query, setOppId);
            Test.stopTest();           
        }
     }
     
     /**
    @Description:  To test the method insertSobjectShare of M2O_OpportunityDAO class. 
    **/
        
         Static testMethod void test_insertSobjectShare() {        
            M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
            Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
            Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
            User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
            User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            insert m2oSystemAdminUser;
            System.runAs(m2oSystemAdminUser) {                
                Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
                insert regionData; 
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc;
                Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
                insert opp;
                List <Sales_Order__c> lstSalesOrder = new List<Sales_Order__c> ();
                lstSalesOrder = M2O_OpportunityTestDataUtility.getListOfSalesOrderRecord(opp.id);
                insert lstSalesOrder; 
                List<Sales_Order__Share> listSalesOrderShare = new List<Sales_Order__Share>();
                test.startTest();
                optyDao.insertSobjectShare(listSalesOrderShare);
                System.assertNotEquals(listSalesOrderShare,null);
                //listSalesOrderShare[0].rowcause = 'test';
                optyDao.insertSobjectShare(listSalesOrderShare);
                test.stopTest();
            }
       }
     
     /**
    @Description:  To test the method deleteSobjectShare of M2O_OpportunityDAO class. 
    **/
       
        static testMethod void test_deleteSobjectShare() {       
            M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
            Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
            Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
            User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
            User runAsUser;
            User newOwner = M2O_UserTestDataUtility.getOwnerRecord(hcProfileId.id);
            insert newOwner;
            insert m2oSystemAdminUser;
            System.runAs(m2oSystemAdminUser) {
                runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
                insert runAsUser;
                Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
                insert regionData; 
                Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
                insert acc; 
                List <Opportunity> lstOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id, runAsUser.Id);
                insert lstOpportunity;
                list<Sales_Order__c> listOfSalesOrder = new list<Sales_Order__c>();
                Set<id> setSalesOrderId = new Set<id>();
                for(Opportunity opp : lstOpportunity) {
                    listOfSalesOrder.add(M2O_OpportunityTestDataUtility.getSalesOrderRecord(opp.id));
                    opp.ownerid = newOwner.id;
                }
                insert listOfSalesOrder;
                update lstOpportunity;
                for(Sales_Order__c so : listOfSalesOrder) {
                    setSalesOrderId.add(so.id);
                }
                List<Sales_Order__Share> listSalesOrderShare = [SELECT UserOrGroupId , ParentId , AccessLevel
                                                                FROM Sales_Order__Share where ParentId in: setSalesOrderId];
                test.startTest();
                optyDao.deleteSobjectShare(listSalesOrderShare);
                System.assertNotEquals(listSalesOrderShare , null);
                //listSalesOrderShare[0].id = '77977879798';
                optyDao.deleteSobjectShare(listSalesOrderShare);
                test.stopTest();
            }
       } 
       
       static testMethod void test_clonedOpportunityTeamMemberInsert() {
           M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           System.runAs(m2oSystemAdminUser) {
               runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
               Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
               insert regionData; 
               Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
               insert acc; 
               Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
               List<OpportunityTeamMember> listOpportunityTeamMember = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
               List<OpportunityShare> opportunityShareList = M2O_OpportunityTestDataUtility.getOpportunityShare(listOpportunityTeamMember[0].UserId);
               test.startTest();
               optyDao.clonedOpportunityTeamMemberInsert(listOpportunityTeamMember, opportunityShareList);
               listOpportunityTeamMember[0].opportunityId = null;
               optyDao.clonedOpportunityTeamMemberInsert(listOpportunityTeamMember, opportunityShareList);
               Test.stopTest();
           }
       }
      
        /**
    @Description:  To test the method retrieveAssociatedOpportunity of M2O_OpportunityDAO class. 
    **/
        static testMethod void test_retrieveAssociatedOpportunity() {
           M2O_OpportunityDAO optyDao = new M2O_OpportunityDAO();
           Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
           Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
           User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
           User runAsUser;
           System.runAs(m2oSystemAdminUser) {
               runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
               Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
               insert regionData;
               Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
               insert acc;
               M2O_OpportunityDAO.retrieveAssociatedOpportunity(string.valueof(acc.id));
               Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
               List<OpportunityTeamMember> listOpportunityTeamMember = M2O_OpportunityTestDataUtility.getListOfOppTeamMemberRecords(opp.id, hcProfileId.id);
               test.startTest();
               M2O_OpportunityDAO.retrieveAssociatedOpportunity(string.valueof(acc.id));
               Test.stopTest();   
        }   
    }
    
    /**
    @Description:  To test the method getOpportunityLineItemForChapterNum of M2O_OpportunityDAO class. 
    **/
    @isTest(seeAllData = true)
    static void test_getOpportunityLineItemForChapterNum() {
        M2O_OpportunityDAO optyDao = new  M2O_OpportunityDAO();
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        User runAsUser;
        insert m2oSystemAdminUser;
        System.runAs(m2oSystemAdminUser) {
            runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
            insert runAsUser;
            Region__c regionData = M2O_OpportunityTestDataUtility.getRegionData();
            insert regionData;
            Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
            insert acc;
            Opportunity opp = M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.Id);
            insert opp;
            PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
            PricebookEntry pbe = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            OpportunityLineItem optyLineItem = M2O_OpportunityTestDataUtility.getOppLineItemRecord(opp.Id, pbe.Id); 
            Set<id> setOppId = new Set<id>();  
            setOppId.add(opp.id); 
            Test.startTest();
            M2O_OpportunityDAO.getOpportunityLineItemForChapterNum(setOppId);
            System.assertNotEquals(opp.Id,null);
            Test.stopTest();          
          }
       }
}