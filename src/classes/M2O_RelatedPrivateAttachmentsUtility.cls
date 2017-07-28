public class M2O_RelatedPrivateAttachmentsUtility{

    public static List<Related_Attachments_Record__c> getRelatedAttRecords(Opportunity oppRec){
        List<Related_Attachments_Record__c> orr = new List<Related_Attachments_Record__c>();
        Related_Attachments_Record__c dummyRec = new Related_Attachments_Record__c();
        dummyRec.name = oppRec.name +' Incoming';
        dummyRec.type__c= 'Incoming';
        dummyRec.Opportunity__c = oppRec.id;
        orr.add(dummyRec);
        dummyRec = new Related_Attachments_Record__c();
        dummyRec.name = oppRec.name + ' Lias';
        dummyRec.type__c= 'Lias';
        dummyRec.Opportunity__c = oppRec.id;
        orr.add(dummyRec);
        dummyRec = new Related_Attachments_Record__c();
        dummyRec.name = oppRec.name + ' Sales';
        dummyRec.type__c= 'Sales';
        dummyRec.Opportunity__c = oppRec.id;
        orr.add(dummyRec);
        dummyRec = new Related_Attachments_Record__c();
        dummyRec.name = oppRec.name + ' 3rd Party';
        dummyRec.type__c= '3rd Party';
        dummyRec.Opportunity__c = oppRec.id;
        orr.add(dummyRec);
        dummyRec = new Related_Attachments_Record__c();
        dummyRec.name = oppRec.name + ' Others';
        dummyRec.type__c= 'Others';
        dummyRec.Opportunity__c = oppRec.id;
        orr.add(dummyRec);
        return orr;
    }
    
    public static List<DSR_Related_Attachments_Record__c> getDSRRelatedAttRecords(Deal_Support_Request_del__c dsrRec){
        List<DSR_Related_Attachments_Record__c> orr = new List<DSR_Related_Attachments_Record__c>();
        DSR_Related_Attachments_Record__c dummyRec = new DSR_Related_Attachments_Record__c();
        dummyRec.name = dsrRec.name +' Factory';
        dummyRec.type__c= 'Factory';
        dummyRec.Deal_Support_Request__c = dsrRec.id;
        orr.add(dummyRec);
        dummyRec = new DSR_Related_Attachments_Record__c();
        dummyRec.name = dsrRec.name + ' Sales';
        dummyRec.type__c= 'Sales';
        dummyRec.Deal_Support_Request__c = dsrRec.id;
        orr.add(dummyRec);
        dummyRec = new DSR_Related_Attachments_Record__c();
        dummyRec.name = dsrRec.name + ' Others';
        dummyRec.type__c= 'Others';
        dummyRec.Deal_Support_Request__c = dsrRec.id;
        orr.add(dummyRec);
        dummyRec = new DSR_Related_Attachments_Record__c();
        dummyRec.name = dsrRec.name + 'Template XLS document';
        dummyRec.type__c= 'Template XLS document';
        dummyRec.Deal_Support_Request__c = dsrRec.id;
        orr.add(dummyRec);
        return orr;
    }
    
    public static List<Private_Attachments_Record__c> getPrivateOppRecords(Opportunity oppRec){
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        privateRec.name = oppRec.name+ ' Private';
        privateRec.type__c = 'Private';
        privateRec.Opportunity__c = oppRec.id;
        opr.add(privateRec);        
        return opr;
    }
    
    public static List<Private_Attachments_Record__c> getPrivateAccRecords(Account accRec){
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        privateRec.name = accRec.name+ ' Private';
        privateRec.type__c = 'Private';
        privateRec.Account__c = accRec.id;
        opr.add(privateRec);          
        return opr;
    }
    
    public static List<Private_Attachments_Record__c> getPrivateConRecords(Contact conRec){
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        privateRec.name = conRec.name+ ' Private';
        privateRec.type__c = 'Private';
        privateRec.Contact__c = conRec.id;
        opr.add(privateRec);        
        return opr;
    }
    
    public static List<Private_Attachments_Record__c> getPrivateDsrRecords(Deal_Support_Request_del__c dsrRec){
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        privateRec.name = dsrRec.name+ ' Private';
        privateRec.type__c = 'Private';
        privateRec.Deal_Support_Request__c = dsrRec.id;
        opr.add(privateRec);        
        return opr;
    }
}