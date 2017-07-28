@isTest(SeeAllData=true)

class HCNA_InsOrUpdOrDelOnOppLineItemTest{

    static testMethod void test_updateDeleteBlock(){
        Profile hcProfileId1 = HCNA_UtilityClass.getHCNAProfileId1();
        User user = HCNA_UtilityClass.getUserRecord1(hcProfileId1);
        user.Using_Philips_Forecast__c = true;
        user.EscapeValidationRule__c  = true;
        user.CurrencyIsoCode = 'USD';
        insert user;        
        Account accountApex = HCNA_UtilityClass.getAccountRecord(); 
        Insert accountApex ;
        Account childAcc = HCNA_UtilityClass.getAccountRecord2(accountApex); 
        Insert childAcc;
        /*Region__c rgn= new Region__c();
        rgn.Country__c='United States';     
        insert rgn;
        Account ApexAcc=new Account(
           Name= 'Acc_jan' ,
           Apex_Account_Identifier__c='Acc_jan',
           BillingStreet='test',
           BillingCountry='CA',
           Zip_Postal_Code_Local__c= '20016',
           BillingState='test',
           BillingCity='Test' ,
           Country__c = 'United States',
           Region__c=Rgn.id,
           Street1_Local__c='test',
           City_Local__c='test',        
           BillingPostalCode='20016',
           Housenumber_Local__c='203'
       );
        insert ApexAcc;
   
       Account childAcc=new Account(
           Name='Child_Acc_jan' ,
           Associated_IDN__c=ApexAcc.id,
           RelatedApexAccount__c=ApexAcc.id,
           Apex_Account_Identifier__c='Child_Acc_jan',
           BillingStreet='test',
           BillingCity='Test' ,
           BillingState='test',
           BillingCountry='CA',
           Zip_Postal_Code_Local__c= '20016' ,
           Country__c= 'United States',
           Region__c=Rgn.id,
           Street1_Local__c='test',
           City_Local__c='test',        
           BillingPostalCode='20016',
           Housenumber_Local__c='203'
       );
       insert childAcc;*/
        List<Opportunity> opportunityList= HCNA_UtilityClass.getListOfOpportunityRecord(childAcc);
        Insert opportunityList;
        Product2 product = New Product2();
        product.Name = 'Procuct';
        insert product ;        
        Pricebook2 pb = New Pricebook2();
        pb = [Select id from Pricebook2  where IsStandard = true];        
        PricebookEntry pbEntry = New PricebookEntry();
        pbEntry.Pricebook2Id = pb.Id;
        pbEntry.Product2Id = product.id;
        pbEntry.UnitPrice = 11;
        pbEntry.UseStandardPrice = false;
        pbEntry.IsActive = true;
        pbEntry.CurrencyIsoCode = 'USD';
        insert pbEntry;
        List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
        OpportunityLineItem opportunityLineItemRecord;
        for(integer i=0;i<1;i++){
            opportunityLineItemRecord = new OpportunityLineItem(OpportunityId = opportunityList[i].id,Quantity=2,PricebookEntryId = pbEntry.id,ServiceDate = system.Today());
            opportunityLineItemList.add(opportunityLineItemRecord);
        }
        test.startTest();
        Insert opportunityLineItemList;
        Delete opportunityLineItemList;  
        test.stopTest(); 
    }
    


}