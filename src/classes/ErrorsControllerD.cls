public with sharing class ErrorsControllerD {

    public List<SObject> errors;
    public String selectedObject {get;set;} 
    public String sObjectType {get;set;}
    public boolean showText {get;set;}

    public Integer eTotalTok;
    public Integer eTotalDeTok;
    public Integer eSelectedObj;


    public ErrorsControllerD() {
        showText = false;
        selectedObject = ApexPages.currentPage().getParameters().get('SelectedObject');
        sObjectType = ApexPages.currentPage().getParameters().get('OperType');
        system.debug(selectedObject + '||' + sObjectType);
        eSelectedObj = 0;
    }

    public Integer geteTotalTok(){
        if (eTotalTok == null){
            String query = 'select count() from DFGError__c where Type__c = \'tokenization\'';
            eTotalTok = Database.countquery(query);  
        }
        return eTotalTok;
    } 

    public Integer geteTotalDeTok(){
        if (eTotalDeTok == null){
            String query = 'select count() from DFGError__c where Type__c = \'detokenization\'';
            eTotalDeTok = Database.countquery(query);  
        }
        return eTotalDeTok;
    }

    public Integer geteSelectedObj(){
        eSelectedObj = 0;
        if (selectedObject != null && selectedObject != '' && sObjectType != null && sObjectType != '') {
            String query = 'select count() from DFGError__c where Type__c =: selectedObject and SObjectType__c =: sObjectType';
            eSelectedObj = Database.countquery(query);  
        }
        return eSelectedObj;
    }


    public List<SelectOption> getSObjectsList() {
    
        List<SelectOption> soList = new List<SelectOption>();
        soList.add(new SelectOption('','-None-'));
        List<ObjectSettings__c> objSettings =  ObjectSettings__c.getall().values();
        
        if (objSettings!=null && !objSettings.IsEmpty()) {
            for(ObjectSettings__c setting: objSettings){
                soList.add(new SelectOption(setting.Name,setting.Name));
            }
        }
 
        return soList;
    }

    public List<SelectOption> getSOList() {
        
        List<SelectOption> soList = new List<SelectOption>();
        soList.add(new SelectOption('','-None-'));
        soList.add(new SelectOption('tokenization','Tokenization'));
        soList.add(new SelectOption('detokenization','Detokenization'));
         
        return soList;
    }

    public List<DFGError__c> geterrors(){
        errors = new List<DFGError__c>();
        system.debug('in geterrors! selectedObject > ' + selectedObject + '; sObjectType > ' + sObjectType); 
        if (selectedObject != null && selectedObject != '' && sObjectType != null && sObjectType != '') {
            errors = [select Id, Name, Message__c, Failed__c, BatchJobId__c, Type__c from DFGError__c 
                      where Type__c =: selectedObject and SObjectType__c =: sObjectType
                      limit 200];
            system.debug('errors = ' + errors);   

            String query = 'select count() from DFGError__c where Type__c =: selectedObject and SObjectType__c =: sObjectType';
            eSelectedObj = Database.countquery(query);  
        }

        return errors;
    }

    public void empty(){
        system.debug('in empty! selectedObject > ' + selectedObject);
    }

}