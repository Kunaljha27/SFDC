@isTest
public class HCNA_FilterWrapperTest {

    @isTest static void test_filterWrapper(){
        test.startTest();
        HCNA_FilterWrapper wraper = new HCNA_FilterWrapper();
        Integer count=0;
        List<SelectOption> fieldList = new List<SelectOption>();
        List<SelectOption> OperatorList = new List<SelectOption>();
        HCNA_FilterWrapper wrapper = new HCNA_FilterWrapper(count,fieldList,OperatorList);
        test.stopTest();
    }
}