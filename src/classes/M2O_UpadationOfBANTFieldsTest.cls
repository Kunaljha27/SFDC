/***Class Name :M2O_UpadationOfBANTFieldsTest 
    Description : Test class for M2O_UpadationOfBANTFields trigger
    Written By : Somdev Bhattacharyya
**/ 
@isTest(SeeAllData=false)
public class M2O_UpadationOfBANTFieldsTest {
    Public static testMethod void M2O_UpadationOfBANT () {
        insert (M2O_OpportunityTestDataUtility.getLeadList());
    }
}