/*** 
*@ClassName : HCNA_GSPAdventistHealthSystemDAO 
*@Description : DAO class for HCNA_GSPAdventistHealthSystem page.
*@Author : Alok Bhakat
*@Last Modified : 25/06/2014
***/
global with sharing class HCNA_GSPAdventistHealthSystemDAO {
    /**    
    * @Description : This method is for retrieving the philips order value list for the selected SAP.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getOrderValueList(Id sapId){        
        String currentYear = String.valueOf(System.today().year() - 1);
        String startYear = String.valueOf(System.today().year() - 5);
        List<Philips_Order_Value__c> orderValueList = [SELECT convertCurrency(I_S__c), convertCurrency(HISS__c), convertCurrency(PCMS__c), convertCurrency(POS__c), convertCurrency(U_S__c) FROM Philips_Order_Value__c WHERE Year__c >= :startYear AND Year__c <= :currentYear AND Strategic_account_plan__c =: sapId ];
        return orderValueList;        
    }
    
    /**    
    * @Description : This method is for retrieving the associated accounts.    
    * @param       : ID accountId
    * @return      : List<Account>
    **/
    public List<Account> getAccountList(Id accountId){                
            List<Account> accountList = [SELECT Id FROM Account where Parent_IDN_of_Associated_IDN__c =:accountId];
            return accountList;        
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities for associated accounts.    
    * @param       : List<ID> accountIdList
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getOpportunityList(List<ID> accountIdList){                
            List<Opportunity> opportunityList = [SELECT convertCurrency(Amount), Business_Group_HCNA__c FROM Opportunity WHERE AccountId IN :accountIdList AND ForecastCategoryName IN ('Pipeline','Best Case','Commit') AND Business_Group_HCNA__c != '']; 
            return opportunityList;        
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities for associated accounts.    
    * @param       : List<ID> accountIdList
    * @return      : List<Opportunity>
    **/
    public List<Opportunity> getOpportunityList(List<ID> accountIdList, String businessGroupValue){                
            List<Opportunity> opportunityList = [SELECT Id FROM Opportunity WHERE AccountId IN :accountIdList AND ForecastCategoryName IN ('Pipeline','Best Case','Commit') AND Business_Group_HCNA__c =: businessGroupValue]; 
            return opportunityList;        
    }
    
    /**    
    * @Description : This method is for retrieving the opportunities line item for associated opportunity.    
    * @param       : List<opportunity> opportunityList
    * @return      : List<OpportunityLineItem>
    **/
    public List<OpportunityLineItem> getOpportunityLineItemList(List<opportunity> opportunityList){                
            List<OpportunityLineItem> opportunityLineItemList = [Select Id,Product_Family__c,Commercial_Product_Name__c, convertCurrency(TotalPrice) from OpportunityLineItem where OpportunityId in :opportunityList]; 
            return opportunityLineItemList;        
    }
    
    /**    
    * @Description : This method is for retrieving the financial details for associated SAP.    
    * @param       : Id sapId
    * @return      : List<Customer_Financial_Detail__c>
    **/
    public List<Customer_Financial_Detail__c> getFinancialDetails(Id sapId){                
            String currentYear = String.valueOf(System.today().year() - 1);
            String startYear = String.valueOf(System.today().year() - 3);
            List<Customer_Financial_Detail__c> financialDetailsList = [SELECT convertCurrency(Net_patient_revenue__c), convertCurrency(Operating_Expenses__c), convertCurrency(Cash_on_Hand__c), convertCurrency(Temporary_Investments__c), convertCurrency(Total_Operating_Expenses__c), convertCurrency(Depreciation_Expense__c), convertCurrency(Current_Assets__c), convertCurrency(Current_Liabilities__c), Payor_Mix_Medicaid__c, Payor_Mix_Medicare__c, Year__c FROM Customer_Financial_Detail__c WHERE Year__c >= :startYear AND Year__c <= :currentYear AND Strategic_account_plan__c = :sapId order by Year__c DESC];
            return financialDetailsList;        
    }
    /**    
    * @Description : This method is for retrieving the Philips Order value for Pie chart on purchase history.  
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getPieChart(ID sapId){        
        try{
            List<Philips_Order_Value__c> philipsOrderValueList  = [SELECT convertCurrency(HISS__c), convertCurrency(I_S__c), convertCurrency(PCMS__c), convertCurrency(POS__c),convertCurrency(Total_M__c), convertCurrency(U_S__c) FROM Philips_Order_Value__c WHERE Strategic_account_plan__c =:sapId];
            return philipsOrderValueList ;
        }catch(Exception ex){
            return null;
        }     
    }
    
    /**    
    * @Description : This method is for retrieving the Philips Order value for Area chart on purchase history.    
    * @param       : ID sapId
    * @return      : List<Philips_Order_Value__c>
    **/
    public List<Philips_Order_Value__c> getAreaChart(ID sapId){        
        try{
            String currentYear = String.valueOf(System.today().year());
            String startYear = String.valueOf(System.today().year() - 6);
            List<Philips_Order_Value__c> orderValueList = [SELECT convertCurrency(HISS__c), convertCurrency(I_S__c),convertCurrency(PCMS__c), convertCurrency(POS__c),convertCurrency(U_S__c),convertCurrency(Total_M__c), Year__c from Philips_Order_Value__c where Strategic_account_plan__c =:sapId order by Year__c];
            return orderValueList;
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the SAP record.    
    * @param       : ID sapId
    * @return      : Strategic_Account_Plan__c
    **/
    public Strategic_Account_Plan__c getSAPRecord(Id sapId){
        try{
            Strategic_Account_Plan__c sapRecord = [Select Recommenadtion__c, Room_Quiet__c , Cost_of_Care__c, HAI_HAC__c, readmission__c, mortality__c FROM Strategic_Account_Plan__c WHERE Id =:sapId];    
            return sapRecord;
        }catch(Exception ex){
            return null;
        }
    }
    
    /**    
    * @Description : This method is for retrieving the associated account name.    
    * @param       : ID accountId
    * @return      : String
    **/
    public String getAccountName(Id accountId){     
        try{              
               Account accountRecord = [Select Name FROM Account WHERE Id = :accountId LIMIT 1];  
               return accountRecord.Name;            
        }catch(Exception ex){
            return '';
        }
    }
}