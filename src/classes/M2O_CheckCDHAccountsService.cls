/**
@Classname :       M2O_CaptureDeleteRecordsService
@Description :     
@Author:           Vishal Kashyap
@Last Modified:    11/15/2013
**/

public class M2O_CheckCDHAccountsService {
    /**
    * @Description : This trigger checks the Is CDH interfaced Check box on Account for CDH interfaced accounts.
    * @param       : List of New Accounts Triggered.
    * @return      : null.
    **/
    public static void checkCDHAccounts(List<Account> newTrigger){
        Map<String,M2O_CDH_Applicable_Countries__c> appCountries= new Map<String,M2O_CDH_Applicable_Countries__c>();
        appCountries = M2O_CDH_Applicable_Countries__c.getall();
        Map<String,M2O_Record_Types_Not_Interfaced__c> appRecordType= M2O_Record_Types_Not_Interfaced__c.getAll();
        Set<Id> accIdToRecordTypeNameList = new Set<Id>();
        CDH_Interfaced_Profiles__c interfacedProfile = CDH_Interfaced_Profiles__c.getInstance(UserInfo.getprofileId());
        Map<String, Schema.SObjectType> sObjectMap = Schema.getGlobalDescribe() ;
        Schema.SObjectType s = sObjectMap.get('Account') ;
        Schema.DescribeSObjectResult resSchema = s.getDescribe() ;
        Id integrationProfileId = M2O_CheckCDHAccountsDAO.dataMigrationID();
        Id rtId;
        
        //getting all Recordtype for the Sobject
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = resSchema.getRecordTypeInfosByName(); 
        for(String recTypeID : appRecordType.KeySet()) {
            accIdToRecordTypeNameList.add(recTypeID);
        }
        
        system.debug('integrationProfileId****'+integrationProfileId);
        try{
            for(Account accObj: newTrigger) {
            
            //checking for all the applicable condtitons to update the flag
            If(accObj.Is_CDH_Interfaced__c==false){
                if(appCountries.get(accObj.Country__c).Is_Applicable__c==True && interfacedProfile.Is_Interfaced__c== true){
                    if((!accIdToRecordTypeNameList.contains(accObj.RecordTypeId))){
                        accObj.Is_CDH_Interfaced__c= true;
                    }
                }
            }
             
             // reset the is CDH interfaced flag once account is updated by integration user.
                if(trigger.isUpdate) {
                    if(UserInfo.getProfileId() == integrationProfileId && accObj.Is_CDH_Interfaced__c==true ) {
                        
                            accObj.Is_CDH_Interfaced__c= false;             
                    }
                }
            }
        }catch(Exception e) {
        
            system.debug('Error while updating Accounts'+e.getMessage());
        }
    }
}