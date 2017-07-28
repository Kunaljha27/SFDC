/**
* @ClassName         : HCNA_IdentiferTriggerServiceClass 
* @Description       : This class is the test class which is covering the code of HCNA_IdentiferTriggerServiceClass Class.
* @Author            : Noor Ali Khan
* @Last Modified     : 29/03/2014
* @Discussionpoints  :No Information
*/

@isTest
public class HCNA_IdentiferTriggerServiceClassTest{ 
    /* 
    * @Description : Test coverage for method indentifyTheDuplicateProductFamily()
    */
    @isTest static void test_indentifyTheDuplicateProductFamily(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        set<Id> opportunityIds= new set<Id>();
        list<Account> acclist = new list<Account>();
        Account acc;
        for(Integer i=0;i<10;i++) {
        acc = new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='India',country__c='India', CL_Account_Classification__c='A', HC_Account_Classification__c='A',
                                             LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O', Housenumber_Local__c='S12345', 
                                             Street1_Local__c='CA', City_Local__c='City');
        acclist.add(acc);
        }
        List<Opportunity> oppList= new list<Opportunity>();
        Opportunity opp;
        for(Integer i=0; i<=10;i++) {
            opp = new Opportunity();
            opp.Name ='Test Master Opty'+i;
            opp.closedate = system.today();
            opp.StageName='Best Case';
            opp.AccountId = acc.Id;
            opp.CurrencyIsoCode='USD';
            opp.Sub_Opportunities_Total_Amounts__c = 0.0;
            opp.ForecastCategoryName = 'Omitted';
            oppList.add(opp); 
            opportunityIds.add(opp.id);          
        }                
        List<OpportunityLineItem> allOpportunityLineItems= new list<OpportunityLineItem>();        
        for(Opportunity opp1 : oppList) {
            allOpportunityLineItems.add(new OpportunityLineItem(Quantity = 3,
                                                                ServiceDate = system.today(), OpportunityId = opp1.Id, 
                                                                TotalPrice = 300));
        }
        system.runas(userRecordTest) {
            HCNA_IdentiferTriggerServiceClass doaClassTest = new HCNA_IdentiferTriggerServiceClass();
            test.startTest();
            doaClassTest.indentifyTheDuplicateProductFamily(opportunityIds,allOpportunityLineItems);            
            test.stopTest();
        }
    }
    /* 
    * @Description : Test coverage for method retrieveAllOpportunityLineItems()
    */
    @isTest static void test_retrieveAllOpportunityLineItems(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        set<Id> opportunityIds= new set<Id>();        
        system.runas(userRecordTest) {
            HCNA_IdentiferTriggerServiceClass doaClassTest = new HCNA_IdentiferTriggerServiceClass();
            test.startTest();
            doaClassTest.retrieveAllOpportunityLineItems(opportunityIds);            
            test.stopTest();
        }
    }
    /* 
    * @Description : Test coverage for method updateOpportunity()
    */
    @isTest static void test_updateOpportunity(){        
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        list<Opportunity> listOfOpportunityToUpdate = new list<Opportunity>();        
        system.runas(userRecordTest) {
            HCNA_IdentiferTriggerServiceClass doaClassTest = new HCNA_IdentiferTriggerServiceClass();
            test.startTest();
            doaClassTest.updateOpportunity(listOfOpportunityToUpdate);            
            test.stopTest();
        }
    }
    
}