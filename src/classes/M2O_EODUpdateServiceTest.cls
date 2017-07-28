@isTest(SeeAllData=true)
public Class M2O_EODUpdateServiceTest {
   
    /**
    @Description: 
    @Return: null 
    **/
    
    static testMethod void  test_eODUpdate() {
         Profile m2oSysAdmProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdmProfileId.Id);
        insert runAsUser;
      //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(m2oSysAdmProfileId.Id);
       //insert validateM2OProfile; 
       System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account acc = new Account ();
            acc = M2O_OpportunityTestDataUtility.getAccountRecord (regionData);
            insert acc;
            opportunity oppty = new opportunity ();
            oppty= M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            
            system.debug('##oppty'+oppty);
            insert oppty;
            List <Opportunity> lstOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id,runAsUser.id);
            insert lstOpportunity; 
            system.debug('@@@@@@opptylist'+lstOpportunity);
            PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
            insert prod;
            
            
            PricebookEntry pbe1 = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            insert pbe1;

            Set<id> setOppId = new Set<id>();
            for(Opportunity opp : lstOpportunity) {
                setOppId.add(opp.id);                
            }
            List<AggregateResult>  oppLineList = new List<AggregateResult> ();
            system.debug('@@setOppId'+setOppId);
            List<OpportunityLineItem> listOpp =new List<OpportunityLineItem >();
            OpportunityLineItem optyLineItem1 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            listOpp.add(optyLineItem1);
            OpportunityLineItem optyLineItem2 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            listOpp.add(optyLineItem2);
            system.debug('@@@setOppId'+setOppId);
            system.debug('####listOpp'+listOpp);
            insert listOpp;
            oppLineList=M2O_OpportunityDAO.getOpportunityLineItemForEODUpdateOnHeader(setOppId);
            system.debug('@@oppLineList'+oppLineList);
            M2O_EODUpdateService EODUpdateService = new M2O_EODUpdateService();
            EODUpdateService.eODUpdate(listOpp,setOppId);
        }
    }
     static testMethod void  test_eODUpdateOnDelete() {
          Profile m2oSysAdmProfileId = M2O_UserTestDataUtility.getM2OSystemAdminProfileId();
        User runAsUser = M2O_UserTestDataUtility.getM2OSystemAdminUserRecord(m2oSysAdmProfileId.Id);
        insert runAsUser;
      //Validate_M2O_Profiles__c validateM2OProfile = M2O_AccountContactTestDataUtility.getValidateM2OProfiles(m2oSysAdmProfileId.Id);
       //insert validateM2OProfile; 
        System.runAs(runAsUser) { 
            Region__c regionData = M2O_AccountContactTestDataUtility.getRegionData();
            insert regionData;
            Account acc = new Account ();
            acc = M2O_OpportunityTestDataUtility.getAccountRecord (regionData);
            insert acc;
            opportunity oppty = new opportunity ();
            oppty= M2O_OpportunityTestDataUtility.getOpportunityRecord(acc.id);
            system.debug('@@@oppty'+oppty);
            insert oppty;
            List <Opportunity> lstOpportunity = M2O_OpportunityTestDataUtility.getListOfOpportunityRecord(acc.id,runAsUser.id);
            insert lstOpportunity; 
            PriceBook2 pb = M2O_OpportunityTestDataUtility.getPriceBookRecord();
            Product2 prod = M2O_OpportunityTestDataUtility.getProductRecord();
            insert prod;
            
            
            PricebookEntry pbe1 = M2O_OpportunityTestDataUtility.getPBEntryRecord(prod.id, pb.id);
            insert pbe1;

            Set<id> setOppId = new Set<id>();
            for(Opportunity opp : lstOpportunity) {
                setOppId.add(opp.id);                
            }
            List<AggregateResult>  oppLineList = new List<AggregateResult> ();
            

            List<OpportunityLineItem> listOpp =new List<OpportunityLineItem >();
            OpportunityLineItem optyLineItem1 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            listOpp.add(optyLineItem1);
            OpportunityLineItem optyLineItem2 = M2O_OpportunityTestDataUtility.getOppLineItemRecord(oppty.Id, pbe1.Id); 
            listOpp.add(optyLineItem2);
            insert listOpp;
            oppLineList=M2O_OpportunityDAO.getOpportunityLineItemForEODUpdateOnHeader(setOppId);
            M2O_EODUpdateService EODUpdateService = new M2O_EODUpdateService();
            EODUpdateService.eODUpdateOnDelete(listOpp,setOppId);
        }            
     }
    
}