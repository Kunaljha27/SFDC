/**
@Classname :       M2O_OppRelatedObjectSharingService
@Description :     It does the following operation:    
                   1. Shares record of related object(e.g. Sales Order, Quotation) with Opportunity Owner, Sales team member
                      whenever a new Sales team is inserted or a opportunity owner is changed.
                   2. Shares record with Opportunity Owner and Sales team whenever a related record(e.g. Sales Order/Quotation
                      is inserted).
                   3. Deletes share record on Sales order or Quotation whenever for an old Opportunity Owner.
                   4. Deletes the share record of Opportunity Team on related object whenever an Opportunity Owner 
                      is changed, with Keep Opportunity checkbox unchecked.
                   As of now the related objects are Sales Order and Quotation. In future more objects can be added.
                   The related objects are stored in Custom setting: M2O_ST_Visibility_Objects__c.
@Author:           Piyali Saha/Somdev Bhattacharyya
@Last Modified:    14/12/2013
**/
public class M2O_OppRelatedObjectSharingService {
    
    @TestVisible List<M2O_ST_Visibility_Objects__c> customSettingValues = M2O_ST_Visibility_Objects__c.getall().values(); 
    Map<String, String> mapCustomSettingValues = new Map<String, String>();
    /*insert sharing for sales team*/
    /**
    @Description: Calculate sharing of Sales Team on Sales Order and Quotation records. Whenever a Sales team record is inserted, it
                  retrieves the Sales order and quotation records of the Opportunity for which the Sales team is added, and
                  gives access to Sales team member for those Sales Order and Quotation records.
    @Param1:      List Of SObjects.
    @Return:      null
    **/
    
    public void calculateSharingOfSalesTeam(List<sObject> listOfRecords) {  
 
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        Set<Id> setOpportunityId = new Set<Id>();   
        Map<Id, Set<Id>> mapOpportunitySalesTeamId = new Map<Id, Set<Id>>();    
        List<sObject> listSObjectShare = new List<sObject>();       
        Set<Id> setSalesTeamId;
        Set<Id> setUserId = new Set<Id>();
        Map<Id, User> mapUserIdType;
        List<Sobject> listSObjectValues;
        if(listOfRecords != null && !listOfRecords.isEmpty()) {
            
            for(sObject sObj : listOfRecords) {
                setUserId.add((Id)sObj.get('UserId'));
            }
            if(setUserId != null) {
                mapUserIdType = queryDMLHelper.getUserRecords(setUserId);
            }
            for(sObject sObj : listOfRecords) {          
                setSalesTeamId = new Set<Id>();
                if(mapOpportunitySalesTeamId.get((Id)sObj.get('OpportunityId'))== null && mapUserIdType.get((Id)sObj.get('UserId')).userType != M2O_DataUtility.partnerUserType) {            
                    setSalesTeamId.add((Id)sObj.get('UserId'));
                    mapOpportunitySalesTeamId.put((Id)sObj.get('OpportunityId'), setSalesTeamId);
                }
                else {
                    if(mapUserIdType.get((Id)sObj.get('UserId')).userType != M2O_DataUtility.partnerUserType) {
                        mapOpportunitySalesTeamId.get((Id)sObj.get('OpportunityId')).add((Id)sObj.get('UserId'));
                    }
                }           
            setOpportunityId.add((Id)sObj.get('OpportunityId'));       
            }       
            /*Retrives the records for which the Sales team should gain access*/
            listSObjectValues = getRelatedRecords(setOpportunityId);  
            sObject sObjectInsert;    
            Schema.sObjectType sObjectName;
            String objectName;
            for(sObject sObj : listSObjectValues) {           
                sObjectName = sObj.getSObjectType();
                objectName = String.valueOf(sObjectName);  
                if(mapOpportunitySalesTeamId.get((Id)sObj.get(mapCustomSettingValues.get(objectName))) != null) {
                    for(Id salesTeamId: mapOpportunitySalesTeamId.get((Id)sObj.get(mapCustomSettingValues.get(objectName)))) {   
                        //Creating a Sobject instance of the object.
                        sObjectInsert = createSObjectInstance(sObj);                                
                        sObjectInsert.put('AccessLevel',M2O_DataUtility.accesEdit);
                        sObjectInsert.put('ParentID',(Id)sObj.get('Id'));
                        sObjectInsert.put('UserOrGroupId', salesTeamId);
                        listSObjectShare.add(sObjectInsert);   
                    }
                }
            }
            if(listSObjectShare != null) {
                //insert the sharing of Sales team member to related object share
                queryDMLHelper.insertSobjectShare(listSObjectShare); 
            }
        }    
    }
      
    /*delete sharing for sales team*/
    /**
    @Description: Delete sharing of Sales Team member on Sales Order and Quotation records whenever a Sales Team is deleted. Retrieves the 
                  share records of Sales team member on related objects and deletes it from the share object.
    @Param1:      List Of SObjects.
    @Return:      null
    **/
    public void deleteSharingForSalesTeam(List<sObject> listOfRecords) {  
       M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
       Set<Id> setOpportunityId = new Set<Id>();
       Set<Id> setUserId = new Set<Id>();   
       Set<Id> setSObjectId = new Set<Id>();   
       if(listOfRecords != null && !listOfRecords.isEmpty()) {
 
           for(sObject sObj: listOfRecords) {                      
               setUserId.add((Id)sObj.get('UserId'));
               setOpportunityId.add((Id)sObj.get('opportunityId'));           
           } 
           /*Retrives the records for which the Sales team should loose access*/   
           List<sObject> listSObjectValue = getRelatedRecords(setOpportunityId); 
           for(sObject sObj : listSObjectValue) {
               setSObjectId.add((Id)sObj.get('Id'));
           } 
           /*Get shared records of related object for Sales team Opportunity owner*/
           List<sObject> lstsObjShrVal = getSharedRecordsOfSObject(setUserId, setSObjectId);    
           if(lstsObjShrVal != null) {        
               //delete the sharing of Sales team member from related object share
               queryDMLHelper.deleteSobjectShare(lstsObjShrVal);       
           }
       }
   }
    
    /*delete sharing on opty owner*/
    /**
    @Description: Delete sharing of Opportunity Owner on related objects for an Opportunity. Retrieves the shared records 
                  of old Opportunity Owner on related objects and deletes it from the share object of the related object.
    @Param1:      List Of SObjects.
    @Return:      null
    **/
    public void deleteSharingOfOpportunityOwner(List<sObject> listOfRecords) {
    
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        List<sObject> listSObjectRecord;
        Set<Id> setOpportunityId = new Set<Id>();
        List<sObject> listSObjectShareValue;
        Set<Id> setUserId = new Set<Id>();
        Set<Id> setSObjectId = new Set<Id>();    
        if(listOfRecords != null && !listOfRecords.isEmpty()) {   
            for(sObject sObj : listOfRecords) { 
                setOpportunityId.add((Id)sObj.get('Id'));
                setUserId.add((Id)sObj.get('ownerId'));
            }
            /*Retrives the records for which the Sales team should loose access*/
            listSObjectRecord = getRelatedRecords(setOpportunityId);
            for(sObject sObj : listSObjectRecord) {
                setSObjectId.add((Id)sObj.get('Id'));
            }
            /*Get shared records of related object for Sales team/ Opportunity owner*/ 
            listSObjectShareValue = getSharedRecordsOfSObject(setUserId, setSObjectId);        
            if(listSObjectShareValue != null) {      
                //delete the sharing of Opportunity owner from related object share  
                queryDMLHelper.deleteSobjectShare(listSObjectShareValue);
            }
        }
    }
    
    /*insert sharing for opty owner*/
    /**
    @Description: Insert sharing of Opportunity Owner on Sales Order and Quotation share records. Whenever an Opportunity
                  Owner is changed then sharing on related objects is calculated for the owner.
    @Param1:      List Of SObjects.
    @Return:      null
    **/
    public void calculateSharingForOpportunityOwner(List<sObject> listOfRecords) {
        
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        Set<Id> setOpportunityId = new Set<Id>();
        List<sObject> listSObjectShare = new List<sObject>();
        Map<Id, Id> mapOpportunityOwnerId = new Map<Id, Id>();
        List<Sobject> listSObjectValues;
        if(listOfRecords != null && !listOfRecords.isEmpty()) {         
            for(sObject sObj : listOfRecords) {
                mapOpportunityOwnerId.put((Id)sObj.get('Id'), (Id)sObj.get('ownerId'));
                setOpportunityId.add((Id)sObj.get('Id'));
            } 
            /*Retrives the records for which the Sales team should gain access*/
            listSObjectValues = getRelatedRecords(setOpportunityId);
            Schema.sObjectType sObjectName;
            String objectName;
            sObject sObjectInsert;
            for(sObject sObj : listSObjectValues) {
                sObjectName = sObj.getSObjectType();
                objectName = String.valueOf(sObjectName); 
                //Creating a Sobject instance of the object.   
                sObjectInsert = createSObjectInstance(sObj);
                sObjectInsert.put('AccessLevel',M2O_DataUtility.accesEdit);
                sObjectInsert.put('ParentID',(Id)sObj.get('Id'));
                sObjectInsert.put('UserOrGroupId', mapOpportunityOwnerId.get((Id)sObj.get(mapCustomSettingValues.get(objectName))));
                listSObjectShare.add(sObjectInsert);
            }
            if(listSObjectShare != null) {  
                //insert the sharing of Opportunity owner to related object share
                queryDMLHelper.insertSobjectShare(listSObjectShare);    
            }
        }    
    }       
    
    /*calculate sharing of Sales team on Sales Order record whnever an Opp owner is changed*/
    /**
    @Description: Calculate sharing of Sales team on Deal support request, Sales Order and Quotation record whenever an 
                  Opportunity owner is changed by taking the set of opportunity and list of Sobject record as parameter.
    @Param1:      Set of Opportunity Id.
    @Param2:      List Of SObjects.
    @Return:      null
    **/
    public void deleteSalesTeamShare(Set<Id> setOpportunityId, List<sObject> listOfRecords) { 
        
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        List<OpportunityTeamMember> listOpportunityTeamMember;
        Map<Id, OpportunityTeamMember> mapOpportunityTeamMember = new Map<Id, OpportunityTeamMember>();
        Set<Id> deletedOpporunityTeam = new Set<Id>();
        Map<Id, Id> mapOpportunityOwnerId = new Map<Id, Id>();
        Set<Id> setSObjectId = new Set<Id>();
        List<sObject> listDeleteSharedRecord = new List<sObject>();
        Map<Id, Id> sObjectOpportunityID = new Map<Id, Id>();
        Schema.sObjectType sObjectName;
        List<sObject> listSObjectRecord;
        List<sObject> listSObjectShareValue;
        if(listOfRecords != null && setOpportunityId != null && !listOfRecords.isEmpty()) {             
            //query Sales team record of Opportunity
            List<OpportunityTeamMember> listOpportunityTeam = queryDMLHelper.getListOpportunityTeam(setOpportunityId);
            String stringSObjectName;
            if(listOpportunityTeam != null && !listOpportunityTeam.isEmpty()) {
                for(OpportunityTeamMember salesTeamMember : listOpportunityTeam) {         
                    listOpportunityTeamMember = new List<OpportunityTeamMember>();
                    if(mapOpportunityTeamMember.get(salesTeamMember.opportunityId)== null) {            
                        listOpportunityTeamMember.add(salesTeamMember);
                        mapOpportunityTeamMember.put(salesTeamMember.opportunityId, salesTeamMember); 
                    }
                    else {               
                         mapOpportunityTeamMember.put(salesTeamMember.opportunityId, salesTeamMember);            
                    }                
                }
            }                
            for(sObject sObj : listOfRecords) {
                mapOpportunityOwnerId.put((Id)sObj.get('Id'), (Id)sObj.get('ownerId'));
            } 
            //iteration to check which opportunity doesnot have sales team member associated with it
            for(Id opportunityID : setOpportunityId) {
                if(mapOpportunityTeamMember.get(opportunityID) == null) { 
                    deletedOpporunityTeam.add(opportunityID);
                }
            }
            //get Sales Order and Quotation records for Opportunities
            listSObjectRecord = getRelatedRecords(deletedOpporunityTeam); 
            //Iterate and store Id of the related object and opportunity Id
            for(sObject sObj : listSObjectRecord) {
                // stores the Id of the related records
                setSObjectId.add((Id)sObj.get('Id'));
                sObjectName = sObj.getSObjectType(); 
                stringSObjectName = String.valueOf(sObjectName);
                sObjectOpportunityID.put((Id)sObj.get('Id'), (Id)sObj.get(mapCustomSettingValues.get(stringSObjectName)));
            } 
            //get the shared records with Opportunity team member
            listSObjectShareValue = getSharedRecordForSalesTeam(setSObjectId); 
            if(listSObjectShareValue != null) {
                for(sObject sObj : listSObjectShareValue) {            
                    if(mapOpportunityOwnerId.get(sObjectOpportunityID.get((Id)sObj.get('ParentId'))) != sobj.get('UserOrGroupId')) {
                        if(sobj.get('RowCause') != 'Owner') {
                            listDeleteSharedRecord.add(sobj);
                        }
                    }
                }
            }                 
            if(listDeleteSharedRecord != null) {
            //deleting sharing of the team member from related object share
                queryDMLHelper.deleteSobjectShare(listDeleteSharedRecord);    
            }
        }     
    }
    
    /*insert sharing for sales team and opty owner*/
    /**
    @Description: Insert sharing of Opportunity Owner and Sales Team member whenever related Object's record will be 
                  created. It retrieves the Sales team member and oppotunity owner for the opportunity on which the
                  related records are added and then inserts the user to related object's sharing object.
                  Related 
    @Param1:      List Of SObjects.
    @Return:      null
    **/
    public void calculateSharingOfSobject(List<sObject> listOfRecords) {  
        
        if(listOfRecords != null && !listOfRecords.isEmpty()) {
            M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
            Set<Id> setOpportunityId = new Set<Id>();
            List<sObject> listSObjectShare = new List<sObject>();  
            Set<Id> setSalesTeamId;
            if (customSettingValues != null) {
                for(M2O_ST_Visibility_Objects__c salesTeamVisblty : customSettingValues) {           
                    mapCustomSettingValues.put(salesTeamVisblty.Obj_API_Name__c , salesTeamVisblty.Relationship_with_opportunity__c);
                }
            }
            String objectName;
            Schema.sObjectType sObjectName;
            for(sObject sObj : listOfRecords) {             
                sObjectName = sObj.getSObjectType();
                objectName = String.valueOf(sObjectName);
                setOpportunityId.add((Id)sObj.get(mapCustomSettingValues.get(objectName)));
            } 
            Map<Id, Opportunity> mapOpportunityOwnerId;
            List<OpportunityTeamMember> listOpportunityTeamMember;
            if(setOpportunityId != null) {
                // get the map of Opportunity Id and it's corresponding owner Id
                mapOpportunityOwnerId = queryDMLHelper.getOpportunity(setOpportunityId);    
                system.debug('Opportunity and its owner'+ mapOpportunityOwnerId );
                // get the list of Opportunity team members for a set of Opportunities      
                listOpportunityTeamMember = queryDMLHelper.getListOpportunityTeam(setOpportunityId); 
            }
            Map<Id, Set<Id>> mapOpportunitySalesTeamId = new Map<Id, Set<Id>>();        
            if(listOpportunityTeamMember != null) {
            for(OpportunityTeamMember salesTeamMember : listOpportunityTeamMember) {
                setSalesTeamId = new Set<Id>();
                if(mapOpportunitySalesTeamId.get((Id)salesTeamMember.get('OpportunityId'))== null) {            
                    setSalesTeamId.add((Id)salesTeamMember.get('UserId'));
                    mapOpportunitySalesTeamId.put((Id)salesTeamMember.get('OpportunityId'), setSalesTeamId);
                }
                else {
                    mapOpportunitySalesTeamId.get((Id)salesTeamMember.get('OpportunityId')).add((Id)salesTeamMember.get('UserId'));
                }
            }
            }   
            sObject sObjectInsert;
            for(sObject sObj : listOfRecords) { 
            //Creating a Sobject instance of the object. 
                sObjectInsert = createSObjectInstance(sObj);      
                sObjectInsert.put('AccessLevel',M2O_DataUtility.accesEdit);
                sObjectInsert.put('ParentID',(Id)sObj.get('Id'));
                system.debug('Opportunity related information'+sObj);
                system.debug('Map value01'+(Id)sObj.get(mapCustomSettingValues.get(objectName)));
                system.debug('Map Value02'+mapOpportunityOwnerId.get((Id)sObj.get(mapCustomSettingValues.get(objectName))));
                sObjectInsert.put('UserOrGroupId', (Id)mapOpportunityOwnerId.get((Id)sObj.get(mapCustomSettingValues.get(objectName))).ownerId);
                listSObjectShare.add(sObjectInsert);
                if(mapOpportunitySalesTeamId.get((Id)sObj.get(mapCustomSettingValues.get(objectName))) != null) {
                    for(Id salesTeamId: mapOpportunitySalesTeamId.get((Id)sObj.get(mapCustomSettingValues.get(objectName)))) {
                    //Creating a Sobject instance of the object.    
                        sObjectInsert = createSObjectInstance(sObj);               
                        sObjectInsert.put('AccessLevel',M2O_DataUtility.accesEdit);
                        sObjectInsert.put('ParentID',(Id)sObj.get('Id'));
                        sObjectInsert.put('UserOrGroupId', salesTeamId);
                        listSObjectShare.add(sObjectInsert);
                    }
                }
            }  
            if(listSObjectShare != null) {
                queryDMLHelper.insertSobjectShare(listSObjectShare);  
            }
        }
    }
    
    /*generic method*/
    /**
    @Description: Create sObject intance of the object
    @Param1:      SObjects.
    @Return:      sObject
    **/
    private sObject createSObjectInstance(sObject sobjName) {
        
        Schema.sObjectType sObjctName = sobjName.getSObjectType();        
        String objectName = String.valueOf(sObjctName);       
        objectName = objectName.substringBefore('__c');
        objectName = objectName + '__Share';
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        return objType.newSObject();
    }
       
    /**
    @Description: Get related records of Opportunity, i.e. Sales order , Quotation records, Deal support request records. Fetches the related object 
                  records of an Opportunity for which opportunity owner is changed and Sales Team is added and 
                  returns the list of records of the related object.
    @Param1:      Set Of Opportunity Id.    
    @Return:      sObject
    **/
    
    private List<Sobject> getRelatedRecords(Set<Id> setOpportunityId) {
        
        List<sObject> listSObjectValues = new List<sObject>();
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        List<Opportunity> listOpportunity;
        if(setOpportunityId != null) {          
            String query;
            query = 'SELECT Id ';
            if(customSettingValues != null) {
                for(M2O_ST_Visibility_Objects__c salesTeamVisblty: customSettingValues) {
                    query += ', (SELECT ' + salesTeamVisblty.Relationship_with_opportunity__c + ', Id FROM ' + salesTeamVisblty.name +') ';
                        mapCustomSettingValues.put(salesTeamVisblty.Obj_API_Name__c , salesTeamVisblty.Relationship_with_opportunity__c);
                }
            }
            query = query + ' FROM Opportunity where Id in: setOpportunityId';
            listOpportunity = queryDMLHelper.getRelatedRecordsOpportunity(query, setOpportunityId);
            if(customSettingValues != null) { 
                for(M2O_ST_Visibility_Objects__c visibilityObject : customSettingValues) {           
                    for(Opportunity opp : listOpportunity) { 
                        if(opp.getSObjects(visibilityObject.name) != null) {
                            listSObjectValues.addall(opp.getSObjects(visibilityObject.name));
                        }
                    }            
                }
            }           
        }
        return listSObjectValues;
    }
    /**
    @Description: Get shared records of related object for Sales team/ Opportunity owner. It retrieves the related object
                  name from the custom setting M2O_ST_Visibility_Objects__c and queries the shared records of the 
                  opportunity to which the Sales team/ Opportunity owner is added by taking the Set od user id and set of sobject ids as parameter.
    @Param1:      Set of User Id.
    @Param2:      set Of SObjects.
    @Return:      sObject
    **/    
    private List<sObject> getSharedRecordsOfSObject(Set<Id> setUserId, Set<Id> setSObjectId) {
        
        List<sObject> listSObjectValues;
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        List<sObject> listShareObjectRecords = new List<sObject>();
        String query;
        String objectName;
        if(setUserId != null && setSObjectId != null) {
            if(customSettingValues != null) {
                for(M2O_ST_Visibility_Objects__c salesTeamVisblty: customSettingValues) {                  
                    objectName = salesTeamVisblty.Obj_API_Name__c;
                    objectName = objectName.removeEnd('__c');
                    objectName = objectName + '__Share';
                            
                    query = 'Select Id, UserOrGroupId, ParentId, RowCause From ' + objectName +' Where ParentId in: setSObjectId and UserOrGroupId in: setUserId ';
                    //Here the Id, UserOrGroupId, ParentId, RowCause values of the records as fetched for specific ParentId and UserOrGroupId.
                    listSObjectValues = queryDMLHelper.getSharedRecordsOfSObject(query, setSObjectId, setUserId);
                    if(listSObjectValues != null && !listSObjectValues.isEmpty()) {
                        listShareObjectRecords.addall(listSObjectValues);
                    }
                    
                }
            }           
        }
        return listShareObjectRecords;
    }
    /**
    @Description: Get shared records of related object for Sales team. It retrieves only the records from the shared
                  objects which is shared with the Sales team for that Opportunity by taking the set of ids of the related records as Parameter..
    @Param1:      List Of ID of SObjects.
    @Return:      sObject
    **/ 
    private List<sObject> getSharedRecordForSalesTeam(Set<Id> setSObjectId) {
        
        List<sObject> listSObjectValues;
        M2O_OpportunityDAO queryDMLHelper = new M2O_OpportunityDAO();
        List<sObject> listShareObjectRecords = new List<sObject>();
        String query;
        String objectName;
        if(setSObjectId != null) {
            //here the oppShare method of M2O_DataUtility class is invoked to get the acess of the record.
            String rowcauseType = M2O_DataUtility.oppShare;
            if(customSettingValues != null) {
                for(M2O_ST_Visibility_Objects__c salesTeamVisblty: customSettingValues) {                  
                    objectName = salesTeamVisblty.Obj_API_Name__c;
                    objectName = objectName.removeEnd('__c');
                    objectName = objectName + '__Share';  
                        String var = M2O_DataUtility.shareManual;
                        
                        if(salesTeamVisblty.Objects_with_manual_share__c == false) {                             
                        query = 'Select Id, UserOrGroupId, RowCause, ParentId From ' + objectName +' Where ParentId in: setSObjectId AND RowCause = '+ M2O_DataUtility.shareManual;
                        system.debug('Query AM I'+query);
                        //get the shared record of the related objects where rowcause = manual
                        listSObjectValues = queryDMLHelper.getSharedRecordsOfSObject(query, setSObjectId);
                        if(listSObjectValues != null && !listSObjectValues.isEmpty()) {
                            listShareObjectRecords.addall(listSObjectValues);
                        }
                    }
                }
            }            
        }
        return listShareObjectRecords;
    }
}