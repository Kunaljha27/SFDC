public class M2O_DocumentManagementDAO {
    public static List<Related_Attachments_Record__c> getOpptyRelatedAttachmentsRecord (Id oppId) {
        try {
            List<Related_Attachments_Record__c> rltdAttchmntList = new List<Related_Attachments_Record__c>();
            rltdAttchmntList = [Select Name,Type__c,Opportunity__c from Related_Attachments_Record__c where Opportunity__c = :oppId] ;
            return rltdAttchmntList;
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            error=M2O_ErrorHandling.errorHandling(e);
            insert error;
            return null;
        }
    }
    public static List<Private_Attachments_Record__c> getOpptyPrivateAttachmentsRecord (Id oppId) {
        try {
            List<Private_Attachments_Record__c> pvtdAttchmntList = new List<Private_Attachments_Record__c>();
            pvtdAttchmntList = [Select Name,Type__c,Opportunity__c from Private_Attachments_Record__c where Opportunity__c = :oppId] ;
            return pvtdAttchmntList;
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            error=M2O_ErrorHandling.errorHandling(e);
            insert error;
            return null;
        }
    }
}