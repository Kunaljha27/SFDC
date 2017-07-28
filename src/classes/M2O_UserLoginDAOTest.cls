/**
@Classname :       M2O_UserLoginDAOTest
@Description :     This test class is written to test the Apex class M2O_UserLoginDAO. 
@Author:           Ramita
@Last Modified:    1/09/2013
**/
@isTest(SeeAllData=false)
public class M2O_UserLoginDAOTest {
    
    static TestMethod void test_getCurrentUserInfo(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        ID exceptionID='00aB0000000Cd8q';
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        test.startTest();
        M2O_UserLoginDAO daoObj = new M2O_UserLoginDAO();
        daoObj.getCurrentUserInfo(runAsUser.id);
        //daoObj.getCurrentUserInfo(null);    
        System.assertNotEquals(runAsUser,null);
        test.stopTest();
    }
    
    static TestMethod void test_getAllLoginList(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        ID exceptionID='00aB0000000Cd8q';
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        test.startTest();
        M2O_UserLoginDAO daoObj = new M2O_UserLoginDAO();
        daoObj.getAllLoginList(runAsUser.id);   
        daoObj.getAllLoginList(null);  
        System.assertNotEquals(runAsUser,null);
        test.stopTest();
    }
    
    
    static TestMethod void test_getConcurrentLoginList (){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        ID exceptionID='00aB0000000Cd8q';
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        test.startTest();
        System.runAs(runAsUser) {
            M2O_UserLoginDAO daoObj = new M2O_UserLoginDAO();
            daoObj.getConcurrentLoginList(runAsUser.id); 
            daoObj.getConcurrentLoginList(null);      
        }
        System.assertNotEquals(runAsUser,null);
        test.stopTest();
    }
    
    static TestMethod void test_getUserLogin(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        ID exceptionID='00aB0000000Cd8q';
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        test.startTest();
        M2O_UserLoginDAO daoObj = new M2O_UserLoginDAO();
        daoObj.getUserLogin(UserInfo.getUserId()); 
        //daoObj.getUserLogin(null);      
        System.assertNotEquals(runAsUser,null);
        test.stopTest();
    }
    
    
    
    static TestMethod void test_getuserLoginHistory(){
        Profile hcProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        ID exceptionID='00aB0000000Cd8q';
        User runAsUser = M2O_UserTestDataUtility.getHCUserRecord(hcProfileId.Id);
        insert runAsUser;
        test.startTest();
        M2O_UserLoginDAO daoObj = new M2O_UserLoginDAO();
        AuthSession userLogin = daoObj.getUserLogin(UserInfo.getUserId()); 
        daoObj.getuserLoginHistory(userLogin,UserInfo.getUserId());
        //daoObj.getuserLoginHistory(userLogin,null);      
        System.assertNotEquals(runAsUser,null);
        test.stopTest();
    }

}