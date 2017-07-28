/**
* @ClassName         : M2O_ActivationPlanTestDataUtility 
* @Description       : This is utility class for storing the test data of Activation Plan.
* @Author            : Albin Deni Arul 
* @Last Modified     : 2/12/2013
* @Discussion points : No Information
*/
public class M2O_ActivationPlanTestDataUtility {
    
    /**
    * @Description : This method creates Account record.
    * @param       : None
    * @return      : Account records.
    **/ 
    
    public static Account getAccountRecord() {
       Account testAccountRecord=new Account(name='Test',BillingState='TE', BillingCity='Test', BillingStreet='Test', BillingCountry='CA',country__c='Albania', CL_Account_Classification__c='A', HC_Account_Classification__c='A', LI_Account_Classification__c='A',Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN');
       return testAccountRecord;
    }
    
    /**
    * @Description : This method creates Strategic Account Plan record.
    * @param       : None
    * @return      : Strategic account Plan record
    **/     
     public static Strategic_Account_Plan__c getStrategicAccountPlanRecord() {
        Strategic_Account_Plan__c testStrategicAccountPlanRecord=new Strategic_Account_Plan__c();
        testStrategicAccountPlanRecord.name='Test';
        testStrategicAccountPlanRecord.From_Date__c=system.today();
        testStrategicAccountPlanRecord.To_Date__c=system.today()+10;
        testStrategicAccountPlanRecord.currencyIsoCode='EUR';
        testStrategicAccountPlanRecord.recordtypeID=system.label.M2O_StrategicAccountPlan_RecordType;
        testStrategicAccountPlanRecord.philips_sector__c = 'Lighting';
        return testStrategicAccountPlanRecord;
     }    
   
    /**
    * @Description : This method creates Activation Plan attachment record.
    * @param       : Id of Strategic Account Plan
    * @return      : Activation Plan record
    **/ 
    public static Activation_Plan__c getActivationPlanAttachmentRecord(Id strategicAccountPlanId) {
        Activation_Plan__c testActivationPlanAttachmentRecord= new Activation_Plan__c(); 
        testActivationPlanAttachmentRecord.Isdummyrecord__c=true;
        testActivationPlanAttachmentRecord.Activity_Detail__c='Test Activity';
        testActivationPlanAttachmentRecord.Activity_End_Date__c=system.today()+2;
        testActivationPlanAttachmentRecord.Activity_Start_Date__c=system.today();
        testActivationPlanAttachmentRecord.Activity_Status__c='Proposed';
        testActivationPlanAttachmentRecord.Category__c='Personal Care';
        testActivationPlanAttachmentRecord.Strategic_Account_Plan__c=strategicAccountPlanId;
        testActivationPlanAttachmentRecord.Type__c='Above the line activities';
        return testActivationPlanAttachmentRecord;
    }
   
    /**
    * @Description : This method creates Activation Plan record.
    * @param       : Id of strategic Account Plan
    * @return      : Activation Plan record
    **/ 
     public static  Activation_Plan__c getActivationPlanRecord(Id strategicAccountPlanId) {

        Activation_Plan__c testActivationPlanRecord= new Activation_Plan__c(); 
        testActivationPlanRecord.Isdummyrecord__c=false;
        testActivationPlanRecord.Activity_Detail__c='Test Activity';
        testActivationPlanRecord.Activity_End_Date__c= system.today()+8 ;
        testActivationPlanRecord.Activity_Start_Date__c=system.today();
        testActivationPlanRecord.Activity_Status__c='Proposed';
        testActivationPlanRecord.Category__c='Personal Care';
        testActivationPlanRecord.Strategic_Account_Plan__c=strategicAccountPlanId;
        testActivationPlanRecord.Type__c='Above the line activities';
        testActivationPlanRecord.recordtypeid = Schema.SObjectType.Activation_Plan__c.getRecordTypeInfosByName().get('M2O Lighting').getRecordTypeId();
        return testActivationPlanRecord;
    }
   
    /**
    * @Description : This method creates Activation Plan record with Diff.
    * @param       : Id of strategic Account Plan
    * @return      : Activation Plan record
    **/     
     public static  Activation_Plan__c getActivationPlanRecordDiff(Id strategicAccountPlanId) {
        Activation_Plan__c activationPlanToPassDiff= new Activation_Plan__c();
        activationPlanToPassDiff.Activity_Detail__c='Test Activity';
        activationPlanToPassDiff.Activity_End_Date__c=system.today()+30;
        activationPlanToPassDiff.Activity_Start_Date__c=system.today();
        activationPlanToPassDiff.Activity_Status__c='Proposed';
        activationPlanToPassDiff.Category__c='Personal Care';
        activationPlanToPassDiff.Strategic_Account_Plan__c=strategicAccountPlanId;
        activationPlanToPassDiff.Type__c='Above the line activities';
        return activationPlanToPassDiff;
    }
    
    /**
    * @Description : This method creates Activation Plan record without required fields.
    * @param       : None
    * @return      : Activation Plan record
    **/     
     public static  Activation_Plan__c getActivationPlanWithoutRequiredFields() {
         Activation_Plan__c activationPlanWithoutRequiredFields= new Activation_Plan__c();
         activationPlanWithoutRequiredFields.Activity_Status__c='Proposed';
         return activationPlanWithoutRequiredFields;
     }
    
    /**
    * @Description : This method creates Attachment record.
    * @param       : Id of strategic Account Plan
    * @return      : Attachment record
    **/      
     public static  Attachment getAttachmentRecord(Id strategicAccountPlanId) {
         Attachment testAttachmentRecord = New Attachment();
         testAttachmentRecord.name='test';
         testAttachmentRecord.body=blob.valueof('test');
         testAttachmentRecord.parentId=strategicAccountPlanId;
         return testAttachmentRecord;
     }
    
   

   
}