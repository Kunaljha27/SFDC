/**
@Classname :       M20_ShowResultFinancialTrackingWrapper
@Description :     
@Last Modified:    
**/ 

global class  M20_ShowResultFinancialTrackingWrapper{
        public List<Financial_Tracking__c> finacialTrackingData;
        public string errorMessage;
        
        public M20_ShowResultFinancialTrackingWrapper(List<Financial_Tracking__c> finacialTrackingData,string errorMessage){
            this.finacialTrackingData= finacialTrackingData;
            this.errorMessage= errorMessage;
            
        }
 
}