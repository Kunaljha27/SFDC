global class M2O_SAPCloneService{
    
    M2O_SAPCloneDAO daoClassObject = new M2O_SAPCloneDAO();
    
    public List<sObject> getCreatedByUser(String query,Id recordId,String queryObject,String whereParam){
        List<sObject> result = new List<sObject>();
        if(query != null){
            result = daoClassObject.getCreatedByUser(query,recordId,queryObject,whereParam);
        }
        return result;
    }
    
    public void insertClonedSAP(Strategic_Account_Plan__c clonedSAP){
        if(clonedSAP != null){
            daoClassObject.insertClonedSAP(clonedSAP); 
        }
    }
    
    public List<sObject> getChildRecords(String childQuery,ID sourceSAPID){
        List<sObject> clonedChildList = new List<sObject>();
        if(childQuery != null){
            clonedChildList = daoClassObject.getChildRecords(childQuery,sourceSAPID);
        }
        return clonedChildList;
    }
    
    public void insertClonedChild(Sobject clonedChild){
        if(clonedChild != null){
            daoClassObject.insertClonedChild(clonedChild); 
        }
    }
}