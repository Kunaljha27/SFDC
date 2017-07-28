public class HCNA_ForecastFilter {

    public HCNA_ForecastFilter() {
    
    }
}

    /*//Filter Count
    public Integer countAccountFilter {get; set;} 
    public Integer countOpptyFilter {get; set;} 
    public Integer countUserFilter {get; set;} 
    public boolean filterAddRemoveFlag {get;set;}
    public boolean filterAddRemoveFlagOppty {get;set;}    
    public boolean filterAddRemoveFlagUser {get;set;}    
    // Creating lists for the wrapper class for the filters
    public List<FilterWrapper> accountFilterList  {get; set; }
    public List<FilterWrapper> opportunityFilterList {get; set; }
    public List<FilterWrapper> userFilterList {get; set; }
    
    private Map<String, String> fieldNameType = new Map<String, String>();
    private Map<String, String> fieldNameTypeOppty = new Map<String, String>();
    private Map<String, String> fieldNameTypeUser = new Map<String, String>();
    private Map<String, List<Schema.sObjectType>> fieldNameReferenceTo = new Map<String, List<Schema.sObjectType>>();
    private Map<String, List<Schema.sObjectType>> fieldNameReferenceToOppty = new Map<String, List<Schema.sObjectType>>();
    private Map<String, List<Schema.sObjectType>> fieldNameReferenceToUser = new Map<String, List<Schema.sObjectType>>();
    string bracket = '(';
    string rightBracket = ')';
    integer rowSize = 4;   
    private HCNA_CustomForecastPageDAOClass customForecastDAO = new HCNA_CustomForecastPageDAOClass();
    
    *//*
    * constructor
    */
   /* public HCNA_ForecastFilter(ApexPages.StandardController controller) {
        countAccountFilter = countOpptyFilter= countUserFilter = rowSize;
        system.debug('constructor called'); 
        accountFilterList = fillFilterList(accountFilterList,HCNA_CustomForecastConstants.filterForAccount);
        opportunityFilterList = fillFilterList(opportunityFilterList,HCNA_CustomForecastConstants.filterForOpportunity);
        userFilterList = fillFilterList(userFilterList,HCNA_CustomForecastConstants.filterForUser);        
    }
    /**/
  //  * set flag for add row/remove row links 
   // */
    /*public PageReference addFilter() {
        string filterFor ='';
        if (Apexpages.CurrentPage().getParameters().get('filterFor') != null){
            filterFor = Apexpages.CurrentPage().getParameters().get('filterFor');
        }
        if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
            filterAddRemoveFlag = true;
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
            filterAddRemoveFlagOppty = true;
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
            filterAddRemoveFlagUser = true;
        }
        system.debug('==filterFor'+filterFor);
        return null;
    }*/
    /*
    * reset flag for add row/remove row links 
    */
   /* public PageReference removeFilter() {
        string filterFor ='';
        if (Apexpages.CurrentPage().getParameters().get('filterFor') != null){
            filterFor = Apexpages.CurrentPage().getParameters().get('filterFor');
        }
        if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
            filterAddRemoveFlag = false;
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
            filterAddRemoveFlagOppty = false;
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
            filterAddRemoveFlagUser = false;
        }
        return null;
    }
    /*
    * add blank row
    */
    /*public PageReference addFilterRow() {
        string filterFor = '';
        try{
            if (Apexpages.CurrentPage().getParameters().get('filterFor') != null){
                filterFor = Apexpages.CurrentPage().getParameters().get('filterFor');
            }
            system.debug('filterFor=='+filterFor);
            if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
                countAccountFilter = countAccountFilter + 1;                        
            }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                countOpptyFilter = countOpptyFilter + 1;                        
            }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
                countUserFilter = countUserFilter + 1;                      
            }else if (filterFor == null){
                return null;
            }        
            System.debug('countAccountFilter >>>>>' + countAccountFilter);
            //Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
            Schema.SObjectType sObjName = Schema.getGlobalDescribe().get(filterFor);
            Schema.DescribeSObjectResult sObjResult = sObjName.getDescribe();
            Map <String, Schema.SObjectField> fieldMap = sObjResult.fields.getMap();//sObjName.sObjectType.getDescribe().fields.getMap();
            List<SelectOption> fieldList = new List<SelectOption>();
            fieldList.add(new SelectOption('None','None'));
            for(Schema.SObjectField sfield : fieldMap.Values())
            {
                schema.describefieldresult dfield = sfield.getDescribe();
                fieldList.add(new SelectOption(dfield.getName(),dfield.getLabel()));
                if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
                    fieldNameType.put(dfield.getName(),string.valueof(dfield.getType()));
                    fieldNameReferenceTo.put(dfield.getName(),dfield.getReferenceTo());
                }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                    fieldNameTypeOppty.put(dfield.getName(),string.valueof(dfield.getType()));
                    fieldNameReferenceToOppty.put(dfield.getName(),dfield.getReferenceTo());                
                }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
                    fieldNameTypeUser.put(dfield.getName(),string.valueof(dfield.getType()));
                    fieldNameReferenceToUser.put(dfield.getName(),dfield.getReferenceTo());                 
                }            
                //System.debug('getType() value >>>>>>>>>' + dfield.getName()+ ' <<<>>>> ' + dfield.getType()+ '<<>>>'+dfield.getReferenceTo());
            
            }       
            List<SelectOption> operatorList = new List<SelectOption>();           
            operatorList = addOperatorList(null,null);        
            if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){              
                accountFilterList.add(new FilterWrapper(countAccountFilter-1,fieldList,operatorList));
            }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                opportunityFilterList.add(new FilterWrapper(countOpptyFilter-1,fieldList,operatorList));
            }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
                userFilterList.add(new FilterWrapper(countUserFilter-1,fieldList,operatorList));
            }
        }catch (Exception e){
            system.debug('Error in addFilterRow '+ e.getStackTraceString());
        }
        return null;
    }*/
    /*
    * remove last row
    */
   /* public PageReference removeFilterRow() {
        string filterFor = '';
        if (Apexpages.CurrentPage().getParameters().get('filterFor') != null){
            filterFor = Apexpages.CurrentPage().getParameters().get('filterFor');
        }
        if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
            countAccountFilter = countAccountFilter - 1;            
            accountFilterList.remove(countAccountFilter);
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
            countOpptyFilter = countOpptyFilter - 1;            
            opportunityFilterList.remove(countOpptyFilter);
        }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
            countUserFilter = countUserFilter - 1;          
            userFilterList.remove(countUserFilter);
        }
        System.debug('filterFor >>>>>' + filterFor);
        return null;
    }
    /*
    * redirect to forecast page
    */
   /* public PageReference cancelFilter() {
        PageReference foreCastPage= new PageReference('/apex/HCNA_CustomForecastPage');
        
        foreCastPage.setRedirect(true);
        return foreCastPage;
     }
       */
   /*
   * Fill data in filter list
   *@param filterlist - account/oppty/user list
   *@param filterFor - account/opportunity/user
   */   
  /*  public List<FilterWrapper> fillFilterList(List<FilterWrapper> filterList,string filterFor) {
        integer startIndex = 0;
        integer endIndex = 4;
        try
        {                          
            if (filterList == null){                             
                filterList = new List<FilterWrapper>();
                system.debug('accountFilterList called for first time'+filterList.size());
            }else{
                system.debug('accountFilterList called for next time'+filterList.size());
                return filterList;
            }
            List<Forecast_Filter__c> forecastFilterList;
            List<Forecast_Filter_Detail__c> forecastFltrDetailList;
            forecastFilterList = customForecastDAO.retrieveForecastFilterData(filterFor);
            /*if (filterFor == HCNA_CustomForecastConstants.filterForAccount){
                forecastFilterList = [select id from Forecast_Filter__c where Filter_Applies_User__c= :Userinfo.getUserId() and Account_Flag__c = true];            
                //system.debug('countAccountFilter >>>>' + countAccountFilter);
            }else if (filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                forecastFilterList = [select id from Forecast_Filter__c where Filter_Applies_User__c= :Userinfo.getUserId() and Opportunity_Flag__c = true];            
                //system.debug('countAccountFilter >>>>' + countOpptyFilter);
            }else if (filterFor == HCNA_CustomForecastConstants.filterForUser){
                forecastFilterList = [select id from Forecast_Filter__c where Filter_Applies_User__c= :Userinfo.getUserId() and User_Flag__c = true];            
                //system.debug('countAccountFilter >>>>' + countUserFilter);
            }*/
          /*  if (forecastFilterList.size() >0){
                //forecastFltrDetailList = [select id, Field_Type__c, Field__c,Operator__c,Filter_Value__c,Forecast_Filter__c,Filter_LookupId__c  from Forecast_Filter_Detail__c where Forecast_Filter__c = :forecastFilterList[0].id order by Sequence__c];
                forecastFltrDetailList = customForecastDAO.retrieveForecastFilterDetailData (forecastFilterList[0].id);
                if (filterFor == HCNA_CustomForecastConstants.filterForAccount){
                    countAccountFilter = forecastFltrDetailList.size();
                    if (countAccountFilter < 4 ){                
                        countAccountFilter = 4;
                    }
                }else if (filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                    countOpptyFilter = forecastFltrDetailList.size();
                    if (countOpptyFilter < 4 ){                
                        countOpptyFilter = 4;
                    }
                }else if (filterFor == HCNA_CustomForecastConstants.filterForUser){
                    countUserFilter = forecastFltrDetailList.size();
                    if (countUserFilter < 4 ){                
                        countUserFilter = 4;
                    }
                }
            }
            if (forecastFltrDetailList == null){
                forecastFltrDetailList = new list<Forecast_Filter_Detail__c>();
            }
            filterList = addFilterListData(countAccountFilter,filterList,forecastFltrDetailList,filterFor);                       
        }catch(exception e){
            system.debug('Error in account filter' + e);
        }
        
        return filterList;
    }
    /*
   * Fill data in filter list
   *@param countFilter - current counter value of account/oppty/user rows
   *@param filterlist - account/oppty/user list
   *@param filterFor - account/opportunity/user
   */   
   /* private list<FilterWrapper> addFilterListData(integer countFilter, List<FilterWrapper> filterWrapperList , List<Forecast_Filter_Detail__c> forecastFltrDetailList, string filterFor){
        Map <String, Schema.SObjectField> fieldMap ;
        List<SelectOption> fieldList;
        try{
            
        
            Schema.SObjectType sObjName = Schema.getGlobalDescribe().get(filterFor);
            Schema.DescribeSObjectResult sObjResult = sObjName.getDescribe();
            for(Integer count = 0; count < countFilter; count++) {                              
            
                    fieldMap = sObjResult.fields.getMap();//Account.sObjectType.getDescribe().fields.getMap();
                    fieldList = new List<SelectOption>();
                    fieldList.add(new SelectOption('None','None'));
                    for(Schema.SObjectField sfield : fieldMap.Values())
                    {
                        schema.describefieldresult dfield = sfield.getDescribe();
                        fieldList.add(new SelectOption(dfield.getName(),dfield.getLabel()));
                        if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
                            fieldNameType.put(dfield.getName(),string.valueof(dfield.getType()));
                            fieldNameReferenceTo.put(dfield.getName(),dfield.getReferenceTo());
                        }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                            fieldNameTypeOppty.put(dfield.getName(),string.valueof(dfield.getType()));
                            fieldNameReferenceToOppty.put(dfield.getName(),dfield.getReferenceTo());                
                        }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
                            fieldNameTypeUser.put(dfield.getName(),string.valueof(dfield.getType()));
                            fieldNameReferenceToUser.put(dfield.getName(),dfield.getReferenceTo());                 
                        }    
                        //System.debug('getType() value >>>>>>>>>' + dfield.getName()+ ' <<<>>>> ' + dfield.getType()+ '<<>>>'+dfield.getReferenceTo());
                    
                    }       
                    List<SelectOption> operatorList = new List<SelectOption>();            
                    operatorList = addOperatorList(null,null);          
                    //system.debug('==fieldList=='+fieldList + '=='+ operatorList);   
                    filterWrapperList.add(new FilterWrapper(count,fieldList,operatorList));                              
                }
                //check for filter detail data and if available fill with those data while user come back on page again
                            
                integer index = 0;
                

                system.debug('==forecastFltrDetailList=='+ forecastFltrDetailList);
                for (Forecast_Filter_Detail__c forecastFltrDetail :forecastFltrDetailList){                    
                    filterWrapperList[index].fieldSelected = forecastFltrDetail.Field__c;
                    filterWrapperList[index].operatorSelected = forecastFltrDetail.Operator__c;
                    filterWrapperList[index].value = forecastFltrDetail.Filter_Value__c;
                    filterWrapperList[index].forecastFilterID = forecastFltrDetail.Forecast_Filter__c;
                    filterWrapperList[index].FieldType = forecastFltrDetail.Field_Type__c;
                    filterWrapperList[index].lookUprecordIds =  forecastFltrDetail.Filter_LookupId__c;
                    if ( filterFor == HCNA_CustomForecastConstants.filterForAccount){
                        filterWrapperList[index].operatorList = addOperatorList(forecastFltrDetail.Field__c,fieldNameType);                
                        //system.debug('fld ref==='+string.valueOf(fieldNameReferenceTo.get(forecastFltrDetail.Field__c)).length() + 'fld=='+forecastFltrDetail.Field__c);
                        if (string.valueOf(fieldNameReferenceTo.get(forecastFltrDetail.Field__c)).length() > 2){                        
                            filterWrapperList[index].fieldReference = String.ValueOf(fieldNameReferenceTo.get(forecastFltrDetail.Field__c)[0]).replace(rightBracket,'').replace(bracket,'');
                        }
                    }else if ( filterFor == HCNA_CustomForecastConstants.filterForOpportunity){
                        filterWrapperList[index].operatorList = addOperatorList(forecastFltrDetail.Field__c,fieldNameTypeOppty);                                    
                        if (string.valueOf(fieldNameReferenceToOppty.get(forecastFltrDetail.Field__c)).length() > 2){                       
                            filterWrapperList[index].fieldReference = String.ValueOf(fieldNameReferenceToOppty.get(forecastFltrDetail.Field__c)[0]).replace(rightBracket,'').replace(bracket,'');
                        }
                    }else if ( filterFor == HCNA_CustomForecastConstants.filterForUser){
                        filterWrapperList[index].operatorList = addOperatorList(forecastFltrDetail.Field__c,fieldNameTypeUser);                                 
                        if (string.valueOf(fieldNameReferenceToUser.get(forecastFltrDetail.Field__c)).length() > 2){                        
                            filterWrapperList[index].fieldReference = String.ValueOf(fieldNameReferenceToUser.get(forecastFltrDetail.Field__c)[0]).replace(rightBracket,'').replace(bracket,'');
                        }
                    }
                    index ++ ;
                }      
            }catch(exception e){
                system.debug('addFilterListData error '+ e);
            }                     
            return filterWrapperList;
    }
    /*
    *set operator list depend on the field selected by user
    *@param : fldname will be the field name selected by user
    *@param  fieldNameType - map to get field type from field name
    */
   /* private List<SelectOption> addOperatorList(string fldName, map<string,string> fieldNameType ){
        List<SelectOption> operatorList = new List<SelectOption>();            
        system.debug('addOperatorList fieldNameType== '+fieldNameType + '==fldName=='+ fldName );
        if( fieldNameType != null && (fieldNameType.get(fldName) == 'DOUBLE' || fieldNameType.get(fldName) == 'INTEGER'
            || fieldNameType.get(fldName) == 'DATE')) 
        {
            operatorList.add(new SelectOption('=','Equals To'));
            operatorList.add(new SelectOption('!=','Not Equals To'));
            operatorList.add(new SelectOption('<','less than'));
            operatorList.add(new SelectOption('>','greater than'));
            operatorList.add(new SelectOption('<=','less or equal'));
            operatorList.add(new SelectOption('>=','greater or equal'));
        }
        else if ( fieldNameType != null && (fieldNameType.get(fldName) == 'STRING' || fieldNameType.get(fldName) == 'TEXTAREA' || fieldNameType.get(fldName) == 'EMAIL' 
        || fieldNameType.get(fldName) == 'URL')){
            operatorList.add(new SelectOption('=','Equals To'));
            operatorList.add(new SelectOption('Like','Contain'));
            operatorList.add(new SelectOption('not Like','does not contains'));
            operatorList.add(new SelectOption('!=','Not Equals To'));    
        }else if ( fieldNameType != null && (fieldNameType.get(fldName) == 'REFERENCE' || fieldNameType.get(fldName) == 'BOOLEAN')){
            operatorList.add(new SelectOption('=','Equals To'));
            operatorList.add(new SelectOption('!=','Not Equals To'));    
        }
        else{
            if (fldName == null){
                operatorList.add(new SelectOption('None','-None-'));
            } 
            operatorList.add(new SelectOption('=','Equals To'));
            operatorList.add(new SelectOption('!=','Not Equals To'));    
            operatorList.add(new SelectOption('Like','Contains'));
            operatorList.add(new SelectOption('not Like','does not contain'));
            operatorList.add(new SelectOption('<','less than'));
            operatorList.add(new SelectOption('>','greater than'));
            operatorList.add(new SelectOption('<=','less or equal'));
            operatorList.add(new SelectOption('>=','greater or equal'));            
        }
        return operatorList;
    }
    /*
    * operators will be filtered based on the field selected by user
    */
   /* public PageReference getfilterByOperator() {
        System.debug('getfilterByOperator called' );
        string fldName ='';
        string fieldFor ='';
        integer index = 0;
        if (Apexpages.CurrentPage().getParameters().get('fieldName') != null){
            fldName = Apexpages.CurrentPage().getParameters().get('fieldName');
        }
        if (Apexpages.CurrentPage().getParameters().get('fieldIndex') != null){  
            index = integer.valueOf(Apexpages.CurrentPage().getParameters().get('fieldIndex'));
        }    
        if (Apexpages.CurrentPage().getParameters().get('fieldFor') != null){  
            fieldFor = Apexpages.CurrentPage().getParameters().get('fieldFor');
        }         
        System.debug('getfilterByOperator fldName>>>'+fldName + '='+ index + fieldNameType.get(fldName));
        //System.debug('getfilterByOperator operatorList='+operatorList );
        if (index == 0){
            index = 1;
        }
        if (fieldFor == HCNA_CustomForecastConstants.filterForAccount){
            accountFilterList[index-1].operatorList = addOperatorList(fldName,fieldNameType);
            accountFilterList[index-1].fieldType =  fieldNameType.get(fldName);
            if (null != fieldNameReferenceTo.get(fldName) && string.valueOf(fieldNameReferenceTo.get(fldName)).length() > 2){
                accountFilterList[index-1].fieldReference = string.ValueOf(fieldNameReferenceTo.get(fldName)[0]).replace(rightBracket,'').replace(bracket,'');
            }
            System.debug('getfilterByOperator accountFilterList[index-1]='+accountFilterList[index-1] );
        }else if (fieldFor == HCNA_CustomForecastConstants.filterForOpportunity){
            opportunityFilterList[index-1].operatorList = addOperatorList(fldName,fieldNameTypeOppty);
            opportunityFilterList[index-1].fieldType =  fieldNameTypeOppty.get(fldName);
            if (null != fieldNameReferenceToOppty.get(fldName) && string.valueOf(fieldNameReferenceToOppty.get(fldName)).length() > 2){
                opportunityFilterList[index-1].fieldReference = string.ValueOf(fieldNameReferenceToOppty.get(fldName)[0]).replace(rightBracket,'').replace(bracket,'');
            }
        }else if (fieldFor == HCNA_CustomForecastConstants.filterForUser){
            userFilterList[index-1].operatorList = addOperatorList(fldName,fieldNameTypeUser);
            userFilterList[index-1].fieldType =  fieldNameTypeUser.get(fldName);
            if (null != fieldNameReferenceToUser.get(fldName) && string.valueOf(fieldNameReferenceToUser.get(fldName)).length() > 2){
                userFilterList[index-1].fieldReference = string.ValueOf(fieldNameReferenceToUser.get(fldName)[0]).replace(rightBracket,'').replace(bracket,'');
            }
        }        
        return null;
    }
    /*
    * Method will delete all the records from filter object and as well from their child object
    */
   /* public PageReference Refresh() {
    
        List<Forecast_Filter__c> forecastFilterList;// = [select id from Forecast_Filter__c where Filter_Applies_User__c = :Userinfo.getUserId()];
        forecastFilterList = customForeCastDAO.retrieveForecastFilterData(null);
        //System.debug('forecastFilterTest Value --->>>>>'+ forecastFilterList );
        if(null != forecastFilterList && forecastFilterList.size() > 0) {
            System.debug('In Condition >>>>>>');
            //delete forecastFilterList ;
            customForeCastDAO.deleteForecastFilterData(forecastFilterList);
        }   
        System.debug('forecastFilterTest Value 1 --->>>>>'+ forecastFilterList);
        accountFilterList = null;
        opportunityFilterList = null;
        userFilterList = null;
        accountFilterList = fillFilterList(accountFilterList,HCNA_CustomForecastConstants.filterForAccount);
        opportunityFilterList = fillFilterList(opportunityFilterList,HCNA_CustomForecastConstants.filterForOpportunity);
        userFilterList = fillFilterList(userFilterList,HCNA_CustomForecastConstants.filterForUser);   
        return null;
    
    }
    /*
    * Save criteria to Forecast Filter and Forecast Filter Detail object.
    */
  /*  public PageReference Save(){
        
        List<Forecast_Filter_Detail__c> forecastFltrDetailList = new  List<Forecast_Filter_Detail__c> ();
        List<Forecast_Filter_Detail__c> forecastFltrDetailListTemp = new  List<Forecast_Filter_Detail__c> ();

        //forecastFltrDetailList = [select id, Field_Type__c, Field__c,Operator__c,Filter_Value__c,Forecast_Filter__c,Filter_LookupId__c  from Forecast_Filter_Detail__c where Forecast_Filter__r.Filter_Applies_User__c = :UserInfo.getUserId()];
        forecastFltrDetailList = customForeCastDAO.retrieveForecastFilterDetailDataUserWise();
        If(forecastFltrDetailList.size() > 0) {
            //delete forecastFltrDetailList;
            customForeCastDAO.deleteForecastFilterDetailData(forecastFltrDetailList);
            forecastFltrDetailList = new  List<Forecast_Filter_Detail__c> ();
        }
        
        
        Forecast_Filter__c forecastFilter;
        List<Forecast_Filter__c> forecastFilterList ;//= [select Account_Flag__c,Opportunity_Flag__c,User_Flag__c,Criteria_String__c,Filter_Applies_User__c from Forecast_Filter__c where Filter_Applies_User__c= :UserInfo.getUserId()];
        forecastFilterList = customForeCastDAO.retrieveForecastFilterData(null);
        if (forecastFilterList.size() == 0){
            forecastFilter = new Forecast_Filter__c();
            forecastFilter.Account_Flag__c = true;
            forecastFilter.Criteria_String__c  =prepareCriteria(accountFilterList,fieldNameType,HCNA_CustomForecastConstants.filterForAccount);
            forecastFilter.Filter_Applies_User__c = Userinfo.getUserId();
            //insert forecastFilter;
            customForeCastDAO.insertForecastFilterData(forecastFilter);
            forecastFltrDetailListTemp = prepareForecastFilterDetailList(accountFilterList,HCNA_CustomForecastConstants.filterForAccount);
            for (Forecast_Filter_Detail__c forecastFltrDetail :forecastFltrDetailListTemp){
                forecastFltrDetail.Forecast_Filter__c = forecastFilter.id;
            }                       
            forecastFltrDetailList.addAll( forecastFltrDetailListTemp);  
            
            forecastFilter = new Forecast_Filter__c();
            forecastFilter.Opportunity_Flag__c = true;
            forecastFilter.Criteria_String__c  =prepareCriteria(opportunityFilterList,fieldNameTypeOppty,HCNA_CustomForecastConstants.filterForOpportunity);
            forecastFilter.Filter_Applies_User__c = Userinfo.getUserId();
            //insert forecastFilter;
            customForeCastDAO.insertForecastFilterData(forecastFilter);
            forecastFltrDetailListTemp  = prepareForecastFilterDetailList(opportunityFilterList,HCNA_CustomForecastConstants.filterForOpportunity);
            for (Forecast_Filter_Detail__c forecastFltrDetail :forecastFltrDetailListTemp){
                forecastFltrDetail.Forecast_Filter__c = forecastFilter.id;
            }                                               
            forecastFltrDetailList.addAll( forecastFltrDetailListTemp);  
            forecastFilter = new Forecast_Filter__c();
            forecastFilter.User_Flag__c = true;
            forecastFilter.Criteria_String__c  =prepareCriteria(userFilterList,fieldNameTypeUser,HCNA_CustomForecastConstants.filterForUser);
            forecastFilter.Filter_Applies_User__c = Userinfo.getUserId();
            //insert forecastFilter;
            customForeCastDAO.insertForecastFilterData(forecastFilter);
            forecastFltrDetailListTemp =  prepareForecastFilterDetailList(userFilterList,HCNA_CustomForecastConstants.filterForUser);
                 
            for (Forecast_Filter_Detail__c forecastFltrDetail :forecastFltrDetailListTemp){
                forecastFltrDetail.Forecast_Filter__c = forecastFilter.id;
            }
            forecastFltrDetailList.addAll( forecastFltrDetailListTemp);    
        }else{
            for (Forecast_Filter__c forecastFilterObj : forecastFilterList){
                system.debug('SAve forecastFilter='+forecastFilterObj);
                if (forecastFilterObj.Account_Flag__c == true){
                    
                    forecastFilterObj.Account_Flag__c = true;
                    if (prepareCriteria(accountFilterList,fieldNameType,HCNA_CustomForecastConstants.filterForAccount) == null){
                        return null;
                    }
                    forecastFilterObj.Criteria_String__c  =prepareCriteria(accountFilterList,fieldNameType,HCNA_CustomForecastConstants.filterForAccount);
                    forecastFilterObj.Filter_Applies_User__c = Userinfo.getUserId();
                    forecastFltrDetailListTemp =  prepareForecastFilterDetailList(accountFilterList,HCNA_CustomForecastConstants.filterForAccount);
                    
                    for (Forecast_Filter_Detail__c forecastFltr :forecastFltrDetailListTemp){
                        forecastFltr.Forecast_Filter__c = forecastFilterObj.id;
                    }
                    forecastFltrDetailList.AddAll( forecastFltrDetailListTemp);                                        
                }else if (forecastFilterObj.Opportunity_Flag__c == true){
                    
                    forecastFilterObj.Opportunity_Flag__c = true;
                    forecastFilterObj.Criteria_String__c  =prepareCriteria(opportunityFilterList,fieldNameTypeOppty,HCNA_CustomForecastConstants.filterForOpportunity);
                    forecastFilterObj.Filter_Applies_User__c = Userinfo.getUserId();
                    forecastFltrDetailListTemp = prepareForecastFilterDetailList(opportunityFilterList,HCNA_CustomForecastConstants.filterForOpportunity);
                    
                    for (Forecast_Filter_Detail__c forecastFltr :forecastFltrDetailListTemp){
                        forecastFltr.Forecast_Filter__c = forecastFilterObj.id;
                    }  
                    forecastFltrDetailList.addAll( forecastFltrDetailListTemp);                 
                }else if (forecastFilterObj.User_Flag__c == true){
                    
                    forecastFilterObj.User_Flag__c = true;
                    forecastFilterObj.Criteria_String__c  =prepareCriteria(userFilterList,fieldNameTypeUser,HCNA_CustomForecastConstants.filterForUser);
                    forecastFilterObj.Filter_Applies_User__c = Userinfo.getUserId();
                    forecastFltrDetailListTemp = prepareForecastFilterDetailList(userFilterList,HCNA_CustomForecastConstants.filterForUser);                    
                    for (Forecast_Filter_Detail__c forecastFltr :forecastFltrDetailListTemp){
                        forecastFltr.Forecast_Filter__c = forecastFilterObj.id;
                    }
                    forecastFltrDetailList.addAll( forecastFltrDetailListTemp );            
                }
            }
            //upsert forecastFilterList;
            customforecastDAO.upsertForecastFilterList(forecastFilterList); 
        }
                                   
        //insert forecastFltrDetailList; 
        customforecastDAO.insertForecastFilterDetailData(forecastFltrDetailList);
        
        return null;
    }    
    /*
    * prepare criteria string to save in filter object
    * @param : FilterWrapperList - filter wrapper list
    * @param : fieldNameType - field type based on the field 
    * @param : saveForObject - Accout/Opportunity/User
    */
    /*private string prepareCriteria(List<FilterWrapper> FilterWrapperList, Map<string,string> fieldNameType, string saveForObject){
        Schema.SObjectType sobjType = Schema.getGlobalDescribe().get(saveForObject); 
        Schema.DescribeSObjectResult sobjResult = sobjType.getDescribe();
        schema.DescribeFieldResult fldResult;
        List<string> lookUpIdList = new list<string>();     
        string criteriaString ='';
        string datetimefield ='';
        List <String> dateList;
        string prefix = saveForObject == HCNA_CustomForecastConstants.filterForUser ? 'Owner' : saveForObject;
        if  (saveForObject ==HCNA_CustomForecastConstants.filterForAccount){
            prefix = saveForObject;
        }  else if (saveForObject ==HCNA_CustomForecastConstants.filterForUser){
            prefix = 'Owner';
        }
        try{
            for (FilterWrapper filterWrapper  :FilterWrapperList){
                system.debug('filterWrapper=='+'='+filterWrapper.fieldSelected+'='+filterWrapper.operatorSelected +'='+ filterWrapper.Value + ' == sobjType=='+sobjType + '==sobjResult=='+sobjResult);
                if (filterWrapper.fieldSelected != 'None'){
                    fldResult = sobjResult.fields.getMap().get(filterWrapper.fieldSelected).getDescribe();
                    system.debug('fldResult=='+fldResult.getType());                
                    if ( filterWrapper.operatorSelected == 'Like'){
                        criteriaString += prefix + '.' + filterWrapper.fieldSelected+ ' ' + filterWrapper.operatorSelected +' \'%' + filterWrapper.Value + '%\'' + ' AND ' ;
                    }else if (filterWrapper.operatorSelected != 'Like') {
                        System.debug('fieldNameType.get(filterWrapper.fieldSelected) value >>>>>>>>>>>>>>>' + fieldNameType.get(filterWrapper.fieldSelected) + '==='+ filterWrapper.Value.toUpperCase());
                        if(fieldNameType.get(filterWrapper.fieldSelected) == 'DOUBLE' || fieldNameType.get(filterWrapper.fieldSelected) == 'INTEGER'
                        || fieldNameType.get(filterWrapper.fieldSelected) == 'BOOLEAN') {
                            if (fieldNameType.get(filterWrapper.fieldSelected) == 'BOOLEAN' && (filterWrapper.Value.toUpperCase() != 'TRUE' && filterWrapper.Value.toUpperCase() != 'FALSE')){
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter either True or False value : ' + filterWrapper.fieldSelected);
                                ApexPages.addMessage(myMsg);                            
                                return null;     
                            }                     
                            criteriaString += filterWrapper.fieldSelected+ ' ' + filterWrapper.operatorSelected + filterWrapper.Value + ' AND ' ;
                        }
                        else if  (fieldNameType.get(filterWrapper.fieldSelected) == 'REFERENCE'){
                            lookUpIdList = filterWrapper.lookUprecordIds.split(',');
                            criteriaString += ' ( ';
                            for (string lookupId :lookUpIdList){
                                criteriaString +=prefix + '.' + filterWrapper.fieldSelected + ' ' + filterWrapper.operatorSelected;
                                criteriaString += ' \'' + lookupId + '\'' + ' OR ';
                            }
                            criteriaString = criteriaString.substring(0,criteriaString.length() - 3);                       
                            criteriaString += ' ) AND ';
                        }
                        else if  (fieldNameType.get(filterWrapper.fieldSelected) == 'PICKLIST'){
                            lookUpIdList = filterWrapper.value.split(',');
                            criteriaString += ' ( ';
                            for (string pickListVal :lookUpIdList){
                                criteriaString += prefix + '.' + filterWrapper.fieldSelected + ' '+ filterWrapper.operatorSelected;
                                criteriaString += ' \'' + pickListVal + '\'' + ' OR ';
                            }
                            criteriaString = criteriaString.substring(0,criteriaString.length() - 3);                       
                            criteriaString += ' ) AND ';
                        } else if(fieldNameType.get(filterWrapper.fieldSelected) ==  'DATETIME' || fieldNameType.get(filterWrapper.fieldSelected) =='DATE'){
                            datetimefield =   filterWrapper.value;               
                            DateList=datetimefield.split('-');
                            Integer size =DateList.size();
                            if(size !=3){
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter date in valid format (yyyy-mm-dd): ' + filterWrapper.fieldSelected);
                                ApexPages.addMessage(myMsg);                            
                                return null;                      
                            }                      
                            String year = DateList[0];
                            String month = DateList[1];                      
                            String day = DateList[2];
                            if( !(year.isNumeric()) || !(month.isNumeric()) || !(day.isNumeric())){
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter date in valid format (yyyy-mm-dd): ' + filterWrapper.fieldSelected);
                                ApexPages.addMessage(myMsg);                            
                                return null;                    
                            }
                            if(((integer.ValueOf(month) > 12) || ( integer.ValueOf(month) < 1)) || ((integer.ValueOf(day) > 31) || ( integer.ValueOf(day) < 1) ) || year.length() != 4){
                                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL,'Please enter valid date (yyyy-mm-dd) : ' + filterWrapper.fieldSelected);
                                ApexPages.addMessage(myMsg);                            
                                return null;                        
                            }
                            
                            String hour = '12',minute = '0',second = '0';                   
                            String operator = filterWrapper.OperatorSelected;
                            if(operator == '<' || operator == '<=')
                                hour = '00';
                            else if(operator == '>' || operator == '>='){
                                hour = '23';
                                minute = '59';
                                second = '59';
                            }
                            String stringDate = year + '-' + month + '-' + day + ' ' + hour + ':' +  minute +  ':' + second;                
                            Datetime searchDate =  datetime.valueOf(stringDate);  
                            String finalDateFormat = searchDate.format('yyyy-MM-dd');
                            if(fieldNameType.get(filterWrapper.fieldSelected) ==  'DATETIME'){                        
                                criteriaString +=  ' DAY_ONLY('  + prefix + '.' +  filterWrapper.fieldSelected + ')' + ' ' + filterWrapper.operatorSelected +' '  + finalDateFormat +  ' AND ';
                            }else{
                                criteriaString +=  prefix + '.' + filterWrapper.fieldSelected + ' ' + filterWrapper.operatorSelected +' '  + finalDateFormat +  ' AND ';
                            }
                                                                                       
                        }
                        else {
                        
                            criteriaString += prefix + '.' + filterWrapper.fieldSelected+ ' ' + filterWrapper.operatorSelected +' \'' + filterWrapper.Value + '\'' + ' AND ' ;
                        } 
                    }                                                 
                }                       
            }
            if (criteriaString.length() > 4){
                criteriaString = criteriaString.substring(0,criteriaString.length() - 4);
            }
            system.debug('criteriaString=='+criteriaString );
        }catch (exception e){
            system.debug('error in prepareCriteria' + e.getStackTraceString());
        }
        return criteriaString;
    }
    /*
    * prepare forecast filter detail object list which will store row wise data for each field selected with operator and value.
    * @param : FilterWrapperList - filter wrapper list
    * @param : saveForObject - Accout/Opportunity/User
    */
    /*private List<Forecast_Filter_Detail__c> prepareForecastFilterDetailList(List<FilterWrapper> FilterWrapperList, string saveForObject){
        Schema.SObjectType sobjType = Schema.getGlobalDescribe().get(saveForObject); 
        Schema.DescribeSObjectResult sobjResult = sobjType.getDescribe();
        schema.DescribeFieldResult fldResult;
        Forecast_Filter_Detail__c forecastFltrDetail ; 
        List<Forecast_Filter_Detail__c> forecastFltrDetailList = new   List<Forecast_Filter_Detail__c>();
        try{ 
            for (FilterWrapper filterWrapper  :FilterWrapperList){            
                if (filterWrapper.fieldSelected != 'None'){
                    fldResult = sobjResult.fields.getMap().get(filterWrapper.fieldSelected).getDescribe();
                    system.debug('filterWrapper=='+'='+filterWrapper.fieldSelected+'='+filterWrapper.operatorSelected +'='+ filterWrapper.Value);
                    //system.debug('fldResult=='+fldResult.getType());
                    forecastFltrDetail = new Forecast_Filter_Detail__c();
                    forecastFltrDetail.Field__c  = filterWrapper.fieldSelected;
                    forecastFltrDetail.Field_Type__c = string.valueof(fldResult.getType());
                    forecastFltrDetail.Filter_Value__c =filterWrapper.value;
                    forecastFltrDetail.Operator__c = filterWrapper.operatorSelected;
                    forecastFltrDetail.Sequence__c = filterWrapper.count;
                    forecastFltrDetail.Filter_LookupId__c =  filterWrapper.lookUprecordIds;
                    forecastFltrDetailList.add(forecastFltrDetail);         
                }
            }
            system.debug('forecastFltrDetail=' +forecastFltrDetailList);
        }catch (exception e){
            system.debug('error in prepareForecastFilterDetailList' + e.getStackTraceString());
        }
        return forecastFltrDetailList;
    }       
    
    /*
    ***** FilterWrapper Class Construction
    */
   /* public class FilterWrapper{  
        public Integer count {get; set;}   
        public  List<SelectOption> fieldList {get;set;}
        public String fieldSelected {get; set;}
        public List<SelectOption> operatorList{get; set;}
        public String operatorSelected {get; set; }
        Public String Value {get; set;}
        Public id forecastFilterID {get; set;}
        public String fieldType{get; set;}
        public string lookUprecordIds{get;set;}
        public String fieldReference{get; set;}
        // FilterWrapper class constructor
        public FilterWrapper() {}    
        public FilterWrapper(Integer count, List<SelectOption> fieldList ,List<SelectOption> OperatorList){
            //system.debug('=fieldList'+fieldList);
            this.count = count+1;
            this.fieldList = fieldList;
            this.fieldSelected = '';   
            this.operatorSelected='';
            this.value='';            
            this.OperatorList=OperatorList;     
            this.fieldType = '';                
        
        }*/