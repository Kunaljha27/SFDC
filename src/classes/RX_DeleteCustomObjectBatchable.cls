global class RX_DeleteCustomObjectBatchable implements Database.Batchable<sObject> {
	String query;
	Integer customObjectIndex = 0;
	Integer batchSize;
	list<RX_IOMetadataWrapper> ioMetaData = null;
	
	global RX_DeleteCustomObjectBatchable(list<RX_IOMetadataWrapper> ioMetaData, Integer index, Integer batchSize) {
		this.customObjectIndex = index;
		this.batchSize = batchSize;
		this.ioMetaData = ioMetaData;
		query = 'select id from ' + ioMetaData[customObjectIndex].Custom_Object_Name;
        system.debug(logginglevel.info, 'Query string: ' + query);
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		Database.delete(scope, true);
	}
	
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
        	TotalJobItems, CreatedBy.Email, ExtendedStatus
        	from AsyncApexJob where Id = :bc.getJobId()];        
        	system.debug('--------------------- finish');
	    if(a.Status == 'Completed') {
	    	system.debug('--------------------- Completed');
	    	if(customObjectIndex < ioMetaData.size()-1) {
		    	RX_DeleteCustomObjectBatchable exp = new RX_DeleteCustomObjectBatchable(ioMetaData, customObjectIndex+1, batchSize);
		    	Database.executeBatch(exp, batchSize);
		    } else{
		    	upsert new RX_ExIm_Status__c(Id__c='Delete ALL',Status__c='Completed', Finished__c=System.now()) ID__c;
		    }
			//	RX_ImportCustomObjectBatchable ioBatchable = new RX_ImportCustomObjectBatchable(currentIndex+1);
			//	Database.executeBatch(ioBatchable, 2);
			//}
		}
	}
	
}