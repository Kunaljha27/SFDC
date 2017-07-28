/**
@Classname :       M2O_CaptureDeleteRecords 
@Description :     
@Author:           Vishal Kashyap
@Last Modified:    11/15/2013
**/

public class M2O_CaptureDeleteRecordsService {    
    /**
    @Description: Captures the deleted record to Delete Notification Object
    @Return:      null
    **/
    public static void captureOnDelete(List<sObject> deletedList) {
        List<Delete_Notifications__c> recordToBeInserted = new List<Delete_Notifications__c>();
        Map<ID,String> recordTypeInfo = new Map<ID,String>();    
        Lead  leadRecord = new Lead();
        Opportunity oppRecord = new Opportunity();
        String name;
        OpportunityLineItem oppLineItemRecord = new OpportunityLineItem();
        Opportunity_Ecosystem__c oppEcoSystemRecord = new Opportunity_Ecosystem__c();
        String recordTypeName;        
        String objType = deletedList.getSObjectType().getDescribe().getName();
    
        for(recordtype recordTypeRec:[Select ID, Name from recordType]) {
            recordTypeInfo.put(recordTypeRec.ID, recordTypeRec.Name);
        }

        for(sObject deletedRecord:deletedList) {
            if(objType == 'Lead') {
                leadRecord = (Lead)deletedRecord;
                name =leadRecord.Salutation + ' ' + leadRecord.firstName+ ' ' + leadRecord.lastName;
                recordTypeName=recordTypeInfo.get(leadRecord.recordTypeID);
            }
            if(objType == 'Opportunity') {
                oppRecord = (Opportunity)deletedRecord;
                name =oppRecord.Name;
                recordTypeName=recordTypeInfo.get(oppRecord.recordTypeID);
            }
            if(objType == 'OpportunityLineItem') {
                oppLineItemRecord = (OpportunityLineItem)deletedRecord;
                name =oppLineItemRecord.PricebookEntry.Product2.Name;
                recordTypeName=recordTypeInfo.get(oppRecord.recordTypeID);
            }
            if(objType == 'Opportunity_Ecosystem__c') {
                oppEcoSystemRecord = (Opportunity_Ecosystem__c)deletedRecord;
                name =oppEcoSystemRecord.Name;
                recordTypeName=recordTypeInfo.get(oppRecord.recordTypeID);
            }
            recordToBeInserted.add(new Delete_Notifications__c( Record_Type_Name__c= recordTypeName , Record_Id__c=deletedRecord.ID, Record_Name__c=name , User__c=userinfo.getUserID() , Object__C=objType, Deleted_Date_Time__c=system.now()));
            
        }
        M2O_CaptureDeleteRecordsDAO.insertDeletedRecord(recordToBeInserted);       
    }
}