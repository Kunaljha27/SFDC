/**
* @ClassName         : M2O_SAPAttachmentComponentDAO
* @Description       : This class is the DOA class of M2O_SAPAttachmentComponentController.This class performes the database related activities of the component
* @Author            : Albin Deni Arul
* @Last Modified     : 26/11/2013
* @Discussionpoints  : No Information
*/
public with sharing class M2O_SAPAttachmentComponentDAO{
    /**
    * @Description : This method retrive the attachments related to that Strategic Account Plan
    * @param       : Attachment Id
    * @return      : list of Attachments
    **/
    public list<Attachment> retriveAttachmentList(Id attachmentID) {  
        try { 
            return([select id,name,Body,lastmodifieddate,lastmodifiedby.name,createdby.name from attachment where ParentId=:attachmentID]);
        } catch(Exception ex) {
            system.debug('Attachment retrieval failed : '+ ex);
            return null;
        }
    }
    /**
    * @Description : This method retrives the current user accessing the object
    * @param1      : Strategic Account Plan Id (Parent Id)
    * @param2      : Current User Id
    * @return      : UserRecordAccess record
    **/
     public UserRecordAccess retriveUserAccess(Id attachmentID, Id currentUser) {  
         try {
            return([SELECT RecordId,HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUser AND RecordId = :attachmentID limit 1]);
        } catch(Exception ex) {
            system.debug('User access retrieval failed : '+ ex);
            return null;
        }
    }
    /**
    * @Description : This method inserts the attachment record to the parent SAP
    * @param       : Attachment record
    * @return      : None
    **/
    public void saveAttachment(Attachment attachmentRecord) {
        try {
            insert attachmentRecord;
        }
        catch(Exception ex) {
            system.debug('Attachment saveing failed : '+ ex);
        }
    }
    /**
    * @Description : This method deletes the attachment record from database
    * @param       : Attachment record
    * @return      : None
    **/
    public void deleteAttachment(Attachment attachmentRecord) {
        try {
            delete attachmentRecord;
        }
        catch(Exception ex) {
           system.debug('Attachment deletion failed : '+ ex); 
        }
    }
}