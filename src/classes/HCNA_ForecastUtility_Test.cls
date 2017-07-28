/**
@Classname :       HCNA_ForecastUtility_Test
@Description :     This test class is written to test the Apex class HCNA_SplitAmount
@Author:           Harmeet
@Last Modified:    4/30/2014
**/

@isTest
class HCNA_ForecastUtility_Test {

    /**    
    * @Description : Test method to check append comma to amount functionality
    **/
    static testMethod void test_GetComma(){
        Test.startTest();
        HCNA_ForecastUtility getAmount = new HCNA_ForecastUtility();
        String splitAmount;
        splitAmount = '100';
        String Str = getAmount.GetComma(SplitAmount);
        system.assertnotequals(Str,null);
        splitAmount = '10001';
        getAmount.GetComma(SplitAmount);
        splitAmount = '100002002';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900056000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900356000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '100100100002';
        getAmount.GetComma(SplitAmount);
        splitAmount = '101011011022';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900450000000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '952451234200';
        getAmount.GetComma(SplitAmount);
        splitAmount = '952051234200';
        getAmount.GetComma(SplitAmount);
        splitAmount = '10002100002';
        getAmount.GetComma(SplitAmount);
        splitAmount = '1000000000000000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900000000000000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900012000000000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '900002011012000';
        getAmount.GetComma(SplitAmount);
        splitAmount = '99999999';
        getAmount.GetComma(SplitAmount);
        splitAmount = '99999999999999';
        getAmount.GetComma(SplitAmount);
        splitAmount = '999999999999';
        getAmount.GetComma(SplitAmount);
        splitAmount = '1000000000000000222';
        getAmount.GetComma(SplitAmount);
        splitAmount = '1011011011011222';  
        getAmount.GetComma(SplitAmount);         
        getAmount.right('',0);
        getAmount.right('10',3);
    }    
}