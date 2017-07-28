@isTest
public class M2O_StrategicAccountPlanTest{
    
    
    static testMethod void validateStrategic_Plan()
    {
        Id userId;
        region__c rediondata;
        string profileName= 'M2O KAM Lighting';
        string testFakeId = System.Label.M2O_SAPTestFakeId;
        User userRecordTest=M2O_UserTestDataUtility.getUserRecord(profileName);
        insert userRecordTest;
        userId=userRecordTest.Id;
        Profile m2oSysAdminProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User m2oSystemAdminUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdminProfileId.Id);
        insert m2oSystemAdminUser;
        system.RunAs(userRecordTest) {
        rediondata=new Region__c();
        rediondata.name='Test Region';
        rediondata.Country__c='India';
        rediondata.Region_Code__c='AA-113';
        insert rediondata;
         Account account=new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', region__c=rediondata.id);
        
        insert account;
        System.runAs(m2oSystemAdminUser) {
                Account accountToUpdate = M2O_OpportunityTestDataUtility.updateAccountRecord(userRecordTest.id, account.id);
                update accountToUpdate;
            }
        Strategic_Account_Plan__c STest=new Strategic_Account_Plan__c();
        Account_Plan_Account__c APATest=new Account_Plan_Account__c();
        
        
        list<account> lstacc = new list<account>();
        
        lstacc.add(account);
        STest.name='Test';
        insert STest;
        WrapperAccount[] WrappedSelectedAccountList;
        APATest.Account_Plan__c=Stest.ID;
        APATest.Account__c=account.id;
        insert APATest;
        
        ApexPages.StandardController controller=new ApexPages.StandardController(account); 
        System.currentPageReference().getParameters().put('preselectedAccountID ',account.id);
        System.currentPageReference().getParameters().put('preselectedSAP',STest.ID); 
        System.currentPageReference().getParameters().put('parentSAP',STest.ID);
        M2O_StrategicAccountPlan SAPTest= new M2O_StrategicAccountPlan(controller);
        
        
        SAPTest.accountPlanName = 'Test';
        List<RecordType> TestID=new List<RecordType>();
        TestID = [Select ID from recordtype where SobjectType=:Label.M2O_SAPStrategicAccountPlan limit 1];
        SAPTest.recordTypeSelected=TestID[0].ID;
        
        SAPTest.strategicAccountPlan.From_Date__c=system.today();
        SAPTest.strategicAccountPlan.CurrencyIsoCode= 'INR';
        SAPTest.account=null;
        test.startTest();
        SAPTest.getrecordTypeSAPPickList();
        SAPTest.getlistSearchResults();
        SAPTest.getListSelectedAccounts();
        SAPTest.goToM2OStrategicAccountPlan();
        SAPTest.search();
        SAPTest.SelectedAccountListSize = SAPTest.getSelectedAccountListSize();
        SAPTest.SearchResultsListSize = SAPTest.getSearchResultsListSize();
        SAPTest.WrappedSelectedAccountList = SAPTest.getWrappedSelectedAccountList();
        SAPTest.WrappedSearchResultsList = SAPTest.getWrappedSearchResultsList();
        SAPTest.getListSelectedAccounts();
        SAPTest.selectedlist.add(account);
        SAPTest.AccountIdSet.add('01pK0000000EmTl');
        //SAPTest.accountPlanDelete.add(APATest);
        SAPTest.save();
        pagereference pgref = SAPTest.createaccountplan();
        SAPTest.accountPlanName = null;
        SAPTest.parentSAPID=STest.Id;
        pgref = SAPTest.createaccountplan();
        SAPTest.setpagesizeSearchResultsList=10;
        SAPTest.SelectedAccountListSize=10;
        SAPTest.WrappedSelectedAccountList.clear();
        SAPTest.WrappedSelectedAccountList= new List<WrapperAccount>();
        SAPTest.WrappedSelectedAccountList.add(new WrapperAccount(account));
        SAPTest.removeentries();
        SAPTest.cancel();
        SAPTest.addtoselectedlist();
        SAPTest.preselectedSAPID=null;
        SAPTest.preselectedAccountID=null;
        SAPTest.setSectorFlag();
        SAPTest.cancel();
        SAPTest.preselectedAccountID=testFakeId ;
        SAPTest.redirect();
        SAPTest.cancel();
        SAPTest.getSearchFields() ;
        system.assertEquals(STest.name,'Test');
        test.stopTest();
                
        }
    }
}