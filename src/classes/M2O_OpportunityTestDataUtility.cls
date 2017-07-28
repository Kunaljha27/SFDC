/**
@Classname :       M2O_OpportunityTestDataUtility
@Description :     This test class is written to store all the data which is to be inserted for testing Lead and Oppportunity.
@Author:           Meeta Pramanik/ Piyali Saha
@Last Modified:    29/11/2013
**/

public with sharing class  M2O_OpportunityTestDataUtility { 
    /**
    @Description: Extract the fields from the field sets.
    @Return:      List of String of the fields in the fieldset.
    **/
    public Static String fieldSetValue (List<Schema.FieldSetMember>marktAttribute) {
        Map<String, Schema.FieldSetMember> mapFieldSchema = new Map<String, Schema.FieldSetMember>();
        String QueriableFields ;
        QueriableFields = null;
        for (Schema.FieldSetMember attributeRecord : marktAttribute) {       
            mapFieldSchema.put(attributeRecord.getFieldPath(), attributeRecord);
            if (QueriableFields == null || QueriableFields =='') {
                QueriableFields = attributeRecord.getFieldPath() + ',';   
            }
            else {
                QueriableFields += attributeRecord.getFieldPath() + ',';   
                }
        }  
        return  QueriableFields;
    }
    
    /**
    @Description: Create data for DSR record
    @Return:      DSR record
    **/
    
    public static Deal_Support_Request_del__c getDSRRecord () {
        Deal_Support_Request_del__c dSR = new Deal_Support_Request_del__c ();
            dSR.Name = 'test';
        dSR.Status__c = 'Open';
        dSR.Prop_Due_Date__c = system.Today();
        dSR.Project_Support_Request_Type__c = 'Financing Request';
        return dSR;
    }    
    
    /**
    @Description: Create data for Note record
    @Parameter 1 : DSR record
    @Return:      Note record
    **/        
    public static Note getNoteRecord(Deal_Support_Request_del__c clonedDSR) {
        Note noteRecord = new Note();
        noteRecord.ParentId =clonedDSR.Id;
        noteRecord.Title= 'Test';
        noteRecord.Body='Hi TESTING';
        return noteRecord;
    }  
   
    /**
    @Description: Create data for Attachment record
    @Parameter 1 : DSR record
    @Return:      Attachment record
    **/ 
    public static Attachment getAttachmentRecord (Deal_Support_Request_del__c clonedDSR) {
        Attachment attachmentRecord = new Attachment();
        List<Attachment> bodyList = new List<Attachment> ();
        bodyList = [Select Body From Attachment];
        system.debug('#################'+bodyList);
        attachmentRecord.ParentId =clonedDSR.Id;
        attachmentRecord.Body= blob.toPdf('s') ;
        attachmentRecord.Name = 'TEST';
        attachmentRecord.Description = '.Pdf';
        return attachmentRecord;
    }    
    /**
    @Description: Create data in custom setting "M2O Sales Team Visibility Objects"
    @Return:      Custom setting Data
    **/
    
    public static List<M2O_ST_Visibility_Objects__c> getSTVisibilityObjects() {
        List<M2O_ST_Visibility_Objects__c> listCustomSetting = new List<M2O_ST_Visibility_Objects__c>();
        M2O_ST_Visibility_Objects__c customSettingQuotation = new M2O_ST_Visibility_Objects__c();     
        customSettingQuotation .Obj_API_Name__c = 'Quotation__c';
        customSettingQuotation .Relationship_with_opportunity__c = 'Opportunity__c';
        customSettingQuotation .name = 'Quotations__r';
        listCustomSetting.add(customSettingQuotation);
        M2O_ST_Visibility_Objects__c customSettingsalesOrder = new M2O_ST_Visibility_Objects__c();
        customSettingsalesOrder.Obj_API_Name__c = 'Sales_Order__c';
        customSettingsalesOrder.Relationship_with_opportunity__c = 'Opportunity__c';
        customSettingsalesOrder.name = 'Sales_Orders__r';
        listCustomSetting.add(customSettingsalesOrder);
        M2O_ST_Visibility_Objects__c customSettingDSR = new M2O_ST_Visibility_Objects__c();
        customSettingDSR.Obj_API_Name__c = 'Deal_Support_Request_del__c';
        customSettingDSR.Relationship_with_opportunity__c = 'Related_Opportunity_del__c';
        customSettingDSR.name = 'Deal_Support_Requests_del__r';
        listCustomSetting.add(customSettingDSR);
        return listCustomSetting;
    }
    
    /**
    @Description: Create data in custom setting "Validate M2O Profiles"
    @Return:   Custom setting Data   
    **/
    
    public static Validate_M2O_Profiles__c getValidateM2OProfiles(Id profileId) {
        Id hcProfileId = profileId;
        Validate_M2O_Profiles__c validateM2OProfile = new Validate_M2O_Profiles__c();
        validateM2OProfile.Validate_Profiles__c = true;
        validateM2OProfile.SetupOwnerId = hcProfileId;
        return validateM2OProfile;
    }
  
    public static Validate_M2O_Profiles__c deleteValidateM2OProfiles() {
        Profile hcProfile= M2O_UserTestDataUtility.getM2OSalesHCProfileId();
        Validate_M2O_Profiles__c delcs = Validate_M2O_Profiles__c.getInstance(hcProfile.Id);
        if(delcs!=null) {
            delete delcs;
        }
        Validate_M2O_Profiles__c validateM2OProfiles = new Validate_M2O_Profiles__c();
        validateM2OProfiles.Validate_Profiles__c = True;
        validateM2OProfiles.SetupOwnerId = hcProfile.Id;
        return validateM2OProfiles;
    }
    
    /**
    @Description: Create Account record.
    @Return:      Account data    
    **/  

 
    public static Account getAccountRecord(Region__c rediondata) {
             
        Account acc;
        acc = new Account(name = 'test acc1', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA', country__c = 'India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c = 'Retail',
                                      Philips_Indstry_Clasification_Level2__c='IDN', Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City',
                                      Region__c = rediondata.id);
        return acc;
    }
    /*
    @Description: Region record
    @Return:      Region data 
    **/
    public static Region__c getRegionData(){
        Region__c rediondata = new Region__c();
        rediondata.name ='Test Region';
        rediondata.Country__c='India';
        rediondata.Region_Code__c='AA-113';
        return rediondata;
        }
  
    /*
    @Description: Updated account record
    @Return:      Updated Account record 
    **/
    public static Account updateAccountRecord(Id userID, Id accountId) {
        Account accountToUpdate = new Account(id = accountId, ownerId = userID,  BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA');
        return accountToUpdate;
    }
    
    /*
    @Description: Create Master Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static list<Opportunity> getListOfMasterOpportunityRecord(id accId) {
        Opportunity masterOpp;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=2;i++) {
            masterOpp = new Opportunity();
            masterOpp.Name ='Test Master Opty'+i;
            masterOpp.closedate = system.today();
            masterOpp.StageName='Best Case';
            masterOpp.AccountId = accId;
            masterOpp.recordTypeId = Label.M2O_Opportunity_Master_RecordType_ID;
            masterOpp.CurrencyIsoCode='USD';
            masterOpp.Sub_Opportunities_Total_Amounts__c = 0.0;
            masterOpp.ForecastCategoryName = 'Omitted';
            masterOpp.City__c = 'test';
            listOpportunity.add(masterOpp);
        }
        return listOpportunity ;    
    }
   
    /*
    @Description: Create Master Opportunity data2
    @Return:      Opportunity data 
    **/
    
    public static list<Opportunity> getListOfMasterOpportunityRecord2(id accId) {
        Opportunity masterOpp;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=2;i++) {
            masterOpp = new Opportunity();
            masterOpp.Name ='Test Master Opty'+i;
            masterOpp.closedate = system.today();
            masterOpp.StageName='Distributing (Master)';
            masterOpp.AccountId = accId;
            masterOpp.recordTypeId = Label.M2O_Opportunity_Master_RecordType_ID;
            masterOpp.CurrencyIsoCode='USD';
            masterOpp.Sub_Opportunities_Total_Amounts__c = 0.0;
            masterOpp.ForecastCategoryName = 'Omitted';
            masterOpp.Update_Sub_opportunity_Stage__c = true;
            masterOpp.Update_Sub_oppty_Expected_Order_Da__c = true;
            masterOpp.City__c = 'test';
            listOpportunity.add(masterOpp);
        }
        return listOpportunity ;    
    }
    
    public static list<Opportunity> getListOfMasterOpportunityRecord3(id accId) {
        Opportunity masterOpp;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=10;i++) {
            masterOpp = new Opportunity();
            masterOpp.Name ='Test Master Opty'+i;
            masterOpp.closedate = system.today();
            masterOpp.StageName='Qualify (Master)';
            masterOpp.AccountId = accId;
            masterOpp.recordTypeId = Label.M2O_Opportunity_Master_RecordType_ID;
            masterOpp.CurrencyIsoCode='USD';
            masterOpp.Sub_Opportunities_Total_Amounts__c = 0.0;
            masterOpp.ForecastCategoryName = 'Omitted';
            masterOpp.Update_Sub_opportunity_Stage__c = true;
            masterOpp.Update_Sub_oppty_Expected_Order_Da__c = true;
            masterOpp.City__c = 'test';
            listOpportunity.add(masterOpp);
        }
        return listOpportunity ;    
    }
    public static list<Opportunity> getListOfMasterOpportunityRecord4(id accId) {
        Opportunity masterOpp;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=10;i++) {
            masterOpp = new Opportunity();
            masterOpp.Name ='Test Master Opty'+i;
            masterOpp.closedate = system.today();
            masterOpp.StageName='Sales Recognized (Master)';
            masterOpp.AccountId = accId;
            masterOpp.recordTypeId = Label.M2O_Opportunity_Master_RecordType_ID;
            masterOpp.CurrencyIsoCode='USD';
            masterOpp.Sub_Opportunities_Total_Amounts__c = 0.0;
            masterOpp.ForecastCategoryName = 'Omitted';
            masterOpp.Update_Sub_opportunity_Stage__c = true;
            masterOpp.Update_Sub_oppty_Expected_Order_Da__c = true;
            masterOpp.City__c = 'test';
            listOpportunity.add(masterOpp);
        }
        return listOpportunity ;    
    }
    
    /**
    @Description: Create Sub Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static List<Opportunity> getListSubOpportunity(id accId, List<Opportunity> listMasterOpportunity) {
        
        List<opportunity> listSubOpportunity = new List<opportunity>();
        for(integer i = 0; i <2; i++) {
            listSubOpportunity.add(new Opportunity(Name ='Test Sub Opty', closedate = system.today(), StageName = 'Develop',
                                                   AccountId = accId, Opportunity_Hierarchy_Link__c = listMasterOpportunity[i].id, CurrencyIsoCode='INR',
                                                   Amount = 1000, recordTypeId = Label.M2O_Opportunity_Healthcare_RecordType_ID, 
                                                   ForecastCategoryName = 'Pipeline', Probability = 40, Vendor_of_Choice__c = 'Philips',
                                                   Funding_Status_Deal_Realization__c = 'Neutral'));
        }
        return listSubOpportunity;    
    }
    
    /**
    @Description: Create Opportunity data
    @Return:      Opportunity data 
    **/
    
    public static Opportunity getOpportunityRecord(id accId) {
        Opportunity oppRec = new Opportunity(Name ='Sampletest1', closedate=system.today(),
                                            StageName = System.Label.StageName_Develop, 
                                            CurrencyIsoCode = 'INR', AccountId = accId,City__c='test');
        return oppRec;    
    }
    
    /**
    @Description: Create Opportunity data with OwnerId.
    @Return:      Opportunity data 
    **/
    public static Opportunity getOpportunityRecordWithOwner(id accId, id userId) {
        Opportunity oppWithOwner = new Opportunity(Name ='Sampletest1', closedate=system.today(),
                                          StageName = System.Label.StageName_Develop, 
                                          CurrencyIsoCode = 'INR', AccountId = accId, ownerId = userId,City__c='test');
        return oppWithOwner;    
    }
    
    /**
    @Description: collection of Opportunity records
    @Return:      list of opportunities 
    **/
    public static list<Opportunity> getListOfOpportunityRecord(id accId, id ownerId) {
        List<Opportunity> listOpp = new List<Opportunity>();
        Opportunity OppRecord;
        for(integer i = 0; i<2; i++) {
            OppRecord = new Opportunity();
            OppRecord.Name = 'Opportunity'+i;
            OppRecord.OwnerId = ownerId;
            OppRecord.closedate = system.today();
            OppRecord.StageName = System.Label.StageName_Develop;
            OppRecord.CurrencyIsoCode = 'INR';
            OppRecord.AccountId = accId;
            OppRecord.Type='Multi Deal Modality';
            OppRecord.City__c='test';
            listOpp.add(OppRecord);
        }
        return listOpp;    
    }
    
    /**
    @Description: Create Quotation records in a List
    @Return:      List of Quotation records 
    **/
    
    public static list<Quotation__c> getListOfQuotationRecord(id oppid) {
        List<Quotation__c> listQuotation = new List<Quotation__c>();
        Quotation__c quotationRecords;
        for(integer i = 0; i<2; i++) {
            quotationRecords = new Quotation__c();
            quotationRecords.Opportunity__c = oppid;
            quotationRecords.CurrencyIsoCode = 'USD';
            listQuotation.add(quotationRecords);
        }
        return listQuotation;
    }
    
    /**
    @Description: Create Quotation data
    @Return:      Quotation data 
    **/
    public static Quotation__c getQuotationRecord(id oppId) {
        Quotation__c quotationRecord = new Quotation__c (Opportunity__c = oppid, CurrencyIsoCode = 'USD');
        return quotationRecord;
    }
    
    /**
    @Description: Create Sales Order records in a List
    @Return:      List of Sales Order records 
    **/
    
    public static list<Sales_Order__c> getListOfSalesOrderRecord(id oppid) {
        List<Sales_Order__c> listSalesOrder = new List<Sales_Order__c>();
        Sales_Order__c salesRecord;
        for(integer i = 0; i<2; i++) {
            salesRecord = new Sales_Order__c();
            salesRecord.Opportunity__c = oppid;
            salesRecord.CurrencyIsoCode = 'USD';
            salesRecord.Sales_Order_External_ID__c = i +'test'+ i;
            system.debug('External id value'+salesRecord.Sales_Order_External_ID__c);
            listSalesOrder.add(salesRecord);
           }               
        return listSalesOrder;    
    }
    public static Sales_Order__c getSalesOrderRecord(id oppId) {
        Sales_Order__c salesOrderRecord = new Sales_Order__c( Opportunity__c = oppid, CurrencyIsoCode = 'USD', Sales_Order_External_ID__c = oppId);
        return salesOrderRecord;
    }
    
    /**
    @Description: Create Opportunity Team Member record
    @Return:      Opportunity Team Member record
    **/
    
    public static OpportunityTeamMember getOptyTeamMemberRecord(id oppid, Id userId) {
        OpportunityTeamMember oppTeamMember = new OpportunityTeamMember (TeamMemberRole = 'HC - District Manager',
                                                                         opportunityId = oppid, UserId = userId);
        return oppTeamMember;
    }
     
     /**
    @Description: Create collection of Opportunity Team Member records
    @Return:      collection of Opportunity Team Member records
    **/
    
    public static list<OpportunityTeamMember> getListOfOppTeamMemberRecords(Id oppid, Id hcProfileId) {        
        List<OpportunityTeamMember> listOpportunityTeamMember = new List<OpportunityTeamMember>();
        List<user> listUser = M2O_UserTestDataUtility.getUserRecordsForOpptyTeam(10, hcProfileId);
        insert listUser;
        OpportunityTeamMember optyTeamRecord;
        for(User usr : listUser) {
            optyTeamRecord = new OpportunityTeamMember();
            optyTeamRecord.TeamMemberRole = 'HC - District Manager';
            optyTeamRecord.OpportunityId = oppid;
            optyTeamRecord.UserId = usr.id;
            listOpportunityTeamMember.add(optyTeamRecord);        
        }   
        return listOpportunityTeamMember; 
    }
    
    /**
    @Description: Create Deal Suppport request record
    @Return:      Deal Support request record 
    **/
    
    public static Deal_Support_Request_del__c getDSRRecord(id oppId) {
        Deal_Support_Request_del__c dSRRecord = new Deal_Support_Request_del__c(Name = 'Test Deal Support', Related_Opportunity_del__c = oppId, 
                                                                                Project_Support_Request_Type__c = 'LIAS Request', 
                                                                                Status__c = 'Open', Prop_Due_Date__c = system.today());
        return dSRRecord;
    }
    
    /**
    @Description: Collection of Deal Suppport request records
    @Return:    Deal Suppport request records      
    **/
    
    public static list<Deal_Support_Request_del__c> getListOfDSRRecord(id oppid) {
        List<Deal_Support_Request_del__c> listDSR = new List<Deal_Support_Request_del__c>();
        Deal_Support_Request_del__c dSRRecord;
        for(integer i = 0; i<2; i++) {
            dSRRecord = new Deal_Support_Request_del__c();
            dSRRecord.Name = 'Deal'+i; 
            dSRRecord.Related_Opportunity_del__c = oppId;
            dSRRecord.Project_Support_Request_Type__c = 'LIAS Request';
            dSRRecord.Status__c = 'Open';
            dSRRecord.Prop_Due_Date__c = system.today();
            listDSR.add(dSRRecord);        
            }   
        return listDSR; 
    }
    
    /**
    @Description: Create collection of Opportunity Ecosystem records
    @Return:      Collection of Opportunity Ecosystem records
    **/
    
    public static list<Opportunity_Ecosystem__c> getListOfOptyEcosystem(List<Opportunity> opp, Account acc) {
        List <Opportunity_Ecosystem__c> oppEcosystemList = new List<Opportunity_Ecosystem__c>();
        Opportunity_Ecosystem__c oppEcoRecord;
        for(integer i = 0; i<10; i++) {              
            oppEcoRecord = new Opportunity_Ecosystem__c();
            oppEcoRecord.Account_Role__c = 'Competitor';            
            oppEcoRecord.Account__c = acc.id;
            oppEcoRecord.Opportunity__c = opp[0].Id;
            oppEcosystemList.add(oppEcoRecord);
        }
        return oppEcosystemList;
    }
     
    /**
    @Description: Create Opportunity Ecosystem record
    @Return:      Opportunity Ecosystem record
    **/   
    public static Opportunity_Ecosystem__c getOptyEcosystemRecord(id oppId, id accId) {
        Opportunity_Ecosystem__c oppEcosystem = new Opportunity_Ecosystem__c (Account_Role__c = 'Philips Global', 
                                                                         Account__c = accid, Opportunity__c = oppId);
        return oppEcosystem ;
    }
    
    /**
    @Description: Create product
    @Return:      product record
    **/
    public static Product2 getProductRecord() {
       Product2 prod = new Product2(productCode = '9890828A', Name = 'Test Product', isActive = true, Family = 'IXR');
       return prod;       
    }
    
    /**
    @Description: Create PricebookEntry record
    @Return:      PricebookEntry record
    **/ 
    public static PricebookEntry getPBEntryRecord(id prodId, id pb) {
        PricebookEntry pbEntry = new PricebookEntry(Product2Id = prodId, Pricebook2Id = pb, isActive = true, UnitPrice = 1.0,
                                                    CurrencyIsoCode = 'INR', UseStandardPrice = false);
        return pbEntry;        
    }
    
    /**
    @Description: Create OpportunityLineItem record
    @Return:      OpportunityLineItem record
    **/ 
    public static OpportunityLineItem getOppLineItemRecord(id oppId, id pbeId) {       
        OpportunityLineItem oppLineItem = new OpportunityLineItem(PricebookEntryId = pbeId, Quantity = 3, Sales_Recognition_Date_2__c = date.Today(),
                                                                  ServiceDate = system.today(), OpportunityId = oppId, TotalPrice = 300);
        return oppLineItem;
    }
    
    /**
    @Description: Create List of OpportunityLine Item records
    @Return:     collection of OpportunityLine Item records
    **/ 
    public static List<OpportunityLineItem> getListOfOppLineItemRecord(Set<id> setOppId, id priceBookEntryId) {       
        List<OpportunityLineItem> listOpportunityLineItem = new List<OpportunityLineItem>();
        for(Id oppId : setOppId) {
            listOpportunityLineItem.add(new OpportunityLineItem(PricebookEntryId = priceBookEntryId, Quantity = 3, Sales_Recognition_Date_2__c = date.Today(),
                                                                ServiceDate = system.today(), OpportunityId = oppId, 
                                                                TotalPrice = 300));
        }
        return listOpportunityLineItem;
    }
    
    
    public static PriceBook2 getPriceBookRecord() {
       Pricebook2 priceBkEntry = [SELECT Id FROM Pricebook2 WHERE isStandard = true AND IsActive = true limit 1];
       return  priceBkEntry;
    } 
    
    /**
    @Description: Create List of OM_VOC_FDR_Matrix records
    @Return:     collection of OM_VOC_FDR_Matrix Item records
    **/ 
    public static OM_VOC_FDR_Matrix__c getVOCFDRMatrixRecord(){
        OM_VOC_FDR_Matrix__c matrixObj = new OM_VOC_FDR_Matrix__c();
        matrixObj.Name = 'Matrix1';
        matrixObj.Funding_status_deal_realization__c = 'Confident';
        matrixObj.Probability__c = 40;
        matrixObj.Vendor_of_Choice__c = 'Competitor';
        return matrixObj;           
    }
    
    /*
    @Description: Create Opportunity where Forecast category is not set
    @Return:      Opportunity data 
    **/
    
    public static list<Opportunity> getListOfOpportunityRecord() {
        Region__c reg = getRegionData();
        insert reg;
        Account acc = getAccountRecord(reg);
        insert acc;
        list<Opportunity> listOpportunity = new list<Opportunity>();
        for(Integer i=0; i<=2;i++) {
            //opp = new Opportunity();
            Opportunity opp = new Opportunity();
            opp.Name ='Test Master Opty'+i;
            opp.closedate = system.today();
            opp.StageName='Qualify';
            opp.AccountId = acc.Id;
            //opp.recordTypeId = Label.M2O_Opportunity_Master_RecordType_ID;
         //   opp.ForecastCategoryName = 'Omitted';
            opp.Funding_status_deal_realization__c = 'Neutral';
            opp.Vendor_of_Choice__c = 'Neutral';
            opp.City__c='test';
            system.debug('@@@@@@@'+opp);
            listOpportunity.add(opp);
        }
        return listOpportunity ;    
    }
    public static List<Lead> getLeadList () {
        List <Lead> leadList= new List<Lead> ();
        Lead ld;
        for(Integer i =0 ; i <2 ; i++) {
            ld=new Lead( Salutation='Mr',Product_of_Interest__c='704 Radiography',  FirstName='Test'+i,Source_System__c='Eloqua',LastName='Test',Sector__c='Healthcare',Company='Wipro',Country__c='Netherlands',Status='Pending',City__c='Eindhoven',Business_Group__c='LI-Other',LeadSource='Digital',Email='U@d.com'+i,Budget__c='Confident',Need__c='Strong',Authority__c='Direct',Timing__c='Urgent',Street_1_Local__c='Test',City_Prospect__c='Pune',Street_Local__c='12');
            leadList.add(ld);
        }
        return leadList;
    } 
    
    public static List<OpportunityShare> getOpportunityShare(Id userId){
        List<OpportunityShare> optyshareList = new List<OpportunityShare>();
        for(Opportunity oppObj : getListOfOpportunityRecord()){
            OpportunityShare oppShare = new OpportunityShare();
            oppShare.UserOrGroupId = userId;
            oppShare.OpportunityId = oppObj.Id;
            optyshareList.add(oppShare);
        }
        return optyshareList;
    }
}