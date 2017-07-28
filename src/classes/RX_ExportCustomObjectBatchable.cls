global class RX_ExportCustomObjectBatchable implements Database.Batchable<sObject>, Database.Stateful {
	String currentObject;
	String query;
	Integer fileSequence = 1;
	Integer customObjectIndex = 0;
	Integer batchSize;
	List<String> queryList = null;
	List<Import_Export_Order__mdt> ioMetaData = null;
	global RX_ExportCustomObjectBatchable(List<Import_Export_Order__mdt> ioMetaData, List<String> queryList,  Integer index, Integer batchSize) {
		this.customObjectIndex = index;
		this.batchSize = batchSize;
		this.queryList = queryList;
		this.ioMetaData = ioMetaData;
		query = queryList[customObjectIndex];
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   		try {
   			list<RX_SObjectWrapper> objList = new list<RX_SObjectWrapper>();
			for(SObject c : scope) {
				String j = JSON.serialize(c);
				map<string, object> m = (map<string, object> )JSON.deserializeUntyped(j);
				objList.add(new RX_SObjectWrapper(m));
			}

			String listJson = JSON.serialize(objList);
	   		insert generateNewContentVersionVersion(ioMetaData[customObjectIndex].Custom_Object_Name__c, listJson);
	   		fileSequence++;
	   	} catch (Exception e) {

	   	}
	}	
	
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
        	TotalJobItems, CreatedBy.Email, ExtendedStatus
        	from AsyncApexJob where Id = :bc.getJobId()];        
	    if(a.Status == 'Completed') {
	    	if(customObjectIndex+1 < ioMetaData.size()) {
	    		batchSize = (Integer) ioMetaData[customObjectIndex+1].BatchSize__c;
				if(batchSize == null) {
					batchSize = 100;
				}
				batchSize = 500;
				integer currentIndex = customObjectIndex+1;
				if(string.isNotBlank(currentObject)) {
					upsert new RX_ExIm_Status__c(
			    		Submitted__c = Datetime.now(),
			    		Finished__c = System.now(),
			    		Status__c = 'Submitted',
			    		ID__c = 'Export ALL',
			    		//Note__c = 'Exported ' +  a.JobItemsProcessed + ' out of ' + a.TotalJobItems + ' items of ' +  currentObject + '(Step ' + currentIndex + '/' + ioMetaData.size() + ')'
			    		Note__c = 'Exported ' +  currentObject + ' (Step ' + currentIndex + '/' + ioMetaData.size() + ')'
			    	) Id__c;
				}
		    	RX_ExportCustomObjectBatchable exp = new RX_ExportCustomObjectBatchable(ioMetaData, queryList, customObjectIndex+1, batchSize);
		    	Database.executeBatch(exp, batchSize);
		    } else{
		    	upsert new RX_ExIm_Status__c(Id__c='Export ALL',Status__c='Completed', Finished__c=System.now(), note__c='Done') ID__c;
		    }
		} 
	}
	
	//if(Limits.getHeapSize() + att.BodyLength > Limits.getLimitHeapSize()) {
    // Do something else
	//}
 
	public ContentVersion generateNewContentVersionVersion(String sObjectName, String jsonData) {
	    ContentVersion cont = new ContentVersion();
	    String fileSeq = RX_Utils.convertIntegerWithPadding(integer.valueOf(fileSequence), 3, '0');
	    cont.Title = 'EXP_' + sObjectName + '_'+fileSeq;
	    currentObject = sObjectName;
	    //cont.PathOnClient = 'file_' + Datetime.now().getTime() + '.txt';
	    cont.PathOnClient = sObjectName + '.json';
	    cont.ExternalDocumentInfo1 = RX_Utils.convertIntegerWithPadding(integer.valueOf(customObjectIndex), 3, '0');
	    cont.ExternalDocumentInfo2 =fileSeq;
	    cont.VersionData = Blob.valueOf(jsonData);
	    cont.Origin = 'H';
	    
	    //insert cont;

	    return cont;
	}
	
}