/**
* @ClassName         : M2O_SAP_AttachmentComponentServiceClass
* @Description       : This class is the service class of M2O_SAP_AttachmentComponentController.This class performes the bussiness logic (functionality) of the component
* @Author            : Albin Deni Arul
* @Last Modified     : 26/11/2013
* @Discussionpoints  : No Information
*/

public with sharing class M2O_SAPAttachmentComponentService{
     public transient Attachment attachmetRecord;  
     public M2O_SAPAttachmentComponentDAO componentDOAClass = new M2O_SAPAttachmentComponentDAO();
   
    /**
    * @Description : This method calls the DOA class to retrive the attachments related to that Strategic Account Plan
    * @param       : Attachment Id
    * @return      : list of the attachment records returned from the query
    **/
    
    public list<Attachment> retriveAttachmentList(Id attachmentID) {
        return(componentDOAClass.retriveAttachmentList(attachmentID));
    }
    
    /**
    * @Description : This method calls the DOA class method to retrive the current user access on that object
    * @param1      : Strategic Account plan Id (Parent id)
    * @param2      : Current User Id 
    * @return      : User record access
    **/
    public UserRecordAccess retriveUserAccess(Id attachmentID, Id currentUser) {
        return(componentDOAClass.retriveUserAccess(attachmentID, currentUser));
    }
    
    /**
    * @Description : This method calls the DOA class method to insert the attachment record and get the latest attachment list
    * @param1      : Strategic Account plan Id (Parent id)
    * @param2      : Attachment name
    * @param3      : Attachment body
    * @return      : list of the attachment records returned from the query
    **/
    
    public list<Attachment> saveAttachment(Id attachmentID, string attachmentName, Blob attachmentBody) {
        attachmetRecord = new Attachment(parentId = attachmentID, name=attachmentName, body =attachmentBody); 
        componentDOAClass.saveAttachment(attachmetRecord);
        return(componentDOAClass.retriveAttachmentList(attachmentID));
    }
    
    /**
    * @Description : This method calls the DOA class method to delete the attachment record and get the latest attachment list
    * @param       : Strategic Account plan Id (Parent id)
    * @return      : list of the attachment records returned from the query
    **/
    
    public list<Attachment> deleteAttachment(Id attachmentID) {
        attachmetRecord = new Attachment(Id=attachmentID); 
        if(attachmetRecord != Null)
            componentDOAClass.deleteAttachment(attachmetRecord);
        return(componentDOAClass.retriveAttachmentList(attachmentID));
    }
}