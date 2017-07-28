/**
@Classname :       M2O_DSRCloneService 
@Description :     This class is a bussiness logic class which is invoked from the controller to perform 
                   the clonning logic. After an user clicks on the Clone button, it creates a clone Deal Support Request (DSR) and
                   clones the related list- Notes and Attachment.
@Author:           Somdev Bhattacharyya
@Last Modified:    08/05/2014
**/
public class M2O_DSRCloneService {
      
    /**
    @Description : This is the bussiness logic method for opportunity clonning.Where the source opportunity id is passed as parameter the the required data is cloned into a new opportunity.
    @Param1      : Id of parent DSR.
    @Return type : string 
    **/
    public String cloneDSR(Id sourceDSRId) {
        M2O_OpportunityCloneService fieldsetHelper = new M2O_OpportunityCloneService();
        List<Schema.FieldSetMember> listDSRFieldsToBeCloned = new List<Schema.FieldSetMember>();
        Deal_Support_Request_del__c clonedDSR = new Deal_Support_Request_del__c();
        String queriableFieldsDSR;
        Id Source = sourceDSRId;
        List<Note> noteList = new List<Note>();
        List<Attachment>attachmentList = new List<Attachment>();
        listDSRFieldsToBeCloned = SObjectType.Deal_Support_Request_del__c.FieldSets.M2O_field_set_for_DSR_clone.getFields();
        //Method calling from OpportunityCloneService class for getting field set values..
        queriableFieldsDSR = fieldsetHelper.fieldSetValue(listDSRFieldsToBeCloned);
        M2O_OpportunityDAO dAOHelper = new M2O_OpportunityDAO();
        Deal_Support_Request_del__c dSRQueryResult = new Deal_Support_Request_del__c();
        //Method calling to query out Source DSR data..
        dSRQueryResult = dAOHelper.getDSRRecord(queriableFieldsDSR,sourceDSRId);
        //Method calling to query out Source DSR note data..
        List<Note> noteQueryResult= dAOHelper.getNoteRecord(sourceDSRId);
        //Method calling to query out Source DSR attachment data..
        List<Attachment> attachmentQueryResult = dAOHelper.getAttachmentRecord(sourceDSRId);
        dSRQueryResult.Id = null;
        dSRQueryResult.Deal_Support_Request__c = sourceDSRId;
        clonedDSR = dAOHelper.clonedDSRInsert(dSRQueryResult);
        Note noteRecord = new Note();
        For(Note noteRec :noteQueryResult) {
            noteRecord = new Note();
            noteRecord.ParentId =clonedDSR.Id;
            noteRecord.Title= noteRec.Title;
            noteRecord.Body=noteRec.Body;
            noteRecord.OwnerId = noteRec.OwnerId;
            noteList.add(noteRecord);
        }
        Attachment attachmentRecord = new Attachment();
        For(Attachment attachmentRec :attachmentQueryResult) {
            attachmentRecord = new Attachment();
            attachmentRecord.ParentId =clonedDSR.Id;
            attachmentRecord.Body=attachmentRec.Body;
            attachmentRecord.OwnerId = attachmentRec.OwnerId;
            attachmentRecord.Name = attachmentRec.Name;
            attachmentRecord.Description = attachmentRec.Description;
            attachmentList.add(attachmentRecord);
        }
        //Method for inserting the notes
        dAOHelper.clonedNoteInsert(noteList);
        //Methods for inserting the attachments
        dAOHelper.clonedAttachmentInsert(attachmentList);
        String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + clonedDSR.Id +'/e?retURL=%2F'+clonedDSR.Id;
        return fullFileURL;
    }
}