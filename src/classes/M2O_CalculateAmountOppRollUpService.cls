/**
@Classname :     M2O_CalculateAmountOppRollUpService
@Description :   Calculates the amount on the sub opportunity and rolls it up to master opportunity. The calculation is
                 done on the default currency of the master Opportunity
@Author:         Piyali Saha
@Last Modified:  09/12/2013
**/
public class M2O_CalculateAmountOppRollUpService {
    
    /**
    @Description: Updates the Sub Opportunity Total Amount field whenever an new Sub Opportunity is inserted
    @param:       Map of Opportunity Id and and it's related Opportunity record.
    @Return:      null
    **/
    
    public void insertOpportunityMasterAmount(Map<id, Opportunity> mapNewSubOpportunities) {
        Map<id, Opportunity> mapMasterOpportunity;
        Map<id,id> mapSubMasterOpportunityId = new Map<id,id>();/*Sub and master opportunity id */
        Set<id> setMasterOpportunityId = new Set<id>();/*master opportunity id*/
        Set<String> setCurrencyCode = new Set<String>(); /*codes of the currency*/   
        for(Opportunity opp: mapNewSubOpportunities.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
            setMasterOpportunityId.add(opp.Opportunity_Hierarchy_Link__c);
            mapSubMasterOpportunityId.put(opp.id, opp.Opportunity_Hierarchy_Link__c);
        }
        //Retrieves the master opportunity data from the database
        mapMasterOpportunity = getMasterOpportunity(setMasterOpportunityId);
        for(Opportunity opp : mapMasterOpportunity.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
        }
        //Gets the currency codes from the database
        Map<String, Double> mapCurrencyIsoCode = getCurrencyCode(setCurrencyCode);
        //Calculates the Sub Opportunity Total Amount field whenever an new Sub Opportunity is inserted
        mapMasterOpportunity = calculateOpportunityMasterAmount(mapNewSubOpportunities, mapCurrencyIsoCode, mapMasterOpportunity, mapSubMasterOpportunityId);
        updateMasterOpportunity(mapMasterOpportunity.values());  
    }
    
    /**
    @Description: Calculates the Sub Opportunity Total Amount field whenever an Sub Opportunity is updated
    @param:       Map of Opportunity Id and and it's related Old Opportunity record.
    @Return:      null
    **/
    
    public void updateOpportunityMasterAmount(Map<id, Opportunity> mapNewSubOpportunities, Map<id, Opportunity> mapOfOldSubOpportunities) {
        Boolean updateHierarchyLink = false;
        Map<id, Opportunity> mapMasterOpportunity;
        Map<id,id> mapSubMasterOpportunityId = new Map<id,id>();/*Sub and master opportunity id */
        Set<id> setMasterOpportunityId = new Set<id>();/*master opportunity id*/
        Set<String> setCurrencyCode = new Set<String>(); /*codes of the currency*/
        Map<id, id> mapOldMasterOpportunity = new Map<id, id>();
        for(Opportunity opp: mapNewSubOpportunities.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
            setMasterOpportunityId.add(opp.Opportunity_Hierarchy_Link__c);
            mapSubMasterOpportunityId.put(opp.id, opp.Opportunity_Hierarchy_Link__c);
        }
        
        for(Opportunity opp: mapOfOldSubOpportunities.values()) {    
            if(opp.Opportunity_Hierarchy_Link__c != mapNewSubOpportunities.get(opp.id).Opportunity_Hierarchy_Link__c) {
                updateHierarchyLink = true;
                setMasterOpportunityId.add(mapOfOldSubOpportunities.get(opp.id).Opportunity_Hierarchy_Link__c);
                setCurrencyCode.add(mapOfOldSubOpportunities.get(opp.id).CurrencyIsoCode);
                mapOldMasterOpportunity.put(opp.id, mapOfOldSubOpportunities.get(opp.id).Opportunity_Hierarchy_Link__c);
                system.debug('OLD Opportunity_Hierarchy_Link__c............'+mapOfOldSubOpportunities.get(opp.id));
            }
        }
        //Retrieves the master opportunity data from the database
        mapMasterOpportunity = getMasterOpportunity(setMasterOpportunityId);
        for(Opportunity opp : mapMasterOpportunity.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
        }
        //Gets the currency codes from the database
        Map<String, Double> mapCurrencyIsoCode = getCurrencyCode(setCurrencyCode);  
        //Calculates the Sub Opportunity Total Amount field whenever a Sub Opportunity is updated
        mapMasterOpportunity = addSubOpportunityAmount(mapNewSubOpportunities, mapOfOldSubOpportunities, mapCurrencyIsoCode, mapMasterOpportunity, mapSubMasterOpportunityId);       
        system.debug('@@mapMasterOpportunity'+mapMasterOpportunity);
        if(mapOldMasterOpportunity != null && !mapOldMasterOpportunity.IsEmpty() && updateHierarchyLink != false) {
            mapMasterOpportunity = deductSubOpportunityAmount(mapOfOldSubOpportunities, mapCurrencyIsoCode, mapMasterOpportunity, mapOldMasterOpportunity); 
        system.debug('this line is executing 1');
        }
        //update the master Opportunity
        updateMasterOpportunity(mapMasterOpportunity.values());  
          
    }
    
    /**
    @Description: Calculates the Sub Opportunity Total Amount field whenever an new Sub Opportunity is inserted
    @param:       Map of Opportunity Id, map of ISO code and it's conversion rate.
    @Return:      Map<id, Double>. It returns the Value of the sub opportunity total amount field for a particular
                  master opportunity.
    **/
        
    private Map<id, Opportunity> calculateOpportunityMasterAmount(Map<id, Opportunity> mapNewSubOpportunities, Map<String, Double> mapCurrencyIsoCode, Map<id, Opportunity> mapMasterOpportunity, Map<id, id> mapSubMasterOpportunityId) {
         Double amountToBeAdded;
         Double updatedAmountMaster;
         if(mapNewSubOpportunities != null) { 
         system.debug('!!mapNewSubOpportunities'+mapNewSubOpportunities);
             for(Opportunity opp : mapNewSubOpportunities.values()) {
                try {
                    if(opp.Opportunity_Hierarchy_Link__c != null && opp.ExpectedRevenue != null) {
                        amountToBeAdded = 0.0;
                        updatedAmountMaster = 0.0;
                        system.debug('Expected_Amount new'+opp.ExpectedRevenue);
                        amountToBeAdded = opp.ExpectedRevenue * (mapCurrencyIsoCode.get(mapMasterOpportunity.get(mapSubMasterOpportunityId.get(opp.id)).CurrencyIsoCode)/mapCurrencyIsoCode.get(opp.CurrencyIsoCode));
                        if(mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c != null &&
                            mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c != 0.0) {                    
                            updatedAmountMaster = mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c + amountToBeAdded;
                            mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c = updatedAmountMaster;
                        }
                        else {
                            updatedAmountMaster = amountToBeAdded;
                            mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c = updatedAmountMaster;
                       }                               
                    }
                }
                 catch(Exception ex) {
                    System.debug('Exception caught at line no' + ex.getLineNumber() +'due to'+ ex.getMessage());
                 }
             }
         }
        return mapMasterOpportunity;
    }
  
    /**
    @Description: Calculates the Sub Opportunity Total Amount field whenever an new Sub Opportunity is deleted
    @param:       Map of Opportunity Id and and it's related Old Opportunity record.
    @Return:      null
    **/
    
    public void deductOpportunityMasterAmount(Map<id, Opportunity> mapOfOldSubOpportunities) {
        Map<id, Opportunity> mapMasterOpportunity;
        Map<id,id> mapSubMasterOpportunityId = new Map<id,id>();/*Sub and master opportunity id */
        Set<id> setMasterOpportunityId = new Set<id>();/*master opportunity id*/
        Set<String> setCurrencyCode = new Set<String>(); /*codes of the currency*/
        for(Opportunity opp: mapOfOldSubOpportunities.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
            setMasterOpportunityId.add(opp.Opportunity_Hierarchy_Link__c);
            mapSubMasterOpportunityId.put(opp.id, opp.Opportunity_Hierarchy_Link__c);
        }
        //Retrieves the master opportunity data from the database
        mapMasterOpportunity = getMasterOpportunity(setMasterOpportunityId);
        for(Opportunity opp : mapMasterOpportunity.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
        }
        for(Opportunity opp : mapMasterOpportunity.values()) {
            setCurrencyCode.add(opp.CurrencyIsoCode);
        } 
        //Gets the currency codes from the database
        Map<String, Double> mapCurrencyIsoCode = getCurrencyCode(setCurrencyCode);  
        //Calculates the Sub Opportunity Total Amount field whenever a Sub Opportunity is deleted
        mapMasterOpportunity = deductSubOpportunityAmount(mapOfOldSubOpportunities, mapCurrencyIsoCode, mapMasterOpportunity, mapSubMasterOpportunityId); 
        //update the master Opportunity
        updateMasterOpportunity(mapMasterOpportunity.values());     
    }
    
    /**
    @Description: Retrieves the master opportunity data from the database
    @param:       Set of Opportunity Id.
    @Return:      Map<id, Double>. It returns the value of the Master Opportunity id and it's value
    **/
    
    private Map<id, Opportunity> getMasterOpportunity(Set<id> setMasterOpportunityId) {
        M2O_OpportunityDAO opportunityDao = new M2O_OpportunityDAO();      
        //get the master opportunities for which the sub- opportunity is inserted.
        Map<id, Opportunity> mapMasterOpportunity = opportunityDao.getMasterOpportunity(setMasterOpportunityId);              
        return mapMasterOpportunity;
    }
    
    /**
    @Description: Retrieves the currency code and exchange rate for a master and sub Opportunity.
    @param:       Set of Currency ISO Code.
    @Return:      Map<id, Double>. It returns the currency code and exchange rates.
    **/
    
    // private Map<String, Double> getCurrencyCode(Set<string> setCurrencyCode) {
    Public Map<String, Double> getCurrencyCode(Set<string> setCurrencyCode) {
        M2O_AdministrativeRelatedDAO administrativeDao = new M2O_AdministrativeRelatedDAO();
        //get the currency rates from the database
        List<DatedConversionRate> listCurrencyType = administrativeDao.getDatedExchangeRates(setCurrencyCode);
        Map<String, Double> mapCurrencyIsoCode = new Map<String, Double>();
        //put the currencyIsoCode and rates in a map so that it can be accessed during calculation
        for(DatedConversionRate cType : listCurrencyType) {
            mapCurrencyIsoCode.put(cType.IsoCode, cType.ConversionRate);
        }
        return mapCurrencyIsoCode;
    }
    
    /**
    @Description: Calculates the diffrence in Opportunity expected revenue whenever an Opportunity is updated, and adds it with     
                  with sub opportunity total amount in Master opportunity.
    @param:       Map of master opportunity Id and its corresponding sub opportunity total amount.
    @Return:      Map<id, Double>. It returns the id and the sub opportunity total amount of a master opportunity.
    **/
    
    private Map<id, Opportunity> addSubOpportunityAmount(Map<id, Opportunity> mapNewSubOpportunity, Map<id, Opportunity> mapOldSubOpportunity, Map<String, Double> mapCurrencyIsoCode, Map<id, Opportunity> mapMasterOpportunity, Map<id, id> mapSubMasterOpportunityId) {
        // Support Fix for Change Request C1094530 : Master Opportunites with negative summary of Sub opportunites
        Double updatedAmountMaster;       
        Double differenceInAmount;
        Map<id, Opportunity> mapUpdatedHierarchyLink = new Map<id, Opportunity>();
        double totalExpectedRevenue = 0.0;
        Set<id> masterIdSet = new set<id>();
        Set<id> updatedSubOpportunityIdSet = new set<id>();
        updatedSubOpportunityIdSet = mapNewSubOpportunity.keySet(); 
        List<Opportunity> subOpportunityList = new List<Opportunity>();
        Map<id,double> expectedRevenueMap = new Map<id,double>();
        double subOppRevenue = 0.0;
        List<Id> hierarchyLinkIdList = new List<Id>();
        system.debug('@@updatedSubOpportunityIdSet '+updatedSubOpportunityIdSet );
        boolean delHeirarchyLink;
        for(Opportunity opp : mapNewSubOpportunity.values()){
             if(opp.Opportunity_Hierarchy_Link__c != NULL){
                 masterIdSet.add(opp.Opportunity_Hierarchy_Link__c);
                 delHeirarchyLink = false;
             }
             system.debug('@@masterIdSet'+masterIdSet);
             system.debug('@@ExpectedRevenue_new'+opp.ExpectedRevenue);
        }
        if(delHeirarchyLink != True){
            subOpportunityList = [ SELECT Id,Opportunity_Hierarchy_Link__c,ExpectedRevenue FROM Opportunity WHERE Opportunity_Hierarchy_Link__c IN: masterIdSet AND Id NOT IN: updatedSubOpportunityIdSet];
        }
        else{
            subOpportunityList = [ SELECT Id,Opportunity_Hierarchy_Link__c,ExpectedRevenue FROM Opportunity WHERE Id NOT IN: updatedSubOpportunityIdSet];
        }
        system.debug('@@subOpportunityList '+subOpportunityList);
        try{
            for(Opportunity oppty:subOpportunityList){
                if(expectedRevenueMap.get(oppty.Opportunity_Hierarchy_Link__c) == NULL && oppty.ExpectedRevenue != NULL ){
                    expectedRevenueMap.put(oppty.Opportunity_Hierarchy_Link__c, oppty.ExpectedRevenue);
                }
                else{
                    subOppRevenue = expectedRevenueMap.get(oppty.Opportunity_Hierarchy_Link__c);
                    if(oppty.ExpectedRevenue != NULL){
                        expectedRevenueMap.put(oppty.Opportunity_Hierarchy_Link__c, (oppty.ExpectedRevenue+subOppRevenue));
                    }
                }
            }
            system.debug('@@expectedRevenueMap'+expectedRevenueMap);
            
            for(Opportunity opp : mapNewSubOpportunity.values()) {
            if(mapOldSubOpportunity.get(opp.id).Opportunity_Hierarchy_Link__c == null || 
                    mapOldSubOpportunity.get(opp.id).Opportunity_Hierarchy_Link__c != opp.Opportunity_Hierarchy_Link__c) {
                    mapUpdatedHierarchyLink.put(opp.id, opp);
                    break;
                }
                if(mapOldSubOpportunity.get(opp.id).ExpectedRevenue != opp.ExpectedRevenue) {
                    system.debug('@@opp.Probability'+opp.Probability);
                    totalExpectedRevenue = totalExpectedRevenue + opp.ExpectedRevenue ;  
                    system.debug('##totalExpectedRevenue B4 total'+totalExpectedRevenue);             
                }
                if(expectedRevenueMap != NULL && !expectedRevenueMap.IsEmpty()){
                    totalExpectedRevenue = totalExpectedRevenue + expectedRevenueMap.get(opp.Opportunity_Hierarchy_Link__c);
                    system.debug('##totalExpectedRevenue after Total '+totalExpectedRevenue);
                }
            }  
             for(Opportunity opp : mapNewSubOpportunity.values()){//subOpportunityList) {
                if(mapOldSubOpportunity.get(opp.id).ExpectedRevenue != opp.ExpectedRevenue) {
                    totalExpectedRevenue = totalExpectedRevenue * (mapCurrencyIsoCode.get(mapMasterOpportunity.get(mapSubMasterOpportunityId.get(opp.id)).CurrencyIsoCode)/mapCurrencyIsoCode.get(opp.CurrencyIsoCode));     
                    system.debug('##totalExpectedRevenue '+totalExpectedRevenue);
                    mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c = totalExpectedRevenue;
                }
        } 
        }  
        catch(Exception ex) {
                    System.debug('Exception caught at line no' + ex.getLineNumber() +'due to'+ ex.getMessage());
                }    
        if(mapUpdatedHierarchyLink !=null) {
            mapMasterOpportunity = calculateOpportunityMasterAmount(mapUpdatedHierarchyLink, mapCurrencyIsoCode, mapMasterOpportunity, mapSubMasterOpportunityId);
        }
      return mapMasterOpportunity;
    }
     
    /**
    @Description: Deducts the Opportunity expectedrevenue in Sub opportunity from sub opportunity total amount in Master opportunity.
    @param:       Map of opportunity Id and corresponding old sub opportunity total amount.
    @Return:      Map<id, Double>. It returns the id and the sub opportunity total amount of a master opportunity.
    **/
    
    private Map<id, Opportunity> deductSubOpportunityAmount(Map<id, Opportunity> mapOfOldSubOpportunities, Map<String, Double> mapCurrencyIsoCode, Map<id, Opportunity> mapMasterOpportunity, Map<id, id> mapSubMasterOpportunityId) {
        System.debug('This line is executing 2');
        Double updatedAmountMaster;       
        Double amountToBeDeducted;
        for(Opportunity opp : mapOfOldSubOpportunities.values()) {
        try {
            if(mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c)!=null) {           
            if(opp.Opportunity_Hierarchy_Link__c != null && mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c !=0.0 &&
               mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c != null) {
                amountToBeDeducted = 0.0;
                updatedAmountMaster = 0.0;
                amountToBeDeducted = opp.ExpectedRevenue * (mapCurrencyIsoCode.get(mapMasterOpportunity.get(mapSubMasterOpportunityId.get(opp.id)).CurrencyIsoCode)/mapCurrencyIsoCode.get(opp.CurrencyIsoCode));
                try { 
                    System.debug('This line is executing 3');
                        updatedAmountMaster = mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c - amountToBeDeducted;
                        mapMasterOpportunity.get(opp.Opportunity_Hierarchy_Link__c).Sub_Opportunities_Total_Amounts__c = updatedAmountMaster;
                    
                }
                catch(Exception ex) {
                    System.debug('Exception caught at line no' + ex.getLineNumber() +'due to'+ ex.getMessage());
                } 
            } 
           } 
           }
           catch(Exception ex) {
               opp.addError('YOU cannot change the master opportunity for this record and also cannot update this record');
           }    

        } 
        return mapMasterOpportunity;
    }
    
    /**
    @Description: updates the master opportunity with the updated sub opportunity total amount value.
    @param:       Map of master opportunity id and its corresponding Master Opportunity Amount.
    @Return:      Map<id, Double>. It returns the id and the sub opportunity total amount of a master opportunity.
    **/
    
    private void updateMasterOpportunity(List<Opportunity> updateMasterOpportunity) {
        system.debug('@@updateMasterOpportunity'+updateMasterOpportunity);
        
        M2O_OpportunityDAO opportunityDao = new M2O_OpportunityDAO();
        Opportunity updateOpportunity;
        List<Opportunity> listToUpdateMasterOpportunity = new List<Opportunity>();
        for(Opportunity opp : updateMasterOpportunity) {
            if(opp.Sub_Opportunities_Total_Amounts__c != null) {
                
                updateOpportunity = new Opportunity(id = opp.id);
                updateOpportunity.Sub_Opportunities_Total_Amounts__c = opp.Sub_Opportunities_Total_Amounts__c;
                system.debug('@@updateOpportunity.Sub_Opportunities_Total_Amounts__c '+updateOpportunity.Sub_Opportunities_Total_Amounts__c );
                listToUpdateMasterOpportunity.add(updateOpportunity);
            }            
        }
        if(listToUpdateMasterOpportunity != null && !listToUpdateMasterOpportunity.IsEmpty()) {
            opportunityDao.updateOpportunity(listToUpdateMasterOpportunity);
        }
    }
}