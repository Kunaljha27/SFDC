/**
@Classname :       M2O_OpportunityCloneService 
@Description :     This class is a bussiness logic class which is invoked from the controller to perform 
                   the clonning logic. After an user clicks on the Clone button, it creates a clone opportunity and
                   clones the related list- Opportunity team, Opportunity line item and Opportunity related list.
                   25/02/2015 - Change to open opportunity in Read-Only mode
@Author:           Somdev Bhattacharyya
@Last Modified:    13/11/2013
**/
public class M2O_OpportunityCloneService {
    M2O_OpportunityDAO dAOHelper = new M2O_OpportunityDAO(); 
    /** 
    @Description :This Method is used to extract the Fields from the fieldsets.This takes a list of fieldset member schema as parameter.
    @Param1:      list of fieldset member schema
    @Return type :String of fields
    **/
    public String fieldSetValue (List<Schema.FieldSetMember> fieldSetValue) {
    
        Map<String, Schema.FieldSetMember> mapFieldSchema = new Map<String, Schema.FieldSetMember>();
        String queriableFields ;
        queriableFields = null;
        if(fieldSetValue != null) {
            for (Schema.FieldSetMember sf : fieldSetValue) {                
                mapFieldSchema.put(sf.getFieldPath(), sf);
                if (queriableFields == null || queriableFields =='') {
                    queriableFields = sf.getFieldPath() + ',';   
                }
                else {
                    queriableFields += sf.getFieldPath() + ',';   
                }
            }
        }  
    return  queriableFields;
    }
    
    /**
    @Description : This is the bussiness logic method for opportunity clonning.Where the source opportunity id is passed as parameter the the required data is cloned into a new opportunity.
    @Param1      : Id of parent Opportunity.
    @Return type : void 
    **/
    public Opportunity cloneOpportunity(Id sourceOpportunityId) {
    
        List<Schema.FieldSetMember> listOpportunityFieldsToBeCloned = new List<Schema.FieldSetMember>();
        Opportunity clonedOpportunity = new Opportunity();
        String queriableFieldsOpportunity;
        Id Source = sourceOpportunityId;
        listOpportunityFieldsToBeCloned = SObjectType.Opportunity.FieldSets.M2O_Opp_Fields_To_Cloned.getFields();
        queriableFieldsOpportunity = fieldSetValue(listOpportunityFieldsToBeCloned);
        Opportunity opportunityQueryResult = new Opportunity();
        opportunityQueryResult = dAOHelper.getOpportunityRecord(queriableFieldsOpportunity,sourceOpportunityId);
        if(opportunityQueryResult.RecordTypeId !=label.M2O_Opportunity_Master_RecordType_ID) {
            opportunityQueryResult.Id = null;
            opportunityQueryResult.Local_Opportunity_Id__c = null; 
            //opportunityQueryResult.StageName= M2O_DataUtility.stageNameNone;
            opportunityQueryResult.ForecastCategoryName = M2O_DataUtility.forcastCategoryPipeline;  
                   
        }
        else {
            opportunityQueryResult.Id = null;
            opportunityQueryResult.Local_Opportunity_Id__c = null; 
            //opportunityQueryResult.StageName= M2O_DataUtility.stageNameNone;
        }
        clonedOpportunity = dAOHelper.clonedOpportunityInsert(opportunityQueryResult);
        return clonedOpportunity;
    }

    /**
    @Description : This is the bussiness logic method for OpportunityEcosystem clonning.Where the source opportunity id is passed as parameter the the required data is cloned into a new opportunity.
    @Param1      : Id of parent Opportunity.
    @Param2      : Newly cloned opportunity.
    @Return type : void 
    **/
    
    public void cloneOpportunityEcoSystem(Id sourceOpportunityId, Opportunity clonedOpportunity) {
    
        List<Schema.FieldSetMember> listOpportunityEcoSystemFieldToBeClone = new List<Schema.FieldSetMember>();
        List<Opportunity_Ecosystem__c> listCloneOpportunityEcoSystem = new List<Opportunity_Ecosystem__c>();
        String queriableFieldsOpportunityEcoSystem;
        listOpportunityEcoSystemFieldToBeClone = SObjectType.Opportunity_Ecosystem__c.FieldSets.Opp_EcoSys_clone.getFields();
        queriableFieldsOpportunityEcoSystem = fieldSetValue (listOpportunityEcoSystemFieldToBeClone);    
        listCloneOpportunityEcoSystem = dAOHelper.getOpportunityEcoSystem(queriableFieldsOpportunityEcoSystem,sourceOpportunityId);
        list<Opportunity_Ecosystem__c > listinsertOpportunityEcoSystem = new list<Opportunity_Ecosystem__c>();
        Opportunity_Ecosystem__c opportunityEcoSystem;
        if(listCloneOpportunityEcoSystem != null) {
            for(Integer j = 0; j < listCloneOpportunityEcoSystem.size(); j++) {        
                opportunityEcoSystem = new Opportunity_Ecosystem__c();
                opportunityEcoSystem.Opportunity__c = clonedOpportunity.Id;
                opportunityEcoSystem.Account__c = listCloneOpportunityEcoSystem.get(j).Account__c;
                opportunityEcoSystem.Account_role__c = listCloneOpportunityEcoSystem.get(j).Account_role__c;
                listinsertOpportunityEcoSystem.add(opportunityEcoSystem);
            }
        }        
        dAOHelper.clonedOpportunityEcoSystemInsert(listinsertOpportunityEcoSystem);
    }
    
    /**
    @Description : This is the bussiness logic method for opportunity team member clonning, where the source opportunity 
                   id is passed as parameter the the required data is cloned into a new opportunity.
    @Param1      : Id of parent Opportunity.
    @Param2      : Newly cloned opportunity.
    @Return type : void 
    **/
    
    public void cloneOpportunityTeamMember(Id sourceOpportunityId, Opportunity clonedOpportunity){
        
        List<OpportunityShare> opptyShare = new List<OpportunityShare>();
        Map<id, OpportunityShare> mapUserIdOpportunityShare = new Map<id, OpportunityShare>();
        List<OpportunityTeamMember> listOpportunityTeamMember = new List<OpportunityTeamMember> ();
        listOpportunityTeamMember = dAOHelper.getOpportunityTeamMember(sourceOpportunityId);
        opptyShare = dAOHelper.getOpportunityShare(sourceOpportunityId);
        if (opptyShare != null ) {
            for(OpportunityShare  opportunityShare : opptyShare) {
                mapUserIdOpportunityShare.put( opportunityShare.UserOrGroupId ,  opportunityShare);
            }
        }
        List<OpportunityShare> listNewOpportunityShare = new List<OpportunityShare>();
        List <OpportunityTeamMember> listInsertOpportunityTeamMember = new List<OpportunityTeamMember>();
        OpportunityTeamMember newOpportunityTeamMember;
        if(listOpportunityTeamMember != null) {
            for(OpportunityTeamMember OpptyMem : listOpportunityTeamMember) {  
              try{
               if(mapUserIdOpportunityShare.get(OpptyMem.UserId)!=null){
                newOpportunityTeamMember = new OpportunityTeamMember();
                OpportunityShare  opportunityShare = new OpportunityShare();         
                 opportunityShare.UserOrGroupId = OpptyMem.UserId;
                 opportunityShare.OpportunityId =  clonedOpportunity.Id;
                 opportunityShare.OpportunityAccessLevel =  mapUserIdOpportunityShare.get(OpptyMem.UserId).OpportunityAccessLevel;
                newOpportunityTeamMember.TeamMemberRole = OpptyMem.TeamMemberRole;
                newOpportunityTeamMember.UserId = OpptyMem.UserId;
                newOpportunityTeamMember.OpportunityId = clonedOpportunity.Id;
                newOpportunityTeamMember.Email_Address__c = OpptyMem.Email_Address__c;
                newOpportunityTeamMember.Functional_Role__c = OpptyMem.Functional_Role__c;
                newOpportunityTeamMember.Quoting_System__c = OpptyMem.Quoting_System__c;
                listInsertOpportunityTeamMember.add(newOpportunityTeamMember);
                listNewOpportunityShare.add( opportunityShare);
                }
                }catch(Exception ex){
                 OpptyMem.addError('Inactive user cannot be cloned');
                }
            }
        }
        dAOHelper.clonedOpportunityTeamMemberInsert(listInsertOpportunityTeamMember,listNewOpportunityShare);
    }
    
    /**
    @Description : This is the bussiness logic method for opportunity line item clonning.Where the source opportunity id is passed as parameter the the required data is cloned into a new opportunity.
    @Param1      : Id of parent Opportunity.
    @Param2      : Newly cloned opportunity.
    @Return type :void 
    **/
    
    public String cloneOpportunityLineItem(Id sourceOpportunityId, Opportunity clonedOpportunity) {
        String fullFileURL;
        List<OpportunityLineItem> listToBeClonedOpportunityLineItem = new List<OpportunityLineItem>();
        List<OpportunityLineItem> listOpportunityLineItem = new List<OpportunityLineItem>();
        listToBeClonedOpportunityLineItem = dAOHelper.getOpportunityLineItem(sourceOpportunityId);
        OpportunityLineItem newOpportunityLineItemEntry;
        if(listToBeClonedOpportunityLineItem != null) {
            for (Integer j=0; j<listToBeClonedOpportunityLineItem.size();j++) {
        
                newOpportunityLineItemEntry = new OpportunityLineItem();
                newOpportunityLineItemEntry.PricebookEntryId = listToBeClonedOpportunityLineItem.get(j).PricebookEntryId;
                newOpportunityLineItemEntry.Quantity = listToBeClonedOpportunityLineItem.get(j).Quantity;
                newOpportunityLineItemEntry.ServiceDate = listToBeClonedOpportunityLineItem.get(j).ServiceDate;
                newOpportunityLineItemEntry.Total_Expected_Order_Value__c = listToBeClonedOpportunityLineItem.get(j).Total_Expected_Order_Value__c;
                newOpportunityLineItemEntry.Expected_POS_order_date__c = listToBeClonedOpportunityLineItem.get(j).Expected_POS_order_date__c;
                newOpportunityLineItemEntry.TotalPrice = listToBeClonedOpportunityLineItem.get(j).TotalPrice;
                newOpportunityLineItemEntry.OpportunityId = clonedOpportunity.Id;
                listOpportunityLineItem.add(newOpportunityLineItemEntry);
                
            }
        }
        
        dAOHelper.clonedOpportunityLineItemInsert(listOpportunityLineItem);
        //fetching the base url of the created opportunity edit page and adding the cloned opportunity id to it.
        if(clonedOpportunity.recordtypeID != '012d0000000hAvL') {
            fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + clonedOpportunity.Id +'/e?retURL=%2F'+clonedOpportunity.Id;
        } else {
            fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + clonedOpportunity.Id;// +'/e?retURL=%2F'+clonedOpportunity.Id;            
        }
        return fullFileURL;
    }
}