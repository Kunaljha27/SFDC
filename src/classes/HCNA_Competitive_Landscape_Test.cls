/**
* @ClassName         : HCNA_Competitive_Landscape_Test
* @Description       : This class is the test class which is covering the code of HCNA_CompetitiveLandscape Trigger.
* @Author            : Ramita Dutta
* @Last Modified     : 24/03/2014
* @Discussionpoints  :No Information
*/
@isTest(SeeAllData=false)
public Class HCNA_Competitive_Landscape_Test {
    /* 
    * @Description : This test method covers the code of HCNA_CompetitiveLandscape Trigger
    */
    static testMethod void test_CompetitiveLandscapeTrigger(){
        Profile profileID = HCNA_UtilityClass.getHCNAProfileId(); 
        User runAsUser = HCNA_UtilityClass.getUserRecord(profileID );
        System.runAs(runAsUser){        
            test.startTest();
            Account apexAccount = HCNA_UtilityClass.getAccountRecord(); 
            insert apexAccount;
            Account parentAccount = HCNA_UtilityClass.getAccountRecord2(apexAccount); 
            insert parentAccount;
            Account childAccount = HCNA_UtilityClass.getChildAccountRecord(apexAccount,parentAccount); 
            insert childAccount;
            Id devRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('PCMS Opportunity').getRecordTypeId();
            Opportunity opp;
            opp = new Opportunity();
            opp.Name ='Test Master Opty';
            opp.AccountId = parentAccount.Id;
            opp.closedate = system.today();
            opp.StageName='Order Booked';
            opp.recordTypeId =devRecordTypeId;
            opp.CurrencyIsoCode='USD';
            opp.ForecastCategoryName = 'Omitted';
            opp.Strategic_Marketing__c='Strategic';
            opp.Vendor_of_Choice__c='Philips';
            opp.Funding_Status__c='Neutral';
            opp.Must_Win_flag__c= true;
            Insert opp;
            test.stopTest();
            Strategic_Account_plan__c strategicAccountPlan = new Strategic_Account_plan__c();
            strategicAccountPlan = HCNA_UtilityClass.getStrategicAccountPlanRecord(parentAccount);
            Insert strategicAccountPlan;
            Competitive_Landscape__c competitiveLandsacpe= new Competitive_Landscape__c();
            competitiveLandsacpe.Name='testCLT';
            competitiveLandsacpe.Strategic_Account_Plan__c = strategicAccountPlan.id;
            competitiveLandsacpe.AccountId_lookup__c= strategicAccountPlan.Account__c;
            StaticVariableClass.firstRun = true;
            Insert competitiveLandsacpe;
            StaticVariableClass.firstRun = true;
            competitiveLandsacpe.AccountId_lookup__c = childAccount.Id;
            Update competitiveLandsacpe;
            StaticVariableClass.firstRun = true;
            Delete competitiveLandsacpe;
            
                 
         }
    }
}