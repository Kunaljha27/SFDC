@isTest
public class FinancialPreCalcReportUtilityTest {
    
    static testMethod void validateIntegrationService() {
        Account acc = createAccount();
        REVVY__MnQuote__c quote = createQuote();
        REVVY__MnQuote__c q = [Select Revvy__Id__c from REVVY__MnQuote__c where ID = :quote.Id ];
		FinancialPreCalcReportUtility pcReport = new FinancialPreCalcReportUtility(quote);
        System.assertNotEquals(quote, null);
    }
    
        //creates a 'ModelN Test Account' and returns it
    static Account createAccount() {
        Account acct = new Account(Name = 'ModelN Test Account TestClass',
            BillingStreet = 'Main St',
            BillingState = 'GA',
            BillingCountry = 'United States',
            BillingCity = 'Atlanta');
        Database.upsert(acct);
        return acct;
    }

    static Account_to_Account_Partner_Junction__c createJunctionAccount(Account Acct){
        Account_to_Account_Partner_Junction__c acc = new Account_to_Account_Partner_Junction__c();
        acc.Account__c = acct.Id;
        acc.Account_2__c = acct.Id;
        Database.upsert(acc);
        return acc;
    }

    //creates a 'ModelN Test Opportunity' and returns it
    static Opportunity createOpportunity(Account acct) {
        return  createOpportunity('ModelN Test Opportunity TestClass', acct);
    }

    static Opportunity createOpportunity(String oppName, Account acct){
        Opportunity opp = new Opportunity(Name = oppName,
                closeDate = System.Today() + 30,
                stageName = 'Prospecting',
                accountid = acct.id);
        system.debug(logginglevel.info, 'New Opportunity to Upsert: ' + opp);
        Database.upsert(opp);
        return opp;
    }

    //creates a 'ModelN Test Quote' and returns it
    static REVVY__MnQuote__c createQuote() {
        Account acct = createAccount();
        system.debug(logginglevel.info, 'New Account: ' + acct);
        Opportunity opp = createOpportunity(acct);
        List<REVVY__MnCatalogNode__c> nodeList = new List<REVVY__MnCatalogNode__c>();
        REVVY__MnCatalogNode__c product = createProduct('ModelN Test Product PreCalc','Sales Value Quote Total','Equipment', false);
        REVVY__MnCatalogNode__c productTwo = createProduct('ModelN Test Product PreCalcTwo','Custom duties','Third Party', false);
        //REVVY__MnCatalogNode__c productThree = createProduct('ModelN Test Product PreCalcThree','Other distribution and warehousing costs','CS', false);
        nodeList.add(product);
        nodeList.add(productTwo);
        //nodeList.add(productThree);
        Database.upsert(nodeList);
        REVVY__MnPriceList__c pricelist = createPriceList(); 
        REVVY__MnPriceListLine__c pricelistLine = createPriceListLine(product, pricelist);
        REVVY__MnPriceListLine__c pricelistLineTwo = createPriceListLine(productTwo, pricelist);
        //REVVY__MnPriceListLine__c pricelistLineThree = createPriceListLine(productTwo, pricelist);
        
        Account_to_Account_Partner_Junction__c junctionAccount = createJunctionAccount(acct);
        REVVY__MnQuote__c quote = new REVVY__MnQuote__c(Name = 'ModelN Test Quote PreCalc',
                REVVY__account__c = acct.Id,
                REVVY__opportunity__c = opp.Id,
                REVVY__status__c = 'Draft',
                REVVY__expiration_date__c = System.Today()
                );
        quote.Maximum_Studies__c =  1;
        quote.Minimum_Studies__c = 1;
        quote.Planned_Activation_Date__c = System.today();
        
        quote.REVVY__EndDateContract__c = System.today().addYears(1);
        quote.REVVY__StartDateContract__c = System.today();
        quote.REVVY__Currency__c = 'EUR';
        quote.Billing_Frequency__c = 'Monthly';
        quote.Attachment_URL__c = '';
        //quote.Quote_Term__c = 1;
        quote.Sales_Organization__c = '1';
        quote.Distribution_Channel__c = '1';
        quote.Division__c = '1';
        quote.Deal_Type__c = '1';
        quote.PO_Number__c  = '1234';
        quote.name = 'tst';
        quote.Uptime__c = '99.9';
        quote.Payment_Terms__c = null;
        //system.debug(logginglevel.info, 'payment terms: ' + quote.Payment_Terms__c);
        //quote.ship_To__c = junctionAccount.Id;
        //quote.Bill_to__c = junctionAccount.Id;
        //quote.Payer__c = junctionAccount.Id;
                
        Database.upsert(quote);        

        REVVY__MnQuoteItem__c item = createQuoteItem(quote, product);
        REVVY__MnQuoteItem__c itemTwo = createQuoteItem(quote, productTwo);
        //REVVY__MnQuoteItem__c itemThree = createQuoteItem(quote, productThree);
        REVVY__MnQuoteSolution__c solution = createTestSolution(quote);
/*        List<REVVY__MnQuoteItem__c> listitems = new List<REVVY__MnQuoteItem__c>{item};
        createSublines(listitems);
        system.debug(logginglevel.info, 'New Quote to Upsert: ' + quote);
        system.debug(logginglevel.info, 'New quote items to Upsert: ' + listitems);
*/
        return quote;
		
    }

    static REVVY__MnQuoteSolution__c createTestSolution(REVVY__MnQuote__c quote)
    {
        REVVY__MnQuoteSolution__c tSolution = new REVVY__MnQuoteSolution__c(REVVY__Quote__c = quote.id,
            REVVY__ExtId__c = '999888777',
            REVVY__CatalogNode__c = createProduct('Solution Product PreCalc','Sales Value Quote Total','Equipment', true).id,
            REVVY__SolutionConfig__c = createmodel().id);
        Database.Upsert(tSolution);
        List<REVVY__MnQuoteSolutionAttribute__c> attList = createSolutionAttributeList(tSolution);

        return tSolution;
    }

    //creates a 'ModelN Test Product' and returns it.
    //

    static REVVY__MnCatalogNode__c createProduct() {
        return createProduct('ModelN Test Product PreCalc','Sales Value Quote Total','Equipment', true);
    }
    
    
    //creates a 'ModelN Test Product' and returns it.
    static REVVY__MnCatalogNode__c createProduct(String prodName, String preCalcDesc, String sourceDimension, Boolean up) {
        REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c( Name = prodName,
                                                                   REVVY__Id__c = prodName,
                                                                   REVVY__status__c = 'Active',
                                                                   REVVY__type__c = 'Product',
                                                                   REVVY__mainImage1__c = 'mainimage1path',
                                                                   REVVY__image2__c = 'image2path',
                                                                   REVVY__image3__c = 'image3path',
                                                                   REVVY__image4__c = 'image4path',
                                                                   Pre_Calc_Category__c = 'Cost of Materials',
                                                                   Pre_Calc_Description__c = preCalcDesc,
                                                                   Pre_Calc_Section__c = 'Integral Costs of Sales',
                                                                   Source_Dimension__c = sourceDimension);
        		
        //this is called from many places where we are running as user
        // who doesn't have permissions to create product. It's ok to skip CRUD/FLS
        if(up)
        	Database.upsert(prod);
        return prod;
    }

    static REVVY__MnPriceList__c createPriceList() {
        REVVY__MnPriceList__c pl =  new REVVY__MnPriceList__c(name = 'ModelN Test PriceList TestClass',
                REVVY__currency__c = 'EUR',
                REVVY__Id__c = 'the_price_list',
                REVVY__Segment__c = 'General',
                REVVY__Start_date__c = System.Today(),
                REVVY__end_date__c = System.Today()+30,
                REVVY__status__c = 'Active');
        Database.upsert(pl);
        return pl;
    }

    static REVVY__MnCatalogNode__c createBundle(String bundleName, Integer numberProductsInBundle) {
        REVVY__MnCatalogNode__c bund = new REVVY__MnCatalogNode__c( Name = bundleName,
                REVVY__Id__c = bundleName,
                REVVY__status__c = 'Active',
                REVVY__type__c = 'Bundle');
        Database.upsert(bund);

        List<REVVY__MnCatalogNodeEdge__c> edgeList = new List<REVVY__MnCatalogNodeEdge__c>();
        List<REVVY__MnCatalogNode__c> prodList = new List<REVVY__MnCatalogNode__c>();


        for (Integer i = 0; i < numberProductsInBundle; i++) {
            REVVY__MnCatalogNode__c prod = new REVVY__MnCatalogNode__c(Name = bundleName+'__'+i,
                    REVVY__Id__c = bundleName+'__'+i,
                    REVVY__status__c = 'Active',
                    REVVY__type__c = 'Product');

            prodList.add(prod);
        }
        Database.upsert(prodList);
        String prodMatch = bundleName + '__%';
        prodList = [SELECT Id FROM REVVY__MnCatalogNode__c WHERE Name LIKE :prodMatch];

        for (Integer i = 0 ; i < prodList.size() ; i++) {
            REVVY__MnCatalogNodeEdge__c edge = new REVVY__MnCatalogNodeEdge__c();
            edge.REVVY__Quantity__c = 1;
            edge.REVVY__Parent__c = bund.Id;
            edge.REVVY__Child__c = prodList[i].Id;
            edge.REVVY__Relative_Level__c = 1;
            edgeList.add(edge);
        }

        Database.upsert(edgeList);
        return bund;
    }

    static REVVY__MnPriceListLine__c createPriceListLine(REVVY__MnCatalogNode__c prod, REVVY__MnPriceList__c pl) {
        if (prod == null) prod = createProduct();
        if (pl == null) pl = createPriceList();
        REVVY__MnPriceListLine__c pll = new REVVY__MnPriceListLine__c(
            REVVY__start_date__c = pl.REVVY__start_date__c,
            REVVY__end_date__c = pl.REVVY__end_date__c,
            REVVY__ListedPrice__c = 50,
            REVVY__product__c =prod.id,
            REVVY__pricelist__c = pl.id,
            Pat1__c = 123456.12,
            Pat2__c = 56789.34,
            targetPrice__c = 3456778.98);
        Database.upsert(pll);
        return pll;
    }

    //creates a quote item for given quote and product with quantity 1.                                                  
    static REVVY__MnQuoteItem__c createQuoteItem(REVVY__MnQuote__c quot, REVVY__MnCatalogNode__c prod) {
        REVVY__MnQuoteItem__c qi = new REVVY__MnQuoteItem__c(
                REVVY__catalog_Node__c = prod.Id,
                REVVY__quantity__c = 1,
                REVVY__quote__c = quot.Id,
        		Pat1__c = 12345.12,
        		Pat2__c = 5678.34,
        		Target_Price__c = 45678.98);
        Database.upsert(qi);
        return qi;
    }


    static REVVY__MnQuoteItemSubLine__c createQuoteItemSublineNoSave(
        REVVY__MnCatalogNode__c prod, REVVY__MnQuoteItem__c qi, String billingFreq)
    {
        REVVY__MnQuoteItemSubLine__c qis = new REVVY__MnQuoteItemSubLine__c(
                REVVY__catalog_Node__c = prod.Id,
                REVVY__quoteItem__c = qi.Id,
                REVVY__Billing_Frequency_WF__c = billingFreq
        );
        return qis;
    }

    static List<REVVY__MnQuoteItemSubLine__c> createSublines(List<REVVY__MnQuoteItem__c> quoteItems) {
        List<REVVY__MnQuoteItemSubLine__c> subLineList = new List<REVVY__MnQuoteItemSubLine__c>();

        List<ID> prodIds = new List<ID>();
        for (REVVY__MnQuoteItem__c item : quoteItems) {
            prodIds.add(item.REVVY__Catalog_Node__c);
        }

        Map<ID, List<REVVY__MnCatalogNodeEdge__c>> prodEdgeMap = new Map<ID, List<REVVY__MnCatalogNodeEdge__c>>();
        for (REVVY__MnCatalogNodeEdge__c edge : 
                [Select m.REVVY__Quantity__c, m.REVVY__Parent__r.Name, m.REVVY__Parent__r.Id, 
                 m.REVVY__Child__r.Name, m.REVVY__Relative_Level__c
                 FROM REVVY__MnCatalogNodeEdge__c m
                 WHERE m.REVVY__Parent__r.Id IN : prodIds AND 
                 m.REVVY__Relative_Level__c = 1.0 AND m.REVVY__Parent__r.REVVY__Type__c = 'Bundle'])
        {
             List<REVVY__MnCatalogNodeEdge__c>  edgeList =  prodEdgeMap.get(edge.REVVY__Parent__r.Id);
             if (edgeList == null) {
                  edgeList = new  List<REVVY__MnCatalogNodeEdge__c>();
                  prodEdgeMap.put(edge.REVVY__Parent__r.Id, edgeList);
             }
             edgeList.add(edge);
        }

        for (REVVY__MnQuoteItem__c item : quoteItems) {
            List<REVVY__MnCatalogNodeEdge__c>  edgeList =  prodEdgeMap.get(item.REVVY__Catalog_Node__c);
            if (edgeList != null) {
                 for (REVVY__MnCatalogNodeEdge__c edge : edgeList) {
                     REVVY__MnQuoteItemSubLine__c subline = new REVVY__MnQuoteItemSubLine__c();
                     subline.REVVY__QuoteItem__c = item.Id;
                     subline.REVVY__Catalog_Node__c = edge.REVVY__Child__r.Id;
                     subline.REVVY__Quantity__c = edge.REVVY__Quantity__c;
                     subLineList.add(subline);
                 }
            }
        }
        Database.upsert(subLineList);
        return subLineList;
    }

    static REVVY__MnConfigEngineModel__c createModel() {
        return createModel('ModelN Test Model PreCalc');
    }

    static REVVY__MnConfigEngineModel__c createModel(String modelName) 
    {
        REVVY__MnConfigEngineModel__c model = new REVVY__MnConfigEngineModel__c();
        model.REVVY__Id__c = modelName;
        Database.upsert(model);

        return model;
    }

    static List<REVVY__MnQuoteSolutionAttribute__c> createSolutionAttributeList(REVVY__MnQuoteSolution__c solution)
    {
        List<String> attName = new List<String>();
        List<String> attValue = new List<String>();

        attName.add('BWP_BillingFreq');
        attValue.add('Quarterly');
        //
        attName.add('BWP_DateStart');
        attValue.add('01012016');
        //
        attName.add('BWP_DateEnd');
        attValue.add('01012018');
        //

        List<REVVY__MnQuoteSolutionAttribute__c> attList = new List<REVVY__MnQuoteSolutionAttribute__c>();

        for(integer i = 0; i < attName.size() - 1; i++)
        {

                REVVY__MnQuoteSolutionAttribute__c qSA = new REVVY__MnQuoteSolutionAttribute__c(REVVY__AttributeValue__c = attValue[i],
                            REVVY__CatalogAttribute__c = createCatalogNodeAttribute(attName[i]).id,
                            REVVY__QuoteSolution__c = solution.id);
                attList.add(qSA);  
        }
        database.upsert(attList);
        return attList;
    } 

    static REVVY__MnCatalogAttribute__c createCatalogNodeAttribute(String revvyID)
    {
        List<REVVY__MnCatalogAttribute__c> attList = new List<REVVY__MnCatalogAttribute__c>();
        
        REVVY__MnCatalogAttribute__c newCatAtt = new REVVY__MnCatalogAttribute__c(REVVY__Id__c = revvyID);
        attList.add(newCatAtt);
        database.upsert(attList);
        return newCatAtt;
    }
}