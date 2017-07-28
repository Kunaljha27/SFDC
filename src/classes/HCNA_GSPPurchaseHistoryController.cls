global with sharing class HCNA_GSPPurchaseHistoryController {
    public Integer totalRecords{get;set;}       
    /**    
    * @Description : This loadAreaChartData method is for displaying the data of Philips_Order_Value__c object on the area chart.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/          
    @RemoteAction  
    global static List<Philips_Order_Value__c> loadAreaChartData(ID sapId) {            
        HCNA_GSPAdventistHealthSystemService serviceClass = new HCNA_GSPAdventistHealthSystemService();
        List<Philips_Order_Value__c> orderValueList = serviceClass.getAreaChart(sapId );  
        String currentYear, startYear; 
        Map<integer,Philips_Order_Value__c> orderValueMap = new Map<integer,Philips_Order_Value__c>();
        List<Philips_Order_Value__c> resultList = new List<Philips_Order_Value__c>();
        if(orderValueList != null && !orderValueList.isEmpty()){
            for(Philips_Order_Value__c orderRecord : orderValueList){ 
                orderRecord = serviceClass.doNullCheckForPhilipsOrderValueRecord(orderRecord);
                orderValueMap.put(integer.valueOf(orderRecord.Year__c),orderRecord);
            }
            Philips_Order_Value__c emptyRecord ;
            startYear = orderValueList[0].Year__c;
            currentYear = orderValueList[orderValueList.size() - 1].Year__c;
            for(Integer countYear = integer.valueOf(startYear); countYear <= integer.valueOf(currentYear); countYear++){
                if(orderValueMap.containsKey(countYear)){
                    resultList.add(orderValueMap.get(countYear));
                }
                else{
                    emptyRecord = new Philips_Order_Value__c(HISS__c = 0.00, I_S__c = 0.00,PCMS__c = 0.00, POS__c = 0.00,U_S__c = 0.00,name = 'emptyRecord',Strategic_account_plan__c = sapId);
                    emptyRecord.Year__c = string.valueOf(countYear);
                    resultList.add(emptyRecord);
                }
            }
            for(Philips_Order_Value__c record : resultList){                 
                record.I_S__c += record.HISS__c;
                record.PCMS__c += record.I_S__c;
                record.POS__c += record.PCMS__c;
                record.U_S__c += record.POS__c; 
                record.Total_M__c = record.U_S__c;      
            }
            return resultList;
        }
        return null;
    }
    
    /**    
    * @Description : This method is for retrieving the Area Chart Total Table in the VF page 
    * @param       : -
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getTotalTable(){
        Id sapid = ApexPages.currentPage().getParameters().get('SAPID');
        List<Philips_Order_Value__c> resultList = HCNA_GSPPurchaseHistoryController.loadAreaChartData(sapid);
        
        if(resultList != null && !resultList.isEmpty()){
            totalRecords = resultList.size() + 1;
            return resultList;
        }
        return null;
    }
    
    /**    
    * @Description : This method is for retrieving the Area Chart Total Table's Total column value in the VF page 
    * @param       : -
    * @return      : Decimal 
    **/
    public Decimal getTotalForTable(){
        Decimal totalForTable = 0.00;
        List<Philips_Order_Value__c> resultList = getTotalTable();
        if(resultList != null && !resultList.isEmpty()){
            for(Philips_Order_Value__c record : resultList){
                totalForTable += record.Total_M__c;
            }
            return totalForTable;
        }
        return null;
    }
    
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of opportunity data for the  selected SAP account's associated account.    
    * @param       : ID sapId
    * @return      : List<HCNA_GSPChartDataWrapper>
    **/ 
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadPieChartData(ID sapId) {         
        HCNA_GSPAdventistHealthSystemService serviceClass = new HCNA_GSPAdventistHealthSystemService();
        List<HCNA_GSPChartDataWrapper> resultList = new List<HCNA_GSPChartDataWrapper>();
        Decimal isTotal = 0.0;
        Decimal pcmsTotal = 0.0;
        Decimal hissCTotal = 0.0;
        Decimal usTotal = 0.0;
        Decimal posTotal = 0.0;
        List<Philips_Order_Value__c> philipsOrderValueList = serviceClass.getPieChart(sapId); 
        if(philipsOrderValueList != null && !philipsOrderValueList.isEmpty()){
            for(Philips_Order_Value__c record : philipsOrderValueList){
                record = serviceClass.doNullCheckForPhilipsOrderValueRecord(record);
                    isTotal += record.I_S__c;
                    hissCTotal += record.HISS__c;
                    pcmsTotal += record.PCMS__c;
                    posTotal += record.POS__c;
                    usTotal += record.U_S__c; 
            }
            if(isTotal == 0.00 && pcmsTotal == 0.00 && hissCTotal == 0.00 && usTotal == 0.00 && posTotal == 0.00){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Info,'No data for Business Groups in Philips Order Value');
                ApexPages.addMessage(myMsg);                                
            }
            resultList.add(new HCNA_GSPChartDataWrapper('IS', isTotal)); 
            resultList.add(new HCNA_GSPChartDataWrapper('PCMS', pcmsTotal)); 
            resultList.add(new HCNA_GSPChartDataWrapper('HISS', hissCTotal)); 
            resultList.add(new HCNA_GSPChartDataWrapper('US', usTotal)); 
            resultList.add(new HCNA_GSPChartDataWrapper('POS', posTotal));  
        }
        return resultList;
    } 
    
    /**    
    * @Description : This method is for retrieving the Pie Chart Table in the VF page 
    * @param       : -
    * @return      : List<HCNA_GSPChartDataWrapper>
    **/ 
    public List<HCNA_GSPChartDataWrapper> getPieChartTable(){
        Id sapid = ApexPages.currentPage().getParameters().get('SAPID');
        List<HCNA_GSPChartDataWrapper> resultList = HCNA_GSPPurchaseHistoryController.loadPieChartData(sapid);
        return resultList;
    }      
}