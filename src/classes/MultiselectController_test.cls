/**
@Classname :       MultiselectController_test
@Description :     This test class is written to test the Apex class MultiselectController
@Author:           Nishant
@Last Modified:    3/22/2014
**/
@isTest(SeeAllData=false)
public Class MultiselectController_test {

    /**
    @Description: Here in this,test method of MultiselectController class is tested.
    @Return: null 
    **/
    static testMethod void  test_setOptions() {  
        List<SelectOption> lftOptions = new List<SelectOption>();
        lftOptions.add(new SelectOption('1','--None--'));
        lftOptions.add(new SelectOption('2','--ABC--'));        
        List<SelectOption> rgtOptions = new List<SelectOption>();
        rgtOptions.add(new SelectOption('A','--None--'));
        rgtOptions.add(new SelectOption('B','--XYZ--'));
        MultiselectController testClsObj = new  MultiselectController();
        testClsObj.leftOptions = lftOptions ; 
        testClsObj.rightOptions = rgtOptions ;  
        String Str = testClsObj.leftOptionsHidden = '--None--&&ABC';
        system.assertnotequals(Str,null); 
        String Str1 = testClsObj.rightOptionsHidden = '--None--&&XYZ';
        system.assertnotequals(Str1,null); 
    }
}