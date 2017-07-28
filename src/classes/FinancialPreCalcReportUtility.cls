public with sharing class FinancialPreCalcReportUtility {

	public List<REVVY__MnQuoteItem__c> quoteItemList {get;set;}
	public List<REVVY__MnQuoteItemSubLine__c> quoteSubItemList {get;set;}

	public List<ReportProductItem> reportProductList {get;set;}
	public REVVY__MnQuote__c quote {get;set;}
	public String testString {get;set;}
	public List<ReportLineItem> netSalesValue {get;set;}
	public List<ReportLineItem> integralCostsOfSale {get;set;}
	public List<ReportLineItem> dedicatedSellingExpenses {get;set;}
	public List<ReportLineItem> fixedSellingExpenses {get;set;}
	public List<List<ReportLineItem>> reportLineDataBucket {get;set;}
	public Decimal netSalesValueTotal {get;set;}
	public String quoteUnitPrice {get;set;}
	public Decimal totalTargetPrice {get;set;}
	public Decimal totalPat1 {get;set;}
	public Decimal totalPat2 {get;set;}
	public Decimal[] totalNSV {get;set;}
	public Decimal[] totalISM {get;set;}
	public Decimal[] totalIVM {get;set;}
	public Decimal[] totalIGM {get;set;}
	public Decimal equipmentRevenueTotal {get;set;}
	public Decimal thirdPartyRevenueTotal {get;set;}
	public Decimal cSRevenueTotal {get;set;}
	public Decimal listPriceRollup{get;set;}
	public Decimal targetPriceRollup{get;set;}
	public Decimal offerPriceRollup{get;set;}
	public String startDate {get;set;}
	public String endDate {get;set;}
    public REVVY__MnQuote__c mainQuote {get;set;}

    public FinancialPreCalcReportUtility(REVVY__MnQuote__c mQuote)
	{
        mainQuote = mQuote;
		FinancialPreCalcReport();
    }
    public FinancialPreCalcReportUtility()
	{
     	FinancialPreCalcReport();
    }
	public void FinancialPreCalcReport()
	{
        String quoteId;
        if(mainQuote == null)
        {
            quoteId =  ApexPages.currentPage().getParameters().get('quoteId');
			quote = Database.Query('SELECT ' + GetQuoteFields() + 'FROM REVVY__MnQuote__c WHERE id = :quoteId');
        }
        else
        {
            quote = mainQuote;
            quoteId = quote.id;
        }
		//String quoteId =  ApexPages.currentPage().getParameters().get('quoteId');
		//quote = Database.Query('SELECT ' + GetQuoteFields() + 'FROM REVVY__MnQuote__c WHERE id = :quoteId');
		SetDates(quote);
		system.debug('quote: ' + quote);
		totalTargetPrice = 0;
		netSalesValueTotal = 0;
		listPriceRollup = 0;
		targetPriceRollup = 0;
		offerPriceRollup = 0;
		equipmentRevenueTotal = 0;
		thirdPartyRevenueTotal = 0;
		cSRevenueTotal = 0;
		List<List<String[]>> staticDataBucket = new List<List<String[]>>();
		List<String[]> netSalesList = GetNetSalesList();
		List<String[]> intCostList = GetIntCostList();
		List<String[]> deligatedExpenseList = GetDeligatedExpenseList();
		List<String[]> fixedExpenseList = GetFixedExpenseList();
		staticDataBucket.add(netSalesList);
		staticDataBucket.add(intCostList);
		staticDataBucket.add(deligatedExpenseList);
		staticDataBucket.add(fixedExpenseList);

		testString = 'testString';

		//Gather the object name fields for the query
        String selectQuoteItemFields = GetQuoteItemFields();
        String selectCatalogNodeFields = GetCatalogNodeFields();

        //System.debug(quoteId);
        netSalesValue = new List<ReportLineItem>();
        integralCostsOfSale = new List<ReportLineItem>();
        dedicatedSellingExpenses = new List<ReportLineItem>();
        fixedSellingExpenses = new List<ReportLineItem>();
        reportLineDataBucket = new List<List<ReportLineItem>>();
        List<REVVY__MnCatalogNode__c> catNodeList = new List<REVVY__MnCatalogNode__c>();
        quoteItemList = new List<REVVY__MnQuoteItem__c>();
        quoteSubItemList = new List<REVVY__MnQuoteItemSubLine__c>();
        reportProductList = new List<ReportProductItem>();
        //Generate the static data objects
        //try
        //{
	        integer j = 0;
	        ReportLineItem fItem = new ReportLineItem('Offered Price','Sales Value Quote Total','');
	        //fItem.total = '$10000test'; HISS_Total_Sell_Price__c
	        //netSalesValueTotal = '100000';
    		fItem.blueLine = true;
    		netSalesValue.add(fItem);
	        for(List<String[]> itemList : staticDataBucket)
	        {	
	        	List<ReportLineItem> tempList = new List<ReportLineItem>();

	        	for(String[] items : itemList)
	        	{
	        		//System.debug(logginglevel.info, 'entry: '+items);
		        	ReportLineItem lItem = new ReportLineItem(items[0],items[1],items[2]);
		        	tempList.add(lItem);
		        	//System.debug(logginglevel.info, 'netsalesvalue added: '+lItem);
	        	}
        		ReportLineItem lItem = new ReportLineItem('SubTotal',GetSubtotalTitle(j),'');
        		lItem.greyLine = true;
        		ReportLineItem mItem = new ReportLineItem(GetMarginTitle(j)[0],GetMarginTitle(j)[1],'');
        		mItem.blueLine = true;
        		tempList.add(lItem);
        		tempList.add(mItem);

	        	if(j == 0)
	        		netSalesValue.addAll(tempList);
	        	else if(j == 1)
	        		integralCostsOfSale = tempList;
	        	else if(j == 2)
	        		dedicatedSellingExpenses = tempList;
	        	else if(j == 3)
	        		fixedSellingExpenses = tempList;
	        	j++;
	        }
	        List<Id> catNodeIdList = new List<Id>();
	        //List<REVVY__MnCatalogNode__c> catNodeList = new List<REVVY__MnCatalogNode__c>();
	        //List<REVVY__MnQuoteItem__c> quoteItemList = new List<REVVY__MnQuoteItem__c>();

	        For(REVVY__MnQuoteItem__c qi : Database.query('SELECT ' + GetQuoteItemFields() + 
	                           'FROM REVVY__MnQuoteItem__c WHERE REVVY__Quote__c =: quoteid'))
	        {
	        	System.debug('QUOTE ITEM QUERY: '+qi + ' qil: ' + quoteItemList);
	        	quoteItemList.add(qi);
	        	
	        	//System.debug(logginglevel.info, qi.REVVY__Catalog_Node__r.id);
	        	catNodeIdList.add(qi.REVVY__Catalog_Node__r.id);
	        	quoteUnitPrice += qi.REVVY__Extended_Price_F__c;
	        	//system.debug(logginglevel.info, 'extended price ' + qi.REVVY__Extended_Price_F__c);

	        }
            system.debug(logginglevel.info, 'CHECKING ITEMS IN QUOTEITEMLIST');
            For(REVVY__MnQuoteItem__c qi : quoteItemList)
            {
                system.debug(logginglevel.info, 'quoteItem in List: ' + qi);
            }
	        for(REVVY__MnQuoteItemSubLine__c subItem : Database.query('SELECT ' + GetQuoteSubItemFields() + 
	                           'FROM REVVY__MnQuoteItemSubLine__c WHERE REVVY__QuoteItem__c IN : quoteItemList'))
	        {
	        	catNodeIdList.add(subItem.REVVY__Catalog_Node__r.id);
	        	system.debug(logginglevel.info,'SUBLINE added to list: ' + subItem);
	        	quoteSubItemList.add(subItem);
	        }
	        for(REVVY__MnCatalogNode__c catNode : Database.query('SELECT ' + GetCatalogNodeFields() + 
	                           'FROM REVVY__MnCatalogNode__c WHERE id IN : catNodeIdList'))
	        {
	        	catNodeList.add(catNode);
	        	system.debug(logginglevel.info,'CATNODE ADDED to list: ' + catNode);
	        	for(ReportProductItem rp : reportProductList)
				{
					if(rp.quoteItem.REVVY__Catalog_Node__r.id == catNode.id)
					{
						rp.catNodeItem = catNode;
					}
                    else
                        system.debug(logginglevel.info, 'reportproductitem not added: ' + rp);
				}
	        }

	        //netSalesValue[0].total = quote.HISS_Total_Sell_Price__c;
	        //netSalesValueTotal = netSalesValue[0].total;
	        //system.debug(logginglevel.info,'net sales value: ' + netSalesValueTotal);
	        List<REVVY__MnPriceListLine__c> listLineList = new List<REVVY__MnPriceListLine__c>();

	        for(REVVY__MnPriceListLine__c lineListItem : Database.Query('SELECT ' + GetPriceLineItemFields() + 'FROM ' + 
			'REVVY__MnPriceListLine__c WHERE REVVY__Product__c IN : catNodeIdList'))
			{
				listLineList.add(lineListItem);
                system.debug(logginglevel.info, 'LINELISTITEM ADDED: ' + lineListItem);
				for(ReportProductItem rp : reportProductList)
				{
					if(rp.quoteItem.REVVY__Catalog_Node__r.id == lineListItem.REVVY__Product__c)
					{
						rp.listLineItem = lineListItem;
					}
                    else
                        system.debug(logginglevel.info, 'quote item not added: ' + rp);
				}
			}
			reportLineDataBucket.add(netSalesValue);
	        reportLineDataBucket.add(integralCostsOfSale);
	        reportLineDataBucket.add(dedicatedSellingExpenses);
	        reportLineDataBucket.add(fixedSellingExpenses);

			for(List<ReportLineItem> reportList : reportLineDataBucket)
			{
		        for(REVVY__MnCatalogNode__c ci : catNodeList)
		        {
		        	MatchDescription(ci, reportList, listLineList);
		        }
		    }
	        //netSalesValueTotal = netSalesValue[0].total;
	        //system.debug(logginglevel.info,'net sales value: ' + netSalesValueTotal);
	        
	        //calculate subtotals
	        //system.debug(logginglevel.info,'reportLineDataBucket: ' + reportLineDataBucket);
	        
	        for(List<ReportLineItem> itemList : reportLineDataBucket)
	        {	
	        	Decimal subTotal = 0;
	        	Decimal eqTotal = 0;
	        	Decimal thirdTotal = 0;
	        	Decimal csTotal = 0;

	        	for(ReportLineItem item : itemList)
	        	{
	        		if(item.description != 'Sales Value Quote Total')
	        		{
		        		if(item.total != null)
	        				subTotal += item.total;
	        			if(item.equipment != null)
	        				eqTotal += item.equipment;
	        			if(item.thirdParty != null)
	        				thirdTotal += item.thirdParty;
	        			if(item.cs != null)
	        				csTotal += item.cs;
        			}
        			
	        	}
                
	        	//system.debug(logginglevel.info, 'itemList: ' + itemList);

	        	//assign subtotal rows
	        	itemList[itemList.size()-2].total = subTotal;	
	        	itemList[itemList.size()-2].equipment = eqTotal;	
	        	itemList[itemList.size()-2].thirdParty = thirdTotal;	
	        	itemList[itemList.size()-2].cs = csTotal;	 
	        	//system.debug(logginglevel.info, 'itemList: ' + itemList);   
        		//calculate margin rows
        		if(itemList==netSalesValue)
        		{
        			itemList[0].total = equipmentRevenueTotal + thirdPartyRevenueTotal + cSRevenueTotal;
                    itemList[0].equipment = equipmentRevenueTotal;
                    itemList[0].thirdParty = thirdPartyRevenueTotal;
                    itemList[0].cs = cSRevenueTotal;
        			itemList[itemList.size()-2].total = NullCheck(itemList[itemList.size()-4].total) - NullCheck(itemList[itemList.size()-3].total);	
	        		itemList[itemList.size()-2].equipment = NullCheck(itemList[itemList.size()-4].equipment) - NullCheck(itemList[itemList.size()-3].equipment);	
	        		itemList[itemList.size()-2].thirdParty = NullCheck(itemList[itemList.size()-4].thirdParty) - NullCheck(itemList[itemList.size()-3].thirdParty);
	        		itemList[itemList.size()-2].cs = NullCheck(itemList[itemList.size()-4].cs) - NullCheck(itemList[itemList.size()-3].cs);

		        	itemList[itemList.size()-1].total = NullCheck(netSalesValue[0].total) + NullCheck(netSalesValue[1].total) - NullCheck(netSalesValue[2].total);	
		        	itemList[itemList.size()-1].equipment = NullCheck(netSalesValue[0].equipment) + NullCheck(netSalesValue[1].equipment) - NullCheck(netSalesValue[2].equipment);	
		        	itemList[itemList.size()-1].thirdParty = NullCheck(netSalesValue[0].thirdParty) + NullCheck(netSalesValue[1].thirdParty) - NullCheck(netSalesValue[2].thirdParty);		
		        	itemList[itemList.size()-1].cs = NullCheck(netSalesValue[0].cs) + NullCheck(netSalesValue[1].cs) - NullCheck(netSalesValue[2].cs);
					totalNSV = new Decimal[]{itemList[itemList.size()-1].total, itemList[itemList.size()-1].equipment, 
	        				itemList[itemList.size()-1].thirdParty, itemList[itemList.size()-1].cs };
	        		netSalesValueTotal = totalNSV[0];
		        }
		        else
		        {
	        		itemList[itemList.size()-1].total = NullCheck(totalNSV[0]) - NullCheck(itemList[itemList.size()-2].total);	
	        		itemList[itemList.size()-1].equipment = NullCheck(totalNSV[1]) - NullCheck(itemList[itemList.size()-2].equipment);	
	        		itemList[itemList.size()-1].thirdParty = NullCheck(totalNSV[2]) - NullCheck(itemList[itemList.size()-2].thirdParty);	
	        		itemList[itemList.size()-1].cs = NullCheck(totalNSV[3]) - NullCheck(itemList[itemList.size()-2].cs);

	        		if(itemList == integralCostsOfSale)
	        		{
	        			totalIGM = new Decimal[]{itemList[itemList.size()-1].total, itemList[itemList.size()-1].equipment, 
	        				itemList[itemList.size()-1].thirdParty, itemList[itemList.size()-1].cs };
	        		}
	        		else if(itemList == dedicatedSellingExpenses)
	        		{
	        			itemList[itemList.size()-1].total = NullCheck(totalIGM[0]) - NullCheck(itemList[itemList.size()-2].total);	
		        		itemList[itemList.size()-1].equipment = NullCheck(totalIGM[1]) - NullCheck(itemList[itemList.size()-2].equipment);	
		        		itemList[itemList.size()-1].thirdParty = NullCheck(totalIGM[2]) - NullCheck(itemList[itemList.size()-2].thirdParty);	
		        		itemList[itemList.size()-1].cs = NullCheck(totalIGM[3]) - NullCheck(itemList[itemList.size()-2].cs);	

		        		totalIVM = new Decimal[]{itemList[itemList.size()-1].total, itemList[itemList.size()-1].equipment, 
	        				itemList[itemList.size()-1].thirdParty, itemList[itemList.size()-1].cs };
	        		}
	        		else if(itemList == fixedSellingExpenses)
	        		{
        				itemList[itemList.size()-1].total = NullCheck(totalIVM[0]) - NullCheck(itemList[itemList.size()-2].total);	
		        		itemList[itemList.size()-1].equipment = NullCheck(totalIVM[1]) - NullCheck(itemList[itemList.size()-2].equipment);	
		        		itemList[itemList.size()-1].thirdParty = NullCheck(totalIVM[2]) - NullCheck(itemList[itemList.size()-2].thirdParty);	
		        		itemList[itemList.size()-1].cs = NullCheck(totalIVM[3]) - NullCheck(itemList[itemList.size()-2].cs);	

		        		totalISM = new Decimal[]{itemList[itemList.size()-1].total, itemList[itemList.size()-1].equipment, 
        				itemList[itemList.size()-1].thirdParty, itemList[itemList.size()-1].cs };
	        		}
		        }
		        //system.debug(logginglevel.info, 'itemList: ' + itemList);
		        for(ReportLineItem item : itemList)
	        	{
	        		//system.debug(logginglevel.info,'calculate for line item: ' + item);
	        		if(netSalesValueTotal!= 0)
    					CalculatePercentages(item);
    				
	        	}
	        }
	        
		//}
		//catch(exception e)
    	//{
    	//	system.debug(logginglevel.info,'2: ' + e);
    	//}
    	//debug values
    	system.debug(logginglevel.info,'net sales list: ' + netSalesValue);
    	system.debug(logginglevel.info, 'bucket: ' + reportLineDataBucket);
    	system.debug(logginglevel.info,'Int Cost List: ' + integralCostsOfSale);
    	system.debug(logginglevel.info,'net sales list: ' + netSalesValue);
        system.debug(logginglevel.info,'quoteItemList: ' + quoteItemList);
        system.debug(logginglevel.info,'pat1 ' + totalPat1);
        system.debug(logginglevel.info,'pat2 ' + totalPat2);
        system.debug(logginglevel.info,'reportProductList: ' + reportProductList);
        //for(reportProductItem rpi : reportProductList)
        //{
        	//listPriceRollup += NullCheck(rpi.quoteItem.REVVY__Extended_Price_F__c);
        	//targetPriceRollup += NullCheck(rpi.listLineItem.TargetPrice__c);
        	//offerPriceRollup += NullCheck(rpi.quoteItem.REVVY__Extended_Price_F__c);
        //}
        listPriceRollup = quote.HISS_Total_List_Price__c;
        offerPriceRollup = quote.HISS_Total_Sell_Price__c;
		//system.debug(logginglevel.info, 'reportProductList: ' + reportProductList);
	}
	private void MatchDescription(REVVY__MnCatalogNode__c node, List<ReportLineItem> sList, List<REVVY__MnPriceListLine__c> llList)
	{
		REVVY__MnPriceListLine__c lineListItem;
		for(REVVY__MnPriceListLine__c priceListLineItem : llList)
		{
			if(priceListLineItem.REVVY__Product__c == node.id)
			{
				lineListItem = priceListLineItem;
				break;
			}
		}
		//system.debug(logginglevel.info, 'lineListitem: ' + lineListItem);
		if(lineListItem != null)
		{
			for(ReportLineItem listEntry : sList)
	        {
	        	//system.debug(logginglevel.info, 'listEntry description: ' + listEntry.description + ' node description: ' + node.Pre_Calc_Description__c);
	        	if(listEntry.description == node.Pre_Calc_Description__c)
	        	{
	        		if(listEntry.description == 'Sales Value Quote Total')
	        		{
	        			
	        			if(totalPat1 == null)
			        		totalPat1 = NullCheck(lineListItem.Pat1__c);
				       	else
				       		totalPat1 += NullCheck(lineListItem.Pat1__c);
			       		
			       		if(totalPat2 == null)
				        	totalPat2 = NullCheck(lineListItem.Pat2__c);
				       	else
				       		totalPat2 += NullCheck(lineListItem.Pat2__c);

	        		}
	        		else if (listEntry.description == 'Integral goods consumption Philips (FFP)')
	        		{
						system.debug(logginglevel.info, 'Items with Integral goods consumption Philips (FFP):listentry: ' + listEntry + ' node: ' + node + ' reportLineItem: ' + sList);
	        		}

	        		listEntry.catNodeItem = node;
	        		listEntry.listLineItem = lineListItem;
	        		//system.debug(logginglevel.info, 'node: ' + node);
	        		//system.debug(logginglevel.info, 'listEntry: ' + listEntry);
	        		//system.debug(logginglevel.info, 'lineListItem: ' + lineListitem);
	        		//if(listEntry.description != 'Sales Value Quote Total')
	        		//{
	        			
	        		AddItemDataToReport(node, listEntry, lineListItem);
	        		//}
	        	}       
	        }
	        //system.debug(logginglevel.info, 'test linelistitem: ' + lineListItem);
	        if(totalTargetPrice == null)
	        	totalTargetPrice = NullCheck(lineListItem.TargetPrice__c);
	       	else
	       		totalTargetPrice += NullCheck(lineListItem.TargetPrice__c);
		    
		}
	}
	private void AddItemDataToReport(REVVY__MnCatalogNode__c node, ReportLineItem sList, REVVY__MnPriceListLine__c lineList)
	{
		REVVY__MnQuoteItem__c quoteItem;
		REVVY__MnQuoteItemSubLine__c quoteSubItem;
		Decimal itemPrice;
		Decimal itemRevenue = 0;

		//system.debug(logginglevel.info, 'quoteItemList1: ' + quoteItemList);

		for(REVVY__MNQuoteItem__c qi: quoteItemList)
		{
			//system.debug(logginglevel.info, 'node description: ' + node.Pre_Calc_Description__c);
			//system.debug(logginglevel.info, 'quoteItem to add3: ' + qi);
			if(qi.REVVY__Catalog_Node__r.id == node.id)
			{
				quoteItem = qi;
			
				if(node.Pre_Calc_Description__c == 'Sales Value Quote Total')
				{
					if(itemPrice == null)
					{
						itemPrice = NullCheck(qi.REVVY__Extended_Price_F__c);
					}
					else
					{
						itemPrice += NullCheck(qi.REVVY__Extended_Price_F__c);
					}
					reportProductList.add(new ReportProductItem(lineList, node, quoteItem));
				}
				/*else if(node.Pre_Calc_Description__c == 'Financing Uplift' ||
					node.Pre_Calc_Description__c == 'No Turnover')
				{
					//itemPrice = quoteItem.REVVY__Extended_Price_F__c;
					if(itemPrice == null)
					{
						itemPrice = NullCheck(qi.REVVY__Extended_Price_F__c);
					}
					else
					{
						itemPrice += NullCheck(qi.REVVY__Extended_Price_F__c);
					}
				}
				else
				{*/
					//itemPrice = quoteItem.REVVY__TotalCostPrice__c;

				else if(itemPrice == null)
				{
					itemPrice = NullCheck(qi.REVVY__TotalCostPrice__c);
					//quoteSubItem = qi;
				}
				else
				{
					itemPrice += NullCheck(qi.REVVY__TotalCostPrice__c);
                    system.debug(logginglevel.info, 'XXX added item cost price: '+ qi.REVVY__TotalCostPrice__c );
				}
				//}

				itemRevenue += NullCheck(qi.REVVY__Extended_Price_F__c);
				//system.debug(logginglevel.info,'Quote Item Revenue: ' + itemRevenue);
			}
		}

		if(quoteItem != null)
		{
			//system.debug(logginglevel.info,'Quote SubItemList: ' + quoteSubItemList);
			for(REVVY__MNQuoteItemSubLine__c qi: quoteSubItemList)
			{
				if(qi.REVVY__Catalog_Node__r.id == node.id)
				{
					//system.debug('subline item: ' + qi.REVVY__Extended_Price_F__c + ' OR : ' + qi.REVVY__TotalCostPrice__c);
					if(itemPrice == null)
					{
						itemPrice = NullCheck(qi.REVVY__TotalCostPrice__c);
						//quoteSubItem = qi;
					}
					else
					{
						itemPrice += NullCheck(qi.REVVY__TotalCostPrice__c);
					}
					itemRevenue += NullCheck(qi.REVVY__Extended_Price_F__c);
				}
			}
		}
		else
		{
			//system.debug(logginglevel.info,'Quote SubItemList: ' + quoteSubItemList);
			for(REVVY__MNQuoteItemSubLine__c qi: quoteSubItemList)
			{
				if(qi.REVVY__Catalog_Node__r.id == node.id)
				{
					system.debug('subline item: ' + qi.REVVY__Extended_Price_F__c + ' OR : ' + qi.REVVY__TotalCostPrice__c);
					if(itemPrice == null)
					{
						itemPrice = NullCheck(qi.REVVY__TotalCostPrice__c);
						//quoteSubItem = qi;
					}
					else
					{
						itemPrice += NullCheck(qi.REVVY__TotalCostPrice__c);
					}
					itemRevenue += NullCheck(qi.REVVY__Extended_Price_F__c);
				}
			}

			//itemPrice = NullCheck(quoteSubItem.REVVY__TotalCostPrice__c);
		}

		
			if(node.Source_Dimension__c == 'Equipment')
			{
				if(sList.equipment == null)
					sList.equipment = NullCheck(itemPrice);
				else
					sList.equipment += NullCheck(itemPrice);
				equipmentRevenueTotal += NullCheck(itemRevenue);
				//system.debug(logginglevel.info, 'slist equipment ' + sList.equipment);
			}
        system.debug('node source: ' + node.Source_Dimension__c);
			if(node.Source_Dimension__c == '3rd Party')
			{
				system.debug('3rd party report item: ' + itemPrice);
				if(sList.thirdParty == null)
					sList.thirdParty = NullCheck(itemPrice);
				else
					sList.thirdParty += NullCheck(itemPrice);
				thirdPartyRevenueTotal += NullCheck(itemRevenue);
				system.debug('3rd party total value: ' + sList.thirdParty);
			}
			if(node.Source_Dimension__c == 'CS')
			{
				if(sList.cs == null)
					sList.cs = NullCheck(itemPrice);
				else
					sList.cs += NullCheck(itemPrice);
				cSRevenueTotal += NullCheck(itemRevenue);
			}
			if(sList.total != null)
				sList.total += NullCheck(itemPrice);
			else
				sList.total = NullCheck(itemPrice);
		
		//system.debug(logginglevel.info,'testend: ');
		//netSalesValueTotal += itemPrice;
	
	}
	private void CalculatePercentages(ReportLineItem sList)
	{
		//system.debug(logginglevel.info, 'reportLineItem Calc Percent: ' + sList);
		if(sList.equipment != null)
		{
			sList.equipmentPercent = 100*sList.equipment/NullCheck(netSalesValueTotal);
		}
		if(sList.thirdParty != null)
		{
			sList.thirdPartyPercent = 100*sList.thirdParty/NullCheck(netSalesValueTotal);
		}
		if(sList.cs != null)
		{
			sList.csPercent = 100*sList.cs/NullCheck(netSalesValueTotal);
		}
		//system.debug(logginglevel.info,'sList.total and netSalesValueTotal: ' + sList.total + ' : ' + netSalesValueTotal);
		if(sList.total != null)
			sList.totalPercent = 100*sList.total/NullCheck(netSalesValueTotal);
	}
	public List<REVVY__MnQuoteItem__c> getQuoteItems() {
        return quoteItemList;
    }
    private String GetQuoteSubItemFields()
    {
    	String quoteString = 'id, name, REVVY__QuoteItem__c, REVVY__Catalog_Node__r.id, REVVY__TotalCostPrice__c, REVVY__Extended_Price_F__c ';
		return quoteString;
    }
	private String GetQuoteFields()
	{
		String quoteString = 'id, name, Extended_Target_Price__c, Extended_Pat1__c, Extended_Pat2__c, REVVY__ContractStartDate__c, REVVY__ContractEndDate__c, REVVY__StartDateContract__c, REVVY__EndDateContract__c, HISS_Total_Cost_price__c, HISS_Total_List_Price__c, HISS_Total_Sell_Price__c, HISS_Target_Margin__c, HISS_Deal_Margin__c, REVVY__One_Time_Unit_Price_S__c ';
		return quoteString;

	}
	private String GetCatalogNodeFields()
	{
		String quoteString = 'id, name, Article_NR__c, Pre_Calc_Category__c, Pre_Calc_Description__c, Pre_Calc_Section__c, Source_Dimension__c, REVVY__LocaleName_F__c ';
		return quoteString;

	}
	private String GetQuoteItemFields()
	{
		String quoteString = 'id, name, Extended_Target_Price__c, REVVY__Quote__c, REVVY__Extended_Price_F__c, REVVY__Catalog_Node__r.id, REVVY__Product_Name_F__c, REVVY__Price__c, HISS_Cost_Price__c, REVVY__TotalCostPrice__c ';
		return quoteString;
	}
	private String GetPriceLineItemFields()
	{
		String quoteString = 'id, name, TargetPrice__c, REVVY__ListedPrice__c, REVVY__CostPrice__c, PAT1__c, PAT2__c, REVVY__Product__c, REVVY__Product_Name__c ';
		return quoteString;
	}
	private List<ReportLineItem> BuildNetSalesList()
	{
        List<ReportLineItem> buildList = new List<ReportLineItem>();

		return buildList;
	}
	private String GetSubtotalTitle(integer index)
	{
		if(index == 0)
			return 'Sales Value Correction Elements';
		else if(index == 1)
			return 'Integral Cost of Sales';
		else if(index == 2)
			return 'Dedicated Selling Expenses';
		else
			return '-Fixed Selling Expenses';
	}
	private String[] GetMarginTitle(integer index)
	{
		if(index == 0)
			return new String[]{'NSV','Net Sales Value'};
		else if(index == 1)
			return new String[]{'IGM','Integral Gross Margin'};
		else if(index == 2)
			return new String[]{'IVM','Integral Variable Margin'};
		else
			return new String[]{'ISM','Integral Sales Margin'};
	}
	List<String[]> GetNetSalesList()
	{
		List<String[]> stringContainer = new List<string[]>{
			new String[]{'Financing Correction','Financing Uplift','9380000'},
			new String[]{'Financing Correction','No Turnover','8000000'}};
		return stringContainer;
	}
	List<String[]> GetIntCostList()
	{
		List<String[]> stringContainer = new List<string[]>{
			new string[]{'Cost of Materials','Integral goods consumption Philips (FFP)',''},
			new string[]{'Cost of Materials','Goods consumption Philips (DTP calculation)','7700052'},
			new string[]{'Cost of Materials','Goods consumption (3rd party purchased locally)','7700050'},
			new string[]{'Cost of Materials','Goods consumption (3rd party purchased centrally)','7700051'},
			new string[]{'Pre-installation','Site preparation performed by Philips','6592021'},
			new string[]{'Pre-installation','Site preparation performed by 3rd Party non-Distributor','7738003'},
			new string[]{'Pre-installation','Dismounting performed by Philips','6592024'},
			new string[]{'Pre-installation','Dismounting performed by 3rd Party non-Distributor','7736455'},
			new string[]{'Distribution','Inward freight, insurance (return from customer to Philips)','7741000'},
			new string[]{'Distribution','Outward freight, insurance (from Philips to customer)','6400100'},
			new string[]{'Distribution','Custom duties','7753000'},
			new string[]{'Distribution','Other distribution and warehousing costs','6494110'},
			new string[]{'Installation','Installation performed by Philips','6592011'},
			new string[]{'Installation','Installation performed by 3rd Party non-distributor','7732000'},
			new string[]{'Installation','Connectivity performed by Philips','6590110'},
			new string[]{'Training','Application training performed by Philips','6592061'},
			new string[]{'Training','Application training performed by 3rd Party non-distributor','7738010'},
			new string[]{'Distributor acting as agent','Distributor order realisation costs','7730072'},
			new string[]{'Other','Other project costs Philips','7730070'},
			new string[]{'Other','Other project costs 3rd Party non-distributor','7730071'},
			new string[]{'Warranty','Standard warrantly costs labour Philips','6592030'},
			new string[]{'Warranty','Standard warrantly costs labour distributor','6593100'},
			new string[]{'Warranty','Standard warrantly costs spare parts','7880000'},
			new string[]{'After Sales Services','Customer services labour - CS Philips (inc. ext. Warranty)','6593690'},
			new string[]{'After Sales Services','Customer services labour - CS (Subcontracted work) (inct. Ext. Warranty)','7736310'},
			new string[]{'After Sales Services','Customer services replacement parts - Philips (incl. ext. Warranty)','7700460'},
			new string[]{'Other Local Cost','Equipment Allocated LCOS','9999997'}};
		return stringContainer;
	}
	List<String[]> GetDeligatedExpenseList()
	{
		List<String[]> stringContainer = new List<string[]>{
			new String[]{'DSE','Commission to be paid to agent','6550107'},
			new String[]{'DSE','Consulting costs','6550800'},
			new String[]{'DSE','Training own staff','6170100'},
			new String[]{'DSE','Promotions/seminars/sponsoring etc.','6524030'},
			new String[]{'DSE','Bank charges','6660100'},
			new String[]{'DSE','Financing costs','6540100'},
			new String[]{'DSE','Customer traveling expenses','6160820'},
			new String[]{'DSE','Travelling expenses own staff','6160600'},
			new String[]{'DSE','Project management (special projects only)','6697010'}};
		return stringContainer;
	}
	List<String[]> GetFixedExpenseList()
	{
		List<String[]> stringContainer = new List<string[]>{
			new String[]{'FSE','Fixed Selling Expenses','No Turnover',''}};
		return stringContainer;
	}
	Decimal NullCheck(Decimal num)
	{
		if(num == null)
			return 0;
		else
			return num;
	}
	void SetDates(REVVY__MnQuote__c qt)
	{
		startDate = quote.REVVY__StartDateContract__c.format();
		endDate = quote.REVVY__EndDateContract__c.format();

	}
	public class ReportLineItem
	{
		public String category {get;set;} 
		public String description {get;set;}
		public String glaccount {get;set;}
		public Decimal total {get;set;}
		public Decimal totalPercent {get;set;}
		public Decimal equipment {get;set;}
		public Decimal equipmentPercent {get;set;}
		public Decimal thirdParty {get;set;}
		public Decimal thirdPartyPercent {get;set;}
		public Decimal cs {get;set;}
		public Decimal csPercent{get;set;}
		public boolean blueLine {get;set;}
		public boolean greyLine {get;set;}
		public REVVY__MnPriceListLine__c listLineItem {get;set;}
		public REVVY__MnCatalogNode__c catNodeItem {get;set;}

		public ReportLineItem(String category, String description, String account)
		{
			this.category = category;
			this.description = description;
			this.glaccount = account;
		}
	}
	public class ReportProductItem
	{
		public String name {get;set;}
		public Decimal listPrice {get;set;}
		public Decimal targetPrice {get;set;}
		public Decimal attainment {get;set;}
		public Decimal ism {get;set;}
		public Decimal ivm {get;set;}
		public Decimal igm {get;set;}
		public REVVY__MnPriceListLine__c listLineItem {get;set;}
		public REVVY__MnCatalogNode__c catNodeItem {get;set;}
		public REVVY__MnQuoteItem__c quoteItem {get;set;}

		public ReportProductItem(REVVY__MnPriceListLine__c pLL, REVVY__MnCatalogNode__c cn, REVVY__MnQuoteItem__c qi)
		{
			catNodeItem = cn;
			listLineItem = pLL;
			quoteItem = qi;
			name=pLL.REVVY__Product_Name__c;
		}
	}
}