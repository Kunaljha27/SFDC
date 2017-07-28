@isTest
private class Test_ErrorsControllerD {
	
	@isTest static void test_method_one() {
		ErrorsControllerD contr = new ErrorsControllerD(); 
		ObjectSettings__c os = new ObjectSettings__c(name='Contact');
		insert os; 
		
		contr.selectedObject = 'selectedObj';
		contr.sObjectType = 'sObjectType';
		contr.getSOList();
		contr.geterrors();
		contr.geteTotalTok();
		contr.geteTotalDeTok();
		contr.geteSelectedObj();
		contr.getSObjectsList();

		contr.empty();

	}
	 
	
}