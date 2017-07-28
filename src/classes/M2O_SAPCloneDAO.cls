global class M2O_SAPCloneDAO{

    public List<sObject> getCreatedByUser(String query,Id recordId,String queryObject,String whereParam){
        List<sObject> result = new List<sObject>();
        try{
            if(query != null){
                result = Database.Query(query); 
            }
            return result ;
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            error=M2O_ErrorHandling.errorHandling(e);
            insert error;
            return null;
        }
    }
    
    public void insertClonedSAP(Strategic_Account_Plan__c clonedSAP){
        try{
            if(clonedSAP != null){
                Database.Insert(clonedSAP); 
            }
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            error=M2O_ErrorHandling.errorHandling(e);
            insert error;
        }
    }
    
    public List<sObject> getChildRecords(String childQuery,ID sourceSAPID){
        List<sObject> clonedChildList = new List<sObject>();
        try{
            if(childQuery != null){
                clonedChildList = Database.Query(childQuery); 
            }
            return clonedChildList;
        }
        catch (Exception e) {
           System.debug('Exception'+e);
           return null;
        }
    }
    
    public void insertClonedChild(Sobject clonedChild){
        try{
            if(clonedChild != null){
                Database.Insert(clonedChild); 
            }
        }
        catch (Exception e) {
            Error_Handling__c error = new Error_Handling__c();
            error=M2O_ErrorHandling.errorHandling(e);
            insert error;
        }
    }
    
}