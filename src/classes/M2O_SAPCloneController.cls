global class M2O_SAPCloneController {




List<sObject> fianlChildList = new List<Sobject>();

    webservice static String getCreatedById(Id recordId,String queryObject, String whereParam){
        M2O_SAPCloneService serviceClass = new M2O_SAPCloneService();
        String createdByName;
        Id createdById;
        String query = 'Select id,OwnerID from ' + queryobject + ' where ' +whereParam +' =:recordID limit 1';
        List<sObject> result = new List<sObject>();
        result = serviceClass.getCreatedByUser(query,recordId,queryObject,whereParam);
        createdById = String.valueOf(result[0].get('OwnerID') );
        return createdById;
    }
    
    webservice static String getCurrentUserId(){
        String currentUsrId;
        currentUsrId = String.valueOf(UserInfo.getUserId());
        return currentUsrId;     
    }
    
    webservice static string getCreatableFieldsSOQL(String objectName, String whereClause, String[] chk){
        M2O_SAPCloneService serviceClass = new M2O_SAPCloneService();
        Set<String> check = new Set<String>();
        check.addAll(chk); 
        String selects = '';
         
        if (whereClause == null || whereClause == ''){
            return null;
        }
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
        
        if (fMap != null){
            for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                if (fd.isCreateable() && !check.contains(fd.getName())){ // field is creatable
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()){
            for (string s:selectFields){
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
             
        }
         
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
         
    }
    
    webservice static String cloneAndRedirect(Id sourceSAPId) {
        M2O_SAPCloneService serviceClass = new M2O_SAPCloneService();
        String fullFileURL;
        List<sObject> clonedChildList;
        Strategic_Account_Plan__c clonedSAP;
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get('Strategic_Account_Plan__c');
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get('SAP_Clone_Excluded_Fields');
        List<Schema.FieldSetMember> fsList = fieldSetObj.getFields();
        List<String> chk = new List<String>();
        for(Schema.FieldSetMember fs : fsList){
            chk.add(fs.getFieldPath());
        }
        String query = getCreatableFieldsSOQL('Strategic_Account_Plan__c', 'ID = :sourceSAPID ',chk);
        clonedSAP = Database.Query(query);
        clonedSAP .ID = null;
        serviceClass.insertClonedSAP(clonedSAP);
        Id newSAP = clonedSAP.id;
        Map<String, SAP_Clone_Objects__c> objectList = SAP_Clone_Objects__c.getAll();
        List<String> fieldsToBeExcluded = new List<String>();
        
        for(String objToBeCloned : objectList.keySet()){
            
            if(objectList.get(objToBeCloned).Fields_to_exclude__c != null){
                fieldsToBeExcluded = objectList.get(objToBeCloned).Fields_to_exclude__c.split(',');
            }
            String childquery = getCreatableFieldsSOQL(objToBeCloned, 'Strategic_Account_Plan__c = :sourceSAPID',fieldsToBeExcluded);
            clonedChildList = serviceClass.getChildRecords(childquery,sourceSAPID);
            objectlist.get(objToBeCloned);
            
            for(Sobject clonedChild :clonedChildList){
                clonedChild.put('Strategic_Account_Plan__c',newSAP);
                clonedChild.id=null;
                serviceClass.insertClonedChild(clonedChild);
            }
        }
        fullFileURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + clonedSAP.Id +'/e?retURL=%2F'+clonedSAP.Id;
        return fullFileURL;
   }

}