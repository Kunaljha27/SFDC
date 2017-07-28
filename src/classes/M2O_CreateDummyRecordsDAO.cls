global class M2O_CreateDummyRecordsDAO{
    
    public void insertRelatedAttachments(List<Related_Attachments_Record__c> relatedRecordsList){
        try{
            if(relatedRecordsList!= Null && !relatedRecordsList.isEmpty())
            {
                insert relatedRecordsList;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
        
    public void insertDSRRelatedAttachments(List<DSR_Related_Attachments_Record__c> dsrRelatedRecordsList){
        
        try{
            if(dsrRelatedRecordsList!= Null && !dsrRelatedRecordsList.isEmpty())
            {
                insert dsrRelatedRecordsList;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
        
    public void insertPrivateAttachments(List<Private_Attachments_Record__c> privateRecordsList){
        try{
            if(privateRecordsList != Null && !privateRecordsList.isEmpty())
            {
                insert privateRecordsList;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
           
    public Opportunity fetchOpportunityRecord(Id oppId){

        Opportunity oppRecord = new Opportunity();    
        try{
            if(oppId != Null)
            {
                oppRecord =  [select name,Dummy_Records_Flag__c,Dummy_Private_Flag__c from Opportunity where id = :oppId];
            }
            if(oppRecord != Null){
                return oppRecord;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public void updateOpportunityRecords(Opportunity oppRecord){
        try{
            if(oppRecord!= Null)
            {
                update oppRecord;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
    
    public Account fetchAccountRecord(Id accId){
        
        Account accRecord = new Account();
        try{
            if(accId != Null)
            {
                accRecord = [select name,Dummy_Private_Flag__c from Account where id = :accId];
            }
            if(accRecord != Null){
                return accRecord;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public void updateAccountRecords(Account accRecord){
        try{
            if(accRecord!= Null)
            {
                update accRecord;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
    
    public Contact fetchContactRecord(Id conId){
        
        Contact conRecord = new Contact ();
        try{
            if(conId != Null)
            {
                conRecord =  [select name,Dummy_Private_Flag__c from Contact where id = :conId];
            }
            if(conRecord != Null){
                return conRecord ;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public void updateContactRecords(Contact conRecord){
        try{
            if(conRecord != Null)
            {
                update conRecord;
            }
        }
        catch(DMLException ex) {
            system.debug(ex);
        }
    }
    
    public Deal_Support_Request_del__c fetchDSRRecord(Id dsrId){
        
        Deal_Support_Request_del__c dsrRecord = new Deal_Support_Request_del__c();
        try{
            if(dsrId != Null)
            {
                dsrRecord =  [select name,Dummy_Records_Flag__c,Dummy_Private_Flag__c from Deal_Support_Request_del__c where id = :dsrId];
            }
            if(dsrRecord != Null){
                return dsrRecord;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
   
    
    public void updateDSRRecords(Deal_Support_Request_del__c dsrRecord){
        try{
            if(dsrRecord != Null)
            {
                update dsrRecord;
            }
        }catch(DMLException ex) {
            system.debug(ex);
        }
    }
    
    public DSR_Related_Attachments_Record__c fetchDSRAttachmentRecord(Id dsrId){
        
        DSR_Related_Attachments_Record__c dsrRecord = new DSR_Related_Attachments_Record__c();
        try{
            if(dsrId != Null)
            {
                dsrRecord = [select id from DSR_Related_Attachments_Record__c where Deal_Support_request__c =: dsrId AND type__c= 'Template XLS document'];
            }
            if(dsrRecord != Null){
                return dsrRecord ;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public Document fetchDocumentRecord(String devName){
        Document docRecord = new Document();
        try{
            if(devName != Null && devName != '')
            {
                docRecord = [select name, body from Document where developername =: devName];
            }
            if(docRecord != Null){
                return docRecord;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public void insertAttachmentRecord(Attachment atchRecord){
        try{
            if(atchRecord != Null)
            {
                insert atchRecord;
            }
        }catch(DMLException ex) {
            system.debug(ex);
        }
    }
    
    public List<sObject> getCreatedBYId(Id recordId,String query){
        try{
            List<sObject> result = new List<sObject>();
            if(recordId!= Null && query!='')
            {
                result = Database.query(query);
            }
            return result;
        }catch(DMLException ex) {
            system.debug(ex);
            return null;
        }
    }
    
    public String getUserName(Id createdById){

        String createdByName;  
        try{
            if(createdById != Null)
            {
                createdByName =  ([Select Name from User where id = : createdById]).Name;
            }
            if(createdByName != ''){
                return createdByName;
            }
            return null;
        }
        catch(QueryException ex) {
            system.debug(ex);
            return null;
        }
    }

}