/**
@Classname :       M2O_DataUtility 
@Description :     This class will be used to define variables to be used in other classes.
@Last Modified:    29/04/2014
**/
public with sharing class M2O_DataUtility {

    
    public static final String partnerUserType = 'PowerPartner';
    public static final String accesEdit = 'Edit';
    public static final String oppShare = 'Manual';
    public static final String shareManual = 'Manual';
    public static final String forcastCategoryPipeline='Pipeline';
    public static final String stageNameNone='--None--';
    public static final String opportunityType='Multi-Modality Deal';
    public static final String regionLookup = 'Region__c';
    public static final String recordTypeLookup = 'RecordTypeId';
    public static final String sourceAccountid = 'sourceAccountid';
    public static final String recordId = 'Id';
    public static final String apiName = 'apiName';
    public static final String selectedRadioValue = 'selectedValue';
    public static final String accountObjectVal = 'Account';
    public static final String opportunityObjectVal = 'Opportunity';
    public static final String leadObjectVal = 'Lead';
    public static final String contactObjectVal = 'Contact';
    public static final String mergingString = 'is merged with Account';
    public static final String cannotMergeString = 'You cannot merge a Customer Account with';
    public static final String selectAccountToMergeString = 'Kindly select an Account to merge.';
    public static final String spaceVal = ' ';
    public static final String internationalElementObjectVal = 'International_Element__c';
    public static final String contactMatrixObjectVal = 'Contact_Matrix__c';
    public static final String PhilipsCategoryPerformanceObjectVal = 'Philips_Category_Performance__c';
    //For erorr messages in Activation Plan
    public static final String errorMsgForDateValidation = 'Start Date and End Date should fall within Strategic Account Plan From Date and To date';
    public static final String ErrorMsgForDateValueEmpty = 'Please check Strategic Account Plan and Activity From and To date fields are filed';
    public static final String lifestyleSector= 'Consumer Lifestyle';
    public static final String lightingSector= 'Lighting';
    public static final String hcnaSAPRecordType = 'HCNA GSP B2B Plan';
    public static final String retailSAPRecordType = 'Retail Plan';
    public static final String channelRecordType = 'M2O Channel Campaign';
    //For the export interval of Strategic Account Plan 
    public static final string SapExportInterval='1';
    public static String logicalSystem1='PR2400';
    public static String logicalSystem2='PR4310';
    public static String orderReasonForSample='ZSO';
    public static String statusOrderBooked='Order Booked';
    public static String QualifyMaster ='Qualify (Master)';
    public static String Qualify ='Qualify';
    public static String DevelopMaster ='Develop (Master)';
    public static String DevelopSub ='Develop';
    public static String ProposeMaster = 'Propose (Master)';
    public static String ProposeSub = 'Propose';
    public static String SalesRecognizedMaster = 'Sales Recognized (Master)';
    public static String SalesRecognizedSub = 'Sales Recognized';
    public static String DistributingMaster='Distributing (Master)';
    public static String DistributingSub = 'Order Promised';
    public static String NotPursuing = 'Not Pursuing';
    public static String CancelledbyCustomer = 'Cancelled by Customer';
    public static String Lost = 'Lost';
    public static String ProposalAcceptedMaster = 'Proposal Accepted (Master)';
    public static final String sourceSystem='Eloqua';
    
}