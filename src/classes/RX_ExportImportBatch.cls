global class RX_ExportImportBatch implements Schedulable, Database.Batchable<Sobject>, Database.Stateful{

	global String requestType {get;set;}
	global List<String> objectNameList {get;set;}
	global String objectName {get;set;}
	global Integer currentPosition {get;set;}

    global void execute(SchedulableContext SC) {

		Set<String> objectNameSet = new Set<String>();
		List<String> tempobjectNameList = new List<String>();
		List<Import_Export_Order__mdt> ios = [select Custom_Object_Name__c, External_Id__c, sequence__c from Import_Export_Order__mdt order by sequence__c];
		for(Import_Export_Order__mdt m : ios) {
			if(!objectNameSet.contains(m.Custom_Object_Name__c)) {
				objectNameSet.add(m.Custom_Object_Name__c);
				tempobjectNameList.add(m.Custom_Object_Name__c);
			}
		}			
		
    	RX_ExportImportBatch batchProcess = new RX_ExportImportBatch();
    	batchProcess.requestType='Import';
    	batchProcess.objectName=tempobjectNameList[0];
    	batchProcess.objectNameList=tempobjectNameList;
    	batchProcess.currentPosition=0;
        Database.executebatch(batchProcess,1);		
        
        if(SC!=null && SC.getTriggerId()!=null)
	        System.abortJob(SC.getTriggerId());	
    }
    	
	global Database.QueryLocator start(Database.BatchableContext BC){

		
		String criteriaOrigin='H';
		String criteriaObjectName = ('Import'.equalsIgnoreCase(requestType) ? 'IMP_' : 'EXP_') + objectName + '%';
		String query = 'Select Id, VersionData From ContentVersion where Origin = :criteriaOrigin and Title like :criteriaObjectName';
		System.debug('>>> query='+query);
		RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c=requestType,Status__c='Processing ' + objectName, Finished__c=null);
		upsert rxstatus Id__c;

		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<Sobject> scope){
		if('Import'.equalsIgnoreCase(requestType)) {
			importProcess(scope);
		} else if('Export'.equalsIgnoreCase(requestType)) {
			exportProcess(scope);
		}
	}

	global void finish(Database.BatchableContext BC){
		if(currentPosition==null)
			currentPosition=0;
		currentPosition++;

		if(objectNameList==null)
			objectNameList = new List<String>();

		if(currentPosition < objectNameList.size()) {
			objectName = objectNameList[currentPosition];
	    	RX_ExportImportBatch batchProcess = new RX_ExportImportBatch();
	    	batchProcess.requestType=requestType;
	    	batchProcess.objectName=objectName;
	    	batchProcess.objectNameList=objectNameList;
	    	batchProcess.currentPosition=currentPosition;
	        Database.executebatch(batchProcess,1);			
		}
		if(currentPosition == (objectNameList.size())) {	
			RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Import',Status__c='Completed', Finished__c=System.now());
			upsert rxstatus Id__c;
			delete [select id from ContentDocument where title like 'IMP_%'];
		}	

	}
	
	private void importProcess(List<SObject> scope) {
		//TODO Import	
	}
	
	private void exportProcess(List<SObject> scope) {
		//Todo Export	
	}

}