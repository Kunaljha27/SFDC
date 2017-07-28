/**
* @ClassName         : M2O_SAPTestDataUtility
* @Description       : This is utility class for storing the test data of related objects for strategic account plan .
* @Author            : srutadeba Chanda
* @Last Modified     : 2/12/2013
* @Discussion points : No Information
*/

public class M2O_SAPTestDataUtility {
   
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
        
        return testStrategicAccountPlanRecord;
     } 
     
     public static List<Category_Analysis__c> getCategoryAnalysis(id SAPId){
         list<Category_Analysis__c> categoryAnalysisList= new List<Category_Analysis__c>();
         Category_Analysis__c categoryAnalysisObj;
         for(integer i=0; i<50;i++){
            categoryAnalysisObj= new Category_Analysis__c();
             categoryAnalysisObj.Company__c='Company name'+i;
             categoryAnalysisObj.Strategic_Account_Plan__c=SAPId;
             categoryAnalysisObj.Category_Analysis__c='Personal Care';
             categoryAnalysisList.add(categoryAnalysisObj);
             
         }
         return categoryAnalysisList;
     } 
     
      public static List<Competitor_Analysis__c> getCompetitorAnalysis(id SAPId){
          list<Competitor_Analysis__c> CompetitorAnalysisList= new List<Competitor_Analysis__c>();
         Competitor_Analysis__c competitorAnalysisObj;
         for(integer i=0; i<50;i++){
            competitorAnalysisObj= new Competitor_Analysis__c();
             competitorAnalysisObj.Brand_1__c='Brand 1'+i;
             competitorAnalysisObj.Strategic_Account_Plan__c=SAPId;
             competitorAnalysisObj.Conclusions_Competitors__c='conclusions competitors';
             CompetitorAnalysisList.add(competitorAnalysisObj);
      
          } 
          return CompetitorAnalysisList;
       }
       
      public static List<SWOT__c> getSWOT(id SAPId){
          list<SWOT__c> SWOTList= new List<SWOT__c>();
         SWOT__c SWOTObj;
         for(integer i=0; i<50;i++){
            SWOTObj= new SWOT__c();
             SWOTObj.Customer_Opportunities__c='customer Opportunity'+i;
             SWOTObj.Strategic_Account_Plan__c=SAPId;
             SWOTObj.Customer_Threats__c='test threat';
             SWOTList.add(SWOTObj);
      
          } 
          return SWOTList;
       }   
       
      public static List<BMC_Analysis__c> getBMCAnalysis(id SAPId){
          list<BMC_Analysis__c> BMCAnalysisList= new List<BMC_Analysis__c>();
         BMC_Analysis__c BMCAnalysisObj;
         for(integer i=0; i<50;i++){
             BMCAnalysisObj= new BMC_Analysis__c();
             BMCAnalysisObj.Philips_Priority_BMC__c='philips priority analysis'+i;
             BMCAnalysisObj.Strategic_Account_Plan__c=SAPId;
             BMCAnalysisObj.Priority_BMC_Objective__c='test BMC objectives';
             BMCAnalysisList.add(BMCAnalysisObj);
      
          } 
          return BMCAnalysisList;
       }   
       
        public static List<Distribution_Analysis__c> getDistributionAnalysis(id SAPId){
          list<Distribution_Analysis__c> DistributionAnalysisList= new List<Distribution_Analysis__c>();
         Distribution_Analysis__c DistributionAnalysisObj;
         for(integer i=0; i<50;i++){
             DistributionAnalysisObj= new Distribution_Analysis__c();
             DistributionAnalysisObj.Key_Product_1__c='Key Product'+i;
             DistributionAnalysisObj.Strategic_Account_Plan__c=SAPId;
             DistributionAnalysisObj.Category__c='Domestic Appliances';
             DistributionAnalysisList.add(DistributionAnalysisObj);
      
          } 
          return DistributionAnalysisList;
       }   
       
        public static List<Objective__c> getObjective(id SAPId){
          list<Objective__c> ObjectiveList= new List<Objective__c>();
         Objective__c objectiveObj;
         for(integer i=0; i<50;i++){
             objectiveObj= new Objective__c();
             objectiveObj.Key_Objective__c='Key Objective'+i;
             objectiveObj.Strategic_Account_Plan__c=SAPId;
             objectiveObj.Category__c='Domestic Appliances';
             ObjectiveList.add(objectiveObj);
      
          } 
          return ObjectiveList;
       }   

}