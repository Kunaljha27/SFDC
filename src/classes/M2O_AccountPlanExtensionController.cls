/**
@Classname :       M2O_AccountPlanExtensionController 
@Description :     This controller will be used by six VF pages: M2O_SAPCAComponent,M2O_SAPBMCComponent,M2O_SAPCompetitorAnalyisComponent,M2O_SAPDistributionAnalyisComponent,M2O_SAPSWOTComponent and M2O_SAPObjectivesComponent.This extension controller
                   query the related compoenents of account plan show in an inline VF page. This is implemented to support sequencing of account plan components.
@Author:           
@Last Modified:    27/11/2013
**/

public with sharing class M2O_AccountPlanExtensionController {
    
    private final Strategic_Account_Plan__c sap;
    public UserRecordAccess hasaccess{get;set;}
    public String sapName{get;set;}
    public String labelId {get;set;}
    transient public List<Category_Analysis__c> catAnalysisList;
    transient public List<BMC_Analysis__c> bmcAnalysisList;
    transient public List <Competitor_Analysis__c> compAnalysisList;
    transient public List <Distribution_Analysis__c> distAnalysisList;
    transient public List <International_Element__c> internationalElementsList;
    transient public List<SWOT__c> swotAnalysisList;
    transient public List<Objective__c> objList;
    transient public List <Contact_Matrix__c> contactMatrixList;
    transient public List <Philips_Category_Performance__c> categoryPerformanceList;
    String finalQuery;
    
    
   
    
        /**Description: Controller method. Retrieve the account plan editibility for logged in user.
                 Return:  Null
        **/
        
        public M2O_AccountPlanExtensionController(ApexPages.StandardController controller) {
        
            this.sap= (Strategic_Account_Plan__c )controller.getRecord();
           
            hasaccess = new UserRecordAccess();
            Id currentUser=UserInfo.getUserId();
            hasaccess=[SELECT RecordId,HasEditAccess FROM UserRecordAccess WHERE UserId = :currentUser AND RecordId = :sap.Id limit 1];
            sapName = [Select Name from Strategic_Account_Plan__c  where id=:sap.Id].Name;
            labelId = Label.M2O_Account_Plan_CA_Field_Id;

            
        }
          
        /**
        @Description: Retrive the list of Category Analysis associated with Account plan
        @Return: List of Category Analysis
        **/
        
        public List<Category_Analysis__c> getCategoryAnalysis() {
            
            finalQuery = createQuery('Category_Analysis__c');
            finalQuery += ' FROM Category_Analysis__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            catAnalysisList = new List<Category_Analysis__c>() ;
            catAnalysisList= database.query(finalQuery);
            return catAnalysisList;
            
        }
         /**
        @Description: Retrive the list of BMC Analysis associated with Account plan
        @Return: List of BMC Analysis
        **/
        
        public List<BMC_Analysis__c> getBMCAnalysis() {
            
            finalQuery = createQuery('BMC_Analysis__c'); 
            finalQuery += ' FROM BMC_Analysis__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            bmcAnalysisList=  new List<BMC_Analysis__c>() ;
            bmcAnalysisList= database.query(finalQuery);
            return bmcAnalysisList;
    
        }
        
        /**
        @Description: Retrive the list of Competitor Analysis associated with Account plan
        @Return: List of Competitor Analysis
        **/
        
        public List<Competitor_Analysis__c> getComAnalysis() {
            
            finalQuery = createQuery('Competitor_Analysis__c'); 
            finalQuery += ' FROM Competitor_Analysis__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            compAnalysisList=  new List<Competitor_Analysis__c>() ;
            compAnalysisList= database.query(finalQuery );
            return compAnalysisList;
    
        }
        
        /**
        @Description: Retrive the list of Distribution Analysis associated with Account plan
        @Return: List of Distribution Analysis
        **/
        
        public List<Distribution_Analysis__c> getDisAnalysis() {
            
            finalQuery = createQuery('Distribution_Analysis__c'); 
            finalQuery += ' FROM Distribution_Analysis__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            distAnalysisList=  new List<Distribution_Analysis__c>() ;
            distAnalysisList= database.query(finalQuery);
            
            return distAnalysisList;
    
        }
        
        /**
        @Description: Retrive the list of SWOT Analysis associated with Account plan
        @Return: List of SWOT Analysis
        **/
        public List<SWOT__c> getSwotAnalysis() {
            
            finalQuery = createQuery('SWOT__c');
            finalQuery += ' FROM SWOT__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            swotAnalysisList=  new List<SWOT__c>() ;
            swotAnalysisList= database.query(finalQuery );
            return swotAnalysisList;
    
        }
        
        /**
        @Description: Retrive the list of Objectives/strategy/tactics Analysis associated with Account plan
        @Return: List of Objectives.
        **/
        
        public List<Objective__c> getObj() {
            
            finalQuery = createQuery('Objective__c');
            finalQuery += ' FROM Objective__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            objList=  new List<Objective__c>() ;
            objList= database.query(finalQuery );
            return objList;
    
        }
        
        /**
        @Description: Retrive the list of International Element associated with Account plan
        @Return: List of International Element
        **/
        
        public List<International_Element__c> getInternationalElement() {
            
            finalQuery = createQuery(M2O_DataUtility.internationalElementObjectVal ); 
            finalQuery += ' FROM International_Element__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            internationalElementsList=  new List<International_Element__c>() ;
            internationalElementsList= database.query(finalQuery);
            return internationalElementsList;
        }
        
        /**
        @Description: Retrive the list of Contacts of Account of Account plan
        @Return: List of Contacts
        **/
        
        public List<Contact_Matrix__c> getContactMatrix() {
            
            finalQuery = createQuery(M2O_DataUtility.contactMatrixObjectVal); 
            finalQuery += ' ,contact__r.name';
            finalQuery += ' FROM Contact_Matrix__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            contactMatrixList=  new List<Contact_Matrix__c>() ;
            contactMatrixList= database.query(finalQuery);
            return contactMatrixList;
        }
        
        
        /**
        @Description: Retrive the list of Category Performance values
        @Return: List of Category Performance
        **/
        
        public List<Philips_Category_Performance__c> getcategoryPerformance() {
            
            finalQuery = createQuery(M2O_DataUtility.PhilipsCategoryPerformanceObjectVal); 
            finalQuery += ' FROM Philips_Category_Performance__c where Strategic_Account_Plan__c=\''+sap.id+'\' order By CreatedDate';
            categoryPerformanceList=  new List<Philips_Category_Performance__c>();
            categoryPerformanceList= database.query(finalQuery);
            return categoryPerformanceList;
        }
        
        /**
        @Description: private method to build up the dynamic query for components realted to account plan 
        @Return: query string.
        **/
        private String createQuery(String objName) {
            
            String query = 'Select ';
            Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
            Schema.sObjectType sObjType = globalDescription.get(objName);  
            Schema.DescribeSObjectResult r1 = sObjType.getDescribe();  
            Map<String , Schema.SObjectField> fldObjMap = r1.fields.getMap(); 
            List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
            for(Schema.SObjectField s : fldObjMapValues)
                {               
                   String fieldName = s.getDescribe().getName();          
                   query += fieldName + ',';
                }
            query = query.subString(0, query.length() - 1); 
            return query ;
        }
        
     
        
}