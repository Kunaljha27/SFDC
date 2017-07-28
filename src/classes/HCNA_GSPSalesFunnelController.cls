/*** 
*@ClassName : HCNA_GSPSalesFunnelController 
*@Description : Controller class for HCNA_GSPSalesFunnel page.
*@Author : Noor Ali Khan
*@Last Modified : 25/06/2014
***/
global with sharing class HCNA_GSPSalesFunnelController {
        
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of product value of product family data from opportunity where business group is "IS" of the selected SAP account's associated account.    
    * @param       : ID accountId
    * @return      : List<DataWrapper>
    **/        
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadImagingSystemsData(ID AccountId) {
        String businessGroup = 'IS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(AccountId, businessGroup);        
        return resultList;
    }                 
             
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of product value of product family data from opportunity where business group is "US" of the selected SAP account's associated account.    
    * @param       : ID accountId
    * @return      : List<DataWrapper>
    **/
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadUltrasoundData(ID AccountId) {
        String businessGroup = 'US';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(AccountId, businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of product value of product family data from opportunity where business group is "PCMS" of the selected SAP account's associated account.    
    * @param       : ID accountId
    * @return      : List<DataWrapper>
    **/
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadPCMSData(ID AccountId) {
        String businessGroup = 'PCMS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(AccountId, businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of product value of product family data from opportunity where business group is "HISS" of the selected SAP account's associated account.    
    * @param       : ID accountId
    * @return      : List<DataWrapper>
    **/
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadHISSData(ID AccountId) {
        String businessGroup = 'HISS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(AccountId, businessGroup);        
        return resultList;
    }
    
    /**    
    * @Description : This RemoteAction method is for retrieving the sum of product value of product family data from opportunity where business group is "HISS" of the selected SAP account's associated account.    
    * @param       : ID accountId
    * @return      : List<DataWrapper>
    **/
    @RemoteAction  
    global static List<HCNA_GSPChartDataWrapper> loadPOSData(ID AccountId) {
        String businessGroup = 'POS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(AccountId, businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This method is to draw chart.    
    * @param       : ID AccountId, String businessGroup
    * @return      : List<DataWrapper>
    **/
    public List<HCNA_GSPChartDataWrapper> drawChart(ID AccountId, String businessGroup) {
        List<HCNA_GSPChartDataWrapper> result = new List<HCNA_GSPChartDataWrapper>();        
        HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService();
        List<Account> accountList = serviceClassObject.getAccountList(accountId);
        List<ID> accountIdList = new List<ID>();
        accountIdList.add(accountId);                                     
        if(accountList != null && !accountList.isEmpty()){        
            for(Account accountRecord : accountList ){
                accountIdList.add(accountRecord.Id);
            }
        }    
        List<Opportunity> opportunityList = serviceClassObject.getOpportunityList(accountIdList,businessGroup); 
        List<OpportunityLineItem> opportunityLineItemList = serviceClassObject.getOpportunityLineItemList(opportunityList);
        Map<String,Decimal> productFamilyMap = new Map<String,Decimal>();
        Decimal tempValue;
        
        if(opportunityLineItemList != null && !opportunityLineItemList.isEmpty()){
            for(OpportunityLineItem opportunityLineItemRecord: opportunityLineItemList){
                tempValue=0.0;
                if(productFamilyMap.get(opportunityLineItemRecord.Product_Family__c)== null){
                    tempValue = opportunityLineItemRecord.TotalPrice;
                    productFamilyMap.put(opportunityLineItemRecord.Product_Family__c,tempValue);
                } else {
                    tempValue = productFamilyMap.get(opportunityLineItemRecord.Product_Family__c);    
                    tempValue += opportunityLineItemRecord.TotalPrice;
                    productFamilyMap.put(opportunityLineItemRecord.Product_Family__c,tempValue);
                }                   
            }
        } 
        if(productFamilyMap != null && !productFamilyMap.isEmpty()){               
            for(String productFamilyRecord: productFamilyMap.keySet()){
                result.add(new HCNA_GSPChartDataWrapper(productFamilyRecord,Math.round(productFamilyMap.get(productFamilyRecord))));               
            }
        }
        return result;
    }
    
    /**    
    * @Description : This method is for retrieving the sum of product value of product family data from opportunity where business group is "IS" of the selected SAP account's associated account.    
    * @param       : None
    * @return      : List<DataWrapper>
    **/        
    public List<HCNA_GSPChartDataWrapper> getImagingSystemsTableData() {
        String businessGroup = 'IS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(ApexPages.currentPage().getParameters().get('AccountId'), businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This method is for retrieving the sum of product value of product family data from opportunity where business group is "US" of the selected SAP account's associated account.    
    * @param       : None
    * @return      : List<DataWrapper>
    **/        
    public List<HCNA_GSPChartDataWrapper> getUltrasoundTableData() {
        String businessGroup = 'US';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(ApexPages.currentPage().getParameters().get('AccountId'), businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This method is for retrieving the sum of product value of product family data from opportunity where business group is "PCMS" of the selected SAP account's associated account.    
    * @param       : None
    * @return      : List<DataWrapper>
    **/        
    public List<HCNA_GSPChartDataWrapper> getPCMSTableData() {
        String businessGroup = 'PCMS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(ApexPages.currentPage().getParameters().get('AccountId'), businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This method is for retrieving the sum of product value of product family data from opportunity where business group is "HISS" of the selected SAP account's associated account.    
    * @param       : None
    * @return      : List<DataWrapper>
    **/        
    public List<HCNA_GSPChartDataWrapper> getHISSTableData() {
        String businessGroup = 'HISS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(ApexPages.currentPage().getParameters().get('AccountId'), businessGroup);        
        return resultList;
    } 
    
    /**    
    * @Description : This method is for retrieving the sum of product value of product family data from opportunity where business group is "POS" of the selected SAP account's associated account.    
    * @param       : None
    * @return      : List<DataWrapper>
    **/        
    public List<HCNA_GSPChartDataWrapper> getPOSTableData() {
        String businessGroup = 'POS';
        HCNA_GSPSalesFunnelController controllerObject = new HCNA_GSPSalesFunnelController();
        List<HCNA_GSPChartDataWrapper> resultList = controllerObject.drawChart(ApexPages.currentPage().getParameters().get('AccountId'), businessGroup);        
        return resultList;
    } 
                  
}