public without sharing class M2O_CommercialPolicyPrintController{

    public Id recordId{get;set;}
    List<Budget_AOP_View__c> listOfSelectedRecords;
    public List<Budget_AOP_View__c> finalListOfFYSelectedRecords{get;set;}
    public List<Budget_AOP_View__c> finalListOfQ1SelectedRecords{get;set;}
    public List<Budget_AOP_View__c> finalListOfQ2SelectedRecords{get;set;}
    public List<Budget_AOP_View__c> finalListOfQ3SelectedRecords{get;set;}
    public List<Budget_AOP_View__c> finalListOfQ4SelectedRecords{get;set;}
    List<AggregateResult> listOfAggregatedRecords;
    Integer upselling = 0;
    Integer retailer = 0;
    Integer consumer = 0;
    Integer brand = 0;
    Integer cooperative = 0;
    Integer trade = 0;
    Integer other = 0;
    Integer total = 0;
    Integer invoiced = 0;
    Integer nSales = 0;
    Integer index = 0;
    Integer last = 0;
    public Boolean printPage{get;set;}
    public String budgetType{get;set;}
    
    public Integer upsellingTotalQ1{get;set;}
    public Integer retailerTotalQ1{get;set;}
    public Integer consumerTotalQ1{get;set;}
    public Integer brandTotalQ1{get;set;}
    public Integer cooperativeTotalQ1{get;set;}
    public Integer tradeTotalQ1{get;set;}
    public Integer otherTotalQ1{get;set;}
    public Integer verticalTotalQ1{get;set;}
    public Integer invoicedTotalQ1{get;set;}
    public Integer nSalesTotalQ1{get;set;}
    
    public Integer upsellingTotalQ2{get;set;}
    public Integer retailerTotalQ2{get;set;}
    public Integer consumerTotalQ2{get;set;}
    public Integer brandTotalQ2{get;set;}
    public Integer cooperativeTotalQ2{get;set;}
    public Integer tradeTotalQ2{get;set;}
    public Integer otherTotalQ2{get;set;}
    public Integer verticalTotalQ2{get;set;}
    public Integer invoicedTotalQ2{get;set;}
    public Integer nSalesTotalQ2{get;set;}
    
    public Integer upsellingTotalQ3{get;set;}
    public Integer retailerTotalQ3{get;set;}
    public Integer consumerTotalQ3{get;set;}
    public Integer brandTotalQ3{get;set;}
    public Integer cooperativeTotalQ3{get;set;}
    public Integer tradeTotalQ3{get;set;}
    public Integer otherTotalQ3{get;set;}
    public Integer verticalTotalQ3{get;set;}
    public Integer invoicedTotalQ3{get;set;}
    public Integer nSalesTotalQ3{get;set;}
    
    public Integer upsellingTotalQ4{get;set;}
    public Integer retailerTotalQ4{get;set;}
    public Integer consumerTotalQ4{get;set;}
    public Integer brandTotalQ4{get;set;}
    public Integer cooperativeTotalQ4{get;set;}
    public Integer tradeTotalQ4{get;set;}
    public Integer otherTotalQ4{get;set;}
    public Integer verticalTotalQ4{get;set;}
    public Integer invoicedTotalQ4{get;set;}
    public Integer nSalesTotalQ4{get;set;}
    
    public Integer upsellingTotalFY{get;set;}
    public Integer retailerTotalFY{get;set;}
    public Integer consumerTotalFY{get;set;}
    public Integer brandTotalFY{get;set;}
    public Integer cooperativeTotalFY{get;set;}
    public Integer tradeTotalFY{get;set;}
    public Integer otherTotalFY{get;set;}
    public Integer verticalTotalFY{get;set;}
    public Integer invoicedTotalFY{get;set;}
    public Integer nSalesTotalFY{get;set;}
    
    public M2O_CommercialPolicyPrintController(ApexPages.StandardController controller) {
         if(ApexPages.currentPage().getParameters().get('id') != null) {
                recordId = ApexPages.currentPage().getParameters().get('Id'); 
            System.debug('****My recordId'+recordId);
         }
            if(ApexPages.currentPage().getParameters().get('Type') != null) {
            
                budgetType = ApexPages.currentPage().getParameters().get('Type'); 
            System.debug('****My budgetType '+budgetType );
            }
            printPage = true;
            listOfSelectedRecords = new List<Budget_AOP_View__c>();
            upsellingTotalFY = 0;
            retailerTotalFY = 0;
            consumerTotalFY = 0;
            brandTotalFY = 0;
            cooperativeTotalFY = 0;
            tradeTotalFY = 0;
            otherTotalFY = 0;
            verticalTotalFY = 0;
            invoicedTotalFY = 0;
            nSalesTotalFY = 0;
            
            upsellingTotalQ1 = 0;
            retailerTotalQ1 = 0;
            consumerTotalQ1 = 0;
            brandTotalQ1 = 0;
            cooperativeTotalQ1 = 0;
            tradeTotalQ1 = 0;
            otherTotalQ1 = 0;
            verticalTotalQ1 = 0;
            invoicedTotalQ1 = 0;
            nSalesTotalQ1 = 0;
            
            upsellingTotalQ2 = 0;
            retailerTotalQ2 = 0;
            consumerTotalQ2 = 0;
            brandTotalQ2 = 0;
            cooperativeTotalQ2 = 0;
            tradeTotalQ2 = 0;
            otherTotalQ2 = 0;
            verticalTotalQ2 = 0;
            invoicedTotalQ2 = 0;
            nSalesTotalQ2 = 0;
            
            upsellingTotalQ3 = 0;
            retailerTotalQ3 = 0;
            consumerTotalQ3 = 0;
            brandTotalQ3 = 0;
            cooperativeTotalQ3 = 0;
            tradeTotalQ3 = 0;
            otherTotalQ3 = 0;
            verticalTotalQ3 = 0;
            invoicedTotalQ3 = 0;
            nSalesTotalQ3 = 0;
            
            upsellingTotalQ4 = 0;
            retailerTotalQ4 = 0;
            consumerTotalQ4 = 0;
            brandTotalQ4 = 0;
            cooperativeTotalQ4 = 0;
            tradeTotalQ4 = 0;
            otherTotalQ4 = 0;
            verticalTotalQ4 = 0;
            invoicedTotalQ4 = 0;
            nSalesTotalQ4 = 0;
            
            getSelectedPeriodFYRecords();
            getSelectedPeriodQ1Records();
            getSelectedPeriodQ2Records();
            getSelectedPeriodQ3Records();
            getSelectedPeriodQ4Records();
            
    }
    public M2O_CommercialPolicyPrintController(){
    
    }
  
  
    public void sumUpselling(){
        
        for(Integer i=index; i<=last;i++){
         if(listOfSelectedRecords[i].Upselling_Investment__c != null)
           upselling += Integer.ValueOf(listOfSelectedRecords[i].Upselling_Investment__c);
         if(listOfSelectedRecords[i].Retailer_promotion_STTI__c != null)
           retailer +=Integer.ValueOf(listOfSelectedRecords[i].Retailer_promotion_STTI__c);
         if(listOfSelectedRecords[i].Consumer_promotion__c != null)
           consumer += Integer.ValueOf(listOfSelectedRecords[i].Consumer_promotion__c);
         if(listOfSelectedRecords[i].Brand_investment__c != null)
           brand +=Integer.ValueOf(listOfSelectedRecords[i].Brand_investment__c);
         if(listOfSelectedRecords[i].Cooperative_advertising_KAM__c != null)
           cooperative +=Integer.ValueOf(listOfSelectedRecords[i].Cooperative_advertising_KAM__c);
         if(listOfSelectedRecords[i].Trade_marketing_investments_TSM__c != null)
           trade +=Integer.ValueOf(listOfSelectedRecords[i].Trade_marketing_investments_TSM__c);
         if(listOfSelectedRecords[i].Other__c != null)
           other +=Integer.ValueOf(listOfSelectedRecords[i].Other__c); 
         if(listOfSelectedRecords[i].Invoiced_Sales__c != null)
           invoiced +=Integer.ValueOf(listOfSelectedRecords[i].Invoiced_Sales__c);
         if(listOfSelectedRecords[i].X3N_Sales__c != null)
           nsales +=Integer.ValueOf(listOfSelectedRecords[i].X3N_Sales__c);
        }
        total = upselling + retailer + consumer + brand + cooperative + trade + other; 
        
        index=last+1;
       
    }
    
    public void getSelectedPeriodFYRecords(){
        finalListOfFYSelectedRecords = new List<Budget_AOP_View__c>();
        index = 0;
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        listOfAggregatedRecords = new List<AggregateResult>();
        listOfAggregatedRecords =[select BG_Code__c bgcode,BG_Name__c bgname,Category_Code__c catcode,Category_Name__c catname,Sum(Upselling_Investment__c) upsell,Sum(Retailer_promotion_STTI__c) retail,Sum(Consumer_promotion__c) consume,Sum(Brand_investment__c) bInvest,Sum(Cooperative_advertising_KAM__c) cooperate,Sum(Trade_marketing_investments_TSM__c) tradeInvest,Sum(Other__c) other,Sum(Invoiced_Sales__c) invSales,Sum(X3N_Sales__c) sales,Sum(Total_Investments__c) tot from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Type__c =: budgetType Group By BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c order By BG_Code__c asc];    
        for(AggregateResult agrRecord : listOfAggregatedRecords){
            listOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c= (String)agrRecord.get('bgcode'),BG_Name__c=(String)agrRecord.get('bgname'),Category_Code__c=(String)agrRecord.get('catcode'),Category_Name__c=(String)agrRecord.get('catname'),Upselling_Investment__c=Integer.valueOf(agrRecord.get('upsell')),Retailer_promotion_STTI__c=Integer.valueOf(agrRecord.get('retail')),Consumer_promotion__c=Integer.valueOf(agrRecord.get('consume')),Brand_investment__c=Integer.valueOf(agrRecord.get('bInvest')),Cooperative_advertising_KAM__c=Integer.valueOf(agrRecord.get('cooperate')),Trade_marketing_investments_TSM__c=Integer.valueOf(agrRecord.get('tradeInvest')),Other__c=Integer.valueOf(agrRecord.get('other')),Total_Investments__c=Integer.valueOf(agrRecord.get('tot')),Invoiced_Sales__c=Integer.valueOf(agrRecord.get('invSales')),X3N_Sales__c=Integer.valueOf(agrRecord.get('sales'))));   
        }
        if(listOfSelectedRecords!= null && !listOfSelectedRecords.isEmpty()){
            listOfSelectedRecords.sort();
            for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                finalListOfFYSelectedRecords.add(listOfSelectedRecords[i]);
                if(i+1 < listOfSelectedRecords.size()){
                    if(listOfSelectedRecords[i].BG_Name__c != listOfSelectedRecords[i+1].BG_Name__c){
                        last=i;                           
                        upselling = 0;
                        retailer = 0;
                        consumer = 0;
                        brand = 0;
                        cooperative = 0;
                        trade = 0;
                        other = 0;
                        invoiced = 0;
                        nSales = 0;
                        total = 0;
                        sumUpselling();
                        finalListOfFYSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
                else{
                    last=i;                           
                    upselling = 0;
                    retailer = 0;
                    consumer = 0;
                    brand = 0;
                    cooperative = 0;
                    trade = 0;
                    other = 0;
                    invoiced = 0;nSales = 0;
                    total = 0;
                    sumUpselling();
                    finalListOfFYSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                }
            }
        }
        for(Budget_AOP_View__c sumUp : finalListOfFYSelectedRecords){
            if(sumUp.Category_Code__c == 'Total'){
            if(sumUp.Upselling_Investment__c != null)
                upsellingTotalFY += Integer.valueOf(sumUp.Upselling_Investment__c);
            if(sumUp.Retailer_promotion_STTI__c != null)
                retailerTotalFY += Integer.valueOf(sumUp.Retailer_promotion_STTI__c);
            if(sumUp.Consumer_promotion__c != null)
                consumerTotalFY += Integer.valueOf(sumUp.Consumer_promotion__c);
            if(sumUp.Brand_investment__c != null)
                brandTotalFY += Integer.valueOf(sumUp.Brand_investment__c);
            if(sumUp.Cooperative_advertising_KAM__c != null)
                cooperativeTotalFY += Integer.valueOf(sumUp.Cooperative_advertising_KAM__c);
            if(sumUp.Trade_marketing_investments_TSM__c != null)
                tradeTotalFY += Integer.valueOf(sumUp.Trade_marketing_investments_TSM__c);
            if(sumUp.Other__c != null)
                otherTotalFY += Integer.valueOf(sumUp.Other__c);
            if(sumUp.Total_Investments__c != null)
                verticalTotalFY += Integer.valueOf(sumUp.Total_Investments__c);
            if(sumUp.Invoiced_Sales__c != null)
                invoicedTotalFY += Integer.valueOf(sumUp.Invoiced_Sales__c);
            if(sumUp.X3N_Sales__c != null)
                nSalesTotalFY += Integer.valueOf(sumUp.X3N_Sales__c);
            }
        }
    }


    
    public void getSelectedPeriodQ1Records(){
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        finalListOfQ1SelectedRecords = new List<Budget_AOP_View__c>();
        index = 0;
        listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c ='Q1' AND Type__c =: budgetType order By BG_Code__c asc];
        if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
            for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                finalListOfQ1SelectedRecords.add(listOfSelectedRecords[i]);
                if(i+1 < listOfSelectedRecords.size()){
                    if(listOfSelectedRecords[i].BG_Name__c != listOfSelectedRecords[i+1].BG_Name__c){
                        last=i;
                        upselling = 0;
                        retailer = 0;
                        consumer = 0;
                        brand = 0;
                        cooperative = 0;
                        trade = 0;
                        other = 0;
                        total = 0;
                        invoiced = 0;
                        nSales = 0;
                        sumUpselling();
                        finalListOfQ1SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
                else{
                    last=i;
                    upselling = 0;
                    retailer = 0;
                    consumer = 0;
                    brand = 0;
                    cooperative = 0;
                    trade = 0;
                    other = 0;
                    total = 0;
                    invoiced = 0;
                    nSales = 0;
                    sumUpselling();
                    finalListOfQ1SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                }
            }
        }
        
        for(Budget_AOP_View__c sumUp : finalListOfQ1SelectedRecords){
            if(sumUp.Category_Code__c=='Total'){
            if(sumUp.Upselling_Investment__c != null)
                upsellingTotalQ1 += Integer.valueOf(sumUp.Upselling_Investment__c);
            if(sumUp.Retailer_promotion_STTI__c != null)
                retailerTotalQ1 += Integer.valueOf(sumUp.Retailer_promotion_STTI__c);
            if(sumUp.Consumer_promotion__c != null)
                consumerTotalQ1 += Integer.valueOf(sumUp.Consumer_promotion__c);
            if(sumUp.Brand_investment__c != null)
                brandTotalQ1 += Integer.valueOf(sumUp.Brand_investment__c);
            if(sumUp.Cooperative_advertising_KAM__c != null)
                cooperativeTotalQ1 += Integer.valueOf(sumUp.Cooperative_advertising_KAM__c);
            if(sumUp.Trade_marketing_investments_TSM__c != null)
                tradeTotalQ1 += Integer.valueOf(sumUp.Trade_marketing_investments_TSM__c);
            if(sumUp.Other__c != null)
                otherTotalQ1 += Integer.valueOf(sumUp.Other__c);
            if(sumUp.Total_Investments__c != null)
                verticalTotalQ1 += Integer.valueOf(sumUp.Total_Investments__c);
            if(sumUp.Invoiced_Sales__c != null)
                invoicedTotalQ1 += Integer.valueOf(sumUp.Invoiced_Sales__c);
            if(sumUp.X3N_Sales__c != null)
                nSalesTotalQ1 += Integer.valueOf(sumUp.X3N_Sales__c);
            }
        }
    }
    
    public void getSelectedPeriodQ2Records(){
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        finalListOfQ2SelectedRecords = new List<Budget_AOP_View__c>();
        index = 0;
        listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c ='Q2' AND Type__c =: budgetType order By BG_Code__c asc];
        if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
            for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                finalListOfQ2SelectedRecords.add(listOfSelectedRecords[i]);
                if(i+1 < listOfSelectedRecords.size()){
                    if(listOfSelectedRecords[i].BG_Name__c != listOfSelectedRecords[i+1].BG_Name__c){
                        last=i;
                        upselling = 0;
                        retailer = 0;
                        consumer = 0;
                        brand = 0;
                        cooperative = 0;
                        trade = 0;
                        other = 0;
                        total = 0;
                        invoiced = 0;
                        nSales = 0;
                        sumUpselling();
                        finalListOfQ2SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
                else{
                    last=i;
                    upselling = 0;
                    retailer = 0;
                    consumer = 0;
                    brand = 0;
                    cooperative = 0;
                    trade = 0;
                    other = 0;
                    total = 0;
                    invoiced = 0;
                    nSales = 0;
                    sumUpselling();
                    finalListOfQ2SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                }
            }
        }
        for(Budget_AOP_View__c sumUp : finalListOfQ2SelectedRecords){
            if(sumUp.Category_Code__c=='Total'){
            if(sumUp.Upselling_Investment__c != null)
                upsellingTotalQ2 += Integer.valueOf(sumUp.Upselling_Investment__c);
            if(sumUp.Retailer_promotion_STTI__c != null)
                retailerTotalQ2 += Integer.valueOf(sumUp.Retailer_promotion_STTI__c);
            if(sumUp.Consumer_promotion__c != null)
                consumerTotalQ2 += Integer.valueOf(sumUp.Consumer_promotion__c);
            if(sumUp.Brand_investment__c != null)
                brandTotalQ2 += Integer.valueOf(sumUp.Brand_investment__c);
            if(sumUp.Cooperative_advertising_KAM__c != null)
                cooperativeTotalQ2 += Integer.valueOf(sumUp.Cooperative_advertising_KAM__c);
            if(sumUp.Trade_marketing_investments_TSM__c != null)
                tradeTotalQ2 += Integer.valueOf(sumUp.Trade_marketing_investments_TSM__c);
            if(sumUp.Other__c != null)
                otherTotalQ2 += Integer.valueOf(sumUp.Other__c);
            if(sumUp.Total_Investments__c != null)
                verticalTotalQ2 += Integer.valueOf(sumUp.Total_Investments__c);
            if(sumUp.Invoiced_Sales__c != null)
                invoicedTotalQ2 += Integer.valueOf(sumUp.Invoiced_Sales__c);
            if(sumUp.X3N_Sales__c != null)
                nSalesTotalQ2 += Integer.valueOf(sumUp.X3N_Sales__c);
            }       
        }
    }
    public void getSelectedPeriodQ3Records(){
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        finalListOfQ3SelectedRecords = new List<Budget_AOP_View__c>();
        index = 0;
        listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c ='Q3' AND Type__c =: budgetType order By BG_Code__c asc];
        if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
            for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                finalListOfQ3SelectedRecords.add(listOfSelectedRecords[i]);
                if(i+1 < listOfSelectedRecords.size()){
                    if(listOfSelectedRecords[i].BG_Name__c != listOfSelectedRecords[i+1].BG_Name__c){
                        last=i;
                        upselling = 0;
                        retailer = 0;
                        consumer = 0;
                        brand = 0;
                        cooperative = 0;
                        trade = 0;
                        other = 0;
                        total = 0;
                        invoiced = 0;
                        nSales = 0;
                        sumUpselling();
                        finalListOfQ3SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
                else{
                    last=i;
                    upselling = 0;
                    retailer = 0;
                    consumer = 0;
                    brand = 0;
                    cooperative = 0;
                    trade = 0;
                    other = 0;
                    total = 0;
                    invoiced = 0;
                    nSales = 0;
                    sumUpselling();
                    finalListOfQ3SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                }
            }
        }
        for(Budget_AOP_View__c sumUp : finalListOfQ3SelectedRecords){
            if(sumUp.Category_Code__c=='Total'){
            if(sumUp.Upselling_Investment__c != null)
                upsellingTotalQ3 += Integer.valueOf(sumUp.Upselling_Investment__c);
            if(sumUp.Retailer_promotion_STTI__c != null)
                retailerTotalQ3 += Integer.valueOf(sumUp.Retailer_promotion_STTI__c);
            if(sumUp.Consumer_promotion__c != null)
                consumerTotalQ3 += Integer.valueOf(sumUp.Consumer_promotion__c);
            if(sumUp.Brand_investment__c != null)
                brandTotalQ3 += Integer.valueOf(sumUp.Brand_investment__c);
            if(sumUp.Cooperative_advertising_KAM__c != null)
                cooperativeTotalQ3 += Integer.valueOf(sumUp.Cooperative_advertising_KAM__c);
            if(sumUp.Trade_marketing_investments_TSM__c != null)
                tradeTotalQ3 += Integer.valueOf(sumUp.Trade_marketing_investments_TSM__c);
            if(sumUp.Other__c != null)
                otherTotalQ3 += Integer.valueOf(sumUp.Other__c);
            if(sumUp.Total_Investments__c != null)
                verticalTotalQ3 += Integer.valueOf(sumUp.Total_Investments__c);
            if(sumUp.Invoiced_Sales__c != null)
                invoicedTotalQ3 += Integer.valueOf(sumUp.Invoiced_Sales__c);
            if(sumUp.X3N_Sales__c != null)
                nSalesTotalQ3 += Integer.valueOf(sumUp.X3N_Sales__c);
            }
        }
    }
    
    public void getSelectedPeriodQ4Records(){
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        finalListOfQ4SelectedRecords = new List<Budget_AOP_View__c>();
        index = 0;
        listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c ='Q4' AND Type__c =: budgetType order By BG_Code__c asc];
        if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
            for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                finalListOfQ4SelectedRecords.add(listOfSelectedRecords[i]);
                if(i+1 < listOfSelectedRecords.size()){
                    if(listOfSelectedRecords[i].BG_Name__c != listOfSelectedRecords[i+1].BG_Name__c){
                        last=i;
                        upselling = 0;
                        retailer = 0;
                        consumer = 0;
                        brand = 0;
                        cooperative = 0;
                        trade = 0;
                        other = 0;
                        total = 0;
                        invoiced = 0;
                        nSales = 0;
                        sumUpselling();
                        finalListOfQ4SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
                else{
                    last=i;
                    upselling = 0;
                    retailer = 0;
                    consumer = 0;
                    brand = 0;
                    cooperative = 0;
                    trade = 0;
                    other = 0;
                    total = 0;
                    invoiced = 0;
                    nSales = 0;
                    sumUpselling();
                    finalListOfQ4SelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                }
            }
        }
        for(Budget_AOP_View__c sumUp : finalListOfQ4SelectedRecords){
            if(sumUp.Category_Code__c=='Total'){
            if(sumUp.Upselling_Investment__c != null)
                upsellingTotalQ4 += Integer.valueOf(sumUp.Upselling_Investment__c);
            if(sumUp.Retailer_promotion_STTI__c != null)
                retailerTotalQ4 += Integer.valueOf(sumUp.Retailer_promotion_STTI__c);
            if(sumUp.Consumer_promotion__c != null)
                consumerTotalQ4 += Integer.valueOf(sumUp.Consumer_promotion__c);
            if(sumUp.Brand_investment__c != null)
                brandTotalQ4 += Integer.valueOf(sumUp.Brand_investment__c);
            if(sumUp.Cooperative_advertising_KAM__c != null)
                cooperativeTotalQ4 += Integer.valueOf(sumUp.Cooperative_advertising_KAM__c);
            if(sumUp.Trade_marketing_investments_TSM__c != null)
                tradeTotalQ4 += Integer.valueOf(sumUp.Trade_marketing_investments_TSM__c);
            if(sumUp.Other__c != null)
                otherTotalQ4 += Integer.valueOf(sumUp.Other__c);
            if(sumUp.Total_Investments__c != null)
                verticalTotalQ4 += Integer.valueOf(sumUp.Total_Investments__c);
            if(sumUp.Invoiced_Sales__c != null)
                invoicedTotalQ4 += Integer.valueOf(sumUp.Invoiced_Sales__c);
            if(sumUp.X3N_Sales__c != null)
                nSalesTotalQ4 += Integer.valueOf(sumUp.X3N_Sales__c);
            }
        }
    }

}