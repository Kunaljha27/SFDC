public with sharing class RX_SObjectWrapper {
	String sObjectBase64 =null;
	public Map<string, object> getSObjectAsMap() {
		system.debug('-----------------------' + EncodingUtil.base64Decode(sObjectBase64).toString());
		return (Map<string, object>) JSON.deserializeUntyped(EncodingUtil.base64Decode(sObjectBase64).toString());
	}
	public RX_SObjectWrapper(map<string, object> m) {
		//System.Blob b = System.Blob.valueOf(innerObj);
		this.sObjectBase64 = EncodingUtil.base64Encode(Blob.valueOf(JSON.serialize(m)));
	}
}