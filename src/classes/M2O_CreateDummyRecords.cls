global class M2O_CreateDummyRecords{
    
    webservice static void createDummyRecordsForOpportunity(Id sourceOppId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Opportunity oppRec = serviceClassObject.fetchOpportunityRecord(sourceOppId);
        if(!oppRec.Dummy_Records_Flag__c){
            List<Related_Attachments_Record__c> orr = new List<Related_Attachments_Record__c>();
            Related_Attachments_Record__c dummyRec = new Related_Attachments_Record__c();
            dummyRec.name = oppRec.name +' Customer Documents';
            dummyRec.type__c= 'Incoming';
            dummyRec.Opportunity__c = sourceOppId;
            orr.add(dummyRec);
            dummyRec = new Related_Attachments_Record__c();
            dummyRec.name = oppRec.name + ' LiAS (Designs and Controls Schemes)';
            dummyRec.type__c= 'LiAS';
            dummyRec.Opportunity__c = sourceOppId;
            orr.add(dummyRec);
            dummyRec = new Related_Attachments_Record__c();
            dummyRec.name = oppRec.name + ' Sales and Service';
            dummyRec.type__c= 'Sales';
            dummyRec.Opportunity__c = sourceOppId;
            orr.add(dummyRec);
            dummyRec = new Related_Attachments_Record__c();
            dummyRec.name = oppRec.name + ' 3rd Party';
            dummyRec.type__c= '3rd Party';
            dummyRec.Opportunity__c = sourceOppId;
            orr.add(dummyRec);
            dummyRec = new Related_Attachments_Record__c();
            dummyRec.name = oppRec.name + ' Others';
            dummyRec.type__c= 'Others';
            dummyRec.Opportunity__c = sourceOppId;
            orr.add(dummyRec);
            serviceClassObject.insertRelatedAttachments(orr);
            oppRec.Dummy_Records_Flag__c= true;
            serviceClassObject.updateOpportunityRecords(oppRec);
        }
        
    }    
    
    webservice static String getCreatedByName(Id recordId,String queryObject, String whereParam){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        String createdByName;
        Id createdById;
        String query = 'Select id,CreatedByID from ' + queryobject + ' where ' +whereParam +' =:recordID limit 1';
        List<sObject> result = new List<sObject>();
        result = serviceClassObject.getCreatedBYId(recordId,query); 
        createdById = String.valueOf(result[0].get('CreatedByID') );
        CreatedByName = serviceClassObject.getUserName(createdById); 
        return createdByName;
    }
    
    webservice static void createDummyRecordsForDSR(Id sourceDsrId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Deal_Support_Request_del__c dsrRec = serviceClassObject.fetchDSRRecord(sourceDsrId);
        if(!dsrRec.Dummy_Records_Flag__c){
            List<DSR_Related_Attachments_Record__c> orr = new List<DSR_Related_Attachments_Record__c>();
            DSR_Related_Attachments_Record__c dummyRec = new DSR_Related_Attachments_Record__c();
            dummyRec.name = dsrRec.name +' Factory';
            dummyRec.type__c= 'Factory';
            dummyRec.Deal_Support_Request__c = sourceDsrId;
            orr.add(dummyRec);
            dummyRec = new DSR_Related_Attachments_Record__c();
            dummyRec.name = dsrRec.name + ' Sales';
            dummyRec.type__c= 'Sales';
            dummyRec.Deal_Support_Request__c = sourceDsrId;
            orr.add(dummyRec);
            dummyRec = new DSR_Related_Attachments_Record__c();
            dummyRec.name = dsrRec.name + ' Others';
            dummyRec.type__c= 'Others';
            dummyRec.Deal_Support_Request__c = sourceDsrId;
            orr.add(dummyRec);
            dummyRec = new DSR_Related_Attachments_Record__c();
            dummyRec.name = dsrRec.name + 'Template XLS document';
            dummyRec.type__c= 'Template XLS document';
            dummyRec.Deal_Support_Request__c = sourceDsrId;
            orr.add(dummyRec);
            serviceClassObject.insertDSRRelatedAttachments(orr);
            DSR_Related_Attachments_Record__c dsrAtch = new DSR_Related_Attachments_Record__c();
            dsrAtch = serviceClassObject.fetchDSRAttachmentRecord(dsrRec.id);
            Document doc = new Document();
            String devName='PLS_europe_ETO_Template_for_SFDC_issue_june_30';
            doc = serviceClassObject.fetchDocumentRecord(devName);
            Attachment atc = new attachment();
            if(doc != null) {
                atc.body = doc.body;
                atc.name = doc.name;
                atc.parentId = dsrAtch.id;
                atc.ContentType='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
                serviceClassObject.insertAttachmentRecord(atc);
                dsrRec.Dummy_Records_Flag__c= true;
                serviceClassObject.updateDSRRecords(dsrRec);
            }
        }
    }    
    
    
    webservice static void createPrivateDummyRecordsForOpportunity(Id sourceOppId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Opportunity oppRec = serviceClassObject.fetchOpportunityRecord(sourceOppId);
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        Integer counter =[select count() from Private_Attachments_Record__c where opportunity__c=:sourceOppId];
        if(counter == 0){
            privateRec.name = oppRec.name+ 'Private' + 1;
        }
        else{
        Integer folder = counter + 1; 
            privateRec.name = oppRec.name+ 'Private' + folder; 
        }
        privateRec.type__c = 'Private';
        privateRec.Opportunity__c = sourceOppId;
        Id recordTypeId = Schema.SObjectType.Private_Attachments_Record__c.getRecordTypeInfosByName().get('M2O Opportunity Attachments').getRecordTypeId();
        privateRec.RecordTypeId = recordTypeId;
        opr.add(privateRec);        
        serviceClassObject.insertPrivateAttachments(opr);
        serviceClassObject.updateOpportunityRecords(oppRec);
    }
    webservice static void createPrivateDummyRecordsForAccount(Id sourceAccId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Account accRec = serviceClassObject.fetchAccountRecord(sourceAccId);
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        Integer counter =[select count() from Private_Attachments_Record__c where account__c=:sourceAccId];
        if(counter == 0){
            privateRec.name = accRec.name+ 'Private' + 1;
        }
        else{
        Integer folder = counter + 1; 
            privateRec.name = accRec.name+ 'Private' + folder; 
        }
        privateRec.type__c = 'Private';
        privateRec.Account__c = sourceAccId;
        Id recordTypeId = Schema.SObjectType.Private_Attachments_Record__c.getRecordTypeInfosByName().get('M2O Account Attachments').getRecordTypeId();
        privateRec.RecordTypeId = recordTypeId;
        opr.add(privateRec);        
        serviceClassObject.insertPrivateAttachments(opr);
        serviceClassObject.updateAccountRecords(accRec);
    }
    
    webservice static void createPrivateDummyRecordsForContact(Id sourceConId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Contact conRec = serviceClassObject.fetchContactRecord(sourceConId);
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        Integer counter =[select count() from Private_Attachments_Record__c where contact__c=:sourceConId];
        if(counter == 0){
            privateRec.name = conRec.name+ 'Private' + 1;
        }
        else{
        Integer folder = counter + 1; 
            privateRec.name = conRec.name+ 'Private' + folder; 
        }
        
        privateRec.type__c = 'Private';
        privateRec.Contact__c = sourceConId;
        Id recordTypeId = Schema.SObjectType.Private_Attachments_Record__c.getRecordTypeInfosByName().get('M2O Contact Attachments').getRecordTypeId();
        privateRec.RecordTypeId = recordTypeId;
        opr.add(privateRec);        
        serviceClassObject.insertPrivateAttachments(opr);
        serviceClassObject.updateContactRecords(conRec);
    }
    
    webservice static void createPrivateDummyRecordsForDSR(Id sourceDsrId){
        M2O_CreateDummyRecordsService serviceClassObject = new M2O_CreateDummyRecordsService();
        Deal_Support_Request_del__c dsrRec = serviceClassObject.fetchDSRRecord(sourceDsrId);
        List<Private_Attachments_Record__c> opr = new List<Private_Attachments_Record__c>();
        Private_Attachments_Record__c privateRec = new Private_Attachments_Record__c();
        Integer counter =[select count() from Private_Attachments_Record__c where Deal_Support_request__c=:sourceDsrId];
        if(counter == 0){
            privateRec.name = dsrRec.name+ 'Private' + 1;
        }
        else{
        Integer folder = counter + 1; 
            privateRec.name = dsrRec.name+ 'Private' + folder; 
        }
        privateRec.type__c = 'Private';
        privateRec.Deal_Support_Request__c = sourceDsrId;
        Id recordTypeId = Schema.SObjectType.Private_Attachments_Record__c.getRecordTypeInfosByName().get('M2O DSR Attachments').getRecordTypeId();
        privateRec.RecordTypeId = recordTypeId;
        opr.add(privateRec);        
        serviceClassObject.insertPrivateAttachments(opr);
        serviceClassObject.updateDSRRecords(dsrRec);
    }
}