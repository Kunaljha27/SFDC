public class HCNA_FilterWrapper{  
        public Integer count {get; set;}   
        public  List<SelectOption> fieldList {get;set;}
        public  List<SelectOption> fieldListTemp;
        public String fieldSelected {get; set;}
        public List<SelectOption> operatorList{get; set;}
        public String operatorSelected {get; set; }
        Public String Value {get; set;}
        Public id forecastFilterID {get; set;}
        public String fieldType{get; set;}
        public string lookUprecordIds{get;set;}
        public String fieldReference{get; set;}        
        public HCNA_FilterWrapper() {
        }    
        public HCNA_FilterWrapper(Integer count, List<SelectOption> fieldList ,List<SelectOption> OperatorList){
            this.count = count+1;
            this.fieldList = fieldList;
            this.fieldSelected = '';   
            this.operatorSelected='';
            this.value='';            
            this.OperatorList=OperatorList;     
            this.fieldType = '';                        
        }
    }