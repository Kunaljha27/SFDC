/**
@Classname :       M20_OptyForecastCategoryUpdateService
@Description :     This class is being called from M2O_ForecastCategoryUpdate trigger.
@Author:           Rupsa Hore
@Last Modified:    29/01/2014
**/

public with sharing class M2O_OptyForecastCategoryUpdateService{
    
    //This method is setting the Forecats Category to Omitted for all Partner users    
    public static void updateForecastCategoryForPartner(List<Opportunity> opportunityList){ 
        for(Opportunity optyObj : opportunityList){
            optyObj.ForecastCategoryName = System.Label.M2O_ForecastCategory_Omitted;                       
        }
    }
    
    //This method derives Probability value from custom settings and update Forecast category in accordance to that for NonPartner users.    
    public static void updateForecastCategory(List<Opportunity> opportunityList, Boolean isInsert, Map<Id, String> optyForecastCategoryIdMap){        
        decimal matrixProbabilityVal = 0;
        decimal probability = 0;                
        for(Opportunity optyObj : opportunityList){
           probability = optyObj.Probability;
           if(getVocFundingMatrixVal().get(optyObj.Funding_status_deal_realization__c+optyObj.Vendor_of_Choice__c) != Null){
                optyObj.Probability = getVocFundingMatrixVal().get(optyObj.Funding_status_deal_realization__c+optyObj.Vendor_of_Choice__c);
                matrixProbabilityVal = optyObj.Probability;
            }else{
                matrixProbabilityVal = optyObj.Probability;            
            }
            system.debug(probability + 'in else >>>>>> '+optyObj.ForecastCategoryName + ' '+optyForecastCategoryIdMap);
            optyObj.Partner_Created__c = true;
            if(isInsert == true){
                checkProbability(matrixProbabilityVal, optyObj);
            }else{
                if(((probability == 20 ||probability == 40) && optyForecastCategoryIdMap.get(optyObj.Id) == System.Label.M2O_ForecastCategory_Pipeline)
                    || (probability == 60 && optyForecastCategoryIdMap.get(optyObj.Id) == System.Label.M2O_ForecastCategory_BestCase)|| 
                    (probability == 80 && optyForecastCategoryIdMap.get(optyObj.Id) == System.Label.M2O_ForecastCategory_Commit)
                    || (probability == 0 && optyForecastCategoryIdMap.get(optyObj.Id) == System.Label.M2O_ForecastCategory_Omitted)){
                    system.debug('in 1st if >>>>>> ');
                    checkProbability(matrixProbabilityVal, optyObj);
                }
            }
        }                          
    }
    
    
    //Check for matrixProbabilityVal value and update forecast category according to the matrix
    @testvisible private static void checkProbability(Decimal matrixProbabilityVal, Opportunity optyObj){
        if(matrixProbabilityVal == 0){
            optyObj.ForecastCategoryName = System.Label.M2O_ForecastCategory_Omitted;
        }
        if(matrixProbabilityVal == 20 || matrixProbabilityVal == 40){
            optyObj.ForecastCategoryName = System.Label.M2O_ForecastCategory_Pipeline;
        }
        if(matrixProbabilityVal == 60){
            optyObj.ForecastCategoryName = System.Label.M2O_ForecastCategory_BestCase;
        }
        if(matrixProbabilityVal == 80){
            optyObj.ForecastCategoryName = System.Label.M2O_ForecastCategory_Commit;
        }
    }
    
    //Retrieving Custom Settings Values
    @testvisible private static Map<String,decimal> getVocFundingMatrixVal(){        
        Map<String,decimal> mapVOCFundingStat = new Map<String,decimal>();
        for(OM_VOC_FDR_Matrix__c matrixObj : OM_VOC_FDR_Matrix__c.getall().values()){
            mapVOCFundingStat.put(matrixObj.Funding_status_deal_realization__c + matrixObj.Vendor_of_Choice__c, matrixObj.Probability__c);
        }
        return mapVOCFundingStat;
    }
}