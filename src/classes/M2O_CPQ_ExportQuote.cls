global with sharing class M2O_CPQ_ExportQuote {

    global final static String INTELLI_SPACEPACK_SKU = '837507';
    global final static String INTELLI_SPACEPACK_DOWN_PAYMENT_SKU = 'DOWNPAYMENT_BMSS';    
    global final static String DEFAULT_CURRENCY = 'EUR';
    global final static String FIXED_DEAL = 'Fixed Fee Per Study';
    global final static String USAGE_DEAL = 'Usage Based Fee Per Study';
    global final static String RATE_BASIS_FLAT = 'Flat';
    global final static String RATE_BASIS_QTY = 'Quantity';
    global final static Decimal TIER_MINIMUM_QTY = 1.00;
    global final static Integer TIER_NUMBER = 1;
    global final static Decimal TIER_USAGE_VALUE = 1.00;
    global final static String USD_CURRENCY = 'USD';
    global String fileName{get; set;}
    global List<StageDataForIntegration__c> stageDataList{get; set;}
    global String agreementId {get;set;}
    
    global M2O_CPQ_ExportQuote(){
        String quoteId = ApexPages.currentPage().getParameters().get('quoteId');
        fileName = 'quoteExport_' + System.now();
        if(quoteId != null)
        {
            stageDataList = stageDataForIntegration(quoteId);
            System.debug(logginglevel.info, stageDataList);
        }
        agreementId = stageDataList.get(0).Agreement_ID__c;
        
    }
    
    global static List<StageDataForIntegration__c> stageDataForIntegration(String quoteId){
        System.debug(logginglevel.info, 'quoteId ='+ quoteId);
        REVVY__MnQuote__c quoteHeader = getQuoteInfo(quoteId);
        StageDataForIntegration__c stageData = new StageDataForIntegration__c();
        StageDataForIntegration__c stageSolutionData = new StageDataForIntegration__c();
        String contractId = null;
        List<StageDataForIntegration__c> stageDataList = new List<StageDataForIntegration__c>();
        
        Organization currOrg = [Select IsSandbox from Organization limit 1];
        Boolean isSand = currOrg.isSandbox;

        String minMax;
        String solutionBillingFrequency;
        String solutionDealType;
        Decimal solutionQuoteTerm;


        //todo: remap class and take out these variables
        Date contractStartDate, contractEndDate;

            
        List<REVVY__MnQuoteSolution__c> quoteSolutions = getQuoteSolution(quoteId);
        Set<String> quoteSolutionIds = new Set<String>();
        system.debug(logginglevel.INFO, 'quotesolution data: ' + quoteSolutions);
        for(REVVY__MnQuoteSolution__c quoteSolution: quoteSolutions)
        {
            quoteSolutionIds.add(quoteSolution.ID);
        }
        Map<String, List<REVVY__MnQuoteSolutionAttribute__c>> QuoteSolutionsAttributesMap = getQuoteSolutionAttributes(quoteSolutionIds);            
        String quoteSolutionID;
        for(REVVY__MnQuoteSolution__c quoteSolution: quoteSolutions)
        {
            
            stageSolutionData.Account__c = quoteHeader.REVVY__Account__r.MP1_Customer_ID__c;
            stageSolutionData.Agreement_ID__c = quoteHeader.REVVY__Id__c;
            //stageSolutionData.Tier_Start_Value__c = TIER_MINIMUM_QTY;
            //stageSolutionData.Tier_Number__c = TIER_NUMBER;
            //stageSolutionData.Tier_Usage_Value__c = TIER_USAGE_VALUE;
            //stageSolutionData.Tier_End_Value__c = TIER_MAXIMUM_QTY;
            contractStartDate = stageSolutionData.Agreement_Start_Date__c = stageSolutionData.Agreement_Line_Start_Date__c = System.Today(); 
            //contractEndDate = stageSolutionData.Agreement_End_Date__c = stageSolutionData.Agreement_Line_End_Date__c = System.Today().addMonths(Integer.valueOF(quoteHeader.Quote_Term__c)); 
            
            stageSolutionData.Local_Currency__c = quoteHeader.REVVY__Currency__c;
            stageSolutionData.Currency__c = DEFAULT_CURRENCY;
            stageSolutionData.CurrencyIsoCode = USD_CURRENCY;
            //stageSolutionData.Billing_Frequency__c = quoteHeader.Billing_Frequency__c;
            stageSolutionData.Attachment_URL__c = quoteHeader.Attachment_URL__c;
            if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Payer__r.Account2_Partner_SAP_Number__c){
                stageData.Account_Payer__c = quoteHeader.Payer__r.Account2_Partner_SAP_Number__c;
            }
            if(quoteHeader.Payer__r.Account2_Partner_SAP_Number__c != quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c){
                stageSolutionData.Account_Ship_To__c = quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c;
            }
            if(quoteHeader.Payer__r.Account2_Partner_SAP_Number__c != quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c){
                stageSolutionData.Account_Bill_To__c = quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c;
            }               
            stageSolutionData.Project_Manager__c = quoteHeader.Project_Manager__r.Code_1_ID__c;
            stageSolutionData.Sales_Manager__c = quoteHeader.Account_Manager__r.Code_1_ID__c;
            stageSolutionData.Sales_Organization__c = quoteHeader.Sales_Organization__c;
            stageSolutionData.Distribution_Channel__c = quoteHeader.Distribution_Channel__c;
            stageSolutionData.Division__c = quoteHeader.Division__c;
            stageSolutionData.PO_Number__c = quoteHeader.PO_Number__c;      
            stageSolutionData.Agreement_Signed_Date__c = System.now(); 
            stageSolutionData.Agreement_Line_Item_ID__c = quoteSolution.REVVY__ExtId__c;
            stageSolutionData.SAP_Product_Code__c = quoteSolution.REVVY__CatalogNode__r.REVVY__Id__c;
            stageSolutionData.Product_Code__c = quoteSolution.REVVY__CatalogNode__r.REVVY__Id__c;
            stageSolutionData.Payment_Terms__c = SplitPaymentTerms(quoteHeader.Payment_Terms__c);
            stageSolutionData.Quantity__c = 1;
            //stageSolutionData.Product_Name__c = quoteSolution.REVVY__CatalogNode__r.Name;
            stageSolutionData.RPI__c = quoteHeader.RPI__c;
            
            quoteSolutionID = quoteSolution.REVVY__ExtId__c;


            List<REVVY__MnQuoteSolutionAttribute__c> attributes = QuoteSolutionsAttributesMap.get(quoteSolution.Id);
            String includeSolution;
            
            if(attributes != null)
            {
                for(REVVY__MnQuoteSolutionAttribute__c attribute :attributes)
                {
                    if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_ExistingContractId')
                    {
                        contractId = attribute.REVVY__AttributeValue__c;
                        stageSolutionData.ExistingContractId__c = attribute.REVVY__AttributeValue__c;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_DealType')
                    {
                        solutionDealType = attribute.REVVY__AttributeValue__c;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_ExistingLineId') //existing parent id
                    {
                        stageSolutionData.Existing_Parent_Line_ID__c = attribute.REVVY__AttributeValue__c;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_BillingFreq')
                    {
                        solutionBillingFrequency = stageSolutionData.Billing_Frequency__c = attribute.REVVY__AttributeValue__c;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_IncludeSolutionLine')
                    {
                        includeSolution = attribute.REVVY__AttributeValue__c;
                    }
                    //populate at the stage line data and stage subline data
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_DateStart' && attribute.REVVY__AttributeValue__c != null)
                    {
                        String dateString = attribute.REVVY__AttributeValue__c;
                        contractStartDate = System.Date.newInstance(integer.valueOf(dateString.left(4)) , integer.valueOf(dateString.mid(4,2)), 
                            integer.valueOf(dateString.right(2)));
                        system.debug(logginglevel.info, 'contract start date: ' + contractStartDate);
                        stageSolutionData.Agreement_Start_Date__c = contractStartDate;
                        stageSolutionData.Agreement_Line_Start_Date__c = contractStartDate;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_DateEnd' && attribute.REVVY__AttributeValue__c != null)
                    {
                        String dateString = attribute.REVVY__AttributeValue__c;
                        contractEndDate = System.Date.newInstance(integer.valueOf(dateString.left(4)), 
                            integer.valueOf(dateString.mid(4,2)), integer.valueOf(dateString.right(2)));
                        system.debug(logginglevel.info, 'contract start date: ' + contractEndDate);

                        stageSolutionData.Agreement_End_Date__c = contractEndDate;
                        stageSolutionData.Agreement_Line_End_Date__c = contractEndDate;
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MinMaxStudiesType')
                    {
                        minMax = attribute.REVVY__AttributeValue__c;
                    } 
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_QuoteTermMonths')
                    {
                        solutionQuoteTerm =  Integer.ValueOf(attribute.REVVY__AttributeValue__c);
                    }
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_Uptime')
                    {
                        stageSolutionData.Uptime__c = Integer.ValueOf(attribute.REVVY__AttributeValue__c);
                    } 
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_CustomerExitFee')
                    {
                        stageSolutionData.Customer_Exit_Fee__c = Integer.ValueOf(attribute.REVVY__AttributeValue__c);
                    }   
                    else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_SellPriceCopy')
                    {
                        stageSolutionData.Tier_Usage_Value__c = Decimal.ValueOf(attribute.REVVY__AttributeValue__c);
                    }   
                }
            }
            if(solutionQuoteTerm != null)
            {
                contractEndDate = stageSolutionData.Agreement_End_Date__c = stageSolutionData.Agreement_Line_End_Date__c = 
                    System.Today().addMonths(Integer.ValueOf(Math.ceil(Double.ValueOf(solutionQuoteTerm)))); 
                stageSolutionData.Term__c = solutionQuoteTerm;
            }
            else
            {
                stageSolutionData.Term__c = solutionQuoteTerm = contractStartDate.monthsBetween(contractEndDate);
            }
            if(solutionDealType != null)
                stageSolutionData.DealType__c = solutionDealType;
            //if statement for adding solution
            system.debug(logginglevel.INFO, 'include solution line?: ' + includeSolution);
            if(includeSolution == 'Yes')
            {
                system.debug(logginglevel.info, 'stage solution data included');
                stageDataList.add(stageSolutionData);
            }
            else
            {
                system.debug(logginglevel.info, 'stage solution data not included');
            }
        }

        
        if(quoteHeader.Related_Quote__c == null || isSand)
        {
            Integer minStudies;
            Integer maxStudies; 
            
            stageData.Account__c = quoteHeader.REVVY__Account__r.MP1_Customer_ID__c;
            stageData.Agreement_ID__c = quoteHeader.REVVY__Id__c;
            //stageData.Tier_Start_Value__c = TIER_MINIMUM_QTY;
            //stageData.Tier_Number__c = TIER_NUMBER;
            //stageData.Tier_Usage_Value__c = TIER_USAGE_VALUE;         
            //stageData.Tier_End_Value__c = TIER_MAXIMUM_QTY;
            stageData.Agreement_Start_Date__c = stageData.Agreement_Line_Start_Date__c  = contractStartDate;
            stageData.Agreement_End_Date__c = stageData.Agreement_Line_End_Date__c = contractEndDate;
            /*
            if(quoteHeader.Quote_Term__c == null)
            {
                quoteHeader.Quote_Term__c = 0;
            }
            */
            stageData.Term__c = solutionQuoteTerm;       

            stageData.Local_Currency__c = quoteHeader.REVVY__Currency__c;
            stageData.Agreement_Signed_Date__c = System.now(); 
            stageData.Currency__c = DEFAULT_CURRENCY;
            stageData.CurrencyIsoCode = USD_CURRENCY;
            //stageData.Billing_Frequency__c = quoteHeader.Billing_Frequency__c;
            stageData.Attachment_URL__c = quoteHeader.Attachment_URL__c;
            if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Payer__r.Account2_Partner_SAP_Number__c){
                stageData.Account_Payer__c = quoteHeader.Payer__r.Account2_Partner_SAP_Number__c;
            }
            if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c){
                stageData.Account_Ship_To__c = quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c;
            }
            if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c){
                stageData.Account_Bill_To__c = quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c;
            }
            stageData.Project_Manager__c = quoteHeader.Project_Manager__r.Code_1_ID__c;
            stageData.Sales_Manager__c = quoteHeader.Account_Manager__r.Code_1_ID__c;
            stageData.Sales_Organization__c = quoteHeader.Sales_Organization__c;
            stageData.Distribution_Channel__c = quoteHeader.Distribution_Channel__c;
            stageData.Division__c = quoteHeader.Division__c;
            stageData.PO_Number__c = quoteHeader.PO_Number__c;
            stageData.Payment_Terms__c = SplitPaymentTerms(quoteHeader.Payment_Terms__c);
            stageData.Site__c = 'PLACEHOLDER';     
            //todo:uzia Add another date price date on stage for data object and map it to price date on Quote header. REVVY__Price_Date__c
            
            stageData.RPI__c = quoteHeader.RPI__c;
            
            
            
            List<REVVY__MnQuoteItem__c> quoteItems = getQuoteLines(quoteId);
            Set<String> quoteItemIds = new Set<String>();
            for(REVVY__MnQuoteItem__c quoteItem: quoteItems)
            {
                quoteItemIds.add(quoteItem.ID);
            }
            Map<String, List<REVVY__MnQuoteItemAttribute__c>> QuoteItemsAttributesMap = getQuoteItemsAttributes(quoteItemIds);
            
            Map<ID, List<REVVY__MnQuoteItemSubLine__c>> subLinesMap = getQuoteSubLinesForItems(quoteItemIds);
            List<List<REVVY__MnQuoteItemSubLine__c>> allSubLines = subLinesMap.values();
            
            Set<String> sublineIds = new Set<String>();
            for(List<REVVY__MnQuoteItemSubLine__c> sublines: allSubLines)
            {
            	for(REVVY__MnQuoteItemSubLine__c subline: sublines)
            	{
                	sublineIds.add(subline.ID);
            	}
            }
            Map<String, List<REVVY__MnQiSubLineAttribute__c>> subLineAttributesMap = getQuoteSubLinesAttributes(subLineIds);
            
            for(REVVY__MnQuoteItem__c quoteItem: quoteItems)
            {
                //quoteItemIds.add(quoteItem.ID);
                StageDataForIntegration__c stageLineData = new StageDataForIntegration__c();
                stageLineData.Account__c = quoteHeader.REVVY__Account__r.MP1_Customer_ID__c;
                stageLineData.Agreement_ID__c = quoteHeader.REVVY__Id__c;
                //if existing contract (existing contract id at the stage level) then agreement start date and agreement line start date as solution start date/end date
                stageLineData.Agreement_Start_Date__c = stageLineData.Agreement_Line_Start_Date__c = contractStartDate;
                stageLineData.Agreement_End_Date__c = stageLineData.Agreement_Line_End_Date__c = contractEndDate;

                stageLineData.Term__c = solutionQuoteTerm;
                stageLineData.Local_Currency__c = quoteHeader.REVVY__Currency__c; 
                stageLineData.Currency__c = DEFAULT_CURRENCY;   
                stageLineData.CurrencyIsoCode = USD_CURRENCY;                 
                stageLineData.Attachment_URL__c = quoteHeader.Attachment_URL__c;
                if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Payer__r.Account2_Partner_SAP_Number__c){
                    stageData.Account_Payer__c = quoteHeader.Payer__r.Account2_Partner_SAP_Number__c;
                }
                if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c){
                    stageLineData.Account_Ship_To__c = quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c;
                }
                if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c){
                    stageLineData.Account_Bill_To__c = quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c;
                }                   
                stageLineData.Project_Manager__c = quoteHeader.Project_Manager__r.Code_1_ID__c;
                stageLineData.Sales_Manager__c = quoteHeader.Account_Manager__r.Code_1_ID__c;
                stageLineData.Sales_Organization__c = quoteHeader.Sales_Organization__c;
                stageLineData.Distribution_Channel__c = quoteHeader.Distribution_Channel__c;
                stageLineData.Division__c = quoteHeader.Division__c;
                stageLineData.PO_Number__c = quoteHeader.PO_Number__c;      
                stageLineData.Agreement_Signed_Date__c = System.now();
                stageLineData.Agreement_Line_Item_ID__c = quoteItem.Id;
                stageLineData.Quantity__c = quoteItem.REVVY__Quantity__c;
                
                stageLineData.Selling_Price_Local_Currency__c = quoteItem.REVVY__Unit_Price__c; 
                stageLineData.Cost_Local_Currency__c = quoteItem.REVVY__CostPrice__c; 
                stageLineData.List_Price_Local_Currency__c =  quoteItem.REVVY__Price__c;
                stageLineData.ExistingContractId__c = ContractId;
                stageLineData.DealType__c = solutionDealType;
                stageLineData.RPI__c = quoteHeader.RPI__c;
                System.debug(logginglevel.info, quoteItem.REVVY__QuoteSolution__r.REVVY__ExtId__c);
                System.debug(logginglevel.info, quoteItem.Billing_Frequency__c);
                System.debug(logginglevel.info, quoteItem.Rate_Basis__c);
               


                //stageLineData. quoteItem.REVVY__Total_Price__c; //todo:uzia figure out what field are we using for list and cost price
                stageLineData.SAP_Product_Code__c = quoteItem.REVVY__Catalog_Node__r.REVVY__Id__c; //TODO:UZIA Product_Code vs SAP_Product_Code?                
                stageLineData.Product_Code__c = quoteItem.REVVY__Catalog_Node__r.REVVY__Id__c;
                stageLineData.Product_Name__c = quoteItem.REVVY__Catalog_Node__r.Name;
                if(stageLineData.Product_Code__c == INTELLI_SPACEPACK_SKU)
                {
                    /*
                    if(quoteHeader.Maximum_Studies__c != null && quoteItem.REVVY__Quantity__c != null)
                    {
                        stageLineData.Maximum_Qty__c = quoteHeader.Maximum_Studies__c * quoteItem.REVVY__Quantity__c/100;
                    }
                    if(quoteHeader.Minimum_Studies__c != null && quoteItem.REVVY__Quantity__c != null)
                    {
                        stageLineData.minimum_Qty__c = quoteHeader.Minimum_Studies__c * quoteItem.REVVY__Quantity__c/100;
                    }
                    */
                    stageLineData.Tier_Start_Value__c = TIER_MINIMUM_QTY;
                    //stageLineData.Tier_Usage_Value__c = TIER_USAGE_VALUE;   
                    //stageLineData.Tier_Usage_Value__c = quoteItem.REVVY__Unit_Price__c;   
                    stageLineData.Tier_Selling_Price_Transaction_Currenc__c = quoteItem.REVVY__Unit_Price__c;             
                    stageLineData.Tier_Number__c = TIER_NUMBER;

                }
                //stageLineData.Parent_Bundle_SKU_Line_Item_No__c = quoteItem.REVVY__QuoteSolution__r.REVVY__ExtId__c;
                stageLineData.Parent_Bundle_SKU_Line_Item_No__c = quoteSolutionID;
                
                //stageLineData.Site__c = 'SITE_NAME_PLACEHOLDER';
                stageLineData.Payment_Terms__c = SplitPaymentTerms(quoteHeader.Payment_Terms__c);

                //stageLineData.Billing_Frequency__c = solutionBillingFrequency;
                Integer costYearVar;
                Integer yearOffset;
                List<REVVY__MnQuoteItemAttribute__c> attributes = QuoteItemsAttributesMap.get(quoteItem.Id);
                if(attributes != null)
                {
                    for(REVVY__MnQuoteItemAttribute__c attribute :attributes)
                    {
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Vendor')
                        {
                            stageLineData.Vendor__c = attribute.REVVY__AttributeValue__c;
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Product_Name')
                        {
                            stageLineData.Product_Name__c = attribute.REVVY__AttributeValue__c;
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Product_Description')
                        {
                            stageLineData.Product_Description__c = attribute.REVVY__AttributeValue__c;//?? is this mapping correct   
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_CostYear')
                        {
                            costYearVar = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            system.debug(logginglevel.info,'costYearVar: ' + costYearVar);
                            //stageLineData.Agreement_Line_Start_Date__c = stageLineData.Agreement_Start_Date__c.addYears(Integer.valueOF(attribute.REVVY__AttributeValue__c));//?? is this mapping correct  
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_LineSingleYearOffset')
                        {
                            yearOffset = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            system.debug(logginglevel.info,'yearOffset: ' + yearOffset);
                            //stageLineData.Agreement_Line_Start_Date__c = stageLineData.Agreement_Start_Date__c.addYears(Integer.valueOF(attribute.REVVY__AttributeValue__c));//?? is this mapping correct  
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Part_Number')
                        {
                            stageLineData.Vendor_Part_Number__c = attribute.REVVY__AttributeValue__c;//?? check the mapping
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Vendor_Number')
                        {
                            stageLineData.Vendor_Number__c = attribute.REVVY__AttributeValue__c;
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_SiteName')
                        {
                            stageLineData.Site__c = attribute.REVVY__AttributeValue__c;
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_RateBasis')
                        {
                            stageLineData.Rate_Basis__c = attribute.REVVY__AttributeValue__c;
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_BillingFreq')
                        {
                            stageLineData.Billing_Frequency__c = attribute.REVVY__AttributeValue__c;
                        }

                        stageLineData.Existing_Parent_Line_ID__c = stageSolutionData.Existing_Parent_Line_ID__c;

                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_ExistingLineId') //existing parent id
                        {
                            stageLineData.Existing_Contract_Line_ID__c = attribute.REVVY__AttributeValue__c;
                        }
                        system.debug(logginglevel.info, 'inside quoteitems attributes');
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_DateStart')
                        {
                            system.debug(logginglevel.info,'Start Date Attribute Value Quote Item: ' + attribute.REVVY__AttributeValue__c);
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_DateEnd')
                        {
                            system.debug(logginglevel.info,'End Date Attribute Value Quote Item: ' + attribute.REVVY__AttributeValue__c);
                        }

                        /*
                        if(contractStartDate != null)
                        {
                            stageLineData.Agreement_Start_Date__c = contractStartDate;
                            stageLineData.Agreement_Line_Start_Date__c = contractStartDate;
                        }
                        if(contractEndDate != null)
                        {
                            stageLineData.Agreement_End_Date__c = contractEndDate;
                            stageLineData.Agreement_Line_End_Date__c = contractEndDate;
                        }
                        */

                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MinQuantity' && attribute.REVVY__AttributeValue__c != null)
                        {
                            minStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                        }   
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MaxQuantity' && attribute.REVVY__AttributeValue__c != null)
                        {
                            maxStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                        }
                        if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_SellPriceCopy' && attribute.REVVY__AttributeValue__c != null)
                        {
                            stageLineData.Tier_Usage_Value__c = Decimal.ValueOf(attribute.REVVY__AttributeValue__c);
                        }
                        /* Now using BWP_Min/MaxQuantity instead of following code:
                        else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MinStudiesPerc' && attribute.REVVY__AttributeValue__c != null)
                        {
                            minStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                        }
                        else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MaxStudiesPerc' && attribute.REVVY__AttributeValue__c != null)
                        {
                            maxStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                        } */

                    }
                }

                //checking for min and max variables to at the quote line level
                //using minMax variable to determine which value should be taken.

                if(minMax == 'Min' && minStudies != null)
                {
                    stageLineData.Minimum_Qty__c = minStudies;
                    minStudies = null;
                }
                else if(minMax == 'Max' && maxStudies != null)
                {
                    stageLineData.Maximum_Qty__c = maxStudies;
                    maxStudies = null;
                }

                if(contractStartDate != null)
                {   
                    stageLineData.Agreement_Start_Date__c = contractStartDate;
                    if(costYearVar != null)
                    {
                        stageLineData.Agreement_Line_Start_Date__c = contractStartDate.addYears(costYearVar);
                        system.debug(logginglevel.info, 'inside lineitem costYearStart: ' + contractStartDate.addYears(costYearVar));
                    }
                    else if(yearOffset != null)
                    {
                        stageLineData.Agreement_Line_Start_Date__c = contractStartDate.addYears(yearOffset);
                    }
                    else
                    {
                        stageLineData.Agreement_Line_Start_Date__c = contractStartDate;
                    }
                }
                if(contractEndDate != null)
                {
                    stageLineData.Agreement_End_Date__c = contractEndDate;
                    if(yearOffset != null)
                    {
                        stageLineData.Agreement_Line_End_Date__c = contractStartDate.addYears(yearOffset+1).addDays(-1);
                    }
                    else
                    {
                        stageLineData.Agreement_Line_End_Date__c = contractEndDate;
                    }
                }
                if(quoteItem.REVVY__QuoteSolution__r.REVVY__ExtId__c != null && quoteItem.REVVY__Catalog_Node__r.REVVY__Id__c != INTELLI_SPACEPACK_DOWN_PAYMENT_SKU){ 
                    //stageLineData.Billing_Frequency__c = quoteHeader.Billing_Frequency__c;
                    stageLineData.Parent_Bundle_SKU_Line_Item_No__c = quoteSolutionID;
                    if(solutionDealType == FIXED_DEAL && quoteItem.REVVY__Catalog_Node__r.REVVY__Id__c == INTELLI_SPACEPACK_SKU){
                        //stageLineData.Rate_Basis__c =  RATE_BASIS_FLAT;
                        stageLineData.Tier_Usage_Value__c = 0;  
                    }else if(solutionDealType == USAGE_DEAL && quoteItem.REVVY__Catalog_Node__r.REVVY__Id__c == INTELLI_SPACEPACK_SKU){
                        //stageLineData.Rate_Basis__c =  RATE_BASIS_QTY;
                        stageLineData.Tier_Usage_Value__c = quoteItem.REVVY__Unit_Price__c; 
                    }
                }else{
                    stageLineData.Billing_Frequency__c = quoteItem.Billing_Frequency__c;
                    stageLineData.Rate_Basis__c =  quoteItem.Rate_Basis__c;
                }


                List<REVVY__MnQuoteItemSubLine__c> quoteSubLines = subLinesMap.get(quoteItem.ID);
                if (quoteSubLines != null){
                for(REVVY__MnQuoteItemSubLine__c quoteSubLine: quoteSubLines )
                {
                    //system.debug(logginglevel.info, 'quoteSubLine data: ' + quoteSubLine);
                    StageDataForIntegration__c stageSubLineData = new StageDataForIntegration__c();
                    stageSubLineData.Account__c = quoteHeader.REVVY__Account__r.MP1_Customer_ID__c;
                    stageSubLineData.Agreement_ID__c = quoteHeader.REVVY__Id__c;
                    //stageSubLineData.Tier_Start_Value__c = TIER_MINIMUM_QTY;
                    //stageSubLineData.Tier_Usage_Value__c = TIER_USAGE_VALUE;
                    //stageSubLineData.Tier_End_Value__c = TIER_MAXIMUM_QTY;
                    //stageSubLineData.Tier_Number__c = TIER_NUMBER;
                    //same logic as above
                    //stageSubLineData.Agreement_Start_Date__c = System.Today(); 
                    ///stageSubLineData.Agreement_Line_Start_Date__c = System.Today(); 
                    //stageSubLineData.Agreement_End_Date__c = System.Today().addMonths(Integer.valueOF(solutionQuoteTerm)); 
                    //stageSubLineData.Agreement_Line_End_Date__c = System.Today().addMonths(Integer.valueOF(solutionQuoteTerm)); 

                    stageSubLineData.Term__c = solutionQuoteTerm;
                    stageSubLineData.Local_Currency__c = quoteHeader.REVVY__Currency__c; 
                    stageSubLineData.Currency__c = DEFAULT_CURRENCY; 
                    stageSubLineData.CurrencyIsoCode = USD_CURRENCY;       
                    //stageSubLineData.Billing_Frequency__c = quoteHeader.Billing_Frequency__c;
                    stageSubLineData.Attachment_URL__c = quoteHeader.Attachment_URL__c;           
                    if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Payer__r.Account2_Partner_SAP_Number__c){
                        stageData.Account_Payer__c = quoteHeader.Payer__r.Account2_Partner_SAP_Number__c;
                    }
                    if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c){
                        stageSubLineData.Account_Ship_To__c = quoteHeader.Ship_To__r.Account2_Partner_SAP_Number__c;
                    }
                    if(quoteHeader.REVVY__Account__r.MP1_Customer_ID__c != quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c){
                        stageSubLineData.Account_Bill_To__c = quoteHeader.Bill_To__r.Account2_Partner_SAP_Number__c;
                    }
                    stageSubLineData.Project_Manager__c = quoteHeader.Project_Manager__r.Code_1_ID__c;
                    stageSubLineData.Sales_Manager__c = quoteHeader.Account_Manager__r.Code_1_ID__c;
                    stageSubLineData.Sales_Organization__c = quoteHeader.Sales_Organization__c;
                    stageSubLineData.Distribution_Channel__c = quoteHeader.Distribution_Channel__c;
                    stageSubLineData.Division__c = quoteHeader.Division__c;
                    stageSubLineData.PO_Number__c = quoteHeader.PO_Number__c;       
                    stageSubLineData.Agreement_Signed_Date__c = System.now();
                    stageSubLineData.Agreement_Line_Item_ID__c = quoteSubLine.Id;
                    stageSubLineData.Quantity__c = quoteSubLine.REVVY__Quantity__c;

                    stageSubLineData.Selling_Price_Local_Currency__c = quoteSubLine.REVVY__Unit_Price__c; 
                    stageSubLineData.Cost_Local_Currency__c = quoteSubLine.REVVY__CostPrice__c; 
                    stageSubLineData.List_Price_Local_Currency__c =  quoteSubLine.REVVY__Price__c;              
                    
                    //stageSubLineData. quoteItem.REVVY__Total_Price__c; //todo:uzia figure out what field are we using for list and cost price
                    stageSubLineData.SAP_Product_Code__c = quoteSubLine.REVVY__Catalog_Node__r.REVVY__Id__c; //TODO:UZIA Product_Code vs SAP_Product_Code?              
                    stageSubLineData.Product_Code__c = quoteSubLine.REVVY__Catalog_Node__r.REVVY__Id__c;
                    stageSubLineData.Product_Name__c = quoteSubLine.REVVY__Catalog_Node__r.Name;
                    stageSubLineData.Parent_Bundle_SKU_Line_Item_No__c = quoteSubLine.REVVY__QuoteItem__r.ID;
                    //System.debug(logginglevel.info, quoteSubLine.REVVY__QuoteItem__r.REVVY__QuoteSolution__r.REVVY__ExtId__c);
                    //stageSubLineData.Site__c = 'SITE_NAME_PLACEHOLDER';
                    stageSubLineData.Payment_Terms__c = SplitPaymentTerms(quoteHeader.Payment_Terms__c);
                    stageSubLineData.ExistingContractId__c = ContractId;
                    stageSubLineData.DealType__c = solutionDealType;
                    stageSubLineData.RPI__c = quoteHeader.RPI__c;
                    
                    List<REVVY__MnQiSubLineAttribute__c> subLineAttributes = SubLineAttributesMap.get(quoteSubLine.Id );

                    Integer costYearVarSubLine;
                    //List<REVVY__MnQiSubLineAttribute__c> attributes = SubLineAttributesMap.get(quoteSubLines.Id);
                    if(subLineAttributes != null)
                    {
                        for(REVVY__MnQiSubLineAttribute__c attribute :subLineAttributes)
                        {
                            if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Vendor')
                            {
                                stageSubLineData.Vendor__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Product_Name')
                            {
                                stageSubLineData.Product_Name__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Product_Description')
                            {
                                stageSubLineData.Product_Description__c = attribute.REVVY__AttributeValue__c;//?? is this mapping correct   
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_CostYear' && attribute.REVVY__AttributeValue__c != null)
                            {
                                costYearVarSubLine = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                                //stageSubLineData.Agreement_Line_Start_Date__c = stageSubLineData.Agreement_Start_Date__c.addYears(Integer.valueOF(attribute.REVVY__AttributeValue__c));//?? is this mapping correct  
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Part_Number')
                            {
                                stageSubLineData.Vendor_Part_Number__c = attribute.REVVY__AttributeValue__c;//?? check the mapping
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Vendor_Number')
                            {
                                stageSubLineData.Vendor_Number__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'HISS_TPV_Vendor_Number')
                            {
                                stageSubLineData.Vendor_Number__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MinQuantity' && attribute.REVVY__AttributeValue__c != null)
                            {
                                minStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            }   
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MaxQuantity' && attribute.REVVY__AttributeValue__c != null)
                            {
                                maxStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            } 
                            if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_RateBasis')
                            {
                                stageSubLineData.Rate_Basis__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_BillingFreq')
                            {
                                stageSubLineData.Billing_Frequency__c = attribute.REVVY__AttributeValue__c;
                            }
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_SellPriceCopy')
                            {
                                stageSubLineData.Tier_Usage_Value__c = Decimal.ValueOf(attribute.REVVY__AttributeValue__c);
                            }   
                            /*
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MinStudiesPerc' && attribute.REVVY__AttributeValue__c != null)
                            {
                                minStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            }   
                            else if(attribute.REVVY__CatalogAttribute__r.REVVY__Id__c == 'BWP_MaxStudiesPerc' && attribute.REVVY__AttributeValue__c != null)
                            {
                                maxStudies = Integer.valueOf(attribute.REVVY__AttributeValue__c);
                            } 
                            */
                            system.debug(logginglevel.info, 'inside subline attributes');
                            
                            
                        }
                    }
                    if(contractStartDate != null)
                    {   if(costYearVarSubLine != null)
                        {
                            stageSubLineData.Agreement_Start_Date__c = contractStartDate;
                            stageSubLineData.Agreement_Line_Start_Date__c = contractStartDate.addYears(costYearVarSubLine);
                            system.debug(logginglevel.info, 'inside subline costYearStart: ' + contractStartDate.addYears(costYearVarSubLine));

                        }
                        else
                        {
                            stageSubLineData.Agreement_Start_Date__c = contractStartDate;
                            stageSubLineData.Agreement_Line_Start_Date__c = contractStartDate;
                        }
                    }
                    if(contractEndDate != null)
                    {
                        if(costYearVarSubLine != null)
                        {
                            stageSubLineData.Agreement_End_Date__c = contractStartDate;
                            stageSubLineData.Agreement_Line_End_Date__c = contractStartDate.addYears(costYearVarSubLine+1);
                            system.debug(logginglevel.info, 'inside subline costYearEnd: ' + contractStartDate.addYears(costYearVarSubLine + 1));
                        }
                        else
                        {
                            stageSubLineData.Agreement_End_Date__c = contractEndDate;
                            stageSubLineData.Agreement_Line_End_Date__c = contractEndDate;
                        }
                    }
                    //checking for min and max variables to at the subline level, 
                    //using minMax variable to determine which value should be taken.
                    if(minMax == 'Min' && minStudies != null)
                    {
                        stageSubLineData.Minimum_Qty__c = minStudies;
                        minStudies = null;
                    }
                    else if(minMax == 'Max' && maxStudies != null)
                    {
                        stageSubLineData.Maximum_Qty__c = maxStudies;
                        maxStudies = null;
                    }

                    stageSubLineData.Existing_Parent_Line_ID__c = stageLineData.Existing_Contract_Line_ID__c;
                    stageDataList.add(stageSubLineData);
                }
                }

                stageDataList.add(stageLineData);
            }
            
            system.debug(logginglevel.info, 'stageDataList inserted: ' + stageDataList);
      
        }         
            return stageDataList;
    }
    
    private static REVVY__MnQuote__c getQuoteInfo(String quoteId){
        //todo:uzia add fields to the soql..
        List<REVVY__MnQuote__c> quoteHeaderList = [Select ID,
        r.Related_Quote__c, 
        r.Maximum_Studies__c, 
        r.Minimum_Studies__c, 
        r.Planned_Activation_Date__c,
        r.REVVY__Account__c, 
        r.REVVY__Account__r.MP1_Customer_ID__c, 
        r.REVVY__EndDateContract__c, 
        r.REVVY__StartDateContract__c, 
        r.REVVY__Currency__c,
        r.Billing_Frequency__c, 
        r.Attachment_URL__c,
        r.Bill_To__r.Account2_Partner_SAP_Number__c,
        r.Ship_To__r.Account2_Partner_SAP_Number__c,
        r.Payer__r.Account2_Partner_SAP_Number__c,
        r.Project_Manager__r.Code_1_ID__c,
        r.Account_Manager__r.Code_1_ID__c,
        r.Quote_Term__c,
        r.Sales_Organization__c,
        r.Distribution_Channel__c,
        r.Division__c,
        r.Deal_Type__c,
        r.REVVY__Id__c,
        r.Payment_Terms__c,
        r.PO_Number__c,
        r.RPI__c
        From REVVY__MnQuote__c r where r.Revvy__id__c = :quoteId];
        if(quoteHeaderList != null && quoteHeaderList.size() > 0)
        {
            REVVY__MnQuote__c quoteHeader = quoteHeaderList.get(0);
            return quoteHeader;
        }       
        return null;
    }
    
    private static List<REVVY__MnQuoteItem__c> getQuoteLines(String quoteId){
        
        List<REVVY__MnQuoteItem__c> quoteItems = [Select ID, 
        r.REVVY__Quote__r.ID,
        r.REVVY__Quantity__c, 
        r.Billing_Frequency__c,
        r.Rate_Basis__c,
        r.REVVY__Price__c, 
        r.REVVY__CostPrice__c, 
        r.REVVY__Unit_Price__c, 
        r.REVVY__Total_Price__c, //todo:uzia figure out what field are we using for list and cost price
        r.REVVY__Catalog_Node__r.REVVY__Id__c, 
        r.REVVY__Catalog_Node__r.Name,
        r.REVVY__QuoteSolution__r.REVVY__ExtId__c            
        From REVVY__MnQuoteItem__c r
        where r.REVVY__Quote__r.REVVY__Id__c =: quoteId];
        return quoteItems;
    }
    
    private static List<REVVY__MnQuoteItemSubLine__c> getQuoteSubLines(Set<String> quoteItemIds)
    {
        String queryString = buildSubLinesBaseQuery();
        queryString += ' WHERE REVVY__QuoteItem__r.ID IN :quoteItemIds';
        List<REVVY__MnQuoteItemSubLine__c> quoteItemSubLines = database.query(queryString);
        return quoteItemSubLines;
    
    }
    
    private static Map<ID, List<REVVY__MnQuoteItemSubLine__c>>  getQuoteSubLinesForItems(Set<String> quoteItemIds)
    {
    	Map<ID, List<REVVY__MnQuoteItemSubLine__c>> sublineMap = new Map<ID, List<REVVY__MnQuoteItemSubLine__c>>(); 
        String queryString = buildSubLinesBaseQuery();
        queryString += ' WHERE REVVY__QuoteItem__r.ID IN :quoteItemIds';
        List<REVVY__MnQuoteItemSubLine__c> quoteItemSubLines = database.query(queryString);
        for(REVVY__MnQuoteItemSubLine__c subline: quoteItemSubLines)
        {
        	List<REVVY__MnQuoteItemSubLine__c> sublines = subLineMap.get(subline.REVVY__QuoteItem__r.ID);
			if(sublines == null)
			{
				sublines = new List<REVVY__MnQuoteItemSubLine__c>();
			}
        	sublines.add(subline);
        	subLineMap.put(subline.REVVY__QuoteItem__r.ID, sublines);
        }
        return sublineMap;
    }

    private static List<REVVY__MnQuoteItemSubLine__c> getQuoteItemSubLines(String quoteItemId)
    {
        String queryString = buildSubLinesBaseQuery();
        queryString += ' WHERE REVVY__QuoteItem__r.ID = :quoteItemId';
        List<REVVY__MnQuoteItemSubLine__c> quoteItemSubLines = database.query(queryString);
        return quoteItemSubLines;
    
    }
    
    private static String buildSubLinesBaseQuery() {
        return 'SELECT Id, ' +
            ' REVVY__Price__c, ' +
            ' REVVY__Catalog_Node__r.REVVY__Id__c, ' +
            ' REVVY__Catalog_Node__r.Name, ' +
            ' REVVY__Billing_Frequency_WF__c, ' +
            ' REVVY__QuoteItem__r.ID, ' +
            ' REVVY__TotalCostPrice__c, ' +
            ' REVVY__CostPrice__c, ' +
            ' REVVY__Unit_Price__c, ' +
            ' REVVY__Quantity__c ' +
            ' FROM ' +
                ' REVVY__MnQuoteItemSubLine__c ';
    }   
    
    private static Map<String, List<REVVY__MnQiSubLineAttribute__c>> getQuoteSubLinesAttributes (Set<String> quoteSubLineIds){
        String queryString = buildSubLinesAttributesQuery();
        queryString += ' WHERE REVVY__QuoteItemSubLine__c IN :quoteSubLineIds';
        List<REVVY__MnQiSubLineAttribute__c > quoteItemSubLineAttributes = database.query(queryString);
        Map<String, List<REVVY__MnQiSubLineAttribute__c>> attributesMap = new Map<String, List<REVVY__MnQiSubLineAttribute__c>>();
        for(REVVY__MnQiSubLineAttribute__c attribute: quoteItemSubLineAttributes)
        {
            
            if(attributesMap.get(attribute.REVVY__QuoteItemSubLine__c) != null)
            {
                List<REVVY__MnQiSubLineAttribute__c> attributesList = attributesMap.get(attribute.REVVY__QuoteItemSubLine__c );
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteItemSubLine__c ,attributesList);
            }
            else
            {
                List<REVVY__MnQiSubLineAttribute__c> attributesList = new List<REVVY__MnQiSubLineAttribute__c>();
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteItemSubLine__c ,attributesList);
            }
        }
        return attributesMap;
    }
    
    private static String buildSubLinesAttributesQuery(){
        return 'Select REVVY__QuoteItemSubLine__r.Name, '+
        ' REVVY__CatalogAttribute__r.REVVY__Id__c, ' +
        ' REVVY__CatalogAttribute__r.Name, ' +
        ' REVVY__CatalogAttribute__c, ' +
        ' REVVY__AttributeValue__c, ' +
        ' REVVY__QuoteItemSubLine__c ' +
            ' From REVVY__MnQiSubLineAttribute__c ';    
    }
    
    private static Map<String, List<REVVY__MnQuoteItemAttribute__c>> getQuoteItemsAttributes (Set<String> quoteItemIds){
        String queryString = buildQuoteItemsAttributesQuery();
        queryString += ' WHERE REVVY__QuoteItem__c IN :quoteItemIds';
        List<REVVY__MnQuoteItemAttribute__c > quoteItemsAttributes = database.query(queryString);
        
        Map<String, List<REVVY__MnQuoteItemAttribute__c>> attributesMap = new Map<String, List<REVVY__MnQuoteItemAttribute__c>>();
        for(REVVY__MnQuoteItemAttribute__c attribute: quoteItemsAttributes)
        {
            
            if(attributesMap.get(attribute.REVVY__QuoteItem__c) != null)
            {
                List<REVVY__MnQuoteItemAttribute__c> attributesList = attributesMap.get(attribute.REVVY__QuoteItem__c );
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteItem__c ,attributesList);
            }
            else
            {
                List<REVVY__MnQuoteItemAttribute__c> attributesList = new List<REVVY__MnQuoteItemAttribute__c>();
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteItem__c ,attributesList);
            }
        }
        return attributesMap;
    }

    private static String buildQuoteItemsAttributesQuery(){
        return 'Select REVVY__QuoteItem__r.Name, '+
        ' REVVY__CatalogAttribute__r.REVVY__Id__c, ' +
        ' REVVY__CatalogAttribute__r.Name, ' +
        ' REVVY__CatalogAttribute__c, ' +
        ' REVVY__AttributeValue__c, ' +
        ' REVVY__QuoteItem__c ' +
            ' From REVVY__MnQuoteItemAttribute__c ';    
    }
        
    private static List<REVVY__MnQuoteSolution__c> getQuoteSolution(String quoteId){
        String queryString = buildQuoteSolutionQuery();
        queryString += ' WHERE r.REVVY__Quote__r.REVVY__Id__c = :quoteId';
        List<REVVY__MnQuoteSolution__c> quoteSolutions = database.query(queryString);
        return quoteSolutions;      
    }
    
    private static String buildQuoteSolutionQuery(){
        return ' Select r.REVVY__Quote__c, ' +
        ' r.REVVY__ExtId__c, ' +
        ' r.REVVY__CatalogNode__r.REVVY__Id__c ' +
            'From REVVY__MnQuoteSolution__c r ';
    }
    private static Map<String, List<REVVY__MnQuoteSolutionAttribute__c>> getQuoteSolutionAttributes (Set<String> quoteSolutionIds){
        String queryString = buildQuoteSolutionAttributesQuery();
        queryString += ' WHERE REVVY__QuoteSolution__c IN :quoteSolutionIds';
        List<REVVY__MnQuoteSolutionAttribute__c > quoteSolutionsAttributes = database.query(queryString);
        
        Map<String, List<REVVY__MnQuoteSolutionAttribute__c>> attributesMap = new Map<String, List<REVVY__MnQuoteSolutionAttribute__c>>();
        for(REVVY__MnQuoteSolutionAttribute__c attribute: quoteSolutionsAttributes)
        {
            
            if(attributesMap.get(attribute.REVVY__QuoteSolution__c) != null)
            {
                List<REVVY__MnQuoteSolutionAttribute__c> attributesList = attributesMap.get(attribute.REVVY__QuoteSolution__c );
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteSolution__c ,attributesList);
            }
            else
            {
                List<REVVY__MnQuoteSolutionAttribute__c> attributesList = new List<REVVY__MnQuoteSolutionAttribute__c>();
                attributesList.add(attribute);
                attributesMap.put(attribute.REVVY__QuoteSolution__c ,attributesList);
            }
        }
        return attributesMap;
    }

    private static String SplitPaymentTerms(String terms)
    {
        if(terms != null)
            return terms.left(4);
        else
            return terms;
    }

    private static String buildQuoteSolutionAttributesQuery(){
        return 'Select REVVY__QuoteSolution__r.Name, '+
        ' REVVY__CatalogAttribute__r.REVVY__Id__c, ' +
        ' REVVY__CatalogAttribute__r.Name, ' +
        ' REVVY__CatalogAttribute__c, ' +
        ' REVVY__AttributeValue__c, ' +
        ' REVVY__QuoteSolution__c ' +
            ' From REVVY__MnQuoteSolutionAttribute__c ';    
    }        
}