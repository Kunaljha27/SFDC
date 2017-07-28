public with sharing class RX_Utils {
	private static Map<String, Schema.SObjectType> globalDesc = null;
	static {
		globalDesc = Schema.getGlobalDescribe();
	}
	public static String convertIntegerWithPadding(Integer sequence, integer digit, String padding) {
		String text = String.valueOf(sequence);
		while (text.length() < digit)  { 
			text = padding + text; 
		}
		return text;
	}
	
	public static Map<String, Schema.SObjectField> generateFieldMapForCustomObject(String sObjName) {
		Schema.Describesobjectresult dr = globalDesc.get(sobjName.toLowerCase()).getDescribe();
		Map<String, Schema.SObjectField> fieldMap = dr.fields.getMap();
		return fieldMap;
	} 
	
	public static String getSObjectName(String fileName) {
		integer startIndex = fileName.indexOf('_');
		integer endIndex = fileName.lastIndexOf('_');
		return fileName.substring(startIndex+1, endIndex);
	}
}