public class M2O_DocumentManagementController {
    public  Id oppId       {get;set;}
    public List<Related_Attachments_Record__c> rltdAttchmntList {get; set;}
    public  List<Private_Attachments_Record__c> pvtdAttchmntList {get; set;}
    public M2O_DocumentManagementController(ApexPages.StandardController controller) {
        oppId = controller.getRecord().Id;
        rltdAttchmntList = M2O_DocumentManagementDAO.getOpptyRelatedAttachmentsRecord (oppId);
        pvtdAttchmntList = M2O_DocumentManagementDAO.getOpptyPrivateAttachmentsRecord(oppId);
    } 
        
           
    
}