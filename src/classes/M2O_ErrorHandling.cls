/**
* @ClassName <M2O_ErrorHandling>
* @Description <This class is the Error Handling class for M2O>
* @Author <Somdev Bhattacharyya>
* @Last Modified <25/07/2014>
* @Discussionpoints <No Information>
*/
public with sharing class M2O_ErrorHandling {
    /**
    * @Description : This method performs error handling.
    * @param       : Exception .
    * @return      : Void.
    **/
    public static Error_Handling__c errorHandling (Exception e) {
        Error_Handling__c error = new Error_Handling__c();
            for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
                error.Exception__c=e.getDmlMessage(i);
            }    
        return error;
    }
}