/**
* @ClassName         : M2O_FinancialBridgeTestDataUtility
* @Description       : This is utility class for storing the test data of Financial Bridge.
* @Author            : Srutadeba Chanda
* @Last Modified     : 28/11/2013
* @Discussionpoints  : No Information
*/

public class M2O_FinancialBridgeTestDataUtility {

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
       
        return testStrategicAccountPlanRecord;
    }
    
    /**
    * @Description : This method creates Financial Bridge Revenue record.
    * @param       : Id of Strategic Account Plan
    * @return      : List of Financial Bridge records
    **/    
        public static List<Financial_Bridge__c> getFinancialBridgeRevenueRecord(Id strategicAccountPlanId){
        List<Financial_Bridge__c> lstFinBridge=new List<Financial_Bridge__c>();
        Id revenueRecordType=Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Revenue').RecordTypeId;
        Financial_Bridge__c fBridgeRevenueQ1=new Financial_Bridge__c();
        fBridgeRevenueQ1.Quarter__c='AOP';
        fBridgeRevenueQ1.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeRevenueQ1.Current_Year_Objective_Revenue__c=140.00;
        fBridgeRevenueQ1.Landing_Year_Revenue__c=100.00;
        fBridgeRevenueQ1.Key_Activities_1_For_Business_Group_1__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_1_For_Business_Group_2__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_1_For_Business_Group_3__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_1_For_Business_Group_4__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_2_For_Business_Group_1__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_2_For_Business_Group_2__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_2_For_Business_Group_3__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_2_For_Business_Group_4__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_3_For_Business_Group_1__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_3_For_Business_Group_2__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_3_For_Business_Group_3__c='test Activities';
        fBridgeRevenueQ1.Key_Activities_3_For_Business_Group_4__c='test Activities';
        fBridgeRevenueQ1.Revenue_For_Business_Group_1__c=10.00;
        fBridgeRevenueQ1.Revenue_For_Business_Group_2__c=10.00;
        fBridgeRevenueQ1.Revenue_For_Business_Group_3__c=10.00;
        fBridgeRevenueQ1.Revenue_For_Business_Group_4__c=10.00;
        fBridgeRevenueQ1.Revenue_Percent_Business_Group_4__c=10;
        fBridgeRevenueQ1.recordtypeId=revenueRecordType;
        lstFinBridge.add(fBridgeRevenueQ1);
        
        Financial_Bridge__c fBridgeRevenueQ2=new Financial_Bridge__c();
        fBridgeRevenueQ2.Quarter__c='End of Q1';
        fBridgeRevenueQ2.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeRevenueQ2.Current_Year_Objective_Revenue__c=140.00;
        fBridgeRevenueQ2.Landing_Year_Revenue__c=100.00;
        fBridgeRevenueQ2.Revenue_For_Business_Group_1__c=10.00;
        fBridgeRevenueQ2.Revenue_For_Business_Group_2__c=10.00;
        fBridgeRevenueQ2.Revenue_For_Business_Group_3__c=10.00;
        fBridgeRevenueQ2.Revenue_For_Business_Group_4__c=10.00;
        fBridgeRevenueQ2.recordtypeId=revenueRecordType;
        lstFinBridge.add(fBridgeRevenueQ2);
        Financial_Bridge__c fBridgeRevenueQ3=new Financial_Bridge__c();
        fBridgeRevenueQ3.Quarter__c='End of Q2';
        fBridgeRevenueQ3.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeRevenueQ3.Current_Year_Objective_Revenue__c=140.00;
        fBridgeRevenueQ3.Landing_Year_Revenue__c=100.00;
        fBridgeRevenueQ3.Revenue_For_Business_Group_1__c=10.00;
        fBridgeRevenueQ3.Revenue_For_Business_Group_2__c=10.00;
        fBridgeRevenueQ3.Revenue_For_Business_Group_3__c=10.00;
        fBridgeRevenueQ3.Revenue_For_Business_Group_4__c=10.00;
        fBridgeRevenueQ3.Revenue_Percent_Business_Group_4__c=10;
        fBridgeRevenueQ3.recordtypeId=revenueRecordType;
        lstFinBridge.add(fBridgeRevenueQ3);
        Financial_Bridge__c fBridgeRevenueQ4=new Financial_Bridge__c();
        fBridgeRevenueQ4.Quarter__c='End of Q3';
        fBridgeRevenueQ4.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeRevenueQ4.Current_Year_Objective_Revenue__c=140.00;
        fBridgeRevenueQ4.Landing_Year_Revenue__c=100.00;
        fBridgeRevenueQ4.Revenue_For_Business_Group_1__c=10.00;
        fBridgeRevenueQ4.Revenue_For_Business_Group_2__c=10.00;
        fBridgeRevenueQ4.Revenue_For_Business_Group_3__c=10.00;
        fBridgeRevenueQ4.Revenue_For_Business_Group_4__c=10.00;
        fBridgeRevenueQ4.recordtypeId=revenueRecordType;
        lstFinBridge.add(fBridgeRevenueQ4);
     
        return lstFinBridge;  
    }
    /**
    * @Description : This method creates Financial Bridge Profit record.
    * @param       : Id of Strategic Account Plan
    * @return      : List of Financial Bridge records
    **/    
    
      public static List<Financial_Bridge__c> getFinancialBridgeProfitRecord(Id strategicAccountPlanId){
        List<Financial_Bridge__c> lstFinBridge=new List<Financial_Bridge__c>();
        Id profitRecordType= Schema.SObjectType.Financial_Bridge__c.RecordTypeInfosByName.get('Profit').RecordTypeId;
        Financial_Bridge__c fBridgeProfitQ1=new Financial_Bridge__c();
        fBridgeProfitQ1.Quarter__c='AOP';
        fBridgeProfitQ1.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeProfitQ1.Current_Year_Objective_Profit__c=140.00;
        fBridgeProfitQ1.Landing_Year_Profit__c=100.00;
        fBridgeProfitQ1.Key_Activities_1_For_Business_Group_1__c='test Activities';
        fBridgeProfitQ1.Key_Activities_1_For_Business_Group_2__c='test Activities';
        fBridgeProfitQ1.Key_Activities_1_For_Business_Group_3__c='test Activities';
        fBridgeProfitQ1.Key_Activities_1_For_Business_Group_4__c='test Activities';
        fBridgeProfitQ1.Key_Activities_2_For_Business_Group_1__c='test Activities';
        fBridgeProfitQ1.Key_Activities_2_For_Business_Group_2__c='test Activities';
        fBridgeProfitQ1.Key_Activities_2_For_Business_Group_3__c='test Activities';
        fBridgeProfitQ1.Key_Activities_2_For_Business_Group_4__c='test Activities';
        fBridgeProfitQ1.Key_Activities_3_For_Business_Group_1__c='test Activities';
        fBridgeProfitQ1.Key_Activities_3_For_Business_Group_2__c='test Activities';
        fBridgeProfitQ1.Key_Activities_3_For_Business_Group_3__c='test Activities';
        fBridgeProfitQ1.Key_Activities_3_For_Business_Group_4__c='test Activities';
        fBridgeProfitQ1.Profit_For_Business_Group_1__c=10.00;
        fBridgeProfitQ1.Profit_For_Business_Group_2__c=10.00;
        fBridgeProfitQ1.Profit_For_Business_Group_3__c=10.00;
        fBridgeProfitQ1.Profit_For_Business_Group_4__c=10.00;
        fBridgeProfitQ1.Profit_In_Percent_Business_Group_4__c=10;
        fBridgeProfitQ1.recordtypeId=profitRecordType ;
        lstFinBridge.add(fBridgeProfitQ1);
        
        Financial_Bridge__c fBridgeProfitQ2=new Financial_Bridge__c();
        fBridgeProfitQ2.Quarter__c='End of Q1';
        fBridgeProfitQ2.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeProfitQ2.Current_Year_Objective_Profit__c=140.00;
        fBridgeProfitQ2.Landing_Year_Profit__c=100.00;
        fBridgeProfitQ2.Profit_For_Business_Group_1__c=10.00;
        fBridgeProfitQ2.Profit_For_Business_Group_2__c=10.00;
        fBridgeProfitQ2.Profit_For_Business_Group_3__c=10.00;
        fBridgeProfitQ2.Profit_For_Business_Group_4__c=10.00;
        fBridgeProfitQ2.recordtypeId=profitRecordType ;
        lstFinBridge.add(fBridgeProfitQ2);
        Financial_Bridge__c fBridgeProfitQ3=new Financial_Bridge__c();
        fBridgeProfitQ3.Quarter__c='End of Q2';
        fBridgeProfitQ3.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeProfitQ3.Current_Year_Objective_Profit__c=140.00;
        fBridgeProfitQ3.Landing_Year_Profit__c=100.00;
        fBridgeProfitQ3.Profit_For_Business_Group_1__c=10.00;
        fBridgeProfitQ3.Profit_For_Business_Group_2__c=10.00;
        fBridgeProfitQ3.Profit_For_Business_Group_3__c=10.00;
        fBridgeProfitQ3.Profit_For_Business_Group_4__c=10.00;
      
        fBridgeProfitQ3.recordtypeId=profitRecordType; 
        lstFinBridge.add(fBridgeProfitQ3);
        Financial_Bridge__c fBridgeProfitQ4=new Financial_Bridge__c();
        fBridgeProfitQ4.Quarter__c='End of Q3';
        fBridgeProfitQ4.Strategic_Account_Plan__c=strategicAccountPlanId;
        fBridgeProfitQ4.Current_Year_Objective_Profit__c=140.00;
        fBridgeProfitQ4.Landing_Year_Profit__c=100.00;
        fBridgeProfitQ4.Profit_For_Business_Group_1__c=10.00;
        fBridgeProfitQ4.Profit_For_Business_Group_2__c=10.00;
        fBridgeProfitQ4.Profit_For_Business_Group_3__c=10.00;
        fBridgeProfitQ4.Profit_For_Business_Group_4__c=10.00;
        fBridgeProfitQ4.recordtypeId=profitRecordType;
        lstFinBridge.add(fBridgeProfitQ4);
     
        return lstFinBridge;  
    }

     
    /**
    * @Description : This method creates Financial Bridge Business groups.
    * @param       : None 
    * @return      : Financial Bridge Business Group records
    **/    
    public static M2O_Financial_Bridge_Business_Group__c getBusinessGrp(){
        M2O_Financial_Bridge_Business_Group__c businessGrpName= new M2O_Financial_Bridge_Business_Group__c();
        businessGrpName.Business_Group_1__c='BG1';
        businessGrpName.Business_Group_2__c='BG2';
        businessGrpName.Business_Group_3__c='BG3';
        businessGrpName.Business_Group_4__c='BG4';
        businessGrpName.Name='Product based plan(direct)';
        return businessGrpName;
    
    }
    
     /**
    * @Description : This method creates Currency record.
    * @param       : None
    * @return      : List of Currency Symbol records
    **/    
     public static List<M2O_CurrencySymbol__c> getCurrencyRecord(){
         List<M2O_CurrencySymbol__c> currecyList=new List<M2O_CurrencySymbol__c>();
         M2O_CurrencySymbol__c Currency1= new M2O_CurrencySymbol__c();
         Currency1.Symbol__c='€';
         Currency1.name='EUR';
         currecyList.add(Currency1);
         M2O_CurrencySymbol__c Currency2= new M2O_CurrencySymbol__c();
         Currency2.Symbol__c='₹';
         Currency2.name='INR';
         currecyList.add(Currency2);
        return currecyList;
       
     }
}