/**
@Classname :       M20_AccountRecordWrapper
@Description :     Used for storing values in non- CDH fields which will be used to display 
                   in VF page. It is also used for sorting the field label in the VF page.
@Author:           Piyali Saha
@Last Modified:    23/08/2013
**/ 

global class M20_AccountRecordWrapper implements Comparable{
        public String fieldName                         {get; set;}
        public String apiName                           {get; set;}
        public Object sourceAccountFieldValue           {get; set;}
        public Object destinationAccountFieldValue      {get; set;}
        
        public M20_AccountRecordWrapper(String fieldName, String apiName, String sourceAccountFieldValue, String destinationAccountFieldValue){
            this.fieldName = fieldName;
            this.apiName = apiName;
            this.sourceAccountFieldValue = sourceAccountFieldValue;
            this.destinationAccountFieldValue = destinationAccountFieldValue; 
            
        }
        global Integer compareTo(Object objToCompare) {        
            return fieldName.compareTo(((M20_AccountRecordWrapper)objToCompare).fieldName);          
          
        }
}