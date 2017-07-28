public without sharing class M2O_CommercialPolicyHeaderController{
    public Commercial_policy__c policyList{get;set;}
    public List<AggregateResult> budgetList{get;set;}
    public String externalReferenceName{get;set;}
    public Id recordId{get;set;}
    public Id accountId;
    public String createdTime{get;set;}
    public String createdBy{get;set;}
    public String createdById;
    public User usrRec;
    
     public M2O_CommercialPolicyHeaderController(ApexPages.StandardController controller) {
     if(ApexPages.currentPage().getParameters().get('Id') != null) {
         recordId = ApexPages.currentPage().getParameters().get('Id'); 
         }try{
         accountId =[select account__c from Commercial_Policy__c where id =: recordid].account__c;
         if(accountId != null){
         externalReferenceName = [select id,name,Local_Business_Partner_ID__c from Account_External_Reference__c where account__c =: accountId and Logical_System_Name__c = 'CP4'].Local_Business_Partner_ID__c;
         }
         if(externalReferenceName == null) {
             externalReferenceName = '';
         }
         }catch(Exception e){}
         getPolicyRecords();
         getBudgetrecords();
     }
    
     public void getPolicyRecords(){
        policyList = new Commercial_policy__c();
        policyList=[select LastModifiedDate,name,id,owner.name,account__r.CurrencyIsoCode,account__r.name,account__r.City_Local__c,account__r.Street1_Local__c,account__r.Golden_Record_Key__c from Commercial_Policy__c where Id =: recordId limit 1];
    }
    
    public void getBudgetrecords(){
        budgetList = new List<AggregateResult>();
        usrRec = new User();
        budgetList=[select MAX(LastModifiedDate) max, LastModifiedById from Budget_AOP_View__c where Commercial_Policy__c =: recordId Group BY LastModifiedById limit 1];
        if(budgetList != null && !budgetList.isEmpty()){
            for(AggregateResult agrRec : budgetList){
                createdTime = String.valueOf(agrRec.get('max'));
                createdById = String.valueOf(agrRec.get('LastModifiedById'));
            }
            usrRec =[select name from User where Id =: createdById];
            createdBy = usrRec.Name;
        }
    }
}