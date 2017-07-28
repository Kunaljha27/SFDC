global class RX_ImportCustomObjectBatchable implements Database.Batchable<sObject>,  Database.Stateful {
	Id journalId;
	String query;
	String currentObject;
	Integer fileSequence = 1;
	Integer customObjectIndex = 0;
	Integer batchSize;
	Map<String, String> externalIdMap;
	Map<String, RX_IOMetadataWrapper> ioMatadataWrapperMap;
	Map<String, Schema.SObjectField> fieldMap;
	RX_IOMetadataWrapper currentMetadata;
	List<RX_IOMetadataWrapper> ioMatadataWrapperList;
	Boolean isUpsert;
	Integer importedRecords = 0;
	global RX_ImportCustomObjectBatchable(Map<String, RX_IOMetadataWrapper> ioMetaData, List<RX_IOMetadataWrapper> listIOMetadata, Map<String, String> externalIdMap,  Integer index, Integer batchSize, Id jId) { 
		this.customObjectIndex = index;
		this.journalId = jId;
		this.batchSize = batchSize;
		this.ioMatadataWrapperMap = ioMetaData;
		this.ioMatadataWrapperList = listIOMetadata;
		this.externalIdMap = externalIdMap;
		this.currentMetadata = ioMatadataWrapperList[customObjectIndex];
		this.fieldMap = RX_Utils.generateFieldMapForCustomObject(currentMetadata.Custom_Object_Name);
		currentObject = currentMetadata.Custom_Object_Name;
		system.debug('obj name = -----------------' + currentMetadata.Custom_Object_Name);
		this.query = 'select title, VersionData from contentVersion where title like \'IMP_' + currentMetadata.Custom_Object_Name + '%\' Order by ExternalDocumentInfo2';
		system.debug('query = -----------------' + this.query);
	}
	
    public static void test(string name) {
		List<ContentVersion> cvs = [select title, VersionData from contentVersion where title = :name ];
		for(ContentVersion cv : cvs) {
			String jsonData = cv.VersionData.toString();
			//system.debug('-----json data=' + jsonData);
            list< RX_SObjectWrapper > objList2 = (list< RX_SObjectWrapper >) JSON.deserialize(jsonData, List<RX_SObjectWrapper>.class);
            for(RX_SObjectWrapper m1 : objList2) { 
				//system.debug('--------------------- RX_SObjectWrapper =' + m1);
				map<string, object> mData = m1.getSObjectAsMap();
                //system.debug(mData);
            }
		}
	}
	
	public static void loadOneFile(string name, integer index) {
		RX_DownloadCustomObject co = new RX_DownloadCustomObject();
		Map<String, RX_IOMetadataWrapper> ioMatadataWrapperMap;
		datetime myDateTime = datetime.now();
		RX_ExIm_Journal__c j = new RX_ExIm_Journal__c(name=myDateTime.format());
		insert j;
		Set<String> objectNameSet = new Set<String>();
		RX_ImportCustomObjectBatchable ioBatchable = new RX_ImportCustomObjectBatchable(co.ioMatadataWrapperMap, co.listIOMetadata, co.getExternalIdMap(), index, 1, j.Id);
		
		List<ContentVersion> cvs = [select title, VersionData from contentVersion where title = :name ];
		for(ContentVersion cv : cvs) {
			ioBatchable.execute(null, (List<sObject>) cvs);
		}
		//List<REVVY__MnConfigEngineRuleDataCell__c> ll = [select id from REVVY__MnConfigEngineRuleDataCell__c];
		//system.debug('----------------size = ' + ll.size());
		//for(REVVY__MnConfigEngineRuleDataCell__c l : ll) {
		//	system.debug('----------------' + l);
		//}
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}
	
   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   		
   		System.debug('execute');
   		List<SObject> insertObjs = new List<SObject>();
   		//boolean needUpsert = wrapper.NeedUpsert;
   		if(currentMetadata.NeedUpsert && 'REVVY__MnImportFormat__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnImportFormat__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogNode__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogNode__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogAttribute__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogAttribute__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogAttributeValue__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogAttributeValue__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogAttribute__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogAttribute__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogNodeAttr__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogNodeAttr__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnCatalogNodeLocaleExt__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnCatalogNodeLocaleExt__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnExpressionCondition__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnExpressionCondition__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnExpression__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnExpression__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnExpressionRef__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnExpressionRef__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineModel__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineModel__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineOptionGroup__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineOptionGroup__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineOption__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineOption__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnPriceList__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnPriceList__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnPriceListLine__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnPriceListLine__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnPrintTemplate__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnPrintTemplate__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineRuleDataCell__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineRuleDataCell__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineRule__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineRule__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnTier__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnTier__c>();
   		} 
   		
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnTieredPricing__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnTieredPricing__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineUILayout__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineUILayout__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnConfigEngineUISection__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnConfigEngineUISection__c>();
   		} 
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnQuoteRecordTypeFieldSetMapping__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnQuoteRecordTypeFieldSetMapping__c>();
   		}
   		else if(currentMetadata.NeedUpsert && 'REVVY__MnOptionGroupAttributeJunction__c'.equalsIgnoreCase(currentMetadata.Custom_Object_Name)) {
   			insertObjs = new List<REVVY__MnOptionGroupAttributeJunction__c>();
   		} 
   		
		for(sObject obj : scope){
			ContentVersion cv = (ContentVersion) obj;
			//String objName = RX_Utils.getSObjectName(cv.title);
			System.debug('Loading data for ----------------------------' + currentMetadata.Custom_Object_Name);
			String jsonData = cv.VersionData.toString();
			system.debug('--------------------- object =' + currentMetadata.Custom_Object_Name);
			list< RX_SObjectWrapper > objList2 = (list< RX_SObjectWrapper >) JSON.deserialize(jsonData, List<RX_SObjectWrapper>.class); 
			//system.debug('--------------------- RX_SObjectWrapper list =' + objList2);
			for(RX_SObjectWrapper m1 : objList2) { 
				//system.debug('--------------------- RX_SObjectWrapper =' + m1);
				map<string, object> mData = m1.getSObjectAsMap();
				sObject o = Schema.getGlobalDescribe().get(currentMetadata.Custom_Object_Name).newSObject();
				system.debug('new sobject =' + o);
				for(string key : mData.keyset()) {
					system.debug(logginglevel.info, 'sobject key = ' + key + ' data = ' + mData.get(key));
					if(!(key.startsWithIgnoreCase('REVVY__Parent') && currentMetadata.MasterLabel == 'CatalogNodeImportWOParent'))
					{
					if(key.endsWith('__r')) {
						Schema.Describefieldresult dField = fieldMap.get(key.replace('__r', '__c')).getDescribe();
						if(dField.getType() == Schema.DisplayType.Reference ) {
							system.debug('reference type key = ' + key + ' data = ' + mData.get(key));
		            		list<Schema.sObjectType > referenceTo = dField.getReferenceTo();
		            		String referenceName = referenceTo[0].getDescribe().getName();
		            		Map<String, Object> m2 = (Map<String, Object>) mData.get(key);
		            		system.debug(logginglevel.info, 'currentMetadata.NeedUpsert='+currentMetadata.NeedUpsert);
		            		if(currentMetadata.NeedUpsert) {
		            			if(currentMetadata.Custom_Object_Name.equalsIgnoreCase(referenceName)) {
		            				//self-referencing, 
		            				System.Type extType = System.Type.forName(referenceName);
				            		SObject parentObj = (SObject) extType.newInstance();
				            		String extIdName = externalIdMap.get(referenceName);
				            		parentObj.put(extIdName, m2.get(extIdName));
				            		String v= (String)mData.get(currentMetadata.Upsert_Field.replace('__r', '__c'));
				            		o.put(currentMetadata.Upsert_Field, v);
				            		o.putSObject(key, parentObj);
		            			} else {
		            				system.debug('2 reference type key = ' + key + ' data = ' + mData.get(key));
		            				System.Type extType = System.Type.forName(referenceName);
				            		SObject extObj = (SObject) extType.newInstance();
				            		String extIdName = externalIdMap.get(referenceName);
				            		System.debug('----------------------' + extIdName);
				            		extObj.put(extIdName, m2.get(extIdName));
				            		o.putSObject(key, extObj);
		            			}
	            			} else {
	            				//System.debug('check point 16 ----------------------------' );
	            				if(!currentMetadata.Custom_Object_Name.equalsIgnoreCase(referenceName)) {
	            					System.Type extType = System.Type.forName(referenceName);
				            		SObject extObj = (SObject) extType.newInstance();
				            		String extIdName = externalIdMap.get(referenceName);
				            		//System.debug('----------------------' + extIdName);
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
				}
				insertObjs.add(o);
			}
			if(currentMetadata.NeedUpsert) {
				Database.upsertResult[] srList = null;
				if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnImportFormat__c')) {
					List<REVVY__MnImportFormat__c> pList = (List<REVVY__MnImportFormat__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogNode__c')) {
					List<REVVY__MnCatalogNode__c> pList = (List<REVVY__MnCatalogNode__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogAttribute__c')) {
					List<REVVY__MnCatalogAttribute__c> pList = (List<REVVY__MnCatalogAttribute__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogAttributeValue__c')) {
					List<REVVY__MnCatalogAttributeValue__c> pList = (List<REVVY__MnCatalogAttributeValue__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogAttribute__c')) {
					List<REVVY__MnCatalogAttribute__c> pList = (List<REVVY__MnCatalogAttribute__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogNodeAttr__c')) {
					List<REVVY__MnCatalogNodeAttr__c> pList = (List<REVVY__MnCatalogNodeAttr__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnCatalogNodeLocaleExt__c')) {
					List<REVVY__MnCatalogNodeLocaleExt__c> pList = (List<REVVY__MnCatalogNodeLocaleExt__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnExpressionCondition__c')) {
					List<REVVY__MnExpressionCondition__c> pList = (List<REVVY__MnExpressionCondition__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnExpression__c')) {
					List<REVVY__MnExpression__c> pList = (List<REVVY__MnExpression__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnExpressionRef__c')) {
					List<REVVY__MnExpressionRef__c> pList = (List<REVVY__MnExpressionRef__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineModel__c')) {
					List<REVVY__MnConfigEngineModel__c> pList = (List<REVVY__MnConfigEngineModel__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineOptionGroup__c')) {
					List<REVVY__MnConfigEngineOptionGroup__c> pList = (List<REVVY__MnConfigEngineOptionGroup__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineOption__c')) {
					List<REVVY__MnConfigEngineOption__c> pList = (List<REVVY__MnConfigEngineOption__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnPriceList__c')) {
					List<REVVY__MnPriceList__c> pList = (List<REVVY__MnPriceList__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnPriceListLine__c')) {
					List<REVVY__MnPriceListLine__c> pList = (List<REVVY__MnPriceListLine__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnPrintTemplate__c')) {
					List<REVVY__MnPrintTemplate__c> pList = (List<REVVY__MnPrintTemplate__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineRuleDataCell__c')) {
					List<REVVY__MnConfigEngineRuleDataCell__c> pList = (List<REVVY__MnConfigEngineRuleDataCell__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineRule__c')) {
					List<REVVY__MnConfigEngineRule__c> pList = (List<REVVY__MnConfigEngineRule__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnTier__c')) {
					List<REVVY__MnTier__c> pList = (List<REVVY__MnTier__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnTieredPricing__c')) {
					List<REVVY__MnTieredPricing__c> pList = (List<REVVY__MnTieredPricing__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineUILayout__c')) {
					List<REVVY__MnConfigEngineUILayout__c> pList = (List<REVVY__MnConfigEngineUILayout__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnConfigEngineUISection__c')) {
					List<REVVY__MnConfigEngineUISection__c> pList = (List<REVVY__MnConfigEngineUISection__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				} else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnQuoteRecordTypeFieldSetMapping__c')) {
					List<REVVY__MnQuoteRecordTypeFieldSetMapping__c> pList = (List<REVVY__MnQuoteRecordTypeFieldSetMapping__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				}
				 else if(currentMetadata.Custom_Object_Name.equalsIgnoreCase('REVVY__MnOptionGroupAttributeJunction__c')) {
					List<REVVY__MnOptionGroupAttributeJunction__c> pList = (List<REVVY__MnOptionGroupAttributeJunction__c>) insertObjs;
					Schema.SObjectField upsertField = fieldMap.get(currentMetadata.Upsert_Field);
					srList = Database.upsert(pList, upsertField, false);
					//upsert pList REVVY__Id__c;
				}
				
				
				// Iterate through each returned result
				List<RX_ExIm_Status__c> exImpLst = new  List<RX_ExIm_Status__c>();
				List<RX_ExIm_Journal_Item__c> journalItems = new List<RX_ExIm_Journal_Item__c>();
				integer exceptionIndex = 1;
				if(srList != null) {
				    for (Database.upsertResult sr : srList) {
				        if (sr.isSuccess()) {
				            // Operation was successful, so get the ID of the record that was processed
				            System.debug('Successfully inserted record. id: ' + sr.getId());
				            journalItems.add(new RX_ExIm_Journal_Item__c(
				            	RX_ExIm_Journal__c = this.journalId,
				            	Object_Name__c = currentMetadata.Custom_Object_Name,
				            	IsCreated__c = sr.IsCreated(),
				            	SFDC_Id__c=sr.getId()
				            	
				            ));
				        }
				        else {
				            // Operation failed, so get all errors   
				            
				                        
				            for(Database.Error err : sr.getErrors()) {
				            	string errorCode = 'The following error has occurred.';
				                 
				                errorCode +=   err.getStatusCode() + '; ' + err.getMessage();                 
				                
				                errorCode += ' affected this error:' + err.getFields();
				                System.debug(errorCode);
				                RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c=currentMetadata.Custom_Object_Name + exceptionIndex, Status__c='error ' , Submitted__c=System.now(),
									Note__c = errorCode);
								exceptionIndex++;
								exImpLst.add(rxstatus);
								journalItems.add(new RX_ExIm_Journal_Item__c(
					            	RX_ExIm_Journal__c = this.journalId,
					            	Object_Name__c = currentMetadata.Custom_Object_Name,
					            	note__c=errorCode,
					            	SFDC_Id__c=sr.getId()
					            	
					            ));
				            
				            }
				            
				        }
				    }
				}
				if(exImpLst.size() > 0) {
	            	upsert exImpLst Id__c;
	            }
				if(journalItems.size() > 0) {
					insert journalItems;
				}
			} else {
				List<RX_ExIm_Journal_Item__c> journalItems2 = new List<RX_ExIm_Journal_Item__c>();
				Database.SaveResult[] srList = Database.insert(insertObjs, false);
				//insert insertObjs;
				// Create two accounts, one of which is missing a required field
				for (Database.SaveResult sr : srList) {
				    if (sr.isSuccess()) {
				        journalItems2.add(new RX_ExIm_Journal_Item__c(
			            	RX_ExIm_Journal__c = this.journalId,
			            	Object_Name__c = currentMetadata.Custom_Object_Name,
			            	IsCreated__c = true,
			            	SFDC_Id__c=sr.getId()
			            ));
				    }
				    else {
				        // Operation failed, so get all errors                
				        for(Database.Error err : sr.getErrors()) {
				            string errorCode = 'The following error has occurred.';
			                errorCode +=   err.getStatusCode() + '; ' + err.getMessage();                 
			                errorCode += ' affected this error:' + err.getFields();
							journalItems2.add(new RX_ExIm_Journal_Item__c(
				            	RX_ExIm_Journal__c = this.journalId,
				            	Object_Name__c = currentMetadata.Custom_Object_Name,
				            	note__c=errorCode,
				            	SFDC_Id__c=sr.getId()
				            ));
				        }
				    }
				}
				if(journalItems2.size() > 0) {
					insert journalItems2;
				}

			}
			
		}
		importedRecords += scope.size();
		upsert new RX_ExIm_Status__c(Id__c='Import All', Status__c='In Progress', Submitted__c=System.now(),
			Note__c = 'Upserted ' + importedRecords + ' ' +currentMetadata.Custom_Object_Name + ' records in step ' + (customObjectIndex+1) + ' of ' + ioMatadataWrapperMap.size()) id__c;
	}
	
	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
        	TotalJobItems, CreatedBy.Email, ExtendedStatus
        	from AsyncApexJob where Id = :bc.getJobId()];        
        	system.debug('--------------------- finish');
        	
	    if(a.Status == 'Completed') {
	    	system.debug('--------------------- Completed');
			if(customObjectIndex+1 < ioMatadataWrapperMap.size()) {
			//if(customObjectIndex+1 < 5) {
		    	RX_ImportCustomObjectBatchable exp = new RX_ImportCustomObjectBatchable(this.ioMatadataWrapperMap, ioMatadataWrapperList, externalIdMap, customObjectIndex+1, batchSize, journalId);
		    	Database.executeBatch(exp, batchSize);
		    } else{
		    	//upsert new RX_ExIm_Status__c(Id__c='Import',Status__c='Completed', Finished__c=System.now()) ID__c;
		    	RX_ExIm_Status__c rxstatus = new RX_ExIm_Status__c(Id__c='Import All', Status__c='Completed' , Finished__c=System.now(),
									Note__c = 'Done');
								upsert rxstatus Id__c;
		    }
		}
	}
	
}