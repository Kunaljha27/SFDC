public class RX_DownloadController {
 
    public String zipFileName {get; set;}
    public String zipContent {get; set;}
    
    public List<RX_ExIm_Status__c> expStatus {get;set;}
    public List<RX_ExIm_Status__c> impStatus {get;set;}
    
    public RX_DownloadController() {
        getExportStatus();
        getImportStatus();
    }
    
    public void setPushTopic() {
        list<PushTopic> pts =  [select id from PushTopic where name = 'RXExportImportProcess'];
        if(pts.size() == 0) {
	        PushTopic pushTopic = new PushTopic();
	        pushTopic.Name = 'RXExportImportProcess'; 
	        pushTopic.Query =   'Select Id, Submitted__c, Status__c, Note__c, Name, Job_ID__c,  ID__c, Finished__c From RX_ExIm_Status__c';
	        pushTopic.ApiVersion = 36.0;
	        pushTopic.NotifyForOperationCreate = true;
	        pushTopic.NotifyForOperationUpdate = true;
	        pushTopic.NotifyForOperationUndelete = false;
	        pushTopic.NotifyForOperationDelete = false;
	        pushTopic.NotifyForFields = 'Referenced';
	        insert pushTopic;
        }
    }
    public PageReference uploadZip() {
        if (String.isEmpty(zipFileName) ||
            String.isBlank(zipFileName)) {
            zipFileName = 'REVVY_EXIMTools.zip';
        }

        delete [Select Id from Document where Name=:zipFileName]; 
         
        Document doc = new Document();
        doc.Name = zipFileName;
        doc.ContentType = 'application/zip';
        doc.FolderId = UserInfo.getUserId();
        doc.Body = EncodingUtil.base64Decode(zipContent);
         
        insert doc;
         
        this.zipFileName = null;
        this.zipContent = null;
        //https://c.cs15.content.force.com/servlet/servlet.FileDownload?file=015e0000000QnQk
        PageReference pageRef = new PageReference('/servlet/servlet.FileDownload?file=' + doc.Id);
        //PageReference pageRef = new PageReference('/' + doc.Id);
        pageRef.setRedirect(true);
         
        return pageRef;
    }
    
    public PageReference exportAllButton() {
        RX_DownloadCustomObject.exportALL();
        getExportStatus();
        return null;
    }

    public PageReference exportModel() {
        String modelId = apexpages.currentpage().getparameters().get('modelId');
        RX_DownloadCustomObject.exportModel(modelId);
        getExportStatus();
        return null;
    }

    public PageReference exportProduct() {
        String productId = apexpages.currentpage().getparameters().get('prodId');
        RX_DownloadCustomObject.exportProduct(productId);
        getExportStatus();
        return null;
    }

    public PageReference exportModelsButton() {
        RX_DownloadCustomObject.exportALL();
        getExportStatus();
        return null;
    }
    
    public List<RX_ExIm_Status__c> getExportStatus() {
        expStatus=[Select Id, Id__c, Submitted__c, Finished__c, Status__c, Job_ID__c From RX_ExIm_Status__c where Id__c = 'Export ALL' limit 1];
        return expStatus;
    }

    public List<RX_ExIm_Status__c> getImportStatus() {
        impStatus= [Select Id, Id__c, Submitted__c, Finished__c, Status__c, Job_ID__c From RX_ExIm_Status__c where Id__c like 'Import%' limit 1];
        return impStatus;
    }
 
    public List<String> getRevvyObjects() {
        List<String> result = new List<String>();
        for(Import_Export_Order__mdt ios: [select Custom_Object_Name__c from Import_Export_Order__mdt order by sequence__c]) {
            result.add(ios.Custom_Object_Name__c);
        }
        return result;      
    }
    
    public PageReference  uploadCVFile() {
        ContentVersion cont = new ContentVersion();

        cont.Title = 'IMP_' + zipFileName.replaceAll('EXP_','');
        cont.PathOnClient = zipFileName.replaceAll('EXP_','') + '.json';
        cont.VersionData = Blob.valueOf(zipContent); //EncodingUtil.base64Decode(zipContent);
        cont.Origin = 'H';

        insert cont;
        upsert new RX_ExIm_Status__c(
            Submitted__c =  Datetime.now(),
            Status__c = 'In Progress',
            ID__c = 'Import All',
            Note__c = 'Uploading ' + cont.Title
        ) Id__c;
        
        return null;
    }   
    
    public PageReference refreshStatus() {
        getExportStatus();
        getImportStatus();
        return null;
    }
    
    @RemoteAction
    public static String createNewContent(String sObjectName, String jsonData) {
        ContentVersion cont = new ContentVersion();

        cont.Title = 'IMP_' + sObjectName.replaceAll('EXP_','');
        cont.PathOnClient = sObjectName + '.json';
        cont.VersionData = Blob.valueOf(jsonData);
        cont.Origin = 'H';

        insert cont;
        return cont.Title;
    }
    
    @RemoteAction
    public static void removeImportedFiles() {
        
        RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Delete',Status__c='In Progress', Submitted__c=System.now(), Job_ID__c=null, Finished__c=null);
        upsert rxstatus Id__c;
        
        delete [select id from ContentDocument where title like 'IMP_%'];
    }

    @RemoteAction
    public static void updateImportedStatus() {
        datetime mydate = system.now();
        integer d = mydate.day();
        integer m = mydate.month();
        integer h = mydate.hour();
        integer s = mydate.second();
        integer min = mydate.minute();
        integer yr = mydate.year();
        if (min == 59)
        {
            min = 0;
            h = h + 1;
        }
        else min = min + 1;
        
        String sch = string.valueof(s) + ' ' + string.valueof(min) + ' ' + string.valueof(h) + ' ' + string.valueof(d) + ' ' + string.valueof(m) + ' ' + '?' + ' ' + string.valueof(yr);
    	
    	 upsert new RX_ExIm_Status__c(
            Submitted__c =  Datetime.now(),
            Status__c = 'In Progress',
            ID__c = 'Import All',
            Note__c = 'Start importing CPQ data... '
        ) Id__c;
        
    	RX_DownloadCustomObject.importAll(); 
    	
    	//RX_ExportImportBatch schlr=new RX_ExportImportBatch();
        //String scheduleName = 'REVVY Import Batch';
    	//String jobId=System.schedule(scheduleName, sch, schlr);

		//rxstatus = new RX_ExIm_Status__c(Id__c='Import',Status__c='Job Scheduled for Import at '+ sch, Job_ID__c=jobId, Finished__c=null);
		//upsert rxstatus Id__c;
		
		//    	
    }
    
    @RemoteAction
    public static void removeExportedFiles() {
        
        RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Export',Status__c='In Progress', Submitted__c=System.now(), Job_ID__c=null, Finished__c=null);
        upsert rxstatus Id__c;
        
        delete [select id from ContentDocument where title like 'EXP_%'];
    }
    
    @RemoteAction
    public static List<String> getContentIds() {
        List<String> result = new List<String>();
        for(ContentVersion cv:[Select Id from ContentVersion where Title like 'EXP_%' and Origin = 'H']) {
            result.add(cv.Id);
        }
        return result; 
    }
    
     
    @RemoteAction 
    public static ContentWrapper getContent(String cvId) {
         
        ContentVersion cv = [select Id, Title, VersionData
                          from ContentVersion
                          where Id = :cvId];
         
        ContentWrapper wrapper = new ContentWrapper();
        wrapper.encodedBody = EncodingUtil.base64Encode(cv.VersionData);
        wrapper.name = cv.Title;
                           
        return wrapper;
    }

    @RemoteAction
    public static List<REVVY__MnConfigEngineModel__c> getModels() {
    
        List<REVVY__MnConfigEngineModel__c> models = [Select r.REVVY__Status__c, r.REVVY__Id__c, r.Name From REVVY__MnConfigEngineModel__c r where r.Revvy__Status__c = 'In Production'];
        return models;
            
    }     

    @RemoteAction
    public static List<REVVY__MnCatalogNode__c> getProducts() {
        return RX_DownloadDAO.getProducts();
            
    }     
     
    public class ContentWrapper {
        public String encodedBody {get; set;}
        public String name {get; set;}
    }     
     

}