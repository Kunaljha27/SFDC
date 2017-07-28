/**    
*@Description : Wrapper class to store name and data values for GSP charts 
*@Author : Alok Bhakat
*@Last Modified : 25/06/2014
**/ 
global class HCNA_GSPChartDataWrapper{
    public String name {get; set;}
    public Decimal value {get; set;}
     
    public HCNA_GSPChartDataWrapper(String name, Decimal value){
        this.name = name;             
        this.value = value;
    }
}