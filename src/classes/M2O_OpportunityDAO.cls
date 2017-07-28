/**
@Classname :       M2O_OpportunityDAO 
@Description :     The DAO class is invoked from the bussiness logic class to perform Lead and Opportuinty 
                   related queries and the DML operation.
@Author:           Somdev Bhattacharyya/ Piyali Saha
@Last Modified:    13/11/2013
**/

public class M2O_OpportunityDAO {

/**
    @Description: Retrieve DSR data which is cloned to a new DSR record.
    @Param1:      String of queriable fields.
    @Param2:      Id of parent DSR.
    @Return:      DSR
    **/
    
    public Deal_Support_Request_del__c getDSRRecord(String Queriablefields, id sourceDSRId) {        
        String strDSRRecord;
        Deal_Support_Request_del__c sourceDSRRecord = new Deal_Support_Request_del__c();
        try {
            strDSRRecord =  'SELECT ' + Queriablefields +'Name From Deal_Support_Request_del__c where id =: sourceDSRId';
            if (strDSRRecord != null) {
                sourceDSRRecord = Database.query(strDSRRecord) ;
            }
           return sourceDSRRecord;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Insert DSR records
    @Param1:      DSR.
    @Return :     DSR .
    
    **/
    
    public Deal_Support_Request_del__c clonedDSRInsert(Deal_Support_Request_del__c insertClonedDSR) { 
       
        try {
            if(insertClonedDSR !=null) {
                insert insertClonedDSR;
            }system.debug('@@@@@@@@@@@@@@@@222222222DSR REcord'+insertClonedDSR);
        return  insertClonedDSR;
        }
        catch(DMLException ex) {
            System.debug(ex);
            return null;
        }            
    }
    
    /**
    @Description: Retrieve DSR data which is cloned to a new DSR record.
    @Param1:      Id of parent DSR.
    @Return:      DSR
    **/
    
    public list<Note> getNoteRecord(id sourceDSRId) {        
        list<Note> noteRecordList = new List<Note>();
        
        try {
             if (sourceDSRId != null) {
                noteRecordList =  [SELECT Body,OwnerId,Title,ParentId From Note where ParentId =: sourceDSRId];
            }system.debug('@@@@@@@@@@@@@@@@@DSR Note REcord'+noteRecordList );
           return noteRecordList;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Insert DSR Notes records
    @Param1:      Notes.
    @Return :     Notes .
    
    **/
    
    public void clonedNoteInsert(List<Note> insertClonedNotes) { 
       
        try {
            if(insertClonedNotes !=null) {
                insert insertClonedNotes;
            }system.debug('@@@@@@@@@@@@@@@@222222222DSR notes REcord'+insertClonedNotes);
        
        }
        catch(DMLException ex) {
            System.debug(ex);
            
        }            
    }
    
/**
    @Description: Retrieve DSR Attachment data which is cloned to a new DSR record.
    @Param1:      Id of parent DSR.
    @Return:      List of attachments
    **/
    
    public list<Attachment> getAttachmentRecord(id sourceDSRId) {        
        list<Attachment> attachmentRecordList = new List<Attachment>();
        
        try {
             if (sourceDSRId != null) {
                attachmentRecordList = [SELECT Body,Description,Id,Name,OwnerId,ParentId FROM Attachment where ParentId = :sourceDSRId];
            }system.debug('@@@@@@@@@@@@@@@@@DSR Attachment REcord'+AttachmentRecordList );
           return attachmentRecordList;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Insert DSR Attachments records
    @Param1:      list of Attachments.
    @Return :     Attachments .
    
    **/
    
    public void clonedAttachmentInsert(List<Attachment> insertClonedAttachments) { 
       
        try {
            if(insertClonedAttachments !=null) {
                insert insertClonedAttachments;
            }system.debug('@@@@@@@@@@@@@@@@222222222DSR Attachments REcord'+insertClonedAttachments);
        
        }
        catch(DMLException ex) {
            System.debug(ex);
            
        }            
    }
    
     /**
    @Description: Retrieve opportunity data for which opportunity line item is being added.
    @Param1:      Set of opportunity Id.
    @Return:      list of Opportunity
    **/
    
    public static list<Opportunity> getOpportunityEOD(set<id>opptyIdSet) {
        try {
            return([Select Id,CloseDate,StageName,Opportunity_Hierarchy_Link__c,Update_Sub_opportunity_Stage__c,Update_Sub_oppty_Expected_Order_Da__c From Opportunity where Id in :opptyIdSet]);
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
     }       
        
    /**
    @Description: Retrieve opportunity data which is cloned to a new Opportunity record.
    @Param1:      String of queriable fields.
    @Param2:      Id of parent opportunity.
    @Return:      Opportunity
    **/
    
    public Opportunity getOpportunityRecord(String Queriablefields, id sourceOpportunityId) {        
        String strOpportunityRecord;
        Opportunity sourceOpportunityRecord = new Opportunity();
        try {
            strOpportunityRecord =  'SELECT ' + Queriablefields +'Name From Opportunity where id =: sourceOpportunityId';
            if (strOpportunityRecord != null) {
                sourceOpportunityRecord = Database.query(strOpportunityRecord) ;
            }
           return sourceOpportunityRecord;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve Opportunity data with respect to a set of opportunity ids.            
    @Param1:      Set of opportunity Ids.
    @Return:      List of opportunity
    **/
    public static LIST<Opportunity> getOpportunityId (Set<Id> oppIdSet) {
        LIST<Opportunity> oppList = new LIST<Opportunity>();
        try {
            if(oppIdSet != null && !oppIdSet.isempty()) {
                oppList = [select Id from Opportunity where RecordTypeId =:label.M2O_Opportunity_Healthcare_RecordType_ID And Id in :oppIdSet And Type=:M2O_DataUtility.opportunityType];             
            }
            return oppList;
            
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    public static LIST<Opportunity> getSubOpportunityId (Set<Id> oppIdSet) {
        LIST<Opportunity> oppList = new LIST<Opportunity>();
        try {
            if(oppIdSet != null && !oppIdSet.isempty()) {
                oppList = [select Id,Opportunity_Hierarchy_Link__c from Opportunity where Opportunity_Hierarchy_Link__c in :oppIdSet];             
            }
            system.debug('@@@@@@@@@@@ chap query'+oppList);    
            return oppList;
            
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
      
    /**
    @Description: Retrieve OpportunityLine  data with respect to a set of opportunity ids.            
    @Param1:      Set of opportunity Ids.
    @Return:      Integer.
    **/
    public static integer getNumberOpportunityLineItem (set<Id> oppIdSet) {
        try {
            return([Select count() from OpportunityLineItem where OpportunityId in :oppIdSet]);
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }  
    }            
        
    
    /**
    @Description: Retrieve OpportunityLineItem data with respect to a set of opportunity ids.            
    @Param1:      Set of opportunity Ids.
    @Return:      List of Aggreagates.
    **/
    public static LIST<AggregateResult> getOpportunityLineItemForEODUpdateOnHeader (set<Id> oppIdSet) {
        
        LIST<AggregateResult> oppLineItemList = new LIST<AggregateResult>();
        try {
            if(oppIdSet != null && !oppIdSet.isempty()) {
                oppLineItemList = [select OpportunityId OptyId,min(ServiceDate) trial from  OpportunityLineItem where OpportunityId in :oppIdSet group by OpportunityId  ];
            system.debug('DDDDDDDDDDD'+oppLineItemList);
            }
            return oppLineItemList;
        } 
         
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }  
    }
    
    /**
    @Description: update Opportunity data with respective eod values.            
    @Param1:      list of opportunity .
    @Return:      void.
    **/
    
    public static void opportunityEODUpdate (Opportunity[] oppty) {
        try {
            if(oppty !=null ) {
                update oppty;
            }    
        }
        catch (DMLException e) {
            system.debug(e);
        }
    }        
    
    /**
    @Description: update Opportunity data with respective eod values.            
    @Param1:      list of opportunity .
    @Return:      void.
    **/
    
    public static void opportunityEODUpdate (Opportunity oppty) {
        try {
            if(oppty !=null ) {
                update oppty;
            }    
        }
        catch (DMLException e) {
            system.debug(e);
        }
    }        
    
    
    /**
    @Description: Retrieve OpportunityLineItem data with respect to a set of opportunity ids.            
    @Param1:      Set of opportunity Ids.
    @Return:      List of Aggreagates.
    **/
    public static LIST<AggregateResult> getOpportunityLineItemForChapterNum (set<Id> oppIdSet) {
        
        LIST<AggregateResult> oppLineItemList = new LIST<AggregateResult>();
        try {
            if(oppIdSet != null && !oppIdSet.isempty()) {
                oppLineItemList = [select OpportunityId,max(Chapter_Number_MMD__c) from  OpportunityLineItem where OpportunityId in :oppIdSet  group by OpportunityId];
            }
            return oppLineItemList;
        }    
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve opportunity ecosystem data of the source opportunity record which is to be cloned to a new 
                  Opportunity Record
    @Param1:      String of queriable fields.
    @Param2:      Id of parent opportunity.
    @Return:      List of Opportunity Ecosystem 
    **/
    
    public List<Opportunity_Ecosystem__c> getOpportunityEcoSystem(String queriableOppEcoSystemFields, id sourceOpportunityId) {    
        String strOppEcoRecord;
        List<Opportunity_Ecosystem__c> listOpptortunityEcoSystem = new List<Opportunity_Ecosystem__c>();
        try {            
            strOppEcoRecord  =  'SELECT ' + queriableOppEcoSystemFields +'Appointed__c From Opportunity_Ecosystem__c where Opportunity__c  = : sourceOpportunityId';
            if(strOppEcoRecord != null) {
                listOpptortunityEcoSystem = Database.query(strOppEcoRecord) ;
            }
            return listOpptortunityEcoSystem;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve opportunity team member data of the source opportunity record which is to be cloned to a new 
                  Opportunity Record
    @Param1:      Id of parent opportunity.
    @Return:      List of Opportunity Team Member
    **/
    
    public List<OpportunityTeamMember> getOpportunityTeamMember(Id sourceOpportunityId) {    
        List<OpportunityTeamMember>  listOpportunityTeamMemeber = new List<OpportunityTeamMember>();
        try {
             if(sourceOpportunityId!= null) {
                 listOpportunityTeamMemeber = ([ SELECT UserId, TeamMemberRole, Email_Address__c,OpportunityAccessLevel, Functional_Role__c, Quoting_System__c  FROM OpportunityTeamMember WHERE OpportunityId = : sourceOpportunityId]);
             }
             return listOpportunityTeamMemeber;
             
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve opportunity Share data
    @Param1:      Id of parent opportunity.
    @Return:      List of OpportunityShare records
    **/
    
    public List<OpportunityShare> getOpportunityShare(Id sourceOpportunityId) {
        List<OpportunityShare> listOpportunityShare = new List<OpportunityShare>();
        try {
            if(sourceOpportunityId != null) {
                listOpportunityShare = [SELECT OpportunityAccessLevel,OpportunityId,RowCause,UserOrGroupId FROM OpportunityShare WHERE OpportunityId = : sourceOpportunityId];            
            }
        return listOpportunityShare;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve opportunity line item data
    @Param1:      Id of parent opportunity.
    @Return:      List of Opportunity Line Item records
    **/
    
    public List<OpportunityLineItem> getOpportunityLineItem (Id sourceOpportunityId) {
    
        List<OpportunityLineItem> listOpportunityLineItem = new List<OpportunityLineItem>();
        try {
            if(sourceOpportunityId != null) {
                listOpportunityLineItem = [SELECT PricebookEntryId,Quantity,ServiceDate,Expected_POS_order_date__c,Total_Expected_Order_Value__c,TotalPrice,UnitPrice FROM OpportunityLineItem WHERE OpportunityId =:sourceOpportunityId];
            }
        return listOpportunityLineItem;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve Opportunity and its related records
    @Param1:      String of items to be query
    @Param2:      Set of opportunity ids.
    @Return:      Opportunity
    **/
    
    public List<Opportunity> getRelatedRecordsOpportunity(String queryRelatedRecords, Set<Id> setOpportunityId) { 
           
        List<Opportunity> listOpportunity = new List<Opportunity>();    
        try {        
            if(queryRelatedRecords != null && setOpportunityId != null) {
                listOpportunity = Database.query(queryRelatedRecords);
            }
        return listOpportunity;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve OpportunityTeamMembers except the Partner users
    @Param1:      Set of opportunity ids.
    @Return:      OpportunityTeamMember
    **/
    
    public List<OpportunityTeamMember> getListOpportunityTeam(Set<Id> setOpportunityId) {
    
        List<OpportunityTeamMember> listOpportunityTeam = new List<OpportunityTeamMember>();
        String queryOppTeam;    
        try {
            if (setOpportunityId != null) {
                queryOppTeam = 'SELECT OpportunityId, Opportunity.OwnerId, Id, UserId, user.userType FROM OpportunityTeamMember WHERE OpportunityId in: setOpportunityId AND user.userType!=\'PowerPartner\'';
            }
            if (queryOppTeam != null) {
                listOpportunityTeam = Database.query(queryOppTeam);
            }
        return listOpportunityTeam;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve Opportunity
    @Param1:      Set of opportunity ids.
    @Return:      Map of Opportunity Id and Opportunity Record
    **/
    
    public Map<Id, Opportunity> getOpportunity(Set<Id> setOppId) { 
       
        Map<Id, Opportunity> mapOpportunityId;
        try {
            if (setOppId != null) {
                mapOpportunityId = new Map<Id, Opportunity>([SELECT Id, OwnerId FROM Opportunity WHERE Id in: setOppId]);
            }
            return mapOpportunityId;
        }
        catch(QueryException ex) {
            system.debug(ex); 
            return null;      
        }
        
    }
    
    /**
    @Description: Retrieve Shared records from the values stored in custom setting for calculating sharing for 
                  Sales team and Opportunity Owner
    @Param1:      String of items to be query
    @Param2:      Set of opportunity ids.
    @Param3:      Set of user ids.
    @Return:      List Of sObject
    **/
    public List<Sobject> getSharedRecordsOfSObject(String querySharedRecords, Set<Id> setSObjectId, Set<Id> setUserId) {    
        List<sObject> listShareObjectResult = new List<sObject>();        
        try {
            if(querySharedRecords != null) {
                listShareObjectResult = Database.query(querySharedRecords);
            }
            return listShareObjectResult;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieve Shared records from the values stored in custom setting for calculating sharing for 
                  Sales team and Opportunity Owner
    @Param1:      String of items to be query
    @Param2:      Set of Sobject ids.
    @Return:      list of sObject
    **/
    
    public List<Sobject> getSharedRecordsOfSObject(String query, Set<Id> setSObjectId) {
               
        List<sObject> listShareObjectResult = new List<sObject>();        
        try {
            if(query != null) {
                listShareObjectResult = Database.query(query);
            }
        return listShareObjectResult;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    } 
     
    /**
    @Description: Retrieve sObject records from the values stored in custom setting for calculating sharing for 
                  Sales team and Opportunity Owner
    @Param1:      String of items to be query
    @Param2:      Set of opportunity ids.
    @Return:      List of sObject
    **/
    
    public List<Sobject> getSObjectRecords(String querySObjRecords, Set<Id> setOpportunityId) {
            
        List<Sobject> listSObject = new List<Sobject>();    
        try {
            if(querySObjRecords != null) {
                listSObject = Database.query(querySObjRecords);
            }
        return listSObject;            
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Retrieves the user and user type for a set of users
    @Param1:      Set of user Ids.
    @Return:      Map of user id and it's corresponing user record
    **/
    
    public Map<Id, User> getUserRecords(Set<Id> setUserId) {
           
        Map<Id, User> mapUserId;        
        try {
            if(setUserId !=null && !setUserId.isEmpty()) {            
                mapUserId = new Map<Id, User>([SELECT Id, userType FROM User WHERE Id in: setUserId]);                      
            }
         return mapUserId;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    /**
    @Description: Insert opportunity records
    @Param1:      opportunity.
    @Return :     opportunity .
    
    **/
    
    public Opportunity clonedOpportunityInsert(Opportunity insertClonedOpportunity) { 
       
        try {
            if(insertClonedOpportunity !=null) {
                insert insertClonedOpportunity;
            }
        return insertClonedOpportunity;        
        }
        catch(DMLException ex) {
            System.debug(ex);
            return null;
        }            
    }
    
    /**
    @Description: update opportunity records
    @Param1:      opportunity.
    @Return :     void .
    **/
    
    public void clonedOpportunityUpdate (Opportunity clonedOpportunity) {
    
        try {
            if (clonedOpportunity != null) {
                update clonedOpportunity;           
            }
        }
        catch(DMLException ex) {
                System.debug(ex);            
        }
    } 
    
    /**
    @Description: Insert opportunity ecosystem records for the cloned Opportunity
    @Param1:      List of opportunity ecosystem.
    @Return :     Void.
    **/
    
    public void clonedOpportunityEcoSystemInsert(List <Opportunity_Ecosystem__c> insertOpportunityEcoSystem) { 
           
        try {
                if(insertOpportunityEcoSystem != null) {
                    insert insertOpportunityEcoSystem;
                }
            }
            catch(DMLException ex) {
                System.debug(ex);
            }              
        }
    
    /**
    @Description: Insert opportunity sales team member records for the cloned Opportunity
    @Param1 :     List of opportunity team member.
    @Param2:      list of opportunity share.
    @Return :     Void.
    **/
    
    public VoId clonedOpportunityTeamMemberInsert(List<OpportunityTeamMember> insertOpportunityTeamMember, List <OpportunityShare> insertOpportunityShare) {    
    
        try {
            if(insertOpportunityTeamMember != null) {
                upsert insertOpportunityTeamMember;
            }
            if(insertOpportunityShare != null) {
                upsert insertOpportunityShare;
            }
        }
        catch(DMLException ex) {
            System.debug(ex);
        }
    }
    
    /**
    @Description: Insert opportunity line item records for the cloned Opportunity
    @Param1 :     List of opportunity line item.
    @Return:      Void.
    **/
    
    public void clonedOpportunityLineItemInsert (List <OpportunityLineItem> insertOpportunityLineItem) {
    
        try {
            if(insertOpportunityLineItem != null) {
                upsert insertOpportunityLineItem;
            }
        }
        catch(DMLException ex) {
            System.debug(ex);
        }
    }
    
    /**
    @Description: Insert sObject records
    @Param1:      List of sobject.
    @Return:      Void.
    **/
    
    public void insertSobjectShare(List<sObject> listInsertSobjectShare) { 
      
        try {
            if(listInsertSobjectShare != null && !listInsertSobjectShare.IsEmpty()) {    
                Database.insert(listInsertSobjectShare, false);
            }
        }
        catch(DMLException ex) {
            System.debug(ex);
        }
    }
    
    /**
    @Description: Delete sObject records
    @Param1:      List of sobject.
    @Return:      Void.
    **/
    
    public void deleteSobjectShare(List<sObject> listDeleteSobjShare) { 
       
        try {
            if((listDeleteSobjShare != null)&& !listDeleteSobjShare.IsEmpty()) {
                Database.delete(ListDeleteSobjShare, false);           
            }
        }
        catch(DMLException ex) {
            System.debug(ex);
        }
    }
    
    /**
    @Description: Retrieve the Master Opportunity records
    @Param1:      Set of opportunity ids.
    @Return:      Map of Opportunity id and it's corresponding records
    **/
    
    public Map<Id, Opportunity> getMasterOpportunity(Set<Id> setOppId) {
       
        Map<Id, Opportunity> mapOpportunityId = null;       
        try {
            if (setOppId != null) {
                mapOpportunityId = new Map<Id, Opportunity>([SELECT Id, OwnerId, CurrencyIsoCode, Sub_Opportunities_Total_Amounts__c, RecordTypeId FROM Opportunity WHERE Id in: setOppId AND RecordTypeId =:Label.M2O_Opportunity_Master_RecordType_ID]);
            }
        }
        catch(DMLException ex) {
            system.debug(ex);       
        }
        return mapOpportunityId;
    }
    
    /**
    @Description: Updates the Opportunity record
    @Param1:      List of opportunity
    @Return:      Void.
    **/
    
    public void updateOpportunity(List<Opportunity> ListToUpdateMasterOpportunity) {
        
        try {
            if((ListToUpdateMasterOpportunity !=null) && !ListToUpdateMasterOpportunity.IsEmpty()) {
                update ListToUpdateMasterOpportunity;                
            }
        }
        catch(DMLException ex) {
            System.debug(ex);
        }
    }
    
    public static List<Opportunity> retrieveAssociatedOpportunity(String accountId){
     
        List<Opportunity> listOpportunityResults;
        try {
            if(accountId!= null) {
               listOpportunityResults= [select AccountId, owner.IsActive from Opportunity where AccountId = :accountId];
               return listOpportunityResults;
            }   
            else {
               return null;
            }
         }
        catch(System.DmlException e){
        system.debug(e.getmessage());
        return null;
        }
    }
    /*
    @Description: Queries the OpportunityLineItem records
    @Param1:      Set of opportunity ids
    @Return:      OpportunityLineItem List.
    */
    public static List<OpportunityLineItem> getOpptyEODList(Set<Id> opportunityIdSet){
        List<OpportunityLineItem> opptyProdList = new List<OpportunityLineItem>();
        try {
            if(opportunityIdSet!= null && !opportunityIdSet.isEmpty()) {
                opptyProdList = [Select Id, Expected_Order_date__c, Opportunity.CloseDate from OpportunityLineItem where OpportunityId in : opportunityIdSet];
                return opptyProdList;
            }
            else {
               return null;
            }
        }
        catch(System.DmlException e){
            system.debug(e.getmessage());
            return null;
        }
        
    }
    
    /*
    @Description: Update the OpportunityLineItem records
    @Param1:      List of opportunityLineItem
    @Return:      Void.
    */
    public void updateOpptyProd(List<OpportunityLineItem> updateProdList, List<Opportunity> oppList){
        try {
            if(updateProdList!= null && !updateProdList.isEmpty()) {
               update updateProdList;
            }   
         }
        catch(System.DmlException e){
            for(Opportunity opp : oppList){
                if(e.getMessage().contains('Competitor_Name__c') && e.getMessage().contains('FIELD_VALIDATION_EXCEPTION')){
                    opp.addError('Please check the Competitor Name on Opportunity product');
                }
                else{
                    opp.addError('Please check the Opportunity data');
                }
            }
            system.debug('123Exception'+e.getmessage());
        }
    }
}