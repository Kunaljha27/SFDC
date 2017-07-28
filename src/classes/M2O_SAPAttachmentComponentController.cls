/**
* @ClassName : M2O_SAPAttachmentComponentController
* @Description : This class is the controller class of M2O_SAPAttachmentComponent.
* @Author : Albin Deni Arul
* @Last Modified : 26/11/2013
* @Discussionpoints : No Information
*/
Public with sharing class M2O_SAPAttachmentComponentController {
    public String attachmentName{get; set;}
    public transient blob attachmentBody{get; set;}
    public transient list<Attachment> attachmentList{get;set;}
    public Activation_plan__c attachmentRecord;
    public boolean showAttachments {get; set;}
    public string attachmentID;
    public M2O_SAPAttachmentComponentService componentServiceClass = new M2O_SAPAttachmentComponentService();
    public UserRecordAccess access{get;set;}
    public string getAttachmentID() { 
        return attachmentID; 
    }
    public void setAttachmentID(string Id) {
        if(Id != null || Id != '') {
            attachmentID = Id;
        }
        if(attachmentList==null) {
            M2O_SAPAttachmentComponentController();
        }
    }
    
    /**
    * @Description : This contructor is doing the check for user access of the strategic Account Plan record from the service class and get the dummy attachment List
    * @param       : None
    * @return      : None
    **/
    public void M2O_SAPAttachmentComponentController() {
        Id currentUserId=UserInfo.getUserId(); 
        if(attachmentID != Null && currentUserId != Null)
            access = componentServiceClass.retriveUserAccess(attachmentID, currentUserId); 
        if(attachmentID != Null)
            attachmentList = componentServiceClass.retriveAttachmentList(attachmentID);
        if(attachmentList != Null && !attachmentList.isEmpty())
            showAttachmentList(attachmentList);
    }
    
    /**
    * @Description : This method calls the Service class method to insert the attachment record and get the latest attachment list
    * @param       : None
    * @return      : None
    **/
    Public void saveAttachment() {
        if(attachmentID != Null && attachmentName != Null && attachmentBody != Null)
            attachmentList = componentServiceClass.saveAttachment(attachmentID, attachmentName, attachmentBody); 
        if(attachmentList != Null && !attachmentList.isEmpty())
            showAttachmentList(attachmentList);
    }  
     
    /**
    * @Description : This method calls the service class method to delete the attachment record and get the latest attachment list
    * @param       : None
    * @return      : None
    **/
    Public void deleteAttachment() { 
        Id attachmentIdPassed = ApexPages.currentPage().getParameters().get('attachmentId');
        if(attachmentIdPassed != Null) {
            attachmentList=componentServiceClass.deleteAttachment(attachmentIdPassed); 
        }
        showAttachmentList(attachmentList);
    }
    
    /**
    * @Description : This method get all the related attachment and show it on the page 
    * @param       : Attachment List
    * @return      : Void 
    **/   
    public void showAttachmentList(list<Attachment> attachmentList) {   
        if(attachmentList!=null && !attachmentList.isEmpty()) {
            showAttachments = true;
        } else {
            showAttachments = false;
        }
    }
}