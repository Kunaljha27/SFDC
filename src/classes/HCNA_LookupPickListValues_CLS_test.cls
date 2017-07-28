/*
Name: HCNA_LookupPickListValues_CLS_test
Description: Test class for HCNA_LookupPickListValues_CLS
*/

@isTest(SeeAllData=false)
public Class HCNA_LookupPickListValues_CLS_test {

/*
Name: test_HCNA_LookupPickListValues_CLS
Description: Test method to check the display of the Pick List values of selected picklist field.
*/

    static testMethod void  test_HCNA_LookupPickListValues_CLS () {

        Test.setCurrentPage(Page.HCNA_LookupPickListValuesPage);
        ApexPages.currentPage().getParameters().put('objectname', 'Account');
        ApexPages.currentPage().getParameters().put('fieldname', 'IsPartner');
        ApexPages.currentPage().getParameters().put('fieldType', 'Boolean');
        Test.startTest();
        HCNA_LookupPickListValues_CLS testPickList = new HCNA_LookupPickListValues_CLS();
        HCNA_LookupPickListValues_CLS.CheckboxOption cs= new HCNA_LookupPickListValues_CLS.CheckboxOption();
        HCNA_LookupPickListValues_CLS.CheckboxOption cs1= new HCNA_LookupPickListValues_CLS.CheckboxOption();
        List<HCNA_LookupPickListValues_CLS.CheckboxOption> options = new List<HCNA_LookupPickListValues_CLS.CheckboxOption>();
        cs.value = 'None';
        cs.selected = true;
        options.add(cs);
        cs1.value = 'None1';
        cs1.selected = true;
        options.add(cs1);
        testPickList.options = options;
        
        testPickList.Values();
        ApexPages.currentPage().getParameters().put('objectname', 'Account');
        ApexPages.currentPage().getParameters().put('fieldname', 'Rating');
        ApexPages.currentPage().getParameters().put('fieldType', 'PICKLIST');
        HCNA_LookupPickListValues_CLS testPickList2 = new HCNA_LookupPickListValues_CLS();
        Test.stopTest();
    }
}