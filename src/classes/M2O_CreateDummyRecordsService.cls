global class M2O_CreateDummyRecordsService{
    
    M2O_CreateDummyRecordsDAO daoClassObject = new M2O_CreateDummyRecordsDAO();
    
    public void insertRelatedAttachments(List<Related_Attachments_Record__c> relatedRecordsList){
        if(relatedRecordsList!= Null && !relatedRecordsList.isEmpty())
        {
            daoClassObject.insertRelatedAttachments(relatedRecordsList);
        }
    }
        
    public void insertDSRRelatedAttachments(List<DSR_Related_Attachments_Record__c> dsrRelatedRecordsList){
        if(dsrRelatedRecordsList!= Null && !dsrRelatedRecordsList.isEmpty())
        {
            daoClassObject.insertDSRRelatedAttachments(dsrRelatedRecordsList);
        }
    }
        
    public void insertPrivateAttachments(List<Private_Attachments_Record__c> privateRecordsList){
        if(privateRecordsList != Null && !privateRecordsList.isEmpty())
        {
            daoClassObject.insertPrivateAttachments(privateRecordsList);
        }
    }
        
    public Opportunity fetchOpportunityRecord(Id oppId){
        Opportunity oppRecord = new Opportunity();
        if(oppId != Null)
        {
            oppRecord = daoClassObject.fetchOpportunityRecord(oppId);
        }
        if(oppRecord != Null){
            return oppRecord;
        }
        return null;
    
    }
    
    public void updateOpportunityRecords(Opportunity oppRecord){
        if(oppRecord!= Null)
        {
            daoClassObject.updateOpportunityRecords(oppRecord);
        }
    }
    
    public Account fetchAccountRecord(Id accId){
        Account accRecord = new Account();
        if(accId != Null)
        {
            accRecord = daoClassObject.fetchAccountRecord(accId);
        }
        if(accRecord != Null){
            return accRecord;
        }
        return null;
    
    }
    
    public void updateAccountRecords(Account accRecord){
        if(accRecord!= Null)
        {
            daoClassObject.updateAccountRecords(accRecord);
        }
    }
    
    public Contact fetchContactRecord(Id conId){
        Contact conRecord = new Contact ();
        if(conId != Null)
        {
            conRecord = daoClassObject.fetchContactRecord(conId);
        }
        if(conRecord != Null){
            return conRecord ;
        }
        return null;
    
    }
    
    public void updateContactRecords(Contact conRecord){
        if(conRecord != Null)
        {
            daoClassObject.updateContactRecords(conRecord);
        }
    }
    
    public Deal_Support_Request_del__c fetchDSRRecord(Id dsrId){
        Deal_Support_Request_del__c dsrRecord = new Deal_Support_Request_del__c();
        if(dsrId != Null)
        {
            dsrRecord = daoClassObject.fetchDSRRecord(dsrId);
        }
        if(dsrRecord != Null){
            return dsrRecord;
        }
        return null;
    
    }
    
    
    
    public void updateDSRRecords(Deal_Support_Request_del__c dsrRecord){
        if(dsrRecord != Null)
        {
            daoClassObject.updateDSRRecords(dsrRecord);
        }
    }
    
    public DSR_Related_Attachments_Record__c fetchDSRAttachmentRecord(Id dsrId){
        DSR_Related_Attachments_Record__c dsrRecord = new DSR_Related_Attachments_Record__c();
        if(dsrId != Null)
        {
            dsrRecord = daoClassObject.fetchDSRAttachmentRecord(dsrId);
        }
        if(dsrRecord != Null){
            return dsrRecord;
        }
        return null;
    
    }
    
    public Document fetchDocumentRecord(String devName){
        Document docRecord = new Document();
        if(devName != Null && devName != '')
        {
            docRecord= daoClassObject.fetchDocumentRecord(devName);
        }
        if(docRecord!= Null){
            return docRecord;
        }
        return null;
    
    }
    
    public void insertAttachmentRecord(Attachment atchRecord){
        if(atchRecord != Null)
        {
            daoClassObject.insertAttachmentRecord(atchRecord);
        }
    }
    
    public List<sObject> getCreatedBYId(Id recordId,String query){
        List<sObject> result = new List<sObject>();
        if(recordId != Null && query!='')
        {
            result = daoClassObject.getCreatedBYId(recordId,query);
        }
        return result;
    }
    
    public String getUserName(Id createdById){
        String createdByName;
        if(createdById != Null)
        {
            createdByName = daoClassObject.getUserName(createdById);
        }
        return createdByName;
    }
}