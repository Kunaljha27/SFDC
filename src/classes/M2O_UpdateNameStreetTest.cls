@IsTest
public with sharing class M2O_UpdateNameStreetTest{

    public static testMethod void testCommunitiesLandingController() {
        test.startTest();
            region__c rediondata=new Region__c();
            rediondata.name='Test Region';
            rediondata.Country__c='India';
            rediondata.Region_Code__c='AA-113';
            insert rediondata;
            Account account = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                          BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                          HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                          Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                          Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', region__c=rediondata.id);
            
            insert account;
            ApexPages.StandardController controller = new ApexPages.StandardController(account); 
            Apexpages.Currentpage().getparameters().put('Id',account.id);
            M2O_UpdateNameStreet testVar = new M2O_UpdateNameStreet(controller);
            account.Name_1_Local__c = 'Test';
            testVar.saveAndReturn();
            testVar.toggleMode();
        test.stopTest();
    }
}