public with sharing class RoyTest {
	public static void genPackage() {
		 
		//List<String> sobjNames = new List<String> {'REVVY__MnQuote__c', 'REVVY__MnCatalogNode__c', 'REVVY__MnQuoteItem__c', 'REVVY__MnQuoteItemSubLine__c',
		//	 'REVVY__MnPriceList__c', 'REVVY__MnPriceListLine__c', 'REVVY__MnCatalogAttributeValue__c', 'REVVY__MnConfigEngineOption__c', 'REVVY__MnConfigEngineOptionGroup__c',
		//	 'REVVY__MnQiSubLineAttribute__c', 'REVVY__MnQuoteItemAttribute__c'};
		List<String> sobjNames = new List<String> {'REVVY__MnQuote__c', 'REVVY__MnCatalogNode__c', 'REVVY__MnQuoteItem__c', 'REVVY__MnQuoteItemSubLine__c',
			 'REVVY__MnPriceList__c', 'REVVY__MnPriceListLine__c',  
			 'REVVY__MnQiSubLineAttribute__c', 'REVVY__MnQuoteItemAttribute__c', 'Revvy__MnQuoteSolution__c', 'Revvy__MnQuoteSolutionAttribute__c'};
		for(String sobjName : sobjNames) {
			Schema.Describesobjectresult dr = Schema.getGlobalDescribe().get(sobjName.toLowerCase()).getDescribe();
			Map<String, Schema.SObjectField> fieldMap = dr.fields.getMap();
			for( String fieldName : fieldMap.keySet() ) {
			    Schema.SObjectField field = fieldMap.get( fieldName );
			    Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
			    if(fieldDescribe.isCustom()) {
			    	if(!fieldDescribe.getLocalName().startsWithIgnoreCase('REVVY__'))
			    	system.debug('<members>'+sobjName + '.' +  fieldDescribe.getLocalName() + '</members>' );
			    }
			}
		}
		
	}
	
	public static void genFLS() {
		 
		//List<String> sobjNames = new List<String> {'REVVY__MnQuote__c', 'REVVY__MnCatalogNode__c', 'REVVY__MnQuoteItem__c', 'REVVY__MnQuoteItemSubLine__c',
		//	 'REVVY__MnPriceList__c', 'REVVY__MnPriceListLine__c', 'REVVY__MnCatalogAttributeValue__c', 'REVVY__MnConfigEngineOption__c', 'REVVY__MnConfigEngineOptionGroup__c',
		//	 'REVVY__MnQiSubLineAttribute__c', 'REVVY__MnQuoteItemAttribute__c'};
		List<String> sobjNames = new List<String> {'REVVY__MnQuote__c', 'REVVY__MnCatalogNode__c', 'REVVY__MnQuoteItem__c', 'REVVY__MnQuoteItemSubLine__c',
			 'REVVY__MnPriceList__c', 'REVVY__MnPriceListLine__c',  
			 'REVVY__MnQiSubLineAttribute__c', 'REVVY__MnQuoteItemAttribute__c', 'Revvy__MnQuoteSolution__c', 'Revvy__MnQuoteSolutionAttribute__c'};
		for(String sobjName : sobjNames) {
			Schema.Describesobjectresult dr = Schema.getGlobalDescribe().get(sobjName.toLowerCase()).getDescribe();
			Map<String, Schema.SObjectField> fieldMap = dr.fields.getMap();
			for( String fieldName : fieldMap.keySet() ) {
			    Schema.SObjectField field = fieldMap.get( fieldName );
			    Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
			    if(fieldDescribe.isCustom()) {
			    	//if(!fieldDescribe.getLocalName().startsWithIgnoreCase('REVVY__'))
			    	system.debug('<members>'+sobjName + '.' +  fieldDescribe.getLocalName() + '</members>' );
			    }
			}
		}
		
	}
}