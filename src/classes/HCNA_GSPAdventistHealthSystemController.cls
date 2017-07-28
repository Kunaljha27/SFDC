/*** 
*@ClassName : HCNA_GSPAdventistHealthSystemController 
*@Description : Custom controller for HCNA_GSPAdventistHealthSystem page.
*@Author : Alok Bhakat
*@Last Modified : 01/07/2014
***/
global with sharing class HCNA_GSPAdventistHealthSystemController {
         public String currentYear {get; set;}
         public String lastYear {get; set;}
         public String lastToLastYear {get; set;}
         public String accName {get; set;}
         
        /**    
        * @Description : This RemoteAction method is for retrieving the average of last 5 years for financial objective data for the selected SAP.    
        * @param       : ID sapId
        * @return      : List<DataWrapper>
        **/         
        @RemoteAction  
        global static List<HCNA_GSPChartDataWrapper> loadAverageData(ID sapId) {
            Decimal isTotal = 0.0;
            Decimal pcmsTotal = 0.0;
            Decimal hissCTotal = 0.0;
            Decimal usTotal = 0.0;
            Decimal posTotal = 0.0;

            List<HCNA_GSPChartDataWrapper> resultList = new List<HCNA_GSPChartDataWrapper>();
            HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService();
            
            List<Philips_Order_Value__c> orderValueList = serviceClassObject.getOrderValueList(sapId);
            
            if(orderValueList != null && !orderValueList.isEmpty()){
                for(Philips_Order_Value__c record : orderValueList){                           
                    if(record.I_S__c != null){
                        isTotal += record.I_S__c;
                    }
                    
                    if(record.PCMS__c != null){
                        pcmsTotal += record.PCMS__c;
                    }
                    
                    if(record.HISS__c != null){
                        hissCTotal += record.HISS__c;
                    }
                    
                    if(record.U_S__c != null){    
                        usTotal += record.U_S__c;
                    }
                    
                    if(record.POS__c != null){        
                        posTotal += record.POS__c;
                    }    
                }            

                resultList.add(new HCNA_GSPChartDataWrapper('IS', (isTotal/1000000)/orderValueList.size())); 
                resultList.add(new HCNA_GSPChartDataWrapper('PCMS', (pcmsTotal/1000000)/orderValueList.size())); 
                resultList.add(new HCNA_GSPChartDataWrapper('HISS', (hissCTotal/1000000)/orderValueList.size())); 
                resultList.add(new HCNA_GSPChartDataWrapper('US', (usTotal/1000000)/orderValueList.size())); 
                resultList.add(new HCNA_GSPChartDataWrapper('POS', (posTotal/1000000)/orderValueList.size())); 
            }
            return resultList;
        }
        
        /**    
        * @Description : This RemoteAction method is for retrieving the sum of opportunity data for the  selected SAP account's associated account.    
        * @param       : ID accountId
        * @return      : List<DataWrapper>
        **/ 
        @RemoteAction  
        global static List<HCNA_GSPChartDataWrapper> loadOpportunityData(ID accountId) {
            Decimal isTotal = 0.0;
            Decimal pcmsTotal = 0.0;
            Decimal hissCTotal = 0.0;
            Decimal usTotal = 0.0;
            Decimal posTotal = 0.0;
            
            List<HCNA_GSPChartDataWrapper> result = new List<HCNA_GSPChartDataWrapper>();
            HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService(); 
            
            List<Account> accountList = serviceClassObject.getAccountList(accountId);
            List<ID> accountIdList = new List<ID>();
            accountIdList.add(accountId);
            
            for(Account accountRecord : accountList ){
                accountIdList.add(accountRecord.Id);
            }
            
            List<Opportunity> opportunityList = serviceClassObject.getOpportunityList(accountIdList);
            
            if(opportunityList != null && !opportunityList.isEmpty()){
                for(Opportunity record : opportunityList){                           
                    if(record.Business_Group_HCNA__c == 'IS' && record.Amount != null){
                        isTotal += record.Amount;
                    }else if(record.Business_Group_HCNA__c == 'PCMS' && record.Amount != null){
                        pcmsTotal += record.Amount;
                    }else if(record.Business_Group_HCNA__c == 'HISS' && record.Amount != null){
                        hissCTotal += record.Amount;
                    }else if(record.Business_Group_HCNA__c == 'US' && record.Amount != null){
                        usTotal += record.Amount;
                    }else if(record.Business_Group_HCNA__c == 'POS' && record.Amount != null){
                        posTotal += record.Amount;
                    }
                }
                
                if(isTotal == 0.0 && pcmsTotal == 0.0 && hissCTotal == 0.0 && usTotal == 0.0 && posTotal == 0.0){
                    ApexPages.Message infoMsg = new ApexPages.Message(ApexPages.Severity.Info,'No products added to Opportunities');
                    ApexPages.addMessage(infoMsg);                                
                }
                
                result.add(new HCNA_GSPChartDataWrapper('IS', isTotal/1000000)); 
                result.add(new HCNA_GSPChartDataWrapper('PCMS', pcmsTotal/1000000)); 
                result.add(new HCNA_GSPChartDataWrapper('HISS', hissCTotal/1000000)); 
                result.add(new HCNA_GSPChartDataWrapper('US', usTotal/1000000)); 
                result.add(new HCNA_GSPChartDataWrapper('POS', posTotal/1000000));   
            }            
            return result;
        }
        
        /**    
        * @Description : This RemoteAction method is for retrieving the benchmark bar chart for the selected SAP.    
        * @param       : Id sapId
        * @return      : List<HCNA_GSPChartDataWrapper>
        **/
        @RemoteAction  
        global static List<HCNA_GSPChartDataWrapper> loadBenchmark(Id sapId){
            Decimal recommendation = 0;
            Decimal roomQuite = 0;
            Decimal haiHAC = 0;
            Decimal readmission = 0;
            Decimal mortality = 0;
            Decimal costOfCare = 0;
            List<HCNA_GSPChartDataWrapper> scorecardList =  new  List<HCNA_GSPChartDataWrapper>();
            HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService(); 
            
            Strategic_Account_Plan__c strategicRecord = serviceClassObject.getSAPRecord(sapId);
            
            if(strategicRecord != null){            
                Strategic_Account_Plan__c sapRecord = serviceClassObject.doNullCheckForSAPRecord(strategicRecord);
                recommendation = sapRecord.Recommenadtion__c;
                roomQuite = sapRecord.Room_Quiet__c;
                costOfCare = sapRecord.Cost_of_Care__c;            
                haiHAC = sapRecord.HAI_HAC__c;
                readmission = sapRecord.readmission__c;
                mortality = sapRecord.mortality__c;
                
                scorecardList.add(new HCNA_GSPChartDataWrapper('Recommendation',recommendation));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Room Quiet',roomQuite));
                scorecardList.add(new HCNA_GSPChartDataWrapper('HAI/HAC',haiHAC));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Readmission',readmission));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Mortality',mortality));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Cost Of Care',costOfCare));
            }
            return scorecardList;
        }
        
        /**    
        * @Description : This method is for retrieving the financial data for the selected SAP.    
        * @param       : None
        * @return      : List<FinancialDetailDataWrapper>
        **/ 
        public List<FinancialDetailDataWrapper> getFinancials(){
            HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService(); 
            accName = serviceClassObject.getAccountName(ApexPages.currentPage().getParameters().get('AccountId'));
            List<Customer_Financial_Detail__c> financialDetailsList = serviceClassObject.getFinancialDetails(ApexPages.currentPage().getParameters().get('SAPID'));
            List<FinancialDetailDataWrapper> resultList = new List<FinancialDetailDataWrapper>();
            currentYear = '';
            lastYear = '';
            lastToLastYear = '';            
                        
            FinancialDetailDataWrapper nopResult = new FinancialDetailDataWrapper();
            FinancialDetailDataWrapper dcohResult = new FinancialDetailDataWrapper();
            FinancialDetailDataWrapper crResult = new FinancialDetailDataWrapper();
            FinancialDetailDataWrapper pmResult = new FinancialDetailDataWrapper();
            
            nopResult.name = 'Net Operating Margin';
            dcohResult.name = 'Days Cash on Hand';
            crResult.name = 'Current ratio';
            pmResult.name = 'Payor Mix';
            
            if(financialDetailsList != null && !financialDetailsList.isEmpty()){                               
                Decimal netMargin;
                Decimal dcoh;
                Decimal currentRatio;
                Decimal payorMix;
                
                String firstYear = String.valueOf(System.today().year() - 1);
                String secondYear = String.valueOf(System.today().year() - 2);
                String thirdYear = String.valueOf(System.today().year() - 3);
                
                for(Customer_Financial_Detail__c financialRecord : financialDetailsList){
                    netMargin = 0.0;
                    dcoh = 0.0;
                    currentRatio = 0.0;
                    payorMix = 0.0;
                    Customer_Financial_Detail__c record = serviceClassObject.doNullCheckForFinancialDetailRecord(financialRecord);
                    
                    if(record.Net_patient_revenue__c != 0.0){                
                        netMargin = (((record.Net_patient_revenue__c - record.Operating_Expenses__c)/record.Net_patient_revenue__c) * 100).setscale(2);                                
                    }
                    
                    if((record.Total_Operating_Expenses__c - record.Depreciation_Expense__c) != 0.0){
                        dcoh = (((record.Cash_on_Hand__c + record.Temporary_Investments__c)/((record.Total_Operating_Expenses__c - record.Depreciation_Expense__c) / 365))).setscale(1);                                
                    }
                    
                    if(record.Current_Liabilities__c != 0.0){
                        currentRatio = (record.Current_Assets__c / record.Current_Liabilities__c).setscale(1);                                
                    }
                    
                    if(record.Payor_Mix_Medicare__c != 0.0){
                        payorMix = ((record.Payor_Mix_Medicaid__c / record.Payor_Mix_Medicare__c) * 100).setscale(2);                
                    }
                    
                    if(firstYear == record.Year__c){
                        nopResult.yearOne = netMargin;
                        dcohResult.yearOne = dcoh;
                        crResult.yearOne = currentRatio;
                        pmResult.yearOne = payorMix;
                        currentYear = record.Year__c;
                    }else if(secondYear == record.Year__c){
                        nopResult.yearTwo = netMargin;
                        dcohResult.yearTwo = dcoh;
                        crResult.yearTwo = currentRatio;
                        pmResult.yearTwo = payorMix;
                        lastYear = record.Year__c;
                    }else if(thirdYear == record.Year__c){
                        nopResult.yearThree = netMargin;
                        dcohResult.yearThree = dcoh;
                        crResult.yearThree = currentRatio;
                        pmResult.yearThree = payorMix;
                        lastToLastYear = record.Year__c;
                    }
                }           
                
                if(currentYear == ''){
                    ApexPages.Message infoMsg = new ApexPages.Message(ApexPages.Severity.Info,'Data not available for year '+ firstYear + ' for Customer Financial Details');
                    ApexPages.addMessage(infoMsg);                                
                }
                
                resultList.add(nopResult);
                resultList.add(dcohResult);
                resultList.add(crResult);
                resultList.add(pmResult);
                
                for(FinancialDetailDataWrapper wrapperRecord : resultList){
                    if(wrapperRecord.yearTwo == null || wrapperRecord.yearOne >= wrapperRecord.yearTwo){
                        wrapperRecord.oneYrTrend = true;
                    }else{
                        wrapperRecord.oneYrTrend = false;
                    }
                    
                    if(wrapperRecord.yearThree == null || wrapperRecord.yearOne >= wrapperRecord.yearThree){
                        wrapperRecord.threeYrTrend = true;
                    }else{
                        wrapperRecord.threeYrTrend = false;
                    }
                }
            }else{                
                ApexPages.Message infoMsg = new ApexPages.Message(ApexPages.Severity.Info,'Data not available for Customer Financial Details');
                ApexPages.addMessage(infoMsg);                                                               
                resultList.add(nopResult);
                resultList.add(dcohResult);
                resultList.add(crResult);
                resultList.add(pmResult);
            }       
            return resultList;
        }
        
        /*** 
        *@ClassName : FinancialDetailDataWrapper 
        *@Description : Wrapper class to store financial data.
        *@Author : Alok Bhakat
        *@Last Modified : 26/06/2014
        ***/
        public class FinancialDetailDataWrapper{
            public String name {get;set;}
            public Decimal yearOne {get;set;}
            public Decimal yearTwo {get;set;}
            public Decimal yearThree {get;set;}
            public Boolean oneYrTrend {get;set;}
            public Boolean threeYrTrend {get;set;}
            
            public FinancialDetailDataWrapper(){
            }            
        }
        
        /**    
        * @Description : This method is for retrieving the scorecard data for the selected SAP.    
        * @param       : None
        * @return      : List<HCNA_GSPChartDataWrapper>
        **/
        public List<HCNA_GSPChartDataWrapper> getScorecard(){
            Decimal recommendation = 0;
            Decimal roomQuite = 0;
            Decimal haiHAC = 0;
            Decimal readmission = 0;
            Decimal mortality = 0;
            Decimal costOfCare = 0;
            List<HCNA_GSPChartDataWrapper> scorecardList =  new  List<HCNA_GSPChartDataWrapper>();
            HCNA_GSPAdventistHealthSystemService serviceClassObject = new HCNA_GSPAdventistHealthSystemService(); 
            accName = serviceClassObject.getAccountName(ApexPages.currentPage().getParameters().get('AccountId'));           
            Strategic_Account_Plan__c strategicRecord = serviceClassObject.getSAPRecord(ApexPages.currentPage().getParameters().get('SAPID'));
            
            if(strategicRecord != null){            
                Strategic_Account_Plan__c sapRecord = serviceClassObject.doNullCheckForSAPRecord(strategicRecord);
                recommendation = (sapRecord.Recommenadtion__c).setscale(2);
                roomQuite = (sapRecord.Room_Quiet__c).setscale(2);
                costOfCare = (sapRecord.Cost_of_Care__c).setscale(2);            
                haiHAC = (sapRecord.HAI_HAC__c).setscale(2);
                readmission = (sapRecord.readmission__c).setscale(2);
                mortality = (sapRecord.mortality__c).setscale(2);
                
                scorecardList.add(new HCNA_GSPChartDataWrapper('Recommendation',recommendation));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Room Quiet',roomQuite));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Healthcare-Associated Infection',haiHAC));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Readmission',readmission));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Mortality',mortality));
                scorecardList.add(new HCNA_GSPChartDataWrapper('Cost Of Care',costOfCare));
            }
            return scorecardList;
        }
}