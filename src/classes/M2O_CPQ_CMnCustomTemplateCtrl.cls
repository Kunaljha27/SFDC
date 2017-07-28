public with sharing class M2O_CPQ_CMnCustomTemplateCtrl
{
    public REVVY__MnQuote__c quote {get; set;}
    public REVVY__MnQuoteProposalParameter__c quoteParams {get;set;}
    public List<CMnQuoteItemWrapper> quoteProdItems {get; set;}
    public List<CMnQuoteItemWrapper> quoteServiceItems {get; set;}
    public List<CMnQuoteItemWrapper> quoteFixedBundleItems {get; set;}
    public List<REVVY__MnQuoteItem__c> quoteConfigItems {get; set;}
    public List<CMnQuoteItemWrapper> quoteConfigWrapperItems {get;set;}
    public List<REVVY__MnQuoteItemSubLine__c> quoteSubLineItems {get;set;}
    public List<REVVY__MnQuoteItemSubLine__c> quoteSubLineWMYItems {get;set;}
    public List<REVVY__MnCatalogNode__c> prodTerms {get;set;}
    public List<REVVY__MnCatalogNode__c> serviceTerms {get;set;}
    public List<REVVY__MnCatalogNode__c> bundleTerms {get;set;}
    public List<REVVY__MnCatalogNode__c> configTerms {get;set;}
    public List<REVVY__MnCatalogNode__c> tempConfigTerms = new List<REVVY__MnCatalogNode__c>();
     
   /**** Quote Param flags that govern the columns on the quote ***/
    public String displayquoteId {get;set;}
    public String displayquoteImage {get;set;}
    public String displayquoteDiscount {get;set;}
    
    /*** Flags that govern the display of each section ***/
    public String displayProducts {get;set;}
    public String displayServices {get;set;}
    public String displayFixedBundles {get;set;}
    public String displayConfigurables {get;set;}
    
    /*** Totals for each sections ***/
    public Decimal prodTotal {get;set;}
    public Decimal bundleTotal {get;set;}
    public Decimal configTotal {get;set;}
    public Decimal servicesTotal {get;set;}
    
    /*** Subtotals for the bundle sections ***/
    public Decimal weeklyBundleTotal {get;set;}
    public Decimal monthlyBundleTotal {get;set;}
    public Decimal yearlyBundleTotal {get;set;}

    public String displayOneTimeBundleTotal {get;set;}
    public String displayWeeklyBundleTotal {get;set;}
    public String displayMonthlyBundleTotal {get;set;}
    public String displayYearlyBundleTotal {get;set;}

    /* Product Terms and Conditions*/
    public String displayBundleTerms {get;set;}
    public String displayProductTerms {get;set;}
    public String displayServiceTerms {get;set;}
    public String displayConfigTerms {get;set;}
    public String displayAllTerms {get;set;}

    /*** Subtotals for the services section ***/
    public Decimal monthlyServicesTotal {get;set;}
    public Decimal weeklyServicesTotal {get;set;}
    public Decimal yearlyServicesTotal {get;set;}

    public String displayOneTimeServicesTotal {get;set;}
    public String displayWeeklyServicesTotal {get;set;}
    public String displayMonthlyServicesTotal {get;set;}
    public String displayYearlyServicesTotal {get;set;}
    
    /*** Subtotals for the configuration section ***/
    public Decimal weeklyConfigTotal {get;set;}
    public Decimal monthlyConfigTotal {get;set;}
    public Decimal yearlyConfigTotal {get;set;}
    
    public String displayWeeklyConfigTotal {get;set;}
    public String displayMonthlyConfigTotal {get;set;}
    public String displayYearlyConfigTotal {get;set;}
    
    public String pricingDate {get;set;}
    public String expDate {get;set;}
    
    /*** Col span variables so we can dyanamically adjust the summaries at the end of each sections ***/
    public String totalColSpanVar {get;set;}
    public Integer intTotalColSpanVar {get;set;}    
    public String billFreqColSpanVar {get;set;}
    public Integer intBillFreqColSpanVar {get;set;}
    //public String extPriceColSpanVar {get;set;}
    //public Integer intExtPriceColSpanVar {get;set;}
        
    public Integer intSectionNameColSpanVar {get;set;}    
    public String sectionNameColSpanVar {get;set;}
    public String headerColSpanVar {get;set;}

    public String currencySymbol {get;set;}
    
    public Boolean renderOpeningComments {get;set;}
    public Boolean renderClosingComments {get;set;}
    public Boolean renderTermsOfService {get;set;}
    public Boolean renderBundleTerms {get;set;}
    public Boolean renderProductTerms {get;set;}
    public Boolean renderServiceTerms {get;set;}
    public Boolean renderConfigTerms {get;set;}

    public String displayTableRowVar;
    public String displayTableCellVar;
    
    public String printStatus {get;set;}
    public String printStatusDisplay {get;set;}
    public String displayCompanyLogo {get;set;}

    /**** Grand Summary Fields ***/
    public Decimal firstYearTotal {get;set;}
    public Decimal followingYearsTotal {get;set;}
    
    public String displayOneTimeSummary {get;set;}
    public String displayMtlySummary {get;set;}
    public String displayWklySummary {get;set;}
    public String displayYrlySummary {get;set;}
    public String displayOneTimeOnlySummary {get;set;}
    public String displayTotalCostofOwner {get;set;}

    public Set<string> ServiceList= new Set<string>();
    public Set<string> BundleList= new Set<string>();
    public Set<string> ProductList= new Set<string>();
    public Set<string> ConfigList= new Set<string>();

    //TODO: these need to go to labels - can't reuse REVVY labels
    private String LABEL_MnProposalDraft = 'DRAFT';
    private String LABEL_MnNoPrice = 'No Price';

    public Map<String, Integer> termCount{get;set;}
    public Integer termIndex;

    public String LABEL_MnProposalPreparedFor { get { return 'PREPARED FOR'; } set {} }
    public String LABEL_MnProposalCreatedBy { get { return 'CREATED BY'; } set {} }
    public String LABEL_MnProposalPricingSummary { get { return 'Summary'; } set {} }
    public String LABEL_MnProposalPricingDate { get { return 'Pricing Date:'; } set {} }
    public String LABEL_MnProposalAttn { get { return 'ATTN:'; } set {} }
    public String LABEL_MnProposalExpDate { get { return 'Quote Valid Through:'; } set {} }
    public String LABEL_MnProposalPhone { get { return 'PH:'; } set {} }
    public String LABEL_MnProposalEmail { get { return 'EMAIL:'; } set {} }
    public String LABEL_MnProposalProducts { get { return 'SERVICE'; } set {} }
    public String LABEL_MnProposalListPrice { get { return 'LIST PRICE'; } set {} }
    public String LABEL_MnProposalAdjustment { get { return 'DISCOUNT'; } set {} }
    public String LABEL_MnProposalQty { get { return 'QTY'; } set {} }
    public String LABEL_MnProposalExtPrice { get { return 'EXTENDED PRICE'; } set {} }
    public String LABEL_MnProposalTotal { get { return 'EQUIPMENT TOTAL:'; } set {} }
    public String LABEL_MnProposalServiceTotal { get { return 'SERVICE TOTAL:'; } set {} }
    public String LABEL_MnProposalServices { get { return 'SERVICES'; } set {} }
    public String LABEL_MnProposalOneTime { get { return 'One Time'; } set {} }
    public String LABEL_MnProposalWeekly { get { return 'Weekly'; } set {} }
    public String LABEL_MnProposalMonthly { get { return 'Monthly'; } set {} }
    public String LABEL_MnProposalYearly { get { return 'Yearly'; } set {} }
    public String LABEL_MnProposalFixedBundle { get { return 'FIXED BUNDLE'; } set {} }
    public String LABEL_MnProposalConfigurable { get { return 'EQUIPMENT'; } set {} }
    public String LABEL_MnProposalOneTimeSummary { get { return 'ONE TIME'; } set {} }
    public String LABEL_MnProposalWeeklySummary { get { return 'WEEKLY'; } set {} }
    public String LABEL_MnProposalMonthlySummary { get { return 'MONTHLY'; } set {} }
    public String LABEL_MnProposalYearlySummary { get { return 'YEARLY'; } set {} }
    public String LABEL_MnProposalTotalSummary { get { return 'TOTAL CUSTOMER INVESTMENT'; } set {} }
    public String LABEL_MnProposalFirstYearSummary { get { return 'First year'; } set {} }
    public String LABEL_MnProposalFollowingYearsSummary { get { return 'Following Year'; } set {} }
    public String LABEL_MnProposalTotalCostOfOwnerShip { get { return 'TOTAL COST OF OWNERSHIP'; } set {} }
    public String LABEL_MnProposalSignedBy { get { return 'Signed By:'; } set {} }
    public String LABEL_MnProposalCheckOne { get { return 'Check one: '; } set {} }
    public String LABEL_MnProposalSignedDate { get { return 'Date'; } set {} }
    public String LABEL_MnProposalCompanyName { get { return 'Philips.'; } set {} }
    public String LABEL_companyFooterLabel { get { return 'Koninklijke Philips N.V., 2004 - 2015. All rights reserved. | www.philips.com'; } set {} }
    public String LABEL_companyFooterConfidentialLabel { get { return 'Company Confidential'; } set {} }
    public String LABEL_MnClosingCommentTitle { get { return 'ADDITIONAL INFORMATION'; } set {} }
    public String LABEL_MnTermsAndConditions { get { return 'TERMS AND CONDITIONS OF SALE'; } set {} }
    public String LABEL_MnProposalTermsAndConditions { get { return 'PRODUCT SPECIFICATIONS'; } set {} }
    public M2O_CPQ_CMnCustomTemplateCtrl()
    {     
         CMnDBUtil dbUtil = new CMnDBUtil();

         displayTableRowVar = 'table-row';
         displayTableCellVar = 'table-cell';
         
         displayConfigurables = displayTableRowVar;
         displayFixedBundles = displayTableRowVar;
         displayServices = displayTableRowVar;
         displayProducts = displayTableRowVar;
         
         displayWeeklyConfigTotal = displayTableRowVar;
         displayMonthlyConfigTotal = displayTableRowVar;
         displayYearlyConfigTotal = displayTableRowVar;

         displayOneTimeBundleTotal = displayTableRowVar;
         displayWeeklyBundleTotal = displayTableRowVar;
         displayMonthlyBundleTotal = displayTableRowVar;
         displayYearlyBundleTotal = displayTableRowVar;

         displayBundleTerms = displayTableRowVar;
         displayProductTerms = displayTableRowVar;
         displayServiceTerms = displayTableRowVar;
         displayConfigTerms = displayTableRowVar;

         displayOneTimeServicesTotal = displayTableRowVar;
         displayWeeklyServicesTotal = displayTableRowVar;
         displayMonthlyServicesTotal = displayTableRowVar;
         displayYearlyServicesTotal = displayTableRowVar;
         
         displayquoteId = displayTableCellVar;
         displayquoteImage = displayTableCellVar;
         displayquoteDiscount = displayTableCellVar;
         
         displayOneTimeSummary = displayTableCellVar;
         displayMtlySummary = displayTableCellVar;
         displayWklySummary = displayTableCellVar;
         displayYrlySummary = displayTableCellVar;
         displayOneTimeOnlySummary = 'none';
         displayTotalCostofOwner = 'none';

         renderBundleTerms = false;
         renderProductTerms = false;
         renderServiceTerms = false;
         renderConfigTerms = false;

         intTotalColSpanVar = 7;
         intSectionNameColSpanVar = 7;
         //intBillFreqColSpanVar = 2;
         //intExtPriceColSpanVar = 2;
         
         headerColSpanVar = '3';

         prodTotal = 0.0;
         bundleTotal = 0.0;
         configTotal = 0.0;
         servicesTotal = 0.0;
         
         weeklyConfigTotal = 0.0;
         monthlyConfigTotal =0.0;
         yearlyConfigTotal = 0.0;

         weeklyBundleTotal  = 0.0;
         monthlyBundleTotal = 0.0;
         yearlyBundleTotal  = 0.0;
         
         weeklyServicesTotal = 0.0;
         monthlyServicesTotal =0.0;
         yearlyServicesTotal = 0.0;
         
         currencySymbol = '$';
         
         quoteSubLineWMYItems  = new List<REVVY__MnQuoteItemSubLine__c>();
         quoteProdItems = new List<CMnQuoteItemWrapper>();
         quoteServiceItems = new List<CMnQuoteItemWrapper>();
         quoteFixedBundleItems = new List<CMnQuoteItemWrapper>();
         
         /*** Fetch Quote record and set corresponding flags ***/
         String quoteId =  ApexPages.currentPage().getParameters().get('quoteId');
        
         String[] selectFields = new String[] {'One_Time_Total_Value_S__c', 'Monthly_Total_Value_S__c', 'Weekly_Total_Value_S__c', 'Yearly_Total_Value_S__c', 'Account__c', 'Contact__c', 'Id__c', 'Status__c', 'Account__r.Name', 'Expiration_Date__c', 'Price_Date__c','Contact__r.Name', 'Contact__r.Phone','Contact__r.Title','Contact__r.MailingStreet','Contact__r.MailingCity','Contact__r.MailingState','Contact__r.MailingPostalCode','Contact__r.MailingCountry','Account__r.BillingCity', 'Account__r.BillingStreet','Account__r.BillingState','Account__r.BillingPostalCode','Contact__r.Email'};

         String selectClause = getSelectClauseWithNS(selectFields) + ', Id, Name, CreatedBy.Name, CreatedBy.Phone, CreatedBy.City, CreatedBy.Email';
         List<REVVY__MnQuote__c> quotes = Database.query('SELECT ' + selectClause + ' FROM REVVY__MnQuote__c WHERE Id = :quoteId');
         quote = quotes[0];
         
         quote = (REVVY__MnQuote__c)dbUtil.removeNonAccessibleFields(quote);
         
         if (quote.REVVY__Price_Date__c != null) pricingDate = quote.REVVY__Price_Date__c.format();
         if (quote.REVVY__Expiration_Date__c != null) expDate = quote.REVVY__Expiration_Date__c.format();
         
         
         firstYearTotal = quote.REVVY__One_Time_Total_Value_S__c + 52 * quote.REVVY__Weekly_Total_Value_S__c +  12 * quote.REVVY__Monthly_Total_Value_S__c + quote.REVVY__Yearly_Total_Value_S__c;
         followingYearsTotal = 52 * quote.REVVY__Weekly_Total_Value_S__c + 12 * quote.REVVY__Monthly_Total_Value_S__c +  quote.REVVY__Yearly_Total_Value_S__c;
         
         if(quote.REVVY__One_Time_Total_Value_S__c <=0)
             displayOneTimeSummary = 'none';
             
         if(quote.REVVY__Monthly_Total_Value_S__c <=0)
              displayMtlySummary = 'none';
         
         if(quote.REVVY__Weekly_Total_Value_S__c <=0)
              displayWklySummary = 'none';
         
         if(quote.REVVY__Yearly_Total_Value_S__c <=0)
              displayYrlySummary = 'none';
              
         if(quote.REVVY__Monthly_Total_Value_S__c <=0 && quote.REVVY__Weekly_Total_Value_S__c <=0 && quote.REVVY__Yearly_Total_Value_S__c <=0){
             //one of the monthly, weekly and yearly value is available
             displayOneTimeOnlySummary = displayTableCellVar;
             displayOneTimeSummary = 'none';
             
         }else{
             //display total cost of owner info
             displayTotalCostofOwner = displayTableCellVar;
         }
        
        /** Fetch quote specific params and set the appropriate flags ***/
        selectFields = new String[] {'usedTemplate__c', 'quote__c', 'proposalTitle__c', 'printStatus__c', 
                                     'openingCommentsTitle__c', 'openingComments__c', 'termsOfServiceTitle__c', 'termsOfService__c',
                                     'displayDiscounts__c', 'displayProductIds__c', 'displayProductImages__c',
                                     'closingCommentsTitle__c', 'closingComments__c', 'companyLogoURL__c'};
         selectClause = getSelectClauseWithNS(selectFields);
         List<REVVY__MnQuoteProposalParameter__c> quoteParamList = 
            Database.query('SELECT ' + selectClause + ' FROM REVVY__MnQuoteProposalParameter__c ' +
                           ' WHERE REVVY__quote__c = :quoteId LIMIT 1');
        quoteParams =  quoteParamList[0];
        quoteParams = (REVVY__MnQuoteProposalParameter__c) dbUtil.removeNonAccessibleFields(quoteParams);


        printStatus = 'DRAFT';
        printStatusDisplay = LABEL_MnProposalDraft;
        if(quoteParams.REVVY__printStatus__c == 'Final') {
          printStatus = '';
          printStatusDisplay = '';
        }

        displayCompanyLogo = 'none';
        if(quoteParams.REVVY__companyLogoURL__c != null) displayCompanyLogo = 'inline-block';

        Schema.SObjectType qiType = REVVY__MnQuoteItem__c.sobjectType;
            //dbUtil.getObjectTypeFromObjName('REVVY__MnQuoteItem__c', null);
        Boolean canViewPrice = dbUtil.isAuthorizedToView(qiType, new List<String> {'REVVY__Price__c'});
        Boolean canViewDiscount = dbUtil.isAuthorizedToView(qiType, new List<String> {'REVVY__Discount__c'});

          /*** Reducing the colspan by 1 for each flag ***/
        if(!quoteParams.REVVY__displayDiscounts__c || (!canViewPrice || !canViewDiscount)){
            displayquoteDiscount = 'none';
            --intTotalColSpanVar;
            //need to reduce two colspans here because we are hiding list price and discount fields.
            --intTotalColSpanVar;
            --intSectionNameColSpanVar;
            --intSectionNameColSpanVar;
        }

        Boolean displayProductIds = quoteParams.REVVY__displayProductIds__c;
        Boolean displayProductImages = quoteParams.REVVY__displayProductImages__c;
        
        if(!displayProductIds){
            displayquoteId = 'none';
            --intTotalColSpanVar;
            --intSectionNameColSpanVar;
        }
        
        if(!displayProductImages){
            displayquoteImage = 'none';
            --intTotalColSpanVar;            
        }
        
        totalColSpanVar = string.valueOf(intTotalColSpanVar);
        sectionNameColSpanVar = string.valueOf(intSectionNameColSpanVar);
        billFreqColSpanVar = String.valueOf(intTotalColSpanVar + 1);
        //extPriceColSpanVar = String.valueOf(intExtPriceColSpanVar);
        
        if(!displayProductIds && !displayProductImages)
            headerColSpanVar = '2';
        else if((!displayProductIds && displayProductImages) || (displayProductIds && !displayProductImages))
            headerColSpanVar = '3';
        
        if (quoteParams.REVVY__openingComments__c == null)
        {
            renderOpeningComments = false;
        } else {
            renderOpeningComments = true;
        }

        if (quoteParams.REVVY__termsOfService__c == null)
        {
            renderTermsOfService = false;
        } else {
            renderTermsOfService = true;
        }

        if (quoteParams.REVVY__closingComments__c == null)
        {
            renderClosingComments = false;
        } else {
            renderClosingComments = true;
        } 

        termIndex = 1;
        termCount = new Map<String,Integer>();
              
         /*** Fetch Products ***/
         List<REVVY__MnQuoteItem__c> regularProducts = fetchRegularProducts(quoteId);
         for(REVVY__MnQuoteItem__c prodQI :  regularProducts) {
            prodQI = (REVVY__MnQuoteItem__c) dbUtil.removeNonAccessibleFields(prodQI);
            quoteProdItems.add(new CMnQuoteItemWrapper(prodQI, null));
            prodTotal += prodQI.REVVY__One_Time_Total_Value_F__c;
            ProductList.add(prodQI.REVVY__Catalog_Node__r.Id);
         }
         regularProducts = null;
                    
         if(quoteProdItems.size()==0)
         displayProducts = 'none';
        
        prodTerms = [SELECT Id,REVVY__Type__c,Name,REVVY__TermsAndConditions__c,REVVY__Id__c  FROM REVVY__MnCatalogNode__c WHERE
        Id IN :ProductList ];
        termIndex = insertTermIndex(termIndex,prodTerms,termCount,'product');
        
        if(!renderProductTerms)
        displayProductTerms = 'none';
        
         /*** Fetch Services ***/                    
         List<REVVY__MnQuoteItem__c> serviceProducts = fetchServiceProducts(quoteId);
         for(REVVY__MnQuoteItem__c serviceQI :  serviceProducts) {
            serviceQI = (REVVY__MnQuoteItem__c) dbUtil.removeNonAccessibleFields(serviceQI);
            quoteServiceItems.add(new CMnQuoteItemWrapper(serviceQI, null));

            /*** accumulate the weekly,monthly and yearly totals ****/
            weeklyServicesTotal += serviceQI.REVVY__Weekly_Total_Value_F__c;
            monthlyServicesTotal += serviceQI.REVVY__Monthly_Total_Value_F__c;
            yearlyServicesTotal += serviceQI.REVVY__Yearly_Total_Value_F__c;
            ServiceList.add(serviceQI.REVVY__Catalog_Node__r.Id);
            servicesTotal += serviceQI.REVVY__One_Time_Total_Value_F__c;
         }
         serviceProducts = null;

         if(servicesTotal == 0.00)
           displayOneTimeServicesTotal = 'none';
         if(weeklyServicesTotal ==0.00)
            displayWeeklyServicesTotal = 'none';
          if(monthlyServicesTotal ==0.00)
            displayMonthlyServicesTotal = 'none';
          if(yearlyServicesTotal ==0.00)
              displayYearlyServicesTotal = 'none';

          if ( quoteServiceItems.size() == 0 ) {
              displayServices = 'none';
          }

        serviceTerms = [SELECT Id,REVVY__Type__c,Name,REVVY__TermsAndConditions__c,REVVY__Id__c  FROM REVVY__MnCatalogNode__c WHERE Id IN :ServiceList];
        termIndex = insertTermIndex(termIndex,serviceTerms,termCount,'service');
        
        if(!renderServiceTerms)
        displayServiceTerms = 'none';          
         
         /*** Fetch Fixed Bundles ***/
         List<REVVY__MnQuoteItem__c> bundleProducts = fetchBundleProducts(quoteId);
         for(REVVY__MnQuoteItem__c bundle :  bundleProducts) {
            bundle = (REVVY__MnQuoteItem__c) dbUtil.removeNonAccessibleFields(bundle);
            quoteFixedBundleItems.add(new CMnQuoteItemWrapper(bundle, bundle.REVVY__QuoteItemSubLine__r));

            bundleTotal += bundle.REVVY__One_Time_Total_Value_F__c;

            /*** accumulate the weekly,monthly and yearly totals ****/
            weeklyBundleTotal += bundle.REVVY__Weekly_Total_Value_F__c;
            monthlyBundleTotal += bundle.REVVY__Monthly_Total_Value_F__c;
            yearlyBundleTotal += bundle.REVVY__Yearly_Total_Value_F__c;
                                            
          }
          bundleProducts = null;
          bundleTerms = [SELECT Id,REVVY__Type__c,Name,REVVY__TermsAndConditions__c,REVVY__Id__c  FROM REVVY__MnCatalogNode__c WHERE Id IN :BundleList];
          termIndex = insertTermIndex(termIndex,bundleTerms,termCount,'bundle');
 
          if(bundleTotal == 0.00)
              displayOneTimeBundleTotal = 'none';
          if(weeklyBundleTotal ==0.00)
              displayWeeklyBundleTotal = 'none';
          if(monthlyBundleTotal ==0.00)
              displayMonthlyBundleTotal = 'none';
          if(yearlyBundleTotal ==0.00)
              displayYearlyBundleTotal = 'none';

         if(!renderBundleTerms)
          displayBundleTerms = 'none';

          if(quoteFixedBundleItems.size()==0)
          displayFixedBundles = 'none';
           
           /**** Fetch Config Items ****/
          quoteConfigWrapperItems = new List<CMnQuoteItemWrapper>();
          quoteSubLineItems = new List<REVVY__MnQuoteItemSubLine__c>();
          List<REVVY__MnQuoteItem__c> configProducts = fetchConfigProducts(quoteId);
          Map<String, String> uiSectionIdToName = new Map<String, String>();
          
          populateUISectionNames(configProducts, uiSectionIdToName);

          for(REVVY__MnQuoteItem__c configQI : configProducts) {

              configQI = (REVVY__MnQuoteItem__c) dbUtil.removeNonAccessibleFields(configQI);
              quoteConfigWrapperItems.add(new CMnQuoteItemWrapper(configQI,configQI.REVVY__QuoteItemSubLine__r,displayProductImages, uiSectionIdToName));
                
                /*** accumulate the weekly,monthly and yearly totals ****/
                weeklyConfigTotal += configQI.REVVY__Weekly_Total_Value_F__c;
                monthlyConfigTotal += configQI.REVVY__Monthly_Total_Value_F__c;
                yearlyConfigTotal += configQI.REVVY__Yearly_Total_Value_F__c;
                ConfigList.add(configQI.REVVY__Catalog_Node__r.Id);

               /***Add Terms and COnditions for SUbline Items ****/
                 List<REVVY__MnQuoteItemSubline__c> sls = configQI.REVVY__QuoteItemSubLine__r;
              if (sls != null && sls.size() > 0) {
                        for (REVVY__MnQuoteItemSubline__c sl : sls) {
                        if(!termCount.containsKey(sl.REVVY__Catalog_Node__r.REVVY__Id__c))
                         {
                           ConfigList.add(sl.REVVY__Catalog_Node__r.Id);
                         }
                      }
               }
                ConfigList.add(configQI.REVVY__Catalog_Node__r.Id);              
                /**** Accumulate grand total for config items ***/
                configTotal += configQI.REVVY__One_Time_Total_Value_F__c;
          }

            Map<Id, REVVY__MnCatalogNode__c> IdToConfigTerms = 
                new Map<Id, REVVY__MnCatalogNode__c>([SELECT Id,REVVY__Type__c,Name,REVVY__TermsAndConditions__c,REVVY__Id__c  
                                                      FROM REVVY__MnCatalogNode__c WHERE Id IN :ConfigList]);
          for(REVVY__MnQuoteItem__c configQI : configProducts) {             
            List<REVVY__MnQuoteItemSubline__c> sls = configQI.REVVY__QuoteItemSubLine__r;

              tempConfigTerms.add(IdToConfigTerms.get(configQI.REVVY__Catalog_Node__r.Id)); 
              if (sls != null && sls.size() > 0) {
                for (REVVY__MnQuoteItemSubline__c sl : sls) {
                    if(IdToConfigTerms.containsKey(sl.REVVY__Catalog_Node__r.Id)) {
                        tempConfigTerms.add(IdToConfigTerms.get(sl.REVVY__Catalog_Node__r.Id));
                    }
                }
              }              
          }
          configTerms = tempConfigTerms;
          termIndex = insertTermIndex(termIndex,configTerms,termCount,'config');

          if(weeklyConfigTotal ==0.00)
            displayWeeklyConfigTotal = 'none';
          if(monthlyConfigTotal ==0.00)
            displayMonthlyConfigTotal = 'none';
          if(yearlyConfigTotal ==0.00)
              displayYearlyConfigTotal = 'none';               
          if(quoteConfigWrapperItems.size()==0)
          displayConfigurables = 'none';                                        
        
         if(!renderConfigTerms)
          displayConfigTerms = 'none';

         if(!renderBundleTerms && !renderProductTerms && !renderServiceTerms && !renderConfigTerms)
         { displayAllTerms = 'none';}
         else
         { displayAllTerms = 'inline'; }
     }

    private List<REVVY__MnQuoteItem__c> fetchRegularProducts(String quoteId) {
        String[] selectFields = new String[] {
            'Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.Name','Catalog_Node__r.REVVY__Billing_Frequency__c','Quantity__c','One_Time_Discount_F__c',
            'One_Time_Price_Before_Discount_F__c','Discount__c','Catalog_Node__r.REVVY__mainImage1__c','Catalog_Node__r.REVVY__Configurable__c',
            'One_Time_Total_Value_F__c ','Price__c','Unit_Price__c'
        };

         String selectClause = getSelectClauseWithNS(selectFields) + ', Id, Name';
         return Database.query('SELECT ' + selectClause + 
                               ' FROM REVVY__MnQuoteItem__c Where REVVY__Quote__c = :quoteId AND ' +
                               ' REVVY__Catalog_Node__r.REVVY__Type__c =\'Product\' AND REVVY__Catalog_Node__r.REVVY__Configurable__c=false AND ' + 
                               ' REVVY__Catalog_Node__r.REVVY__Billing_Frequency__c=\'One Time\'');
    }

    private List<REVVY__MnQuoteItem__c> fetchServiceProducts(String quoteId) {
        String[] selectFields = new String[] {
            'Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.Name','Catalog_Node__r.REVVY__Billing_Frequency__c','Weekly_Discount_F__c',
            'Weekly_Price_Before_Discount_F__c','Yearly_Price_Before_Discount_F__c ','Quantity__c','Discount__c ','One_Time_Discount_F__c',
            'One_Time_Price_Before_Discount_F__c','Monthly_Price_Before_Discount_F__c',
            'Catalog_Node__r.REVVY__mainImage1__c','Catalog_Node__r.REVVY__Configurable__c','Price__c','Unit_Price__c',
            'One_Time_Total_Value_F__c','Weekly_Total_Value_F__c','Monthly_Total_Value_F__c','Yearly_Total_Value_F__c'
        };

        String selectClause = getSelectClauseWithNS(selectFields) + ', Id, Name';
        return Database.query('SELECT ' + selectClause + 
                              ' FROM REVVY__MnQuoteItem__c Where REVVY__Quote__c = :quoteId AND ' +
                              ' REVVY__Catalog_Node__r.REVVY__Type__c !=\'Bundle\' And REVVY__Catalog_Node__r.REVVY__Configurable__c=false AND ' +
                              ' REVVY__Catalog_Node__r.REVVY__Billing_Frequency__c !=\'One Time\'');
    }

    private List<REVVY__MnQuoteItem__c> fetchBundleProducts(String quoteId) {
        String[] selectFields = new String[] {
            'Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.Name','Catalog_Node__r.REVVY__Billing_Frequency__c','Quantity__c','One_Time_Discount_F__c',
            'One_Time_Price_Before_Discount_F__c','Discount__c','Catalog_Node__r.REVVY__mainImage1__c','Catalog_Node__r.REVVY__Configurable__c',
            'One_Time_Total_Value_F__c','Weekly_Price_Before_Discount_F__c','Monthly_Price_Before_Discount_F__c','Yearly_Price_Before_Discount_F__c',
            'Weekly_Total_Value_F__c','Monthly_Total_Value_F__c','Yearly_Total_Value_F__c','Price__c','Unit_Price__c'
        };
        String[] sublineSelectFields = new String[] {
            'UISection__c','Catalog_Node__r.Name','Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.REVVY__Billing_Frequency__c',
            'Discount__c','Quantity__c','Extended_Price_F__c','Price__c','Catalog_Node__r.REVVY__Configurable__c'
        };
        String selectClause = getSelectClauseWithNS(selectFields) + ', Id, Name';
        String sublineSelectClause = getSelectClauseWithNS(sublineSelectFields) + ', Id';

        return Database.query('SELECT ' + selectClause + ', (SELECT ' + sublineSelectClause + ' FROM REVVY__QuoteItemSubLine__r)' +
                              ' FROM REVVY__MnQuoteItem__c ' +
                              ' WHERE REVVY__Quote__c = :quoteId AND REVVY__Catalog_Node__r.REVVY__Type__c =\'Bundle\'');

    }

    private List<REVVY__MnQuoteItem__c> fetchConfigProducts(String quoteId) {
        String[] selectFields = new String[] {
            'Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.Name',
            'Weekly_Extended_Price_S__c','Monthly_Extended_Price_S__c','Catalog_Node__r.REVVY__Billing_Frequency__c',
            'Quantity__c','One_Time_Discount_F__c','One_Time_Price_Before_Discount_F__c','Yearly_Extended_Price_S__c','One_Time_Extended_Price_S__c',
            'Catalog_Node__r.REVVY__mainImage1__c','Catalog_Node__r.REVVY__Configurable__c','Weekly_Price_Before_Discount_S__c',
            'Monthly_Price_Before_Discount_S__c','Yearly_Price_Before_Discount_S__c','Weekly_Discount_F__c','Monthly_Discount_F__c','Yearly_Discount_F__c',
            'Weekly_Price_Before_Discount_F__c','Monthly_Price_Before_Discount_F__c ','Yearly_Price_Before_Discount_F__c',
            'One_Time_Total_Value_F__c','Weekly_Total_Value_F__c','Monthly_Total_Value_F__c','Yearly_Total_Value_F__c',
            'Price__c','Unit_Price__c','Discount__c'
        };

        String[] sublineSelectFields = new String[] {
            'UISection__c','Catalog_Node__r.Name','Catalog_Node__r.REVVY__Id__c','Catalog_Node__r.REVVY__Billing_Frequency__c','GroupNumber__c',
            'Discount__c','Quantity__c','Extended_Price_F__c','Price__c','Catalog_Node__r.REVVY__Configurable__c','OptionNumber__c','SectionNumber__c','QuoteItem__c'
        };

        String selectClause = getSelectClauseWithNS(selectFields) + ', Id, Name';
        String sublineSelectClause = getSelectClauseWithNS(sublineSelectFields) + ', Id';

        return Database.query('SELECT ' + selectClause + 
                              ', (SELECT ' + sublineSelectClause + ' FROM REVVY__QuoteItemSubLine__r ' +
                              ' Order By REVVY__QuoteItem__c,REVVY__SectionNumber__c ,REVVY__GroupNumber__c,REVVY__OptionNumber__c)' +
                              ' FROM REVVY__MnQuoteItem__c ' +
                              ' WHERE REVVY__Quote__c = :quoteId  AND REVVY__Catalog_Node__r.REVVY__Type__c =\'Product\' AND' +
                              ' REVVY__Catalog_Node__r.REVVY__Configurable__c=true ORDER BY REVVY__Record_Number__c');
    }

    private void populateUISectionNames(List<REVVY__MnQuoteItem__c> configProducts, 
                                        Map<String, String> uiSectionIdToName)
    {
      for(REVVY__MnQuoteItem__c configQI : configProducts) {
        List<REVVY__MnQuoteItemSubLine__c> sublineList = configQI.REVVY__QuoteItemSubLine__r;
        for (REVVY__MnQuoteItemSubLine__c subline : sublineList) {
            uiSectionIdToName.put(subline.REVVY__UISection__c, '');
        }
      }
      Set<String> uiSectionNames = uiSectionIdToName.keySet();
      List<REVVY__MnConfigEngineUISection__c> uiSections = 
        Database.query(
          'SELECT Name, REVVY__Id__c FROM REVVY__MnConfigEngineUISection__c WHERE REVVY__Id__c IN :uiSectionNames');
      for (REVVY__MnConfigEngineUISection__c uiSection : uiSections) {
        uiSectionIdToName.put(uiSection.REVVY__Id__c, uiSection.Name);
      }
    }

     private String getSelectClauseWithNS(String[] fields) {
        String selectC = ' ';
        for (Integer i = 0; i < fields.size(); i++) {
            selectC += 'REVVY__' + fields[i];
            if (i != (fields.size()-1)) {
                selectC += ', ';
            }
        }
        return selectC;
     }


     class AccessControlException extends Exception {}

     class CMnDBUtil {



        // START CODE from ESAPI implmentation by SFDC - "https://code.google.com/p/force-dot-com-esapi/"
        //
        // Key : SobjectAPIName  For ex. Account 
        // Value : Map<String, Schema.SObjectField>, field map (k:fieldname, v:Schema.Sobjectfield)
        final Map<String, Map<String, Schema.SObjectField>> FIELD_CACHE = new Map<String, Map<String, Schema.SObjectField>>();

        /**
         *  Returns a field map for a given sobject type. 
         *
         *  Note : this method is kept public for Test cases to share the same field map info, without requiring a field desribe.
         *
         *  @param objectType sobject type for ex. Contact.getSObjectType()
         *  @returns FieldMap [Key:FieldName,Value:Schema.SObjectField]
         */
        Map<String, Schema.SObjectField> fieldMapFor(Schema.SObjectType objectType) {
            Map<String, Schema.SObjectField> fieldMap = null;
            Schema.DescribeSObjectResult d = objectType.getDescribe(); // added since we use this more than once
            String sobjName = d.getName();
            //String normalizedObjectType = sobjName.toLowerCase(); // not needed    
            if (FIELD_CACHE.containsKey(sobjName)) {
                fieldMap = FIELD_CACHE.get(sobjName);
            } else {
                fieldMap = d.fields.getMap();
                // cache it for next use
                FIELD_CACHE.put(sobjName, fieldMap);
            }
    
            return fieldMap;
        }

        Boolean isAuthorizedToView(Schema.SObjectType someType, List<String> fieldNames) {
            Schema.DescribeSObjectResult objDesc = someType.getDescribe();
            if (!objDesc.isAccessible()){
                return false;
            }
            Map<String, Schema.SObjectField> fMap = fieldMapFor(someType);
            for (String f : fieldNames) {
                Schema.SObjectField sObjectFld = fMap.get(f);
                if (sObjectFld == null) {
                    throw new AccessControlException('Field not found ' +  objDesc.getName());
                }
                if (!sObjectFld.getDescribe().isAccessible()){
                    return false;
                }
            }
            return true;
        }

        // FINISH CODE from ESAPI implmentation by SFDC - "https://code.google.com/p/force-dot-com-esapi/"
            

        Map<String, Schema.SObjectField> getNonAccessibleFields(SObjectType sObjectType) {
            if (!sObjectType.getDescribe().isAccessible()) return null;

            Map<String, Schema.SObjectField> noAccessFMap = new Map<String, Schema.SObjectField>();
            Map<String, Schema.SObjectField> fieldMap = fieldMapFor(sObjectType);
            //System.debug('==== checking accessibility for object fieldMap: ' + fieldMap);
            for (Schema.SObjectField fObj : fieldMap.values()) {
                Schema.DescribeFieldResult fdesc = fObj.getDescribe();
                if (!fdesc.isAccessible()) {
                    noAccessFMap.put(fdesc.getName(), fObj);
                }
            }

            return noAccessFMap;
        }

        SObject removeNonAccessibleFields(SObject sObj) {
            if (sObj == null) return null;
            List<SObject> sobjs = new List<SObject>();
            sobjs.add(sObj);
            sobjs = removeNonAccessibleFields(sobjs);

            return (sobjs.size() > 0) ? sobjs.get(0): null;
        }

        List<SObject> removeNonAccessibleFields(List<SObject> sObjs)
        {
            if (sObjs == null || sObjs.size() == 0) return sObjs;

            Map<String, Map<String, Schema.SObjectField>> objNoAccessFieldMap =
                    new Map<String, Map<String, Schema.SObjectField>>();

            Integer i = -1;
            List<Integer> elemToRemove = new List<Integer>();
            for (SObject sobj: sObjs) {
                Schema.DescribeSObjectResult describeObject = sobj.getSObjectType().getDescribe();

                // check CRUD : if object is not accessible, remove entire sObject from list
                i++;
                if (!describeObject.isAccessible()) {
                    elemToRemove.add(i);
                    continue; //don't worry validating this element, it'll be remove from list.
                }

                String sobjType = describeObject.getName();

                Map<String, Schema.SObjectField> fMap = objNoAccessFieldMap.get(sobjType);
                if (fMap == null) {
                    fMap = getNonAccessibleFields(sobj.getSObjectType());
                    objNoAccessFieldMap.put(sobjType, fMap);
                }

                // deserialize the object to find fields present on our SObject
                Map<String,Object> retObjMap =(Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(sobj));
                Set<String> fieldsPresent = retObjMap.keySet().clone();
                fieldsPresent.remove('Id');
                // Salesforce always adds an extra 'attributes' key to SObjects
                // when you do JSON stuff, so let's get rid of that.
                fieldsPresent.remove('attributes');
                //retObjMap.keySet().remove('attributes');
                ///////
                //System.debug('==== checking accessibility for object fMap: ' + fMap);
                //System.debug('==== checking accessibility for object : ' + sobj);
                //System.debug('==== checking accessibility for object : ' + JSON.serialize(sobj));

                for (String currField : fieldsPresent) {
                    //System.debug('==== checking accessibility for : ' + currField);
                    String fmapSearchStr = currField;
                    if (fMap.containsKey(fmapSearchStr)) {
                        // current field is not accessible to user so set it to null
                        //System.debug('==== clearinging non accessible field : ' + currField);
                        retObjMap.remove(currField); //field not accessible
                    }  if (currField.endsWith('__r')) {
                        //handle reference object fields or child object fields accessibility here
                        List<SObject> relsObjs;
                        Boolean isMasterChild = false;
                        try {
                            //this will work for reference type field
                            // for master child it will throw exception
                            SObject rsobj = sobj.getSObject(currField);
                            relsObjs = new List<SObject>();
                            relsObjs.add(rsobj);
                        } catch(Exception e){
                            // if this is masterchild
                            isMasterChild = true;
                            relsObjs = (List<SObject>)sobj.getSObjects(currField);
                        }
                        relsObjs = removeNonAccessibleFields(relsObjs);

                        //Now set these relsObjs back in our original retObjMap
                        if (isMasterChild) {
                            ((Map<String,Object>)retObjMap.get(currField)).put('records',
                                    relsObjs);
                        } else {
                            retObjMap.put(currField, relsObjs[0]);
                        }
                    }
                }
                //done with all fields removal now deserialize json back to sobject.
                sObjs[i] = (SObject) JSON.deserialize(JSON.serialize(retObjMap), Type.forName(sobjType));
            }

            //remove all SObjects that are not accessible.
            for (Integer k = elemToRemove.size() -1; k >= 0; k--) {
                sObjs.remove(elemToRemove.get(k));
            }

            return sObjs;
        }
     }

    class CMnQuoteItemWrapper {
            public String QIName {get;set;}
            public String QIId {get;set;}
            public String QIBillFreq {get;set;}
            public String QIListPrice2 {get;set;}
            public Decimal QIListPrice {get;set;}
            public Decimal QIBaseLinePrice {get;set;}
            public Decimal QIBaseLineUnitPrice {get;set;}
            public Decimal QIBaseLineDiscount {get;set;}
            public String  QIBaseLineDiscountImage {get;set;}

            public String QIBaseLinePrice_Str {get;set;}
            public String QIBaseLineUnitPrice_Str {get;set;}

            public Decimal QIDiscount {get;set;}
            public String QIExtPrice2 {get;set;}
            public String QIDiscountImage {get;set;}
            
            public Decimal QIExtPrice {get;set;}
            public Integer QIQuantity {get;set;}
            public String QIImage {get;set;}
            public String DisplaySubLineItems {get;set;}
            public String DisplayBillFreqItems {get;set;}
            List<String> args = new String[]{'0','number','###,###,##0.00'};
            
            public List<REVVY__MnQuoteItemSubLine__c> BundleSublineItems {get;set;}
            public List<ConfigSubLineClass> ConfigSublineItems {get;set;}
            public List<BillFrequencyItems> BillFreqHdrItems {get;set;}
            public List<REVVY__MnQuoteItemSubLine__c> BillFreqSubLineItems {get;set;}
            
            public List<REVVY__MnQuoteItemSubLine__c> localOneTimeSubLineItems {get;set;}
            public List<REVVY__MnQuoteItemSubLine__c> localWeeklySubLineItems {get;set;}
            public List<REVVY__MnQuoteItemSubLine__c> localMonthlySubLineItems {get;set;}
            public List<REVVY__MnQuoteItemSubLine__c> localYearlySubLineItems {get;set;}
            
            public Boolean headerInserted {get;set;}
            public String currencySymbol ='$';//{get;set;}
            
            private String LABEL_MnNoPrice = 'No Price';
            private String LABEL_MnProposalOneTime = 'One Time';
            private String LABEL_MnProposalWeekly = 'Weekly';
            private String LABEL_MnProposalMonthly = 'Monthly';
            private String LABEL_MnProposalYearly = 'Yearly';

            public CMnQuoteItemWrapper(){
                
            }
            public CMnQuoteItemWrapper(REVVY__MnQuoteItem__c configQIRec, list<REVVY__MnQuoteItemSubLine__c> sublineList){
                
                BundleSublineItems = new List<REVVY__MnQuoteItemSubLine__c>();
                //currencySymbol = '$';
                
                /** This constructor only wraps the QIs for Products Services and Bundles ***/
                REVVY__MnCatalogNode__c catalogNode = configQIRec.REVVY__Catalog_Node__r;
                QIName= catalogNode.Name;
                QIId = catalogNode.REVVY__Id__c;
                QIBillFreq = getFrequencyDisplay(catalogNode.REVVY__Billing_Frequency__c);
                QIDiscount = getScaledDiscount(configQIRec.REVVY__Discount__c);
                QIDiscountImage = getDiscountImage(QIDiscount);
                QIDiscount = getAdjustedDiscount(QIDiscount);
                QIQuantity = configQIRec.REVVY__Quantity__c.intValue();
                QIImage = catalogNode.REVVY__mainImage1__c;

                //if unit price is null, set list price and ext price as noprice (for products, bundles and services).
                if(configQIRec.REVVY__Unit_Price__c == null) {
                    QIListPrice2  = LABEL_MnNoPrice;
                    QIExtPrice2 = LABEL_MnNoPrice;
                } else if (catalogNode.REVVY__Billing_Frequency__c == 'Weekly'){
                    QIListPrice2 = formatCurrency(configQIRec.REVVY__Weekly_Price_Before_Discount_F__c);
                    QIExtPrice2 = formatCurrency(configQIRec.REVVY__Weekly_Total_Value_F__c);
                } else if (catalogNode.REVVY__Billing_Frequency__c == 'Monthly'){
                    QIListPrice2 = formatCurrency(configQIRec.REVVY__Monthly_Price_Before_Discount_F__c);
                    QIExtPrice2 = formatCurrency(configQIRec.REVVY__Monthly_Total_Value_F__c);
                } else if (catalogNode.REVVY__Billing_Frequency__c == 'Yearly'){
                    QIListPrice2 = formatCurrency(configQIRec.REVVY__Yearly_Price_Before_Discount_F__c);
                    QIExtPrice2 = formatCurrency(configQIRec.REVVY__Yearly_Total_Value_F__c);
                } else {
                    QIListPrice2 = formatCurrency(configQIRec.REVVY__One_Time_Price_Before_Discount_F__c);
                    QIExtPrice2 = formatCurrency(configQIRec.REVVY__One_Time_Total_Value_F__c);
                }

                if (configQIRec.REVVY__Price__c == null) {
                    //if price is null, list price should be displayed as no price.
                    QIListPrice2  = LABEL_MnNoPrice;
                }

                if (sublineList != null) {
                    BundleSublineItems.addAll(sublineList);
                }
            }
            
            public CMnQuoteItemWrapper(REVVY__MnQuoteItem__c configQIRec,list<REVVY__MnQuoteItemSubLine__c> sublineList,Boolean displayImage, Map<String, String> uiSectionIdToName) {

                REVVY__MnCatalogNode__c catalogNode = configQIRec.REVVY__Catalog_Node__r;
                QIName= catalogNode.Name;
                QIId = catalogNode.REVVY__Id__c;
                QIBillFreq = getFrequencyDisplay(catalogNode.REVVY__Billing_Frequency__c);
                QIBaseLinePrice_Str = formatCurrency(configQIRec.REVVY__Price__c);
                //if price is null, set unit price that gets displayed on base line as no price (for configurable baseline).
                if(configQIRec.REVVY__Price__c == null) {
                    QIBaseLineUnitPrice_Str  = LABEL_MnNoPrice;
                    QIBaseLineUnitPrice = 0;
                } else {
                    QIBaseLineUnitPrice_Str  = formatCurrency(configQIRec.REVVY__Unit_Price__c);
                    QIBaseLineUnitPrice = configQIRec.REVVY__Unit_Price__c;
                }

                QIBaseLineDiscount = getScaledDiscount(configQIRec.REVVY__Discount__c);
                QIBaseLineDiscountImage = getDiscountImage(QIBaseLineDiscount);
                QIBaseLineDiscount = getAdjustedDiscount(QIBaseLineDiscount);

                ConfigSublineItems = new List<ConfigSubLineClass>();
                localOneTimeSubLineItems = new List<REVVY__MnQuoteItemSubLine__c>();
                localWeeklySubLineItems = new List<REVVY__MnQuoteItemSubLine__c>();
                localMonthlySubLineItems = new List<REVVY__MnQuoteItemSubLine__c>();
                localYearlySubLineItems = new List<REVVY__MnQuoteItemSubLine__c>();
                BillFreqHdrItems = new List<BillFrequencyItems>();
                headerInserted = false;
                //currencySymbol = '$';
                    
                //system.debug('Incoming subline: ' + sublineList);

                /*** Constructing the config section subline items ***/
                for(Integer i=0;i<sublineList.size();i++){
                    if (i == 0 ) {
                        ConfigSubLineClass cslc = new ConfigSubLineClass(sublineList[i],'none');
                        cslc.sectionName = sublineList[i].REVVY__UISection__c;
                        //System.debug('*** None...' + cslc.sectionName);
                        ConfigSubLineItems.add(cslc);
                    } else {
                        if(sublineList[i].REVVY__SectionNumber__c == sublineList[i-1].REVVY__SectionNumber__c){
                            ConfigSubLineItems.add(new ConfigSubLineClass(sublineList[i],'none'));
                        }else{
                            ConfigSubLineClass cslc = new ConfigSubLineClass(sublineList[i],'table-row');
                            cslc.sectionName = sublineList[i].REVVY__UISection__c;
                            ConfigSubLineItems.add(cslc);
                        }
                    }
                }

                //system.debug('Final subline: ' + ConfigSubLineItems);
                /*** Constructing the config header section where we display the summary of billing frequency items ***/            
                /* Collecting the one time, weekly, monthly and yearly subline items into seperate arrays */
                for(REVVY__MnQuoteItemSubLine__c configSubQI : sublineList){
                    String billingFreq = configSubQI.REVVY__Catalog_Node__r.REVVY__Billing_Frequency__c;
                    if(billingFreq == 'Weekly'){                    
                        localWeeklySubLineItems.add(configSubQI);                    
                    }else if(billingFreq == 'Monthly'){
                        localMonthlySubLineItems.add(configSubQI);
                    }else if(billingFreq == 'Yearly'){
                        
                        localYearlySubLineItems.add(configSubQI);
                    }else{                    
                        localOneTimeSubLineItems.add(configSubQI);
                    }
                }

                String billingFreq = catalogNode.REVVY__Billing_Frequency__c;
                
                if(localOneTimeSubLineItems.size()>0 || billingFreq =='One Time'){
                    /** To create the first row for the QI ***/
                    
                    if(configQIRec.REVVY__One_Time_Total_Value_F__c == null){
                        BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,LABEL_MnNoPrice,'',configQIRec.REVVY__One_Time_Discount_F__c,displayImage, 'One Time'));
                        headerInserted = true;
                    }    
                    if(configQIRec.REVVY__One_Time_Total_Value_F__c != null){
                        String ExtPrice = formatCurrency(configQIRec.REVVY__One_Time_Total_Value_F__c);
                        String ListPrice = formatCurrency(configQIRec.REVVY__One_Time_Price_Before_Discount_F__c);
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,ListPrice,ExtPrice,configQIRec.REVVY__One_Time_Discount_F__c,displayImage, 'One Time'));
                            headerInserted = true;
                        }else                
                        BillFreqHdrItems.add(new BillFrequencyItems(ListPrice,ExtPrice,configQIRec.REVVY__One_Time_Discount_F__c,'One Time'));
                    }    
                }
                if(localWeeklySubLineItems.size()>0 || billingFreq =='Weekly'){
                    if(configQIRec.REVVY__Weekly_Total_Value_F__c == null){
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,LABEL_MnNoPrice,'',configQIRec.REVVY__Weekly_Discount_F__c,displayImage, 'Weekly'));
                            headerInserted = true;
                        }else                
                        BillFreqHdrItems.add(new BillFrequencyItems(LABEL_MnNoPrice,'',configQIRec.REVVY__Weekly_Discount_F__c,'Weekly'));
                    }    
                    if(configQIRec.REVVY__Weekly_Total_Value_F__c != null){
                    
                        String ExtPrice = formatCurrency(configQIRec.REVVY__Weekly_Total_Value_F__c);
                        String ListPrice = formatCurrency(configQIRec.REVVY__Weekly_Price_Before_Discount_F__c);
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,ListPrice,ExtPrice,configQIRec.REVVY__Weekly_Discount_F__c,displayImage, 'Weekly'));
                            headerInserted = true;
                        }else    
                        BillFreqHdrItems.add(new BillFrequencyItems(ListPrice,ExtPrice,configQIRec.REVVY__Weekly_Discount_F__c,'Weekly'));
                    }    
                }
                
                if(localMonthlySubLineItems.size()>0 || billingFreq =='Monthly'){
                    if(configQIRec.REVVY__Monthly_Total_Value_F__c == null){
                        //system.debug('Monthly Ext Price null: ');
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,LABEL_MnNoPrice,'',configQIRec.REVVY__Monthly_Discount_F__c,displayImage, 'Monthly'));
                            headerInserted = true;
                        }else                
                        BillFreqHdrItems.add(new BillFrequencyItems(LABEL_MnNoPrice,'',configQIRec.REVVY__Monthly_Discount_F__c,'Monthly'));
                    }    
                    if(configQIRec.REVVY__Monthly_Total_Value_F__c != null){
                        String ExtPrice = formatCurrency(configQIRec.REVVY__Monthly_Total_Value_F__c);
                        String ListPrice = formatCurrency(configQIRec.REVVY__Monthly_Price_Before_Discount_F__c);
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,ListPrice,ExtPrice,configQIRec.REVVY__Monthly_Discount_F__c,displayImage, 'Monthly'));
                            headerInserted = true;
                        }else    
                        BillFreqHdrItems.add(new BillFrequencyItems(ListPrice,ExtPrice,configQIRec.REVVY__Monthly_Discount_F__c,'Monthly'));
                    }    
                }
                
                if(localYearlySubLineItems.size()>0 || billingFreq =='Yearly'){
                    if(configQIRec.REVVY__Yearly_Total_Value_F__c == null){
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,LABEL_MnNoPrice,'',configQIRec.REVVY__Yearly_Discount_F__c,displayImage, 'Yearly'));
                            headerInserted = true;
                        }else                
                        BillFreqHdrItems.add(new BillFrequencyItems(LABEL_MnNoPrice,'',configQIRec.REVVY__Yearly_Discount_F__c,'Yearly'));
                    }    
                    if(configQIRec.REVVY__Yearly_Total_Value_F__c != null){
                        String ExtPrice = formatCurrency(configQIRec.REVVY__Yearly_Total_Value_F__c);
                        String ListPrice = formatCurrency(configQIRec.REVVY__Yearly_Price_Before_Discount_F__c);
                        
                        if(!headerInserted){
                            BillFreqHdrItems.add(new BillFrequencyItems(configQIRec,ListPrice,ExtPrice,configQIRec.REVVY__Yearly_Discount_F__c,displayImage, 'Yearly'));
                            headerInserted = true;
                        }else
                        BillFreqHdrItems.add(new BillFrequencyItems(ListPrice,ExtPrice,configQIRec.REVVY__Yearly_Discount_F__c,'Yearly'));
                    }    
                }
            }

            public String getFrequencyDisplay(String frequency){
                if (frequency == 'One Time') {
                    return LABEL_MnProposalOneTime;
                } else if (frequency == 'Weekly') {
                    return LABEL_MnProposalWeekly;
                } else if (frequency == 'Monthly') {
                    return LABEL_MnProposalMonthly;
                } else if (frequency == 'Yearly') {
                    return LABEL_MnProposalYearly;
                } else {
                    return '';
                }

            }

            public String formatCurrency(Decimal dollarValue){
                String formattedCurrency;
                if (dollarValue == null) {
                    formattedCurrency = LABEL_MnNoPrice;
                } else {
                    formattedCurrency = currencySymbol + dollarValue.format();
                    if(!formattedCurrency.contains('.'))
                    formattedCurrency +='.00';
                    else if(formattedCurrency.substringAfter('.').length()==1)
                    formattedCurrency += '0';
                }
                return formattedCurrency;                
            }

        }
            
            public class ConfigSubLineClass{
            
                public REVVY__MnQuoteItemSubLine__c subline {get;set;}
                public String addLineBreakBefore {get;set;}
                public String QISLListPrice {get;set;}
                public String QISLExtPrice {get;set;}
                public String QISLBillFreq {get;set;}
                public String QISLDiscountImage {get;set;}
                public String SectionName {get;set;}
                
                // TODO: move this to labels
                private String LABEL_MnNoPrice = 'No Price';
                private String LABEL_MnProposalOneTime = 'One Time';
                private String LABEL_MnProposalWeekly = 'Weekly';
                private String LABEL_MnProposalMonthly = 'Monthly';
                private String LABEL_MnProposalYearly = 'Yearly';

                public ConfigSubLineClass(REVVY__MnQuoteItemSubLine__c sublineRec,String lineBreak){
                    CMnQuoteItemWrapper wrapper = new CMnQuoteItemWrapper();

                    subline = sublineRec;
                    if (subline.REVVY__Discount__c != null) {
                      subline.REVVY__Discount__c = getScaledDiscount(subline.REVVY__Discount__c);
                      QISLDiscountImage = getDiscountImage(subline.REVVY__Discount__c);
                      subline.REVVY__Discount__c = getAdjustedDiscount(subline.REVVY__Discount__c);
                    }

                    addLineBreakBefore = lineBreak;
                    /*System.debug('**** sectionName ' + SectionName + 
                                 ' SectionNumber ' + subline.REVVY__SectionNumber__c +
                                 ' addLineBreak ' + lineBreak);*/
                    if(sublineRec.REVVY__Price__c == null) {
                        QISLListPrice  = LABEL_MnNoPrice;
                    } else {
                        QISLListPrice  = wrapper.formatCurrency(sublineRec.REVVY__Price__c);
                    }
                    if(sublineRec.REVVY__Price__c == null) {
                        QISLExtPrice = LABEL_MnNoPrice;
                    } else {
                        QISLExtPrice = wrapper.formatCurrency(sublineRec.REVVY__Extended_Price_F__c);
                    }
                    QISLBillFreq = wrapper.getFrequencyDisplay(subline.REVVY__Catalog_Node__r.REVVY__Billing_Frequency__c);
                    
                }

                
            }

            
            public class BillFrequencyItems{
                public String QISLName {get;set;}
                public String QISLId {get;set;}
                public String QISLBillFreq {get;set;}
                public String QISLListPrice {get;set;}
                public Decimal QISLDiscount {get;set;}
                public String QISLDiscountImage {get;set;}
                public String QISLExtPrice {get;set;}
                public Integer QISLQuantity {get;set;}
                public String QISLImage {get;set;}
                public String QISLdisplayImage {get;set;}

                // TODO: move this to labels
                private String LABEL_MnNoPrice = 'No Price';
                
                public BillFrequencyItems(REVVY__MnQuoteItem__c QI,String ListPrice,String ExtPrice,Decimal Discount,Boolean displayImage, String billFreq){
                        CMnQuoteItemWrapper wrapper = new CMnQuoteItemWrapper();
                        /*** Only for first row of each QI ***/
                        QISLName = QI.REVVY__Catalog_Node__r.Name;
                        QISLImage = QI.REVVY__Catalog_Node__r.REVVY__mainImage1__c; 
                        QISLId = QI.REVVY__Catalog_Node__r.REVVY__Id__c;
                        QISLBillFreq = wrapper.getFrequencyDisplay(billFreq);
                        QISLQuantity = QI.REVVY__Quantity__c.intValue();
                        QISLListPrice = ListPrice;
                        QISLExtPrice = ExtPrice;
                        QISLDiscount = getScaledDiscount(Discount);
                        QISLDiscountImage = getDiscountImage(QISLDiscount);
                        QISLDiscount = getAdjustedDiscount(QISLDiscount);
                        QISLdisplayImage = 'block';
                        if(QISLImage == null || !displayImage) QISLdisplayImage = 'none';
                }
                
                public BillFrequencyItems(String Price,String ExtPrice,Decimal Discount,String BillFreq){
                        CMnQuoteItemWrapper wrapper = new CMnQuoteItemWrapper();
                        /*** only for the summary rows for each QI ****/    
                        QISLBillFreq = wrapper.getFrequencyDisplay(BillFreq);
                        QISLListPrice = Price;
                        QISLExtPrice = ExtPrice;
                        QISLDiscount = getScaledDiscount(Discount);
                        QISLDiscountImage = getDiscountImage(QISLDiscount);
                        QISLDiscount = getAdjustedDiscount(QISLDiscount);
                        QISLImage = '';
                        QISLdisplayImage = 'none';
                    
                }

            }
            
            
            public static String getDiscountImage(Decimal discount) {
                return discount < 0 ? 'discount-up.png' : ( discount > 0 ? 'discount-down.png' : null );
            }

            public static Decimal getAdjustedDiscount(Decimal discount) {
                if (discount == null) return null;
                return discount < 0 ? (discount * -1.0).setScale(2) : discount;
            }

            public static Decimal getScaledDiscount(Decimal discount) {
                if (discount == null) return null;
                else return discount.setScale(2);
            }
            public Integer insertTermIndex(Integer conditionIndex,List<REVVY__MnCatalogNode__c> conditionTerms,Map<String, Integer> conditionCount,String termType)
            {
                termCount = conditionCount;
                if(conditionTerms.size() > 0)
                {
                    for (Integer i = 0; i < conditionTerms.size(); i++) {
                        if (conditionTerms[i].REVVY__TermsAndConditions__c == null) {
                            termCount.put(conditionTerms[i].REVVY__Id__c, 0);
                        } else {
                            if (termType == 'product') {
                                renderProductTerms = true;   /** Check if atleast one term is present to display Header ***/
                            } else if (termType == 'service') {
                                renderServiceTerms = true;
                            } else if (termType == 'bundle') {
                                renderBundleTerms = true;
                            } else if (termType == 'config') {
                                renderConfigTerms = true;
                            }
                            termCount.put(conditionTerms[i].REVVY__Id__c, conditionIndex);
                            conditionIndex++;
                        }
                    }
        
        
                }
                return conditionIndex;        
            }

            
}