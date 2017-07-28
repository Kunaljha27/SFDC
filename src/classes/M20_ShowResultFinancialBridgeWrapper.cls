/**
@Classname :       M20_ShowResultFinancialBridgeWrapper
@Description :     
@Last Modified:    
**/ 

global class  M20_ShowResultFinancialBridgeWrapper{
        public List<Financial_Bridge__c> finacialBridgeData;
        public string errorMessage;
        
        public M20_ShowResultFinancialBridgeWrapper(List<Financial_Bridge__c> finacialBridgeData,string errorMessage){
            this.finacialBridgeData= finacialBridgeData;
            this.errorMessage= errorMessage;
            
        }
               
          
      
}