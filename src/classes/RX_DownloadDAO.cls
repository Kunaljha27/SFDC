public class RX_DownloadDAO {

	public static List<REVVY__MnConfigEngineModel__c> getModels() {
	
		List<REVVY__MnConfigEngineModel__c> models = [Select r.REVVY__Status__c, r.REVVY__Id__c, r.Name From REVVY__MnConfigEngineModel__c r where r.Revvy__Status__c = 'In Production'];
		return models;
			
	}

	public static List<REVVY__MnCatalogNode__c> getProducts() {
	
		List<REVVY__MnCatalogNode__c> products = [Select r.REVVY__Id__c, r.Name From REVVY__MnCatalogNode__c r where r.REVVY__Type__c = 'Product'];
		return products;
			
	}
	
	public static Set<String> getProductIdsForModel(String modelId) {
		List<String> prodIds;
		Set<String> productIdset;
		List<REVVY__MnConfigEngineModel__c> models = [Select r.Revvy__Product_IDs__c From REVVY__MnConfigEngineModel__c r where r.Revvy__ID__c =: modelId];
		List <REVVY__MnCatalogNode__c> configurableProds = [Select r.REVVY__Id__c From REVVY__MnCatalogNode__c r where REVVY__Model__r.Revvy__Id__c =: modelId];
		if(models.size() > 0 )
		{
			if(models[0].Revvy__Product_IDs__c != null) {
				String productIds = models[0].Revvy__Product_IDs__c;        
            	prodIds = (List<String>) JSON.deserialize(
                                    productIds, List<String>.class);
                                    
               	productIdset = new Set<String>(prodIds);
        	} 
		}
		for(REVVY__MnCatalogNode__c configProd: configurableProds)
		{
			productIdset.add(configProd.Revvy__Id__c);
		}
        return productIdset;			
	}	

}