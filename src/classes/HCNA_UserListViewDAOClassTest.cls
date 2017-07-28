/**
* @ClassName         : HCNA_UserListViewDAOClassTest
* @Description       : This class is the test class which is covering the code of HCNA_UserListViewDAOClass Class.
* @Author            : Noor Ali Khan
* @Last Modified     : 30/04/2014
* @Discussionpoints  :No Information
*/

@isTest
public class HCNA_UserListViewDAOClassTest{ 
    /* 
    * @Description : Test coverage for method getUserDetails()
    */
    @isTest static void test_getUserDetails(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        String criteria;
        String fields;
        criteria ='Geography__c = Canada';
        fields='IsActive = true';
        String falseCriteria;
        String falseFields;
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.getUserDetails(falseCriteria,falseFields);
        dAOClass.getUserDetails(Criteria,fields);
        test.stopTest();    
    }
    @isTest static void test_getAccountDetails(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        String criteria;
        String fields;
        criteria ='Region__c = Goa';
        fields='CurrencyIsoCode';
        String falseCriteria;
        String falseFields;
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.getAccountDetails(Criteria,fields);
        dAOClass.getAccountDetails(falseCriteria,falseFields);
        test.stopTest();    
    }
    @isTest static void test_getUserList(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        String str='Canada';
        String nullQuery;
        String query =' Select id,UserRole.name,IsActive from user where (Geography__c = '+'\''+str+'\''+') Limit 100';
        String falseQuery =' Select from user where (Geography__c = '+'\''+str+'\''+') Limit 100';
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.getUserList(query);
        dAOClass.getUserList(falseQuery);
        dAOClass.getUserList(nullQuery);
        test.stopTest();    
    }
    @isTest static void test_getAccountList(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        String str='USD';
        String nullQuery;
        String query='Select id,Region__c from Account where (CurrencyIsoCode = '+'\''+str+'\''+') Limit 100';
        String falseQuery='Select from Account where (CurrencyIsoCode = '+'\''+str+'\''+') Limit 100';
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.getAccountList(query);
        dAOClass.getAccountList(falseQuery);
        dAOClass.getAccountList(nullQuery);
        test.stopTest();    
    }
    @isTest static void test_insertListOfAccountShare(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        List<AccountShare> lstAccShare = new List<AccountShare>();
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.insertListOfAccountShare(lstAccShare);
        try{
        AccountShare falseValue;
        List<AccountShare> falseLstAccShare;
        falseLstAccShare.add(falseValue);
        dAOClass.insertListOfAccountShare(falseLstAccShare);
        }
        catch(Exception exceptionMessage){
            system.debug(exceptionMessage.getmessage());
        }
        test.stopTest();    
    }
    @isTest static void test_insertListOfAccountTeam(){                
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        test.startTest();
        List<AccountTeamMember> accTeamList= new List<AccountTeamMember>();
        HCNA_UserListViewDAOClass dAOClass = new HCNA_UserListViewDAOClass();
        dAOClass.insertListOfAccountTeam(accTeamList);
        try{
        AccountTeamMember falseValue;
        List<AccountTeamMember> falseAccTeamList;
        falseAccTeamList.add(falseValue);
        dAOClass.insertListOfAccountTeam(falseAccTeamList);
        }
        catch(Exception exceptionMessage){
            system.debug(exceptionMessage.getmessage());
        }
        test.stopTest();    
    }
}