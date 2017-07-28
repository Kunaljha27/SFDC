/**
* @ClassName : M2O_checkRecursiveTest
* @Description : 
* @Author : Somdev
* @Last Modified :
* @Discussionpoints : No Information 
*/

@isTest(SeeAllData=false)
Public class M2O_checkRecursiveTest{
    public static testMethod void test_M2O_checkRecursiveTest(){
        M2O_checkRecursive con = new M2O_checkRecursive();
        M2O_checkRecursive.runOnce();
        M2O_checkRecursive.run1Once();
        M2O_checkRecursive.run2Once();
    }
}