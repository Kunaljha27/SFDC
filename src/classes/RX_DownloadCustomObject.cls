public with sharing class RX_DownloadCustomObject {
	class InternalException extends Exception {
 
	}
	public Map<String, String>  getExternalIdMap() { return externalIdMap;}
	private Map<String, String> externalIdMap = new Map<String, String>();
	private Map<String, Schema.SObjectType> globalDesc = null;
	public Map<String, RX_IOMetadataWrapper> ioMatadataWrapperMap;
	public List<RX_IOMetadataWrapper> listIOMetadata = new List<RX_IOMetadataWrapper>();
	public RX_DownloadCustomObject() {
		ioMatadataWrapperMap = new Map<String, RX_IOMetadataWrapper>();
		globalDesc = Schema.getGlobalDescribe();
		List<Import_Export_Order__mdt> ios = [select NamespacePrefix, DeveloperName, MasterLabel, Upsert_Field__c,  NeedUpsert__c, Custom_Object_Name__c, External_Id__c, sequence__c from Import_Export_Order__mdt order by sequence__c];
		for(Import_Export_Order__mdt m : ios) {
			externalIdMap.put(m.Custom_Object_Name__c, m.External_Id__c);
			RX_IOMetadataWrapper iometadata = new RX_IOMetadataWrapper(m.MasterLabel, m.DeveloperName );
			iometadata.Custom_Object_Name = m.Custom_Object_Name__c;
			iometadata.External_Id = m.External_Id__c;
			iometadata.NamespacePrefix = m.NamespacePrefix;
			iometadata.Sequence = m.sequence__c;
			iometadata.NeedUpsert = m.NeedUpsert__c;
			iometadata.Upsert_Field = m.Upsert_Field__c;
			ioMatadataWrapperMap.put(m.DeveloperName, iometadata);
			listIOMetadata.add(iometadata);
		}
		
	}

	public static void testImport() { 
		boolean needUpsert = false;
		String fileName = 'EXP_REVVY__MnCatalogNode__c_001';
		String objName = RX_Utils.getSObjectName(fileName);
		RX_DownloadCustomObject co = new RX_DownloadCustomObject();
		contentVersion cv = [select title, VersionData from contentVersion where title = :fileName limit 1];
			//String objName = cv.title.subString(4);
			//System.debug('-------------' + objName);
			//Type objClass = Type.forName(objName);
		String jsonData = cv.VersionData.toString();
		//system.debug('--------------------- jsonData=' + jsonData);
		list< RX_SObjectWrapper > objList2 = (list< RX_SObjectWrapper >) JSON.deserialize(jsonData, List<RX_SObjectWrapper>.class);
		List<SObject> insertObjs = new List<SObject>();
		Map<String, Schema.SObjectField> fieldMap = RX_Utils.generateFieldMapForCustomObject(objName); 

		for(RX_SObjectWrapper m1 : objList2) { 
			map<string, object> mData = m1.getSObjectAsMap();
			sObject o = Schema.getGlobalDescribe().get(objName).newSObject();
			for(string key : mData.keyset()) {
				if(key.endsWith('__r')) {
					Schema.Describefieldresult dField = fieldMap.get(key.replace('__r', '__c')).getDescribe();
					if(dField.getType() == Schema.DisplayType.Reference ) {
	            		list<Schema.sObjectType > referenceTo = dField.getReferenceTo();
	            		String referenceName = referenceTo[0].getDescribe().getName();
	            		Map<String, Object> m2 = (Map<String, Object>) m1.getSObjectAsMap().get(key);
						if(needUpsert) {
	            			if(objName.equalsIgnoreCase(referenceName)) {
	            				//self-referencing, 
	            				System.Type extType = System.Type.forName(referenceName);
			            		SObject parentObj = (SObject) extType.newInstance();
			            		String extIdName = co.getExternalIdMap().get(referenceName);
			            		parentObj.put(extIdName, m2.get(extIdName));
			            		SObject currentObj = (SObject) extType.newInstance();
			            		Map<String, Object> mc = (Map<String, Object>) m1.getSObjectAsMap().get('REVVY__Id__c');
			            		currentObj.put('REVVY__Id__c', m2.get(extIdName));
			            		currentObj.putSObject(key, parentObj);
	            			}
            			} else {
            				if(!objName.equalsIgnoreCase(referenceName)) {
            					System.Type extType = System.Type.forName(referenceName);
			            		SObject extObj = (SObject) extType.newInstance();
			            		String extIdName = co.getExternalIdMap().get(referenceName);
			            		System.debug('----------------------' + extIdName);
			            		extObj.put(extIdName, m2.get(extIdName));
			            		o.putSObject(key, extObj);
            				}
            			}
	            	} 
				} else {
					if(fieldMap.get(key) != null) {
						Schema.Describefieldresult dField = fieldMap.get(key).getDescribe();
						Schema.DisplayType displayType = dField.getType();
						if((dField.isNameField() && !dField.isAutoNumber()) || ((displayType != Schema.DisplayType.Reference) &&  dField.isCustom() && dField.isUpdateable())) {
							//o.put(key, mData.get(key));
							try {
								if(displayType == Schema.DisplayType.Date || displayType == Schema.DisplayType.Datetime ) {
									if(mData.get(key) != null) {
										string theDate = string.valueOf(mData.get(key));
										//system.debug(logginglevel.info, '  date = ' + theDate);
										o.put(key, Date.valueOf(theDate));
									}
								}  else {
									o.put(key,mData.get(key));
								}
							} catch(Exception e) {
							}

						}
					} 
				}				
			}
			insertObjs.add(o);
			system.debug('------' + o);
		}
		insert insertObjs;

	}

	public static void testExport() {
		RX_DownloadCustomObject co = new RX_DownloadCustomObject();
		String q = co.generateDynamicQuery('REVVY__MnCatalogNodeEdge__c');
		q += ' limit 10';
		list<REVVY__MnCatalogNodeEdge__c> cne = Database.query(q);
		list<RX_SObjectWrapper> objList = new list<RX_SObjectWrapper>();
		for(REVVY__MnCatalogNodeEdge__c c : cne) {
			String j = JSON.serialize(c);
			map<string, object> m = (map<string, object> )JSON.deserializeUntyped(j);
			objList.add(new RX_SObjectWrapper(m));
		}

		String listJson = JSON.serialize(objList);
		// import test

		
		List<SObject> insertObjs = new List<SObject>();
		Map<String, Schema.SObjectField> fieldMap = RX_Utils.generateFieldMapForCustomObject('REVVY__MnCatalogNodeEdge__c'); 

		list< RX_SObjectWrapper > objList2 = (list< RX_SObjectWrapper >) JSON.deserialize(listJson, List<RX_SObjectWrapper>.class);
		
		for(RX_SObjectWrapper m1 : objList2) { 
			map<string, object> mData = m1.getSObjectAsMap();
			sObject o = Schema.getGlobalDescribe().get('REVVY__MnCatalogNodeEdge__c').newSObject();
			for(string key : mData.keyset()) {
				if(key.endsWith('__r')) {
					Schema.Describefieldresult dField = fieldMap.get(key.replace('__r', '__c')).getDescribe();
					if(dField.getType() == Schema.DisplayType.Reference ) {
	            		list<Schema.sObjectType > referenceTo = dField.getReferenceTo();
	            		String referenceName = referenceTo[0].getDescribe().getName();
	            		//System.debug('reference to ' + referenceName);
	            		//System.debug('value = ' + m1.getSObjectAsMap().get(key));
	            		Map<String, Object> m2 = (Map<String, Object>) m1.getSObjectAsMap().get(key);
	            		//System.debug('external Id = ' + m2.get('REVVY__Id__c'));
	            		System.Type extType = System.Type.forName(referenceName);
	            		SObject extObj = (SObject) extType.newInstance();
	            		extObj.put('REVVY__Id__c', m2.get('REVVY__Id__c'));
	            		o.putSObject(key, extObj);
	            		system.debug('---------------new object 1---' + o);
	            	} 
				} else {
					if(fieldMap.get(key) != null) {
						Schema.Describefieldresult dField = fieldMap.get(key).getDescribe();
						if((dField.isNameField() && !dField.isAutoNumber()) || ((dField.getType() != Schema.DisplayType.Reference) &&  dField.isCustom() && dField.isUpdateable())) {
							system.debug('---------------key=--' + key + ' value =' + mData.get(key));
							o.put(key, mData.get(key));
						}
					} else {
						system.debug('---------------key--- isNull' + key);
					}
					//o.put(key, mData.get(key));
	            	//system.debug('---------------new object 2---' + o);
				}
				
			}
			insertObjs.add(o);
			//system.debug('---------------new object ---' + o);
		}
		insert insertObjs;
	}

	public static void deleteAll() {
		RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Delete ALL',Status__c='In Progress', Submitted__c=System.now(), Note__c='Delete all records');
		upsert rxstatus id__c;
		List<Import_Export_Order__mdt> ios = [select NamespacePrefix, DeveloperName, MasterLabel, Upsert_Field__c,  NeedUpsert__c, Custom_Object_Name__c, External_Id__c, sequence__c  from Import_Export_Order__mdt order by sequence__c desc];
		list<RX_IOMetadataWrapper> wrapperList = new List<RX_IOMetadataWrapper>();
		for(Import_Export_Order__mdt m : ios) {
			RX_IOMetadataWrapper iometadata = new RX_IOMetadataWrapper(m.MasterLabel, m.DeveloperName );
			iometadata.Custom_Object_Name = m.Custom_Object_Name__c;
			iometadata.External_Id = m.External_Id__c;
			iometadata.NamespacePrefix = m.NamespacePrefix;
			iometadata.Sequence = m.sequence__c;
			iometadata.NeedUpsert = m.NeedUpsert__c;
			iometadata.Upsert_Field = m.Upsert_Field__c;
			wrapperList.add(iometadata);
		}
		RX_DeleteCustomObjectBatchable exp = new RX_DeleteCustomObjectBatchable(wrapperList, 0, 100);
		Database.executeBatch(exp, 100);

	}
	
	public static void listAllQueries() {
		RX_DownloadCustomObject o = new RX_DownloadCustomObject();
		Set<String> objectNameSet = new Set<String>();
		List<Import_Export_Order__mdt> ios = [select Custom_Object_Name__c, External_Id__c, sequence__c, BatchSize__c from Import_Export_Order__mdt order by sequence__c asc];
		List<Import_Export_Order__mdt> validMetadataList = new List<Import_Export_Order__mdt>();
		List<String> queryList = new List<String>();
		for(Import_Export_Order__mdt m : ios) {
			try{
				if(!objectNameSet.contains(m.Custom_Object_Name__c)) {
					objectNameSet.add(m.Custom_Object_Name__c);
					queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c));
					validMetadataList.add(m);
				}
			} catch(InternalException e) {
				System.debug(m.Custom_Object_Name__c + ' has empty attributes');
			}	
		}
		System.debug('Listing all queries...');
		for(String s : queryList) {
			System.debug(s);
		}
	}
	public static void exportAll(){
		RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Export ALL',Status__c='In Progress', Submitted__c=System.now(), Finished__c=null);
		upsert rxstatus Id__c;
		
		List<ContentVersion> cvs = new List<ContentVersion>();
		RX_DownloadCustomObject o = new RX_DownloadCustomObject();
		o.removeExportedFiles();
		Set<String> objectNameSet = new Set<String>();
		List<Import_Export_Order__mdt> ios = [select Custom_Object_Name__c, External_Id__c, sequence__c, BatchSize__c from Import_Export_Order__mdt order by sequence__c asc];
		List<Import_Export_Order__mdt> validMetadataList = new List<Import_Export_Order__mdt>();
		List<String> queryList = new List<String>();
		for(Import_Export_Order__mdt m : ios) {
			try{
				if(!objectNameSet.contains(m.Custom_Object_Name__c)) {
					objectNameSet.add(m.Custom_Object_Name__c);
					queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c));
					validMetadataList.add(m);
				}
			} catch(InternalException e) {
				System.debug(m.Custom_Object_Name__c + ' has empty attributes');
			}	
		}

		decimal batchSize = validMetadataList[0].BatchSize__c;
		if(batchSize == null) {
			batchSize = 100;
		}
		RX_ExportCustomObjectBatchable exp = new RX_ExportCustomObjectBatchable(validMetadataList, queryList, 0, (Integer)batchSize);
		Database.executeBatch(exp, (Integer)batchSize);
		//insert cvs;
		
		//rxstatus.Status__c='Completed';
		//rxstatus.Finished__c=System.now();
		//update rxstatus;
	
	}
	
	public static void exportModel(String modelId) {
		RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Export ALL',Status__c='In Progress', Submitted__c=System.now(), Finished__c=null);
		upsert rxstatus Id__c;
		
		List<ContentVersion> cvs = new List<ContentVersion>();
		RX_DownloadCustomObject o = new RX_DownloadCustomObject();
		o.removeExportedFiles();
		Set<String> objectNameSet = new Set<String>();
		List<Import_Export_Order__mdt> ios = [select Custom_Object_Name__c, External_Id__c, sequence__c, BatchSize__c, Where_Clause__c from Import_Export_Order__mdt order by sequence__c asc];
		List<Import_Export_Order__mdt> validMetadataList = new List<Import_Export_Order__mdt>();
		List<String> queryList = new List<String>();
		Set<String> productIds = RX_DownloadDAO.getProductIdsForModel(modelId);		
		String productsString = '';
		for(String productId: productIds)
		{
			productsString += '\'' + productId + '\',';
		}
		productsString = productsString.subString(0,productsString.length()-1);
		System.debug(logginglevel.info, 'productsString=' + productsString);
		for(Import_Export_Order__mdt m : ios) {
			try{
				if(!objectNameSet.contains(m.Custom_Object_Name__c)) {
					objectNameSet.add(m.Custom_Object_Name__c);
					if(m.where_clause__c != null)
					{
						String whereClause = m.where_clause__c.replace('@REVVYID', modelId);
						whereClause = whereClause.replace('@REVVYPRODUCTIDS', productsString);
						queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c) + ' ' + whereClause);
						System.debug(logginglevel.info, 'query='+queryList);
					}
					else
					{
						queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c));
					}
					validMetadataList.add(m);
				}
			} catch(InternalException e) {
				System.debug(m.Custom_Object_Name__c + ' has empty attributes');
			}	
		}

		decimal batchSize = validMetadataList[0].BatchSize__c;
		if(batchSize == null) {
			batchSize = 100;
		}
		RX_ExportCustomObjectBatchable exp = new RX_ExportCustomObjectBatchable(validMetadataList, queryList, 0, (Integer)batchSize);
		Database.executeBatch(exp, (Integer)batchSize);
		//insert cvs;
		
		//rxstatus.Status__c='Completed';
		//rxstatus.Finished__c=System.now();
		//update rxstatus;
	}

	public static void exportProduct(String productId) {
		RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Export ALL',Status__c='In Progress', Submitted__c=System.now(), Finished__c=null);
		upsert rxstatus Id__c;
		
		List<ContentVersion> cvs = new List<ContentVersion>();
		RX_DownloadCustomObject o = new RX_DownloadCustomObject();
		o.removeExportedFiles();
		Set<String> objectNameSet = new Set<String>();
		List<Import_Export_Order__mdt> ios = [select Custom_Object_Name__c, External_Id__c, sequence__c, BatchSize__c, Product_Where_Clause__c, Where_Clause__c from Import_Export_Order__mdt order by sequence__c asc];
		List<Import_Export_Order__mdt> validMetadataList = new List<Import_Export_Order__mdt>();
		List<String> queryList = new List<String>();
		for(Import_Export_Order__mdt m : ios) {
			try{
				if(!objectNameSet.contains(m.Custom_Object_Name__c)) {
					objectNameSet.add(m.Custom_Object_Name__c);
					if(m.product_where_clause__c != null)
					{
						String whereClause = m.product_where_clause__c.replace('@REVVYID',productId);
						queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c) + ' ' + whereClause);
						System.debug(logginglevel.info, 'query='+queryList);
					}
					else
					{
						queryList.add(o.generateDynamicQuery(m.Custom_Object_Name__c));
					}
					validMetadataList.add(m);
				}
			} catch(InternalException e) {
				System.debug(m.Custom_Object_Name__c + ' has empty attributes');
			}	
		}

		decimal batchSize = validMetadataList[0].BatchSize__c;
		if(batchSize == null) {
			batchSize = 100;
		}
		RX_ExportCustomObjectBatchable exp = new RX_ExportCustomObjectBatchable(validMetadataList, queryList, 0, (Integer)batchSize);
		Database.executeBatch(exp, (Integer)batchSize);
		//insert cvs;
		
		//rxstatus.Status__c='Completed';
		//rxstatus.Finished__c=System.now();
		//update rxstatus;
	}

	public static void importAll() { 
		RX_DownloadCustomObject co = new RX_DownloadCustomObject();
		Map<String, RX_IOMetadataWrapper> ioMatadataWrapperMap;

		Set<String> objectNameSet = new Set<String>();
		datetime myDateTime = datetime.now();
		RX_ExIm_Journal__c j = new RX_ExIm_Journal__c(name=myDateTime.format());
		insert j;
		 
		RX_ImportCustomObjectBatchable ioBatchable = new RX_ImportCustomObjectBatchable(co.ioMatadataWrapperMap, co.listIOMetadata, co.getExternalIdMap(), 0, 1, j.Id);
		Database.executeBatch(ioBatchable, 1);
	}
	public void removeExportedFiles() {
		delete [select id from ContentDocument where title like 'EXP_%'];
	}

	//if(Limits.getHeapSize() + att.BodyLength > Limits.getLimitHeapSize()) {
    // Do something else
	//}

	
	public String generateDynamicQuery(String sobjName) {
		Schema.Describesobjectresult dr = globalDesc.get(sobjName.toLowerCase()).getDescribe();
		system.debug('--------' + dr.getName());
		Map<String, Schema.SObjectField> fieldMap = dr.fields.getMap();
		String querySelect = 'Select ';
		String queryBody='';
		for(String fName : fieldMap.keySet()) {
            
			if(String.isBlank(fName)) {
				continue;
			}
			Schema.Describefieldresult dField = fieldMap.get(fName).getDescribe();
            system.debug('------fName--' + fName + '  type =' + dField.getType() + dField.isUpdateable());
            if((dField.isNameField() && !dField.isAutoNumber()) || (dField.isCustom() && dField.isUpdateable()) || (dField.isCustom() && dField.getType() == Schema.DisplayType.Reference)) {
            	if(dField.getType() == Schema.DisplayType.Reference ) {
            		list<Schema.sObjectType > referenceTo = dField.getReferenceTo();
            		String referenceName = referenceTo[0].getDescribe().getName();
            		system.debug('referenceName=' + referenceName);
            		if(externalIdMap.containsKey(referencename)) {
            			String ln = dField.getLocalName().replace('__c', '__r');
						ln += '.' + externalIdMap.get(referencename);
						System.debug('------------------- referenceTo to =' + ln);
						queryBody += ln + ',';
            		} else {
            			//queryBody += dField.getLocalName() + ',';
            		}
				} else {
	            	queryBody += dField.getLocalName() + ',';
	            }
            } 
		}
		queryBody = queryBody.removeEnd(',');
		if(String.isBlank(queryBody)) {
			throw new InternalException();
		}
        string query = querySelect + queryBody + ' from ' + dr.getName();
        system.debug('----------' + query);
        //need to move following DML out of loop
		return query;
	}
}