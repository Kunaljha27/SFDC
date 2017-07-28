public without sharing class M2O_CommercialPolicyController{

    public Id recordId{get;set;}
    public String renderSec{get;set;}
    public Id accountId;
    public Boolean editMode{get;set;}
    public Boolean documentError {get;set;}
    public Boolean childError{get;set;}
    public Boolean noChildError{get;set;}
    public Boolean editModeCommit{get;set;}
    public Boolean editModePay{get;set;}
    public Boolean editModePayR{get;set;}
    public Boolean editModeControl{get;set;}
    public Commercial_policy__c policyList{get;set;}
    public String SelectedQuarter{get;set;}
    public String SelectedQuarterControl{get;set;}
    public String SelectedQuarterForView{get;set;}
    List<Budget_AOP_View__c> listOfSelectedRecords;
    public List<Budget_AOP_View__c> finalListOfSelectedRecords{get;set;}
    public List<Commitment__c> finalListOfCommRecords{get;set;}
    List<AggregateResult> listOfAggregatedRecords;
    Set<Id> parentCommitmentsIdSet = new Set<Id>();
    public List<Commitment__c> childCommitmentList = new List<Commitment__c>();
    Integer upselling = 0;
    Integer nSales = 0;
    Integer retailer = 0;
    Integer consumer = 0;
    Integer brand = 0;
    Integer cooperative = 0;
    Integer trade = 0;
    Integer other = 0;
    Integer total = 0;
    Integer invoiced = 0;
    Integer index = 0;
    Integer last = 0;
    Integer activity = 0;
    Integer expected = 0;
    Boolean hideAll;
    public Integer upsellingTotal{get;set;}
    public Integer nSalesTotal{get;set;}
    public Integer retailerTotal{get;set;}
    public Integer consumerTotal{get;set;}
    public Integer brandTotal{get;set;}
    public Integer cooperativeTotal{get;set;}
    public Integer tradeTotal{get;set;}
    public Integer otherTotal{get;set;}
    public Integer verticalTotal{get;set;}
    public Integer invoicedTotal{get;set;}
    public List<Commitment__c> upsertPayList = new List<Commitment__c>();
    public List<Commitment__c> upsertPayReviewList = new List<Commitment__c>();
    public List<Commitment__c> upsertPayReviewFinalList = new List<Commitment__c>();
    public Set<Commitment__c> upsertPayReviewFinalSet = new Set<Commitment__c>();
    public Set<Budget_AOP_View__c> upsertBudgetSet = new Set<Budget_AOP_View__c>();
    public Set<Budget_AOP_View__c> upsertControlSet = new Set<Budget_AOP_View__c>();
    public List<Budget_AOP_View__c> upsertBudgetList = new List<Budget_AOP_View__c>();
    public String filterCriteria;
    public Commitment__c comit{get;set;}
    public List<Commitment__c> newCommit{get;set;}
    public Integer noOfRows{get;set;}
    public List<Commitment__c> listOfCommitmentRrecords{get;set;}
    public Set<Commitment__c> finalCommitmentSet = new Set<Commitment__c>();
    public List<Commitment__c> finalCommitmentList = new List<Commitment__c>();
    public Integer totalActivity{get;set;}
    public Integer totalExpected{get;set;}
    public List<Commitment__c> paymentList{get;set;}
    public Integer totalActivityP{get;set;}
    public Integer totalExpectedP{get;set;}
    public Integer totalEntitled{get;set;}
    public Integer totalRealized{get;set;}
    public List<Commitment__c> paymentReviewList{get;set;}
    public Integer totalActivityR{get;set;}
    public Integer totalEntitledR{get;set;}
    public Integer totalPaidR{get;set;}
    public Integer totalActivityRClosed{get;set;}
    public Integer totalEntitledRClosed{get;set;}
    public Integer totalPaidRClosed{get;set;}
    List<Budget_AOP_View__c> listOfSelectedControlRecords;
    public List<Budget_AOP_View__c> finalListOfSelectedControlRecords{get;set;}
    public List<Budget_AOP_View__c> upsertBudgetControlList = new List<Budget_AOP_View__c>();
    Integer upsellingControl = 0;
    Integer nSalesControl = 0;
    Integer retailerControl = 0;
    Integer consumerControl = 0;
    Integer brandControl = 0; 
    Integer cooperativeControl = 0;
    Integer tradeControl = 0;
    Integer otherControl = 0;
    Integer totalControl = 0;
    Integer invoicedControl = 0;
    Integer indexControl = 0;
    Integer lastControl = 0;
    Integer indexComm = 0;
    Integer lastComm = 0;
    public Integer upsellingControlTotal{get;set;}
    public Integer nSalesControlTotal{get;set;}
    public Integer retailerControlTotal{get;set;}
    public Integer consumerControlTotal{get;set;}
    public Integer brandControlTotal{get;set;}
    public Integer cooperativeControlTotal{get;set;}
    public Integer tradeControlTotal{get;set;}
    public Integer otherControlTotal{get;set;}
    public Integer verticalControlTotal{get;set;}
    public Integer invoicedControlTotal{get;set;}
    public Map<Id,Commitment__c> mapOfIdAndParent = new Map<Id,Commitment__c>();
    List<Commitment__c> childCommitmentsList = new List<Commitment__c>();
    public List<FinalCommitmentRecords> finalListOfCommitments{get;set;}
    public Map<Id,List<Commitment__c>> mapOfParentIdAndChild = new Map<Id,List<Commitment__c>>();
    public boolean ShowChild{get;set;}
    public boolean isExpandAll {get;set;}
    public boolean isExpandAllBtn {get;set;}
    public ID parentCheck{get;set;} 
    public ID deleteChild{get;set;}   
    public Boolean checkMethod{get;set;}
    public String checkParam{get;set;}
    public String concatenatedDoc{get;set;}
    public Boolean setRequired{get;set;}
    
    
    public void setfilterCriteria(String Filter) {
        filterCriteria = filter;
        if(filter == 'budget1') {
            getSelectedPeriodRecords();
        }
        else {
            getSelectedPeriodViewRecords();
        }
        editMode = false;
    }
    
    public string getfilterCriteria() {
        return filterCriteria;
    }  
    
    public pagereference getcheck(){
        if(checkParam == 'Invoice'){
            checkMethod = true;
        }
        else{
            checkMethod = false;
        }
        return null;
    }
    

    Set<String> setOfConcatenatedCriteria;
    Map<String,List<Budget_AOP_View__c>> mapOfStringAndBudgetRecord;
    
    
    public M2O_CommercialPolicyController(ApexPages.StandardController controller) {
         if(ApexPages.currentPage().getParameters().get('Id') != null) {
                recordId = ApexPages.currentPage().getParameters().get('Id'); 
            }
        comit = new Commitment__c();
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        listOfSelectedControlRecords = new List<Budget_AOP_View__c>();
        SelectedQuarter='FY';
        SelectedQuarterForView='FY';
        SelectedQuarterControl='FY';
        upsellingTotal = 0;
        nSalesTotal = 0;
        retailerTotal = 0;
        consumerTotal = 0;
        brandTotal = 0;
        cooperativeTotal = 0;
        tradeTotal = 0;
        otherTotal = 0;
        verticalTotal = 0;
        invoicedTotal = 0;
        upsellingControlTotal = 0;
        nSalesControlTotal = 0;
        retailerControlTotal = 0;
        consumerControlTotal = 0;
        brandControlTotal = 0;
        cooperativeControlTotal = 0;
        tradeControlTotal = 0;
        otherControlTotal = 0;
        verticalControlTotal = 0;
        invoicedControlTotal = 0;
        totalActivity = 0;
        totalExpected = 0;
        totalActivityP = 0;
        totalEntitled = 0;
        totalExpectedP = 0;
        totalRealized = 0;
        totalActivityR = 0;
        totalEntitledR = 0;
        totalPaidR = 0;
        totalActivityRClosed = 0;
        totalEntitledRClosed = 0;
        totalPaidRClosed = 0;
        noOfRows = 0;
        getSelectedPeriodViewRecords();
        getSelectedControlRecords();
        getSelectedPeriodRecords();
        getCommitmentRecords();
        getPaymentRecords();
        getPaymentReviewRecords();
        ShowChild = true;
        checkMethod = false;
        concatenatedDoc='';
        isExpandAll = false;
        isExpandAllBtn = true;
        setRequired =false;
    }
    public M2O_CommercialPolicyController(){
    
    }
    
    public void editCommitment(){
        editModeCommit=(editModeCommit==true)?false:true;
        if(listOfCommitmentRrecords.size() == 0){
            
            noOfRows= 5;
            newCommit = new List<Commitment__c>();
            for(integer i=1;i<=noOfRows;i++){
               newCommit.add(new Commitment__c(Name = 'Commitment'+i,Commercial_Policy__c = recordId,Commitment_Status__c = 'Draft')); 
            }
        }
        else{
            newCommit = new List<Commitment__c>();
        }
    }
    public void addRows(){
        noOfRows = noOfRows + 1;
        newCommit.add(new Commitment__c(Name = 'Commitment'+noOfRows,Commercial_Policy__c = recordId,Commitment_Status__c = 'Draft', Commitment_Type__c='Trade Investment')); 
    }
    
    public void enableEditing() {
            editMode=(editMode==true)?false:true;
            if(editMode!=true) {
                getSelectedPeriodRecords();
            }
    }
    
    public void enableEditingControl() {
            editModeControl=(editModeControl==true)?false:true;
            if(editModeControl!=true) {
                getSelectedControlRecords();
            }
    }
    
    public void EditPay() {
            editModePay=(editModePay==true)?false:true;
            if(editModePay!=true) {
                getPaymentRecords();
            }
    }
    
    public void EditPayReview() {
            editModePayR=(editModePayR==true)?false:true;
            if(editModePayR!=true) {
                getPaymentReviewRecords();
            }
    }
    
    public List<SelectOption> getViewList(){
        List<SelectOption> selctList = new List<SelectOption>();
        selctList.add(new SelectOption('FY','FY'));
        selctList.add(new SelectOption('Q1','Q1'));
        selctList.add(new SelectOption('Q2','Q2'));
        selctList.add(new SelectOption('Q3','Q3'));
        selctList.add(new SelectOption('Q4','Q4'));
        
        return  selctList;
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
               nSales +=Integer.ValueOf(listOfSelectedRecords[i].X3N_Sales__c);
        }
        
        total = upselling + retailer + consumer + brand + cooperative + trade + other; 
        
        index=last+1;
        upsellingTotal +=upselling;
        retailerTotal +=retailer;
        consumerTotal +=consumer;
        brandTotal +=brand;
        cooperativeTotal +=cooperative;
        tradeTotal +=trade;
        otherTotal +=other;
        verticalTotal +=total;
        invoicedTotal +=invoiced;
        nSalesTotal +=nSales;
    }
    
    public void sumUpsellingControl(){
        
        for(Integer i=indexControl; i<=lastControl;i++){
           if(listOfSelectedControlRecords[i].Upselling_Investment__c != null)
               upsellingControl += Integer.ValueOf(listOfSelectedControlRecords[i].Upselling_Investment__c);
           if(listOfSelectedControlRecords[i].Retailer_promotion_STTI__c != null)
               retailerControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Retailer_promotion_STTI__c);
           if(listOfSelectedControlRecords[i].Consumer_promotion__c != null)
               consumerControl += Integer.ValueOf(listOfSelectedControlRecords[i].Consumer_promotion__c);   
           if(listOfSelectedControlRecords[i].Brand_investment__c != null)    
               brandControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Brand_investment__c);
           if(listOfSelectedControlRecords[i].Cooperative_advertising_KAM__c != null)   
               cooperativeControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Cooperative_advertising_KAM__c);
           if(listOfSelectedControlRecords[i].Trade_marketing_investments_TSM__c != null)   
               tradeControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Trade_marketing_investments_TSM__c);
           if(listOfSelectedControlRecords[i].Other__c != null)    
               otherControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Other__c); 
           if(listOfSelectedControlRecords[i].Invoiced_Sales__c != null)    
               invoicedControl +=Integer.ValueOf(listOfSelectedControlRecords[i].Invoiced_Sales__c);
           if(listOfSelectedControlRecords[i].X3N_Sales__c != null)    
               nSalesControl +=Integer.ValueOf(listOfSelectedControlRecords[i].X3N_Sales__c);
        }
        
        totalControl = upsellingControl + retailerControl + consumerControl + brandControl + cooperativeControl + tradeControl + otherControl; 
        
        indexControl=lastControl+1;
        upsellingControlTotal +=upsellingControl;
        retailerControlTotal +=retailerControl;
        consumerControlTotal +=consumerControl;
        brandControlTotal +=brandControl;
        cooperativeControlTotal +=cooperativeControl;
        tradeControlTotal +=tradeControl;
        otherControlTotal +=otherControl;
        verticalControlTotal +=totalControl;
        invoicedControlTotal +=invoicedControl;
        nSalesControlTotal +=nSalesControl;
    }
    
    
    public void sumCommit(){
        
        for(Integer i=indexComm; i<=lastComm;i++){
           if(listOfCommitmentRrecords[i].Activity_Amount__c != null)
               activity += Integer.ValueOf(listOfCommitmentRrecords[i].Activity_Amount__c );
           if(listOfCommitmentRrecords[i].Expected_Incremental_3N_Sales__c != null)
               expected +=Integer.ValueOf(listOfCommitmentRrecords[i].Expected_Incremental_3N_Sales__c );
           }
           indexComm=lastComm+1;
        
    }
    
    
    public void getSelectedPeriodRecords(){
        upsellingTotal = 0;
        nSalesTotal = 0;
        retailerTotal = 0;
        consumerTotal = 0;
        brandTotal = 0;
        cooperativeTotal = 0;
        tradeTotal = 0;
        otherTotal = 0;
        verticalTotal = 0;
        invoicedTotal = 0;
        finalListOfSelectedRecords = new List<Budget_AOP_View__c>();
        
        index = 0;
        
        
        if(SelectedQuarter != 'FY'){
            listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Invoiced_Sales__c,X3N_Sales__c,Total_Investments__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c =:SelectedQuarter AND Type__c='Budget AOP' order By BG_Code__c,Category_Name__c asc];
            if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
                for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                    finalListOfSelectedRecords.add(listOfSelectedRecords[i]);
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
                            total = 0;
                            nSales = 0;
                            sumUpselling();
                            finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
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
                        nSales = 0;
                        invoiced = 0;
                        total = 0;
                        sumUpselling();
                            
                        finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
            }
        } 
        else{
            listOfSelectedRecords = new List<Budget_AOP_View__c>();
            listOfAggregatedRecords = new List<AggregateResult>();
            listOfAggregatedRecords =[select BG_Code__c bgcode,BG_Name__c bgname,Category_Code__c catcode,Category_Name__c catname,Sum(Upselling_Investment__c) upsell,Sum(Retailer_promotion_STTI__c) retail,Sum(Consumer_promotion__c) consume,Sum(Brand_investment__c) bInvest,Sum(Cooperative_advertising_KAM__c) cooperate,Sum(Trade_marketing_investments_TSM__c) tradeInvest,Sum(Other__c) other,Sum(Invoiced_Sales__c) invSales,Sum(X3N_Sales__c) sales,Sum(Total_Investments__c) tot from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Type__c='Budget AOP' Group By BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c order By BG_Code__c ,Category_Name__c asc];    
            for(AggregateResult agrRecord : listOfAggregatedRecords){
                listOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c= (String)agrRecord.get('bgcode'),BG_Name__c=(String)agrRecord.get('bgname'),Category_Code__c=(String)agrRecord.get('catcode'),Category_Name__c=(String)agrRecord.get('catname'),Upselling_Investment__c=Integer.valueOf(agrRecord.get('upsell')),Retailer_promotion_STTI__c=Integer.valueOf(agrRecord.get('retail')),Consumer_promotion__c=Integer.valueOf(agrRecord.get('consume')),Brand_investment__c=Integer.valueOf(agrRecord.get('bInvest')),Cooperative_advertising_KAM__c=Integer.valueOf(agrRecord.get('cooperate')),Trade_marketing_investments_TSM__c=Integer.valueOf(agrRecord.get('tradeInvest')),Other__c=Integer.valueOf(agrRecord.get('other')),Total_Investments__c=Integer.valueOf(agrRecord.get('tot')),Invoiced_Sales__c=Integer.valueOf(agrRecord.get('invSales')),X3N_Sales__c=Integer.valueOf(agrRecord.get('sales'))));   
            }
            if(listOfSelectedRecords!= null && !listOfSelectedRecords.isEmpty()){
                for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                    finalListOfSelectedRecords.add(listOfSelectedRecords[i]);
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
                            finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
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
                        invoiced = 0;
                        nSales = 0;
                        total = 0;
                        sumUpselling();
                        finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
            }
        }   
    }
    
    
    public void getSelectedControlRecords(){
        upsellingControlTotal = 0;
        nSalesControlTotal = 0;
        retailerControlTotal = 0;
        consumerControlTotal = 0;
        brandControlTotal = 0;
        cooperativeControlTotal = 0;
        tradeControlTotal = 0;
        otherControlTotal = 0;
        verticalControlTotal = 0;
        invoicedControlTotal = 0;
        finalListOfSelectedControlRecords = new List<Budget_AOP_View__c>();
        
        indexControl = 0;
        
        
        if(SelectedQuarterControl != 'FY'){
            listOfSelectedControlRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Invoiced_Sales__c,X3N_Sales__c,Total_Investments__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c =:SelectedQuarterControl AND Type__c='Accruals' order By BG_Code__c ,Category_Name__c asc];
            if(listOfSelectedControlRecords != null && !listOfSelectedControlRecords.isEmpty()){
                for(Integer i = 0; i < listOfSelectedControlRecords.size(); i++){
                    finalListOfSelectedControlRecords.add(listOfSelectedControlRecords[i]);
                    if(i+1 < listOfSelectedControlRecords.size()){
                        if(listOfSelectedControlRecords[i].BG_Name__c != listOfSelectedControlRecords[i+1].BG_Name__c){
                            lastControl=i;
                            upsellingControl = 0;
                            retailerControl = 0;
                            consumerControl = 0;
                            brandControl = 0;
                            cooperativeControl = 0;
                            tradeControl = 0;
                            otherControl = 0;
                            invoicedControl = 0;
                            totalControl = 0;
                            nSalesControl = 0;
                            sumUpsellingControl();
                            finalListOfSelectedControlRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedControlRecords[i].BG_Code__c,BG_Name__c=listOfSelectedControlRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upsellingControl,Retailer_promotion_STTI__c=retailerControl,Consumer_promotion__c=consumerControl,Brand_investment__c=brandControl,Cooperative_advertising_KAM__c=cooperativeControl,Trade_marketing_investments_TSM__c=tradeControl,Other__c=otherControl,Total_Investments__c=totalControl,Invoiced_Sales__c=invoicedControl,X3N_Sales__c=nSalesControl));
                        }
                    }
                    else{
                        lastControl=i;
                        upsellingControl = 0;
                        retailerControl = 0;
                        consumerControl = 0;
                        brandControl = 0;
                        cooperativeControl = 0;
                        tradeControl = 0;
                        otherControl = 0;
                        nSalesControl = 0;
                        invoicedControl= 0;
                        totalControl = 0;
                        sumUpsellingControl();
                            
                        finalListOfSelectedControlRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedControlRecords[i].BG_Code__c,BG_Name__c=listOfSelectedControlRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upsellingControl,Retailer_promotion_STTI__c=retailerControl,Consumer_promotion__c=consumerControl,Brand_investment__c=brandControl,Cooperative_advertising_KAM__c=cooperativeControl,Trade_marketing_investments_TSM__c=tradeControl,Other__c=otherControl,Total_Investments__c=totalControl,Invoiced_Sales__c=invoicedControl,X3N_Sales__c=nSalesControl));
                    }
                }
            }
        } 
        else{
            listOfSelectedControlRecords = new List<Budget_AOP_View__c>();
            listOfAggregatedRecords = new List<AggregateResult>();
            listOfAggregatedRecords =[select BG_Code__c bgcode,BG_Name__c bgname,Category_Code__c catcode,Category_Name__c catname,Sum(Upselling_Investment__c) upsell,Sum(Retailer_promotion_STTI__c) retail,Sum(Consumer_promotion__c) consume,Sum(Brand_investment__c) bInvest,Sum(Cooperative_advertising_KAM__c) cooperate,Sum(Trade_marketing_investments_TSM__c) tradeInvest,Sum(Other__c) other,Sum(Invoiced_Sales__c) invSales,Sum(X3N_Sales__c) sales,Sum(Total_Investments__c) tot from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Type__c='Accruals' Group By BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c order By BG_Code__c ,Category_Name__c asc];    
            for(AggregateResult agrRecord : listOfAggregatedRecords){
                listOfSelectedControlRecords.add(new Budget_AOP_View__c(BG_Code__c= (String)agrRecord.get('bgcode'),BG_Name__c=(String)agrRecord.get('bgname'),Category_Code__c=(String)agrRecord.get('catcode'),Category_Name__c=(String)agrRecord.get('catname'),Upselling_Investment__c=Integer.valueOf(agrRecord.get('upsell')),Retailer_promotion_STTI__c=Integer.valueOf(agrRecord.get('retail')),Consumer_promotion__c=Integer.valueOf(agrRecord.get('consume')),Brand_investment__c=Integer.valueOf(agrRecord.get('bInvest')),Cooperative_advertising_KAM__c=Integer.valueOf(agrRecord.get('cooperate')),Trade_marketing_investments_TSM__c=Integer.valueOf(agrRecord.get('tradeInvest')),Other__c=Integer.valueOf(agrRecord.get('other')),Total_Investments__c=Integer.valueOf(agrRecord.get('tot')),Invoiced_Sales__c=Integer.valueOf(agrRecord.get('invSales')),X3N_Sales__c=Integer.valueOf(agrRecord.get('sales'))));   
            }
            if(listOfSelectedControlRecords!= null && !listOfSelectedControlRecords.isEmpty()){
                for(Integer i = 0; i < listOfSelectedControlRecords.size(); i++){
                    finalListOfSelectedControlRecords.add(listOfSelectedControlRecords[i]);
                    if(i+1 < listOfSelectedControlRecords.size()){
                        if(listOfSelectedControlRecords[i].BG_Name__c != listOfSelectedControlRecords[i+1].BG_Name__c){
                            lastControl=i;                           
                            upsellingControl = 0;
                            retailerControl = 0;
                            consumerControl = 0;
                            brandControl = 0;
                            cooperativeControl = 0;
                            tradeControl = 0;
                            otherControl= 0;
                            invoicedControl = 0;
                            nSalesControl = 0;
                            totalControl = 0;
                            sumUpsellingControl();
                            finalListOfSelectedControlRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedControlRecords[i].BG_Code__c,BG_Name__c=listOfSelectedControlRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upsellingControl,Retailer_promotion_STTI__c=retailerControl,Consumer_promotion__c=consumerControl,Brand_investment__c=brandControl,Cooperative_advertising_KAM__c=cooperativeControl,Trade_marketing_investments_TSM__c=tradeControl,Other__c=otherControl,Total_Investments__c=totalControl,Invoiced_Sales__c=invoicedControl,X3N_Sales__c=nSalesControl));
                        }
                    }
                    else{
                        lastControl=i;                           
                        upsellingControl = 0;
                        retailerControl = 0;
                        consumerControl = 0;
                        brandControl = 0;
                        cooperativeControl = 0;
                        tradeControl = 0;
                        otherControl = 0;
                        invoicedControl = 0;
                        nSalesControl = 0;
                        totalControl = 0;
                        sumUpselling();
                        finalListOfSelectedControlRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedControlRecords[i].BG_Code__c,BG_Name__c=listOfSelectedControlRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upsellingControl,Retailer_promotion_STTI__c=retailerControl,Consumer_promotion__c=consumerControl,Brand_investment__c=brandControl,Cooperative_advertising_KAM__c=cooperativeControl,Trade_marketing_investments_TSM__c=tradeControl,Other__c=otherControl,Total_Investments__c=totalControl,Invoiced_Sales__c=invoicedControl,X3N_Sales__c=nSalesControl));
                    }
                }
            }
        }   
    }
    
    public pagereference cancel() {
        editMode = false;
        return ApexPages.currentPage();
    }
    
    public pagereference cancelControl() {
        editModeControl = false;
        return ApexPages.currentPage();
    }
    
    public pagereference cancelPay() {
        editModePay = false;
        getPaymentRecords();
        return null;
    }
    
    public pagereference cancelPayReview() {
        editModePayR = false;
        getPaymentReviewRecords();
        return null;
    }
    
    public pagereference cancelCommit() {
        editModeCommit = false;
        newCommit = new List<Commitment__c>();
        getCommitmentRecords();
        return null;
    }
    
    public pagereference save(){
        upsertBudgetList = new List<Budget_AOP_View__c>();
        for(Budget_AOP_View__c budgetRec :finalListOfSelectedRecords){
            if(budgetRec.Category_Code__c != 'Total'){
                upsertBudgetSet.add(budgetRec);
            }
        }
        for(Budget_AOP_View__c finalRec : upsertBudgetSet){
            upsertBudgetList.add(finalRec);
        }
        try{
            if(upsertBudgetList!= null && !upsertBudgetList.isEmpty()){
                update upsertBudgetList;
            }
        }
        catch(Exception exp){
            ApexPages.addMessages(exp);
        }
        enableEditing();
        return ApexPages.currentPage();
    }
    
    public pagereference saveControl(){
        upsertBudgetControlList = new List<Budget_AOP_View__c>();
        for(Budget_AOP_View__c budgetRec :finalListOfSelectedControlRecords){
            if(budgetRec.Category_Code__c != 'Total'){
                upsertControlSet.add(budgetRec);
            }
        }
        for(Budget_AOP_View__c finalRec : upsertControlSet){
            upsertBudgetControlList.add(finalRec);
        }
        try{
            if(upsertBudgetControlList!= null && !upsertBudgetControlList.isEmpty()){
                update upsertBudgetControlList;
            }
        }
        catch(Exception exp){
            ApexPages.addMessages(exp);
        }
        enableEditingControl();
        return ApexPages.currentPage();
    }
    
    
    public pagereference savePay(){
        upsertPayList = new List<Commitment__c>();
        for(Commitment__c comRec : paymentList){
            if(comRec.Counterperformance_Status__c != '-None-' && comRec.Counterperformance_Status__c != 'None'){
                setRequired = true;
            }
            upsertPayList.add(comRec);
        }
        try{
            if(upsertPayList!= null && !upsertPayList.isEmpty()){
                update upsertPayList;
            }
        }
        catch(DMLException e){
        ApexPages.addMessages(e);
        return null;
        }
        EditPay();
        getPaymentReviewRecords();
        return null;
    }
    
    public pagereference savePayReview(){
        childError = false;
        noChildError = false;
        documentError = false;
        upsertPayReviewList = new List<Commitment__c>();
        upsertPayReviewFinalList = new List<Commitment__c>();
        upsertPayReviewFinalSet = new Set<Commitment__c>();
        Set<Id> setOfParentId = new Set<Id>();
        List<Commitment__c> listOfChildToBeChecked = new List<Commitment__c>();
            for(FinalCommitmentRecords finRec : finalListOfCommitments){
                upsertPayReviewList.add(finRec.parentCommitment);
                if(finRec.listChildCommitments != null && !finRec.listChildCommitments.isEmpty()){
                    for(Commitment__c comRec1 : finRec.listChildCommitments) {
                        concatenatedDoc = concatenatedDoc +';'+ comRec1.Document_Number__c;
                    }
                    
                    if(finRec.parentCommitment.ID == parentCheck){
                        for(Commitment__c comRec : finRec.listChildCommitments) {
                            if(comRec.Settlement_Method__c == 'Invoice' && comRec.Document_Number__c == null)
                                documentError = true;
                            if(!comRec.Request_Settlement__c && comRec.Parent_Commitment__c == parentCheck && finRec.parentCommitment.Close_commitment__c)
                                childError = true;
                        }
                    }
                    upsertPayReviewList.addAll(finRec.listChildCommitments);
                }
                else{
                    if(finRec.parentCommitment.Close_Commitment__c){
                        noChildError = true;
                    }
                }
             }
           
            if(documentError)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Documet number is mandatory when settlement method is \'Invoice\''));
            if(childError){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Commitment cannot be closed until all the children records are settled'));    
            }
            if(noChildError && !childError && !documentError){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Commitment without children cannot be closed'));    
            }
            upsertPayReviewFinalSet.addAll(upsertPayReviewList);
            upsertPayReviewFinalList.addAll(upsertPayReviewFinalSet);
            try{
                if(upsertPayReviewFinalList!= null && !upsertPayReviewFinalList.isEmpty() && !documentError && !childError && !noChildError){
                    update upsertPayReviewFinalList;
                }
            }
            catch(DMLException e){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Paid amount cannot be greater than the entitled amount'));
               return null;
            }
            if(!documentError) {
            EditPayReview(); 
            getPaymentReviewRecords();}
            else {
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Documet Paid amount cannot be greater than the entitled amount'));
        }
        return null;
    }
    
    public pagereference saveCommitment(){
    finalCommitmentSet = new Set<Commitment__c>();
    finalCommitmentList = new List<Commitment__c>();
    if(listOfCommitmentRrecords != null && !listOfCommitmentRrecords.isEmpty()){
        for(Commitment__c commRec : listOfCommitmentRrecords){
            finalCommitmentSet.add(commRec);
        }
    }
    if(newCommit != null && !newCommit.isEmpty()){
        for(Commitment__c commNewRec : newCommit){
            if(commNewRec.Acitivity_start_date__c != null || commNewRec.Activity_Amount__c != null || commNewRec.Activity_Completion_Date__c != null || commNewRec.Activity_Description__c != null || commNewRec.Activity_Short_Description__c != null || commNewRec.Budget_Agreement_nr__c != null || commNewRec.Category__c != null || commNewRec.Commitment_Type__c != null || commNewRec.Expected_Incremental_3N_Sales__c != null || commNewRec.Investment_Type__c != null || commNewRec.Measurement_Criteria__c != null || commNewRec.Product__c != null || commNewRec.Approve__c != false){
                finalCommitmentSet.add(commNewRec);
            }
        }
    }
    try{
        if(finalCommitmentSet!= null && !finalCommitmentSet.isEmpty()){
            finalCommitmentList.addAll(finalCommitmentSet);
            Database.upsert(finalCommitmentList);
            getPaymentRecords();
        }
    }
    catch(DMLException e){
        ApexPages.addMessages(e);
        return null;
    }
    getCommitmentRecords();
    editCommitment();
    
    return null;
    }
    
    public void getChangedAOPValue() {
        if(ApexPages.currentPage().getParameters().get('Id') != null) {
                recordId = ApexPages.currentPage().getParameters().get('Id'); 
            }
            listOfSelectedRecords = new List<Budget_AOP_View__c>();
            upsellingTotal = 0;
            retailerTotal = 0;
            consumerTotal = 0;
            brandTotal = 0;
            cooperativeTotal = 0;
            tradeTotal = 0;
            otherTotal = 0;
            verticalTotal = 0;
            invoicedTotal = 0;
            nSalesTotal = 0;
            getSelectedPeriodRecords();
    }
    public void getChangedViewValue() {
        if(ApexPages.currentPage().getParameters().get('Id') != null) {
                recordId = ApexPages.currentPage().getParameters().get('Id'); 
            }
            listOfSelectedRecords = new List<Budget_AOP_View__c>();
            upsellingTotal = 0;
            retailerTotal = 0;
            consumerTotal = 0;
            brandTotal = 0;
            cooperativeTotal = 0;
            tradeTotal = 0;
            otherTotal = 0;
            verticalTotal = 0;
            invoicedTotal = 0;
            nSalesTotal = 0;
            SelectedQuarter='FY';
            getSelectedPeriodViewRecords();
    }
    
    
    
    
    public void getSelectedPeriodViewRecords(){
        upsellingTotal = 0;
        retailerTotal = 0;
        consumerTotal = 0;
        brandTotal = 0;
        cooperativeTotal = 0;
        tradeTotal = 0;
        otherTotal = 0;
        verticalTotal = 0;
        invoicedTotal = 0;
        nSalesTotal = 0;
        listOfSelectedRecords = new List<Budget_AOP_View__c>();
        finalListOfSelectedRecords = new List<Budget_AOP_View__c>();
        
        index = 0;
        
        if(SelectedQuarterForView != 'FY'){
            listOfSelectedRecords = [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c =:SelectedQuarterForView AND Type__c='Budget Latest View' order By BG_Code__c ,Category_Name__c asc];
            if(listOfSelectedRecords != null && !listOfSelectedRecords.isEmpty()){
                for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                    finalListOfSelectedRecords.add(listOfSelectedRecords[i]);
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
                            finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
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
                            
                        finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
            }
        } 
        else{
            listOfSelectedRecords = new List<Budget_AOP_View__c>();
            listOfAggregatedRecords = new List<AggregateResult>();
            listOfAggregatedRecords = queryAggResult();
            for(AggregateResult agrRecord : listOfAggregatedRecords){
                listOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c= (String)agrRecord.get('bgcode'),BG_Name__c=(String)agrRecord.get('bgname'),Category_Code__c=(String)agrRecord.get('catcode'),Category_Name__c=(String)agrRecord.get('catname'),Upselling_Investment__c=Integer.valueOf(agrRecord.get('upsell')),Retailer_promotion_STTI__c=Integer.valueOf(agrRecord.get('retail')),Consumer_promotion__c=Integer.valueOf(agrRecord.get('consume')),Brand_investment__c=Integer.valueOf(agrRecord.get('bInvest')),Cooperative_advertising_KAM__c=Integer.valueOf(agrRecord.get('cooperate')),Trade_marketing_investments_TSM__c=Integer.valueOf(agrRecord.get('tradeInvest')),Other__c=Integer.valueOf(agrRecord.get('other')),Total_Investments__c=Integer.valueOf(agrRecord.get('tot')),Invoiced_Sales__c=Integer.valueOf(agrRecord.get('invSales')),X3N_Sales__c=Integer.valueOf(agrRecord.get('sales'))));   
            }
            if(listOfSelectedRecords!= null && !listOfSelectedRecords.isEmpty()){
               for(Integer i = 0; i < listOfSelectedRecords.size(); i++){
                    finalListOfSelectedRecords.add(listOfSelectedRecords[i]);
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
                            finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
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
                        finalListOfSelectedRecords.add(new Budget_AOP_View__c(BG_Code__c=listOfSelectedRecords[i].BG_Code__c,BG_Name__c=listOfSelectedRecords[i].BG_Name__c,Category_Code__c='Total',Category_Name__c='',Upselling_Investment__c=upselling,Retailer_promotion_STTI__c=retailer,Consumer_promotion__c=consumer,Brand_investment__c=brand,Cooperative_advertising_KAM__c=cooperative,Trade_marketing_investments_TSM__c=trade,Other__c=other,Total_Investments__c=total,Invoiced_Sales__c=invoiced,X3N_Sales__c=nSales));
                    }
                }
            }
        }   
    }
    
    public List<Budget_AOP_View__c> queryResult(){
        List<Budget_AOP_View__c> qResult= [select BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c,Upselling_Investment__c,Retailer_promotion_STTI__c,Consumer_promotion__c,Brand_investment__c,Cooperative_advertising_KAM__c,Trade_marketing_investments_TSM__c,Other__c,Total_Investments__c,Invoiced_Sales__c,X3N_Sales__c from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Quarter__c =:SelectedQuarterForView AND Type__c='Budget Latest View' order By BG_Code__c ,Category_Name__c asc];
        return null;
    }
    
    public List<AggregateResult> queryAggResult(){
        List<AggregateResult> aggResult = [select BG_Code__c bgcode,BG_Name__c bgname,Category_Code__c catcode,Category_Name__c catname,Sum(Upselling_Investment__c) upsell,Sum(Retailer_promotion_STTI__c) retail,Sum(Consumer_promotion__c) consume,Sum(Brand_investment__c) bInvest,Sum(Cooperative_advertising_KAM__c) cooperate,Sum(Trade_marketing_investments_TSM__c) tradeInvest,Sum(Other__c) other,Sum(Invoiced_Sales__c) invSales,Sum(X3N_Sales__c) sales,Sum(Total_Investments__c) tot from Budget_AOP_View__c where Commercial_Policy__c =: recordId AND Type__c='Budget Latest View' Group By BG_Code__c,BG_Name__c,Category_Code__c,Category_Name__c order By BG_Code__c,Category_Name__c asc];    
        return aggResult;
    }
    public void getCommitmentRecords(){
        listOfCommitmentRrecords = new List<Commitment__c>();
        finalListOfCommRecords = new List<Commitment__c>();
        indexComm = 0;
        totalExpected = 0;
        totalActivity = 0;
        listOfCommitmentRrecords = [select Id,Total__c,Acitivity_start_date__c,Activity_Amount__c,Activity_Completion_Date__c,Activity_Description__c,Activity_Short_Description__c,Budget_Agreement_nr__c,Budget_Quarter__c,Category__c,Commitment_reference__c,Commitment_reference_parent__c,Commitment_Status__c,Commitment_Type__c,Completion_month__c,Expected_Incremental_3N_Sales__c,Investment_Type__c,Measurement_Criteria__c,Product__c,Approve__c from Commitment__c where Commercial_Policy__c =:recordId AND (Parent_Commitment__c = null OR Parent_Commitment__c = '') order By Commitment_Status__c,LastModifiedDate asc];
        if(listOfCommitmentRrecords != null && !listOfCommitmentRrecords.isEmpty()){
            for(Integer i = 0; i < listOfCommitmentRrecords.size(); i++){
                    finalListOfCommRecords.add(listOfCommitmentRrecords[i]);
                    if(i+1 < listOfCommitmentRrecords.size()){
                        if(listOfCommitmentRrecords[i].Commitment_Status__c != listOfCommitmentRrecords[i+1].Commitment_Status__c ){
                            lastComm=i;                           
                            expected = 0;
                            activity = 0;
                            sumCommit();
                            finalListOfCommRecords.add(new Commitment__c(Commitment_Status__c=(listOfCommitmentRrecords[i].Commitment_Status__c=='Approval requested'?'Request':listOfCommitmentRrecords[i].Commitment_Status__c) + ' Total' ,Commitment_Type__c = '',Total__c = 'Total',Activity_Amount__c=activity,Expected_Incremental_3N_Sales__c = expected));
                        }
                    }
                    else{
                        lastComm=i;                           
                        expected = 0;
                        activity = 0;
                        sumCommit();
                        finalListOfCommRecords.add(new Commitment__c(Commitment_Status__c=listOfCommitmentRrecords[i].Commitment_Status__c + ' Total',Commitment_Type__c = '',Total__c = 'Total',Activity_Amount__c=activity,Expected_Incremental_3N_Sales__c = expected));
                    }
                }
            
            for(Commitment__c comRec : listOfCommitmentRrecords){
                if(comRec.Expected_Incremental_3N_Sales__c != null){
                    totalExpected = totalExpected + Integer.ValueOf(comRec.Expected_Incremental_3N_Sales__c);
                }
                if(comRec.Activity_Amount__c != null){
                    totalActivity = totalActivity + Integer.ValueOf(comRec.Activity_Amount__c);
                }
            }
        }
    }
    
    
    public void getPaymentRecords(){
        paymentList = new List<Commitment__c>();
        totalActivityP = 0;
        totalEntitled = 0;
        totalExpectedP = 0;
        totalRealized = 0;
        paymentList = [select Parent_Commitment__c,Id,Commitment_reference__c,Acitivity_start_date__c,Activity_Amount__c,Activity_Completion_Date__c,Activity_Description__c,Activity_Short_Description__c,Category__c,Commitment_reference_parent__c,Commitment_Status__c,Commitment_Type__c,Completion_month__c,Status_remark__c,Realized_Incremental_3N_Sales__c,Expected_Incremental_3N_Sales__c,Entitled_Amount__c,Counterperformance_Status__c,settlement_frequency__c,Settlement_method__c,Investment_Type__c,Measurement_Criteria__c,Product__c from Commitment__c where Commercial_Policy__c =:recordId AND Commitment_Status__c = 'Approved' AND (Parent_Commitment__c = null OR Parent_Commitment__c = '') AND (Counterperformance_Status__c = 'None' OR Counterperformance_Status__c = '--None--') Order By LastModifiedDate asc];
        if(paymentList != null && !paymentList.isEmpty()){
            for(Commitment__c comRec : paymentList){
                if(comRec.Expected_Incremental_3N_Sales__c != null){
                    totalExpectedP = totalExpectedP + Integer.ValueOf(comRec.Expected_Incremental_3N_Sales__c);
                }
                if(comRec.Activity_Amount__c != null){
                    totalActivityP = totalActivityP + Integer.ValueOf(comRec.Activity_Amount__c);
                }
                if(comRec.Realized_Incremental_3N_Sales__c != null){
                    totalRealized = totalRealized + Integer.ValueOf(comRec.Realized_Incremental_3N_Sales__c);
                }
                if(comRec.Entitled_Amount__c != null){
                    totalEntitled = totalEntitled + Integer.ValueOf(comRec.Entitled_Amount__c);
                }
            }
        }
    }
    
    public void getPaymentReviewRecords(){
        paymentReviewList = new List<Commitment__c>();
        finalListOfCommitments = new List<FinalCommitmentRecords>();
        mapOfParentIdAndChild = new Map<Id,List<Commitment__c>>();
        totalActivityR = 0;
        totalEntitledR = 0;
        totalPaidR = 0;
        totalActivityRClosed = 0;
        totalEntitledRClosed = 0;
        totalPaidRClosed = 0;
        paymentReviewList = [select Parent_Commitment__c,Id,requested__c,Acitivity_start_date__c,Request_Settlement__c,Commitment_reference_parent__c,Document_Number__c,Value_Easy_Invoice_ref__c,Activity_Amount__c,Activity_Completion_Date__c,Activity_Description__c,Activity_Short_Description__c,Category__c,Commitment_Status__c,Commitment_Type__c,Completion_month__c,Status_remark__c,Realized_Incremental_3N_Sales__c,Expected_Incremental_3N_Sales__c,Entitled_Amount__c,Counterperformance_Status__c,settlement_frequency__c,Settlement_method__c,Investment_Type__c,Measurement_Criteria__c,Product__c,Paid_Amount__c,Close_Commitment__c from Commitment__c where Commercial_Policy__c =:recordId AND Commitment_Status__c = 'Approved' AND (Counterperformance_Status__c = 'Delivered' OR Counterperformance_Status__c = 'Partially Delivered') AND (Parent_Commitment__c = null OR Parent_Commitment__c = '') ];
        if(paymentReviewList != null && !paymentReviewList .isEmpty()){
            for(Commitment__c comRec : paymentReviewList ){
                if(comRec.Activity_Amount__c != null && !comRec.Close_Commitment__c){
                    totalActivityR = totalActivityR + Integer.ValueOf(comRec.Activity_Amount__c);
                }
                if(comRec.Entitled_Amount__c != null && !comRec.Close_Commitment__c){
                    totalEntitledR = totalEntitledR + Integer.ValueOf(comRec.Entitled_Amount__c);
                }
                if(comRec.Paid_Amount__c != null && !comRec.Close_Commitment__c){
                    totalPaidR = totalPaidR + Integer.ValueOf(comRec.Paid_Amount__c);
                }
                if(comRec.Activity_Amount__c != null && comRec.Close_Commitment__c){
                    totalActivityRClosed = totalActivityRClosed+ Integer.ValueOf(comRec.Activity_Amount__c);
                }
                if(comRec.Entitled_Amount__c != null && comRec.Close_Commitment__c){
                    totalEntitledRClosed = totalEntitledRClosed + Integer.ValueOf(comRec.Entitled_Amount__c);
                }
                if(comRec.Paid_Amount__c!= null && comRec.Close_Commitment__c){
                    totalPaidRClosed = totalPaidRClosed + Integer.ValueOf(comRec.Paid_Amount__c);
                }
                parentCommitmentsIdSet.add(comRec.id);
            }
        childCommitmentList=[Select Id,requested__c,Commitment_reference_Parent__c,Acitivity_start_date__c,Request_Settlement__c,Document_Number__c,Value_Easy_Invoice_ref__c,Activity_Amount__c,Activity_Completion_Date__c,Activity_Description__c,Activity_Short_Description__c,Category__c,Commitment_Status__c,Commitment_Type__c,Completion_month__c,Status_remark__c,Realized_Incremental_3N_Sales__c,Expected_Incremental_3N_Sales__c,Entitled_Amount__c,Counterperformance_Status__c,settlement_frequency__c,Settlement_method__c,Investment_Type__c,Measurement_Criteria__c,Product__c,Paid_Amount__c,Close_Commitment__c,Parent_Commitment__c from Commitment__c where Commercial_Policy__c =:recordId AND Commitment_Status__c = 'Approved' AND (Counterperformance_Status__c = 'Delivered' OR Counterperformance_Status__c = 'Partially Delivered') AND Close_Commitment__c = FALSE AND Parent_Commitment__c IN :parentCommitmentsIdSet];
        }
        for(Commitment__c comitParent : paymentReviewList){
            mapOfIdAndParent.put(comitParent.Id,comitParent);
        }
        for(Commitment__c comitChild : childCommitmentList){
            if(mapOfParentIdAndChild.get(comitChild.Parent_Commitment__c) != null){
                mapOfParentIdAndChild.get(comitChild.Parent_Commitment__c).add(comitChild);
            }
            else{
                mapOfParentIdAndChild.put(comitChild.Parent_Commitment__c,new List<Commitment__c>());
                mapOfParentIdAndChild.get(comitChild.Parent_Commitment__c).add(comitChild);
            }
        }
        for(Id keyValue: mapOfParentIdAndChild.keySet()){
            if(mapOfIdAndParent.get(keyValue) != null && mapOfParentIdAndChild.get(keyValue) != null){
                finalListOfCommitments.add(new FinalCommitmentRecords(mapOfIdAndParent.get(keyValue),mapOfParentIdAndChild.get(keyValue)));
            }
        }
        for(Id keyVal: mapOfIdAndParent.keySet()){
            if(!mapOfParentIdAndChild.containsKey(keyVal)){
                    finalListOfCommitments.add(new FinalCommitmentRecords(mapOfIdAndParent.get(keyVal)));
            }
        }
    }
    
    
    public PageReference showAllChildren(){
        showChild = true;
        Boolean isAnyCollapsed = false;
        isExpandAllBtn = false;
        for(FinalCommitmentRecords loopVar : finalListOfCommitments) {
            if(loopVar.ParentCommitment.ID == parentCheck) {
                loopVar.toggleExpand();
            }
            else{
                //loopvar.toggleExpand();
                loopVar.expanded= false;
            }
        
            if(!loopVar.expanded){
                isAnyCollapsed = true;
            }    
            
        }
        if(isAnyCollapsed){
            isExpandAllBtn = true;
        }
        return null;
    }
    
    public PageReference expandAllChildren(){
        isExpandAll = true;
        isExpandAllBtn = false;
        showChild = true;
        hideAll = false;
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@finalList'+finalListOfCommitments);
        for(FinalCommitmentRecords loopVar : finalListOfCommitments) {
            loopVar.expanded = true;
        }
        return null;
    }
    
    public PageReference hideAllChildren(){
        showChild = true;
        return null;
    }
    
    public PageReference deleteChildren(){
        Commitment__c toBeDeletedRecord = new Commitment__c();
        toBeDeletedRecord =[select id,commercial_policy__c,Parent_Commitment__c from Commitment__c where Id = : deleteChild];
        if(tobeDeletedRecord != null){
            delete toBeDeletedRecord;
        }
        deleteSelectedPaymet(deleteChild);
        //getPaymentReviewRecords();
        
        //showAllChildren();
        return null;
    }
    public void  deleteSelectedPaymet(Id deleteChild){
        for(FinalCommitmentRecords commitmentRecord : finalListOfCommitments){
            if(commitmentRecord.parentCommitment.id == parentCheck){
                commitmentRecord.allDocs = '';
                commitmentRecord.allDocsCust = '';
                for(Integer index = 0; index < commitmentRecord.listChildCommitments.size() ; index++){
                    if(commitmentRecord.listChildCommitments[index].id == deleteChild){
                        commitmentRecord.listChildCommitments.remove(index);
                    }else{
                        if(commitmentRecord.allDocs != null){
                            commitmentRecord.allDocs = commitmentRecord.allDocs +','+commitmentRecord.listChildCommitments[index].Value_Easy_Invoice_ref__c;
                        }
                        else{
                            commitmentRecord.allDocs  = commitmentRecord.listChildCommitments[index].Value_Easy_Invoice_ref__c;
                        }
                        if(commitmentRecord.allDocsCust != null){
                            commitmentRecord.allDocsCust = commitmentRecord.allDocsCust +','+commitmentRecord.listChildCommitments[index].Document_Number__c;
                        }
                        else{
                            commitmentRecord.allDocsCust = commitmentRecord.listChildCommitments[index].Document_Number__c;
                        }
                    }
                }
                break;
            }
        }
    }
    
    public pageReference addnewChildren(){
        Commitment__c oldCommitment = new Commitment__c();
        Commitment__c newChild = new Commitment__c();
        oldCommitment = [Select Id,Commercial_policy__c,currencyISOcode,requested__c,Acitivity_start_date__c,Commitment_reference_Parent__c,Request_Settlement__c,Document_Number__c,Value_Easy_Invoice_ref__c,Activity_Amount__c,Activity_Completion_Date__c,Activity_Description__c,Activity_Short_Description__c,Category__c,Commitment_Status__c,Commitment_Type__c,Completion_month__c,Status_remark__c,Realized_Incremental_3N_Sales__c,Expected_Incremental_3N_Sales__c,Entitled_Amount__c,Counterperformance_Status__c,settlement_frequency__c,Settlement_method__c,Investment_Type__c,Measurement_Criteria__c,Product__c,Paid_Amount__c,Close_Commitment__c,Parent_Commitment__c from Commitment__c where Id = :parentcheck];
        newChild.Acitivity_start_date__c = oldCommitment.Acitivity_start_date__c;
        newChild.Activity_Amount__c = oldCommitment.Activity_Amount__c;
        newChild.Activity_Completion_Date__c = oldCommitment.Activity_Completion_Date__c;
        newChild.Activity_Description__c = oldCommitment.Activity_Description__c;
        newChild.Activity_Short_Description__c = oldCommitment.Activity_Short_Description__c;
        newChild.Category__c = oldCommitment.Category__c;
        newChild.Commitment_Status__c = oldCommitment.Commitment_Status__c;
        newChild.Commitment_Type__c = oldCommitment.Commitment_Type__c;
        newChild.Status_remark__c = oldCommitment.Status_remark__c;
        newChild.Realized_Incremental_3N_Sales__c = oldCommitment.Realized_Incremental_3N_Sales__c;
        newChild.Expected_Incremental_3N_Sales__c = oldCommitment.Expected_Incremental_3N_Sales__c;
        newChild.Entitled_Amount__c = oldCommitment.Entitled_Amount__c;
        newChild.Counterperformance_Status__c = oldCommitment.Counterperformance_Status__c;
        newChild.settlement_frequency__c = oldCommitment.settlement_frequency__c;
        newChild.Settlement_method__c = oldCommitment.Settlement_method__c;
        newChild.Investment_Type__c = oldCommitment.Investment_Type__c;
        newChild.Measurement_Criteria__c = oldCommitment.Measurement_Criteria__c;
        newChild.Product__c = oldCommitment.Product__c;
        newChild.Parent_Commitment__c = parentCheck;
        //newChild.Activity_Amount__c = 100;
        newChild.CurrencyISOCode = oldCommitment.currencyISOcode;
        newChild.Commercial_policy__c = oldCommitment.Commercial_policy__c;
        newChild.Paid_Amount__c = 0;
        insert newChild;
        //system.debug('The list is'+finalListOfCommitments.listChildCommitments);
        addNewPayment(newchild);
        //getPaymentReviewRecords();
        parentCheck = newChild.Parent_Commitment__c;
        //showAllChildren();
        return null;
    }
    
    public void addNewPayment(Commitment__c newchild){
        for(FinalCommitmentRecords commitmentRecord : finalListOfCommitments){
            if(commitmentRecord.parentCommitment.id == newChild.Parent_Commitment__c){
                commitmentRecord.expanded = true;
                if(commitmentRecord.listChildCommitments == null){
                    commitmentRecord.listChildCommitments = new List<Commitment__c>();
                }
                commitmentRecord.listChildCommitments.add(newchild);
                if(commitmentRecord.allDocs != null){
                    commitmentRecord.allDocs = commitmentRecord.allDocs +','+newchild.Value_Easy_Invoice_ref__c;
                }
                else{
                    commitmentRecord.allDocs  = newchild.Value_Easy_Invoice_ref__c;
                }
                if(commitmentRecord.allDocsCust != null){
                    commitmentRecord.allDocsCust = commitmentRecord.allDocsCust +','+newchild.Document_Number__c;
                }
                else{
                    commitmentRecord.allDocsCust = newchild.Document_Number__c;
                }                
            }
        }
    }
    
    public class FinalCommitmentRecords{
        public Commitment__c parentCommitment{get;set;}
        public List<Commitment__c> listChildCommitments{get;set;}
        public boolean expanded{get;set;}
        public String allDocs{get;set;}
        public String allDocsCust{get;set;}
        
        public FinalCommitmentRecords(){
        expanded=false;
        allDocs = '';
        allDocsCust = '';
        //listChildCommitments = new List<Commitment__c>();
            
        }
        
        public FinalCommitmentRecords(Commitment__c parentRec)
        {   
            expanded=false;
            parentCommitment = new Commitment__c();
            //listChildCommitments = new List<Commitment__c>();
            parentCommitment = parentRec.clone(true,true,true,true);
        }
        public FinalCommitmentRecords(Commitment__c parentRec,List<Commitment__c> listChild)
        {   
            expanded=false;
            parentCommitment = new Commitment__c();
            listChildCommitments = new List<Commitment__c>();
            parentCommitment = parentRec.clone(true,true,true,true);
            listChildCommitments.addAll(listChild);
        
            for(Commitment__c comRec : listChildCommitments){
                if(allDocs != null){
                    allDocs = allDocs +','+comRec.Value_Easy_Invoice_ref__c;
                }
                else{
                    allDocs  = comRec.Value_Easy_Invoice_ref__c;
                }
                if(allDocsCust != null){
                    allDocsCust = allDocsCust +','+comRec.Document_Number__c;
                }
                else{
                    allDocsCust = comRec.Document_Number__c;
                }
            }
        }
        public void toggleExpand() {
            if(expanded)
                expanded = false;
            else
                expanded = true;
        }
    }
}