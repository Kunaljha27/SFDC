/**
* @ClassName :M2O_FinancialBridgeDAO
* @Description : This class is the DAO class of financial bridge to perform all the soql and the DML operation 
* @Author : Srutadeba Chanda 
* @Last Modified : 29/11/2013
* @Discussionpoints : No Information
*/

public class M2O_FinancialBridgeDAO{
    /**
    * @Description : This method get the master strategic Account Plan record for the Financial Bridge
    * @param       : Strategic Account Plan Id 
    * @return      : record for Strategic Account Plan
    **/ 
     public static Strategic_Account_Plan__c querySapRecord(Id SapRecordID) {
        Strategic_Account_Plan__c SapRecord= new Strategic_Account_Plan__c();
        try {
            SapRecord=[select To_Date__c,From_Date__c,recordtype.Name,Philips_Sector__c, CurrencyIsoCode  from Strategic_Account_Plan__c where id =:SapRecordID limit 1];
            return SapRecord;
        }
        catch(QueryException e){
            system.debug('No strategic Account Plan data found'+e.getMessage());
            return null;
         }   
     }
     
    /**
    * @Description : This method get the user access information to edit the Financial Bridge record 
    * @param       : Running user Id, Strategic Account Plan Id
    * @return      : record of type UserRecordAccess
    **/ 
     public Static UserRecordAccess queryUserAccess(Id currentUser, Id sapRecordID){
        UserRecordAccess hasaccess= new UserRecordAccess();
        try {
            hasaccess=[SELECT RecordId,HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUser AND RecordId = :SapRecordID limit 1];
            return hasaccess;
        }
        catch(QueryException e){
             system.debug('Fail to Query on user Access on Strategic Account Plan'+e.getMessage());
             return null;
         }   
    }
  
    /**
    * @Description : This method is used to get the fields for Profit 
    * @param       : None
    * @return      : List of Schema.FieldSetMember
    **/     
    
     public Static List<Schema.FieldSetMember> getFieldsProfit() {
        try {
             return SObjectType.Financial_Bridge__c.FieldSets.M2O_FinancialBridgeProfit_Fieldset.getFields();
        }
        catch(Exception e) {
             system.debug('Fail to return FieldsProfit'+e.getMessage());
             return null;
        }
      }
      
      /**
    * @Description : This method is used to get the fields for Revenue 
    * @param       : None
    * @return      : List of Schema.FieldSetMember
    **/     
    
    public Static List<Schema.FieldSetMember> getFieldsRevenue() {
        try {
            return SObjectType.Financial_Bridge__c.FieldSets.M2O_FinancialBridgerevenue_Fieldset.getFields();
        }
        catch(Exception e) {
            system.debug('Fail to return FieldsRevenue'+e.getMessage());
            return null;
        }
    }
      
      /**
    * @Description : This method is used to get the Financial Data 
    * @param       : None
    * @return      : List of Financial_Bridge__c
    **/ 
   
    public static List<Financial_Bridge__c> getFinancialData(string quarter,Id sapRecordID, Id finBridgeRecordtype ){
        List<Financial_Bridge__c> financialBridgeList= new List<Financial_Bridge__c>();
        string firstQuerySection;
        string queryString;
        firstQuerySection= 'SELECT ';
        if(Schema.SObjectType.Financial_Bridge__c.getRecordTypeInfosById().get(finBridgeRecordtype).getName()=='Revenue'){
            for(Schema.FieldSetMember fieldSet : getFieldsRevenue()) {
                firstQuerySection +=fieldSet.getFieldPath() +  ', ';
            }
            queryString=firstQuerySection + ' Id from Financial_Bridge__c where Strategic_Account_Plan__c=:sapRecordID and recordtypeid=:finBridgeRecordtype and Quarter__c in '+ quarter +' order by Quarter__c ASC limit 8';
            try {
                financialBridgeList=database.query(queryString);   
                return financialBridgeList; 
            }
            catch(QueryException e) {
                system.debug('Fail to Query on Financial Bridge on Strategic Account Plan'+e.getMessage());
                return null;
            }
        }
        else {
            for(Schema.FieldSetMember fieldSet : getFieldsProfit()) {
                firstQuerySection +=fieldSet.getFieldPath() +  ', ';
            }
            queryString=firstQuerySection + ' Id from Financial_Bridge__c where Strategic_Account_Plan__c=:sapRecordID and recordtypeid=:finBridgeRecordtype and Quarter__c in '+ quarter +' order by Quarter__c ASC limit 8';
            try {
                financialBridgeList=database.query(queryString);   
                return financialBridgeList; 
            }
            catch(QueryException e) {
                system.debug('Fail to Query on Financial Bridge on Strategic Account Plan'+e.getMessage());
                return null;
            }
        }
    }
    
    /**
    * @Description : This method is used to save the  Financial Data .
    * @param       : List of Financial Bridge
    * @return      : none
    **/      
    
    public static M20_ShowResultFinancialBridgeWrapper saveFinancialData(List<Financial_Bridge__c> saveFinBridgeList, Id finBridgeRecordtype ){
       M20_ShowResultFinancialBridgeWrapper ShowResultFinancialBridgeWrapper;
       string recordtypeName=Schema.SObjectType.Financial_Bridge__c.getRecordTypeInfosById().get(finBridgeRecordtype).getName();
        try{
           if(saveFinBridgeList!=null && !saveFinBridgeList.isEmpty()){
                update saveFinBridgeList;
                ShowResultFinancialBridgeWrapper= new M20_ShowResultFinancialBridgeWrapper(saveFinBridgeList,null);
            }
            
        }
        catch(System.DmlException e){
        if(recordtypeName=='Revenue'){
             
             ShowResultFinancialBridgeWrapper= new M20_ShowResultFinancialBridgeWrapper(saveFinBridgeList,e.getDmlMessage(0));
             system.debug('Update of Financial Bridge Revenue failed'+ e.getDmlMessage(0));
          }
          else{

             ShowResultFinancialBridgeWrapper= new M20_ShowResultFinancialBridgeWrapper(saveFinBridgeList,e.getDmlMessage(0));
              system.debug('Update of Financial Bridge Profit failed'+ e.getDmlMessage(0));
          }
         
        }
         return ShowResultFinancialBridgeWrapper; 
     }   
    
    
    
}