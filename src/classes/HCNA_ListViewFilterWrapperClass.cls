/**
* @ClassName : HCNA_ListViewFilterWrapperClass
* @Description : This is the Wrapper Class for Opportunity List View Page.
* @Author : Ruchika Patil
* @Last Modified : 25/05/2014
* @Discussionpoints : No Information
**/

public class HCNA_ListViewFilterWrapperClass{  
    public Integer count {get; set;}   
    public  List<SelectOption> fieldList {get;set;}
    public String fieldSelected {get; set;}
    public List<SelectOption> operatorList{get; set;}
    public String operatorSelected {get; set; }
    Public String value {get; set;}
    Public id forecastFilterID {get; set;}
    public String fieldType{get; set;}
    public string lookUprecordIds{get;set;}
    public String fieldReference{get; set;}
    public String filterLogicOperator{get;set;}
    public HCNA_ListViewFilterWrapperClass() {
    }    
    public HCNA_ListViewFilterWrapperClass(Integer count, List<SelectOption> fieldList ,List<SelectOption> operatorList){
        this.count = count+1;
        this.fieldList = fieldList;
        this.fieldSelected = '';   
        this.operatorSelected='';
        this.value='';           
        this.operatorList=operatorList;     
        this.fieldType = ''; 
        this.filterLogicOperator = 'AND';                       
    }
}