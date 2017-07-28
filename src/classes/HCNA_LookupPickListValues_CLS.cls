/*****************************************************************************************
Name: HCNA_LookupPickListValues_CLS
Copyright © Philips
=========================================================================================
Purpose:
-------
This visual force page Controller is to 
   a. Displays the Pick List values of selected picklist field.
   
=========================================================================================
History
-------
VERSION        AUTHOR                  DATE               DETAIL                                            
1.0            Wipro                   02/04/2014          Initial Development                                                     
********************************************************************************************/

/*
* @ClassName :  HCNA_LookupPickListValues_CLS
* @Description : This class is to Display the Pick List values of selected picklist field 
* @Author : shirish Barsaniya
* @Last Modified :
* @Discussionpoints : No Information
*/   
public with sharing class HCNA_LookupPickListValues_CLS {

    private Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    private Map<String,Schema.SObjectField> fieldMap;
    private string objtName,fildName;
    private set<string> values = New set<String>();
    private List<SelectOption> allField;
    public  string Value {get;set;}
    public  List<CheckboxOption> Options {get;set;}
    public string fieldType{get;set;} 
    
    /**
    * @Description : This is a constructor of the class.
    * @param       : None
    * @return      : None
    **/       
    public HCNA_LookupPickListValues_CLS(){
        
        try{
            allField = New List<SelectOption>(); 
            objtName = ApexPages.currentPage().getParameters().get(System.Label.HCNA_OBJECT_NAME);
            fildName = ApexPages.currentPage().getParameters().get(System.Label.HCNA_FIELD_NAME);   
            fieldType = ApexPages.currentPage().getParameters().get(System.Label.HCNA_FIELD_TYPE);        
            if(objtName != NULL){            
                fieldMap = schemaMap.get(objtName).getDescribe().fields.getMap();     
                for(Schema.SObjectField sfield : fieldMap.Values()){
                    schema.describefieldresult dfield = sfield.getDescribe();
                    string fieldAPIName = dfield.getname();
                    string fieldLabel = dfield.getLabel(); 
                    if(fieldtype == 'PICKLIST' && fildName == fieldAPIName){
                        List<Schema.PicklistEntry> pickListEntries = dfield.getPicklistValues();             
                        options = new List<CheckboxOption>();
                        for(Schema.PicklistEntry picList : pickListEntries){
                            CheckboxOption check = new CheckboxOption();
                            if(picList.getValue()!='Void/Error' && picList.getValue()!='Please Specify'){
                                check.value = String.ValueOf(picList.getValue());
                                check.selected = false;
                                options.add(check);
                            }
                        }              
                    }
                    if(fieldtype=='BOOLEAN' && fildName == fieldAPIName){
                        options = new List<CheckboxOption>(); 
                        CheckboxOption check = new CheckboxOption();
                        check.value='True';   
                        check.selected = false;
                        options.add(check);
                        CheckboxOption check1 = new CheckboxOption();
                        check1.value='False';   
                        check1.selected = false;
                        options.add(check1);
                    }
                    allField.add(new SelectOption(fieldAPIName,fieldLabel));
                }                                                       
            }
        }catch(Exception e){         
        }    
    }
    
    /**
    * @Description : This is to Append all the Selected Values.
    * @param       : None
    * @return      : PageReference 
    **/     
    public PageReference Values(){    
        
        integer i = 0;  
        for(CheckboxOption checkbox :  options){
            if(checkbox.selected == true){
                if(i == 0){
                    Value = string.valueof(checkbox.value);
                    values.add(checkbox.value);
                }
                if(i > 0){
                    Value = Value +','+ string.valueof(checkbox.value); 
                }
                i = i +1;
            }
        }    
        return NULL;
    } 
    
    /**
    * @Description : This is Wrapper Class to Display the Picklist Values in VF with Check box and identify the selected value from the VF page..
    * @param       : None
    * @return      : None
    **/ 

    public class CheckboxOption {
       
       public Boolean selected { get; set; }
        public String label { get; set; }
        public String value { get; set; }
    }
}