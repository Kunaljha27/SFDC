/*** 
*@ClassName : HCNA_GSPAdventistHealthSystemService 
*@Description : Service class for HCNA_GSPAdventistHealthSystem page.
*@Author : Alok Bhakat
*@Last Modified : 25/06/2014
***/
global with sharing class HCNA_GSPAdventistHealthSystemService {
    HCNA_GSPAdventistHealthSystemDAO daoClassObject = new HCNA_GSPAdventistHealthSystemDAO();
    
    /**    
    * @Description : This method is for retrieving the philips order value list for the selected SAP.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getOrderValueList(Id sapId){
        try{
            if(sapId != null){
                List<Philips_Order_Value__c> orderValueList = daoClassObject.getOrderValueList(sapId);
                return orderValueList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the associated accounts.    
    * @param       : ID accountId
    * @return      : List<Account>
    **/
    public List<Account> getAccountList(Id accountId){     
        try{   
            if(accountId != null){
                List<Account> accountList = daoClassObject.getAccountList(accountId);
                return accountList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities for associated accounts.    
    * @param       : List<ID> accountIdList
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getOpportunityList(List<ID> accountIdList){        
        try{
            if(accountIdList != null && !accountIdList.isEmpty()){
                List<Opportunity> opportunityList = daoClassObject.getOpportunityList(accountIdList);
                return opportunityList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities for associated accounts.    
    * @param       : List<ID> accountIdList, String businessGroupValue
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getOpportunityList(List<ID> accountIdList,String businessGroupValue){        
        try{
            if(accountIdList != null && !accountIdList.isEmpty()){
                List<Opportunity> opportunityList = daoClassObject.getOpportunityList(accountIdList,businessGroupValue);
                return opportunityList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities line item for associated opportunity.    
    * @param       : List<opportunity> opportunityList
    * @return      : List<OpportunityLineItem>
    **/
    public List<OpportunityLineItem> getOpportunityLineItemList(List<opportunity> opportunityList){        
        try{
            if(opportunityList != null && !opportunityList.isEmpty()){
                List<OpportunityLineItem> opportunityLineItemList = daoClassObject.getOpportunityLineItemList(opportunityList);
                return opportunityLineItemList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the financial details for associated SAP.    
    * @param       : Id sapId
    * @return      : List<Customer_Financial_Detail__c>
    **/
    public List<Customer_Financial_Detail__c> getFinancialDetails(Id sapId){        
        try{
            if(sapId != null){
                List<Customer_Financial_Detail__c> financialDetailsList = daoClassObject.getFinancialDetails(sapId);
                return financialDetailsList;
            }else{
                return null;
            }
        }catch(Exception ex){
            return null;
        }
    }
    
        /**    
    * @Description : This method is for retrieving the Philips Order value for Pie chart on purchase history.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getPieChart(ID sapId){        
        if(sapId != null){
            List<Philips_Order_Value__c> philipsOrderValueList  = daoClassObject.getPieChart(sapId);
            return philipsOrderValueList ;
        }else{
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the Philips Order value for Area chart on purchase history.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getAreaChart(ID sapId){        
        if(sapId != null){
            List<Philips_Order_Value__c> orderValueList = daoClassObject.getAreaChart(sapId);
            return orderValueList;
        }else{
            return null;
        }
    }
    
    /**    
    * @Description : This method is for checking null values in financial detail record and assigning them to zero
    * @param       : Customer_Financial_Detail__c
    * @return      : Customer_Financial_Detail__c
    **/
    public Customer_Financial_Detail__c doNullCheckForFinancialDetailRecord(Customer_Financial_Detail__c financialRecord){
        if(financialRecord.Net_patient_revenue__c == null){
            financialRecord.Net_patient_revenue__c = 0.0;
        }    
        if(financialRecord.Operating_Expenses__c == null){ 
            financialRecord.Operating_Expenses__c = 0.0;
        }    
        if(financialRecord.Cash_on_Hand__c == null){ 
            financialRecord.Cash_on_Hand__c = 0.0;
        }    
        if(financialRecord.Temporary_Investments__c == null){
            financialRecord.Temporary_Investments__c = 0.0;
        }    
        if(financialRecord.Total_Operating_Expenses__c == null){
            financialRecord.Total_Operating_Expenses__c = 0.0;
        }    
        if(financialRecord.Depreciation_Expense__c == null){   
            financialRecord.Depreciation_Expense__c = 0.0;
        }    
        if(financialRecord.Current_Assets__c == null){
            financialRecord.Current_Assets__c = 0.0;
        }    
        if(financialRecord.Current_Liabilities__c == null){
            financialRecord.Current_Liabilities__c = 0.0;
        }
        if(financialRecord.Payor_Mix_Medicaid__c == null){
            financialRecord.Payor_Mix_Medicaid__c = 0.0;
        }    
        if(financialRecord.Payor_Mix_Medicare__c == null){
            financialRecord.Payor_Mix_Medicare__c = 0.0;
        }    
        return financialRecord;
    }
    
    /**    
    * @Description : This method is for checking null values in SAP record and assigning them to zero
    * @param       : Strategic_Account_Plan__c
    * @return      : Strategic_Account_Plan__c
    **/
    public Strategic_Account_Plan__c doNullCheckForSAPRecord(Strategic_Account_Plan__c sapRecord){
        if(sapRecord.Recommenadtion__c == null){
            sapRecord.Recommenadtion__c = 0.00;
        }    
        if(sapRecord.Room_Quiet__c == null){ 
            sapRecord.Room_Quiet__c = 0.00;
        }    
        if(sapRecord.Cost_of_Care__c == null){
            sapRecord.Cost_of_Care__c = 0.00;
        }   
        return sapRecord;
    }
    
    /**    
    * @Description : This method is for retrieving the SAP record.    
    * @param       : ID sapId
    * @return      : Strategic_Account_Plan__c
    **/
    public Strategic_Account_Plan__c getSAPRecord(Id sapId){
        if(sapId != null){
            Strategic_Account_Plan__c sapRecord = daoClassObject.getSAPRecord(sapId);
            return sapRecord;
        }else{
            return null;
        }
    }
    /**    
    * @Description : This method is for checking null values in Philips Order Value record and assigning them to zero
    * @param       : Philips_Order_Value__c
    * @return      : Philips_Order_Value__c
    **/
    public Philips_Order_Value__c doNullCheckForPhilipsOrderValueRecord(Philips_Order_Value__c philipsOrderValueRecord){
        if(philipsOrderValueRecord.HISS__c == null){
            philipsOrderValueRecord.HISS__c = 0.00;
        }   
        if(philipsOrderValueRecord.I_S__c == null) {
            philipsOrderValueRecord.I_S__c = 0.00;
        }
        if(philipsOrderValueRecord.U_S__c == null){ 
            philipsOrderValueRecord.U_S__c = 0.00;
        }    
        if(philipsOrderValueRecord.PCMS__c == null) {
            philipsOrderValueRecord.PCMS__c = 0.00;
        }    
        if(philipsOrderValueRecord.POS__c == null){
            philipsOrderValueRecord.POS__c = 0.00;
        }    
        if(philipsOrderValueRecord.Total_M__c == null){
            philipsOrderValueRecord.Total_M__c = 0.00;
        }                
        return philipsOrderValueRecord;
    }
     
    /**    
    * @Description : This method is for retrieving the associated account name.    
    * @param       : ID accountId
    * @return      : String
    **/
    public String getAccountName(Id accountId){       
        if(accountId != null){
            String accountName = daoClassObject.getAccountName(accountId);
            return accountName;
        }else{
            return '';
        }        
    }
}