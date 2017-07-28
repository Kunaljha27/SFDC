/**
* @ClassName : M2O_FinancialBridgeService
* @Description : This class is the service class of M2O_FinancialBridgeRevenue_Chart visualforce page.This class performes the bussiness logic (functionality) of the page 
* @Author : Srutadeba Chanda
* @Last Modified : 28/11/2013
* @Discussionpoints : No Information
*/

Public class M2O_FinancialBridgeService{
    public static string quarter;
    /**
    * @Description : This method get the master strategic Account Plan record for the Financial Bridge
    * @param       : Strategic Account Plan Id
    * @return      : record for Strategic Account Plan
    **/ 
   
     public static  Strategic_Account_Plan__c getMasterRecordSAP(Id sapRecordID){
        Strategic_Account_Plan__c sapRecord;
        sapRecord=M2O_FinancialBridgeDAO.querySapRecord(sapRecordID);
        
        return sapRecord;
    }
    
    /**
    * @Description : This method get the user access information to edit the Financial Bridge record 
    * @param       : Running user Id and Strategic Account Plan id 
    * @return      : record of type UserRecordAccess
    **/  
    
    public static UserRecordAccess getUserAccess(Id currentUser, Id sapRecordID){
         UserRecordAccess hasaccess;
         hasaccess =M2O_FinancialBridgeDAO.queryUserAccess(currentUser,sapRecordID);
         return hasaccess;
        
    }
    
     /**
    * @Description : This method retrive the data for First two quarter and the Quartre value to the DAO class to get all the details
    * @param       : Strategic Account Plan id and Financial Bridge Recordtype Id
    * @return      : List of Financial Bridge
    **/ 

     public static List<Financial_Bridge__c> getFinancialBridgeListQ1Q2(Id sapRecordID,Id finBridgeRecordtype){
         //string quarter;
         List<Financial_Bridge__c> financialBridgeListQ1Q2;
         List<Financial_Bridge__c> showfinancialBridgeListQ1Q2= new List<Financial_Bridge__c>();
         quarter= '(\'AOP\',\'End of Q1\')';
          financialBridgeListQ1Q2=M2O_FinancialBridgeDAO.getFinancialData(quarter,sapRecordID,finBridgeRecordtype); 
         if(financialBridgeListQ1Q2!=null && !financialBridgeListQ1Q2.isEmpty()){
           if(Schema.SObjectType.Financial_Bridge__c.getRecordTypeInfosById().get(finBridgeRecordtype).getName()=='Revenue'){
               showfinancialBridgeListQ1Q2=getFinValueRevenue(financialBridgeListQ1Q2); 
            }
            else{
                showfinancialBridgeListQ1Q2=getFinValueProfit(financialBridgeListQ1Q2); 
           }            
           return showfinancialBridgeListQ1Q2; 
         }
         else{
            return null;
         }   
         
     }
     
   /**
    * @Description : This method retrieve the data for Last two quarter and the Quartre value to the DAO class to get all the details
    * @param       : Strategic Account Plan id and Financial Bridge Recordtype Id
    * @return      : List of Financial Bridge
    **/ 
  
     public static List<Financial_Bridge__c> getFinancialBridgeListQ2Q3(Id sapRecordID,Id finBridgeRecordtype){
         //string quarter;
         List<Financial_Bridge__c> financialBridgeListQ2Q3;
         List<Financial_Bridge__c> showfinancialBridgeListQ2Q3= new List<Financial_Bridge__c>();
         quarter= '(\'End of Q2\',\'End of Q3\')';
          financialBridgeListQ2Q3=M2O_FinancialBridgeDAO.getFinancialData(quarter,sapRecordID,finBridgeRecordtype); 
         if(financialBridgeListQ2Q3!=null && !financialBridgeListQ2Q3.isEmpty()){
            if(Schema.SObjectType.Financial_Bridge__c.getRecordTypeInfosById().get(finBridgeRecordtype).getName()=='Revenue'){
                showfinancialBridgeListQ2Q3=getFinValueRevenue(financialBridgeListQ2Q3);           
            }
             else{
                showfinancialBridgeListQ2Q3=getFinValueProfit(financialBridgeListQ2Q3); 
              }   
            return showfinancialBridgeListQ2Q3; 
           } 
              
          else{
              return null;
           }    
     }
      
    /**
    * @Description : This method is used to get the currency symbol depends on the currency set for the strategic Account Plan from custom settings 
    * @param       : Startegic Account Plan Id
    * @return      : String
    **/      

     public static string getCurrencyValue(Id sapRecordID){
         Map<String,M2O_CurrencySymbol__c> currencySymbol=new Map<String,M2O_CurrencySymbol__c>();
         string currencyvalue ;
         currencySymbol=M2O_CurrencySymbol__c.getAll();
         currencyvalue =(currencySymbol.get(getMasterRecordSAP(sapRecordID).CurrencyIsoCode)).Symbol__c;
         return currencyvalue;      
     }
         
    /**
    * @Description : This method is used to multiply all the currency vale of Financial bridge Revenue by 1000 to show the fata in unit of 1000
    * @param       : List of Financial Bridge
    * @return      : List of Financial Bridge
    **/       
     public static List<Financial_Bridge__c> updateFinValueRevenue(List<Financial_Bridge__c> finBrdgeList){
          List<Financial_Bridge__c> updateFinBridgeList= new List<Financial_Bridge__c>(); 
           for(Financial_Bridge__c fBridge : finBrdgeList){
                     fBridge.Landing_year_Revenue__c =fBridge.Landing_year_Revenue__c *1000;
                     fBridge.Revenue_for_Business_Group_1__c=fBridge.Revenue_for_Business_Group_1__c*1000;
                     fBridge.Revenue_for_Business_Group_2__c= fBridge.Revenue_for_Business_Group_2__c*1000;
                     fBridge.Revenue_for_Business_Group_3__c= fBridge.Revenue_for_Business_Group_3__c*1000;
                     fBridge.Revenue_for_Business_Group_4__c=fBridge.Revenue_for_Business_Group_4__c*1000;
                     fBridge.Current_year_Objective_Revenue__c=fBridge.Current_year_Objective_Revenue__c*1000;
                     updateFinBridgeList.add(fBridge );
           }
           return updateFinBridgeList;
     } 
     
    /**
    * @Description : This method is used to multiply all the currency vale by 1000 to show the data in unit of 1000
    * @param       : List of Financial Bridge
    * @return      : List of Financial Bridge
    **/       
    public static List<Financial_Bridge__c> updateFinValueProfit(List<Financial_Bridge__c> finBrdgeList){
          List<Financial_Bridge__c> updateFinBridgeList= new List<Financial_Bridge__c>(); 
           for(Financial_Bridge__c fBridge : finBrdgeList){
                     fBridge.Landing_Year_Profit__c =fBridge.Landing_Year_Profit__c *1000;
                     fBridge.Profit_For_Business_Group_1__c=fBridge.Profit_For_Business_Group_1__c *1000;
                     fBridge.Profit_For_Business_Group_2__c= fBridge.Profit_For_Business_Group_2__c *1000;
                     fBridge.Profit_For_Business_Group_3__c= fBridge.Profit_For_Business_Group_3__c *1000;
                     fBridge.Profit_For_Business_Group_4__c=fBridge.Profit_For_Business_Group_4__c *1000;
                     fBridge.Current_Year_Objective_Profit__c=fBridge.Current_Year_Objective_Profit__c *1000;
                     updateFinBridgeList.add(fBridge );
           }
           return updateFinBridgeList;
     } 
    
     
    /**
    * @Description : This method is used to devide all the currency vale of Financial Bridge Revenue by 1000 to show the fata in unit of 1000
    * @param       : List of Financial Bridge
    * @return      : List of Financial Bridge
    **/ 
    public static List<Financial_Bridge__c> getFinValueRevenue(List<Financial_Bridge__c> finBrdgeList){
          List<Financial_Bridge__c> showFinBridgeList= new List<Financial_Bridge__c>(); 
           for(Financial_Bridge__c fBridge : finBrdgeList){
                     fBridge.Landing_year_Revenue__c =(fBridge.Landing_year_Revenue__c /1000).setScale(2);
                     fBridge.Revenue_for_Business_Group_1__c=(fBridge.Revenue_for_Business_Group_1__c/1000).setScale(2);
                     fBridge.Revenue_for_Business_Group_2__c= (fBridge.Revenue_for_Business_Group_2__c/1000).setScale(2);
                     fBridge.Revenue_for_Business_Group_3__c= (fBridge.Revenue_for_Business_Group_3__c/1000).setScale(2);
                     fBridge.Revenue_for_Business_Group_4__c=(fBridge.Revenue_for_Business_Group_4__c/1000).setScale(2);
                     fBridge.Current_year_Objective_Revenue__c=(fBridge.Current_year_Objective_Revenue__c/1000).setScale(2);
                      showFinBridgeList.add(fBridge );
           }
          return showFinBridgeList;
     }
    /**
    * @Description : This method is used to devide all the currency vale by 1000 to show the data in unit of 1000
    * @param       : List of Financial Bridge
    * @return      : List of Financial Bridge
    **/ 
    public static List<Financial_Bridge__c> getFinValueProfit(List<Financial_Bridge__c> finBrdgeList){
          List<Financial_Bridge__c> showFinBridgeList= new List<Financial_Bridge__c>(); 
           for(Financial_Bridge__c fBridge : finBrdgeList){
       
                fBridge.Landing_Year_Profit__c =(fBridge.Landing_Year_Profit__c/1000).setScale(2);
                fBridge.Profit_For_Business_Group_1__c=(fBridge.Profit_For_Business_Group_1__c/1000).setScale(2);
                fBridge.Profit_For_Business_Group_2__c= (fBridge.Profit_For_Business_Group_2__c/1000).setScale(2);
                fBridge.Profit_For_Business_Group_3__c= (fBridge.Profit_For_Business_Group_3__c/1000).setScale(2);
                fBridge.Profit_For_Business_Group_4__c=(fBridge.Profit_For_Business_Group_4__c/1000).setScale(2);
                fBridge.Current_Year_Objective_Profit__c=(fBridge.Current_Year_Objective_Profit__c/1000).setScale(2);
                showFinBridgeList.add(fBridge );
           }
          return showFinBridgeList;
     }
    /**
    * @Description : This method is used to show the error message if current year objective does not add up to sum of Last year landing & growth/fall of categories  .
    * @param       : List of Financial Bridge
    * @return      : string
    **/  
    
    public static string checkValidityOfFinDataRevenue(List<Financial_Bridge__c> finBrdgeList){
          string errorMessage=null;
           for(Financial_Bridge__c fBridge: finBrdgeList){
                   if(fBridge.Landing_year_Revenue__c==null){
              fBridge.Landing_year_Revenue__c=0;
             } 
           if(fBridge.Revenue_for_Business_Group_1__c==null){
              fBridge.Revenue_for_Business_Group_1__c=0;
             }   
           if(fBridge.Revenue_for_Business_Group_2__c==null){
              fBridge.Revenue_for_Business_Group_2__c=0;
             } 
             
           if(fBridge.Revenue_for_Business_Group_3__c==null){
              fBridge.Revenue_for_Business_Group_3__c=0;
             }   
             
           if(fBridge.Revenue_for_Business_Group_4__c==null){
              fBridge.Revenue_for_Business_Group_4__c=0;
             } 
             
           if(fBridge.Current_year_Objective_Revenue__c==null){
              fBridge.Current_year_Objective_Revenue__c=0;
             }
           if(fBridge.Revenue_for_Business_Group_1__c!=0 || fBridge.Revenue_for_Business_Group_2__c!=0 || fBridge.Revenue_for_Business_Group_3__c!=0 || fBridge.Revenue_for_Business_Group_4__c!=0){       
            Decimal currentYearObjectiveQ2Q3= fBridge.Landing_year_Revenue__c + fBridge.Revenue_for_Business_Group_1__c + fBridge.Revenue_for_Business_Group_2__c + fBridge.Revenue_for_Business_Group_3__c + fBridge.Revenue_for_Business_Group_4__c;
              
             if((fBridge.Current_year_Objective_Revenue__c!=currentYearObjectiveQ2Q3) && (currentYearObjectiveQ2Q3!=0)){
                if(errorMessage ==null){ 
                    errorMessage = fBridge.Quarter__c;      
                 }
                 else{
                   errorMessage = errorMessage + ',' + fBridge.Quarter__c;
                 }
           }
       
       }
      
       }
        return errorMessage;
    }
    
    /**
    * @Description : This method is used to show the error message if current year objective does not add up to sum of Last year landing & growth/fall of categories  .
    * @param       : List of Financial Bridge
    * @return      : string
    **/  
    
    public static string checkValidityOfFinDataProfit(List<Financial_Bridge__c> finBrdgeList){
          string errorMessage=null;
           for(Financial_Bridge__c fBridge : finBrdgeList){
          if(fBridge.Landing_Year_Profit__c==null){
              fBridge.Landing_Year_Profit__c=0;
             } 
           if(fBridge.Profit_For_Business_Group_1__c==null){
              fBridge.Profit_For_Business_Group_1__c=0;
             }   
           if(fBridge.Profit_For_Business_Group_2__c==null){
              fBridge.Profit_For_Business_Group_2__c=0;
             } 
             
           if(fBridge.Profit_For_Business_Group_3__c==null){
              fBridge.Profit_For_Business_Group_3__c=0;
             }   
             
           if(fBridge.Profit_For_Business_Group_4__c==null){
              fBridge.Profit_For_Business_Group_4__c=0;
             } 
             
           if(fBridge.Current_Year_Objective_Profit__c==null){
              fBridge.Current_Year_Objective_Profit__c=0;
             }     
         
          if(fBridge.Profit_For_Business_Group_1__c!=0 || fBridge.Profit_For_Business_Group_2__c!=0 || fBridge.Profit_For_Business_Group_3__c!=0 || fBridge.Profit_For_Business_Group_4__c!=0){
          Decimal currentYearObjectiveQ1Q2= fBridge.Landing_Year_Profit__c + fBridge.Profit_For_Business_Group_1__c+ fBridge.Profit_For_Business_Group_2__c + fBridge.Profit_For_Business_Group_3__c + fBridge.Profit_For_Business_Group_4__c;
           
             if((fBridge.Current_Year_Objective_Profit__c!=currentYearObjectiveQ1Q2) && (currentYearObjectiveQ1Q2!=0)){
             
                if(errorMessage ==null){ 
                    errorMessage = fBridge.Quarter__c;      
                 }
                 else{
                   errorMessage = errorMessage + ',' + fBridge.Quarter__c;
                 }
                
             }
           
           }
         }
        return errorMessage;
    }    
            
    
   /**
    * @Description : This method is used to save the  Financial Data .
    * @param       : List of Financial Bridge
    * @return      : Boolean
    **/      

    
    public static M20_ShowResultFinancialBridgeWrapper saveGrid(List<Financial_Bridge__c> financialBridgeListQ1Q2,List<Financial_Bridge__c> financialBridgeListQ2Q3,Id finBridgeRecordtypeId){
          M20_ShowResultFinancialBridgeWrapper ShowResultFinancialBridgeWrapper;
          string finBridgeRecordtypeName=Schema.SObjectType.Financial_Bridge__c.getRecordTypeInfosById().get(finBridgeRecordtypeId).getName();
          string errorMessage=null;
          string errorMessageQ1Q2=null;
          string errorMessageQ2Q3=null;
          boolean saveRecord=true;
          boolean displayChart ;
          List<Financial_Bridge__c> updateFinancialBridgeList= new List<Financial_Bridge__c>();
          List<Financial_Bridge__c> updateFinancialBridgeListQ1Q2;
          List<Financial_Bridge__c> updateFinancialBridgeListQ2Q3;
          if(finBridgeRecordtypeName=='Revenue'){
              errorMessageQ1Q2=checkValidityOfFinDataRevenue(financialBridgeListQ1Q2);
              errorMessageQ2Q3=checkValidityOfFinDataRevenue(financialBridgeListQ2Q3);
            }
            else{
                errorMessageQ1Q2=checkValidityOfFinDataProfit(financialBridgeListQ1Q2);
                errorMessageQ2Q3=checkValidityOfFinDataProfit(financialBridgeListQ2Q3);
            }  
          if (errorMessageQ1Q2!=null && errorMessageQ2Q3!=null ){
              errorMessage=errorMessageQ1Q2+errorMessageQ2Q3;
           }   
           if(errorMessageQ1Q2== null && errorMessageQ2Q3!=null ){
              errorMessage=errorMessageQ2Q3;
            }  
           if(errorMessageQ1Q2!= null && errorMessageQ2Q3==null){
              errorMessage=errorMessageQ1Q2;
           }
           if(errorMessage==null) {  
                displayChart=true;
                if(finBridgeRecordtypeName=='Revenue'){
                    updateFinancialBridgeListQ1Q2=updateFinValueRevenue(financialBridgeListQ1Q2);
                    updateFinancialBridgeListQ2Q3=updateFinValueRevenue(financialBridgeListQ2Q3);
                    
                 }
                 else{
                      updateFinancialBridgeListQ1Q2=updateFinValueProfit(financialBridgeListQ1Q2);
                      updateFinancialBridgeListQ2Q3=updateFinValueProfit(financialBridgeListQ2Q3);
                 }
                updateFinancialBridgeList.addall(updateFinancialBridgeListQ1Q2); 
                updateFinancialBridgeList.addall(updateFinancialBridgeListQ2Q3);   
                if(updateFinancialBridgeList!=null && !updateFinancialBridgeList.isEmpty()){
                   ShowResultFinancialBridgeWrapper=M2O_FinancialBridgeDAO.saveFinancialData(updateFinancialBridgeList,finBridgeRecordtypeId);
                }
          
           } 
           else{
           
           if(finBridgeRecordtypeName=='Revenue'){
              ShowResultFinancialBridgeWrapper=new  M20_ShowResultFinancialBridgeWrapper(financialBridgeListQ1Q2,errorMessage +' this year objective does not add up to sum of Last year landing & growth/fall of categories ');
            }
            else{
                ShowResultFinancialBridgeWrapper=new  M20_ShowResultFinancialBridgeWrapper(financialBridgeListQ1Q2,errorMessage +' this year objective does not add up to sum of Last year landing & growth/fall of categories ');
               }
      
          }
          
         return ShowResultFinancialBridgeWrapper;
      }
   }