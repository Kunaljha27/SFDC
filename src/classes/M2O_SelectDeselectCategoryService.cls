/**
@Classname :       M2O_SelectDeselectCategoryService 
@Description :     The Service class is invoked from 'M2O_DeselectAllCategory' trigger. All the PPP category fields will be unchecked.
@Author:           Dipali Vijapure
@Last Modified:    25/04/2014
**/
public with sharing class M2O_SelectDeselectCategoryService {
 
    public static void updateCategoryFlag ( List<Retail_Contract__c> contractsList) {
        if(contractsList != null && !contractsList.isempty()) {
         //Iterate over the Contracts list
            for(Retail_Contract__c cont : contractsList) {
                 //updating Ctaegory Values to 'True'
                 if(cont.Select_Deselect_all_category__c  == true && cont.Flag_for_select__c==false){
                     cont.Air_PPP__c  = true;
                     cont.Beauty_PPP__c = true;
                     cont.Beverage_Appliance_PPP__c = true;
                     cont.Espresso_Domestic_PPP__c = true;
                     cont.Floor_Care_PPP__c = true;
                     cont.Garment_Care_PPP__c = true;
                     cont.Kitchen_Appliances_PPP__c = true;
                     cont.Male_Grooming_PPP__c = true;
                     cont.Mother_Child_Care_PPP__c = true;
                     cont.Pain_Management_PPP__c = true;
                     cont.Philips_Oral_Healthcare_PPP__c = true;
                     cont.Flag_for_select__c=true;
                     cont.Flag_to_de_select__c=False;
                 }
                 
                 //updating Ctaegory Values to 'False'    
                 if(cont.Select_Deselect_all_category__c  == false && cont.Flag_to_de_select__c==False &&cont.Air_PPP__c  == true && cont.Beauty_PPP__c == true && cont.Beverage_Appliance_PPP__c == true && cont.Espresso_Domestic_PPP__c == true && cont.Floor_Care_PPP__c == true && cont.Garment_Care_PPP__c == true && cont.Kitchen_Appliances_PPP__c == true && cont.Male_Grooming_PPP__c == true && cont.Mother_Child_Care_PPP__c == true && cont.Mother_Child_Care_PPP__c == true && cont.Pain_Management_PPP__c == true && cont.Philips_Oral_Healthcare_PPP__c == true){
                     cont.Flag_to_de_select__c=true;
                     cont.Flag_for_select__c=false;
                     cont.Air_PPP__c  = false;
                     cont.Beauty_PPP__c = false;
                     cont.Beverage_Appliance_PPP__c = false;
                     cont.Espresso_Domestic_PPP__c = false;
                     cont.Floor_Care_PPP__c = false;
                     cont.Garment_Care_PPP__c = false;
                     cont.Kitchen_Appliances_PPP__c = false;
                     cont.Male_Grooming_PPP__c = false;
                     cont.Mother_Child_Care_PPP__c = false;
                     cont.Pain_Management_PPP__c = false;
                     cont.Philips_Oral_Healthcare_PPP__c = false;
                 }
                 
                 //Reset the 'Select/Dselect' flag to 'False'
                 if(cont.Select_Deselect_all_category__c  == true && cont.Flag_for_select__c==true &&(cont.Air_PPP__c  == false || cont.Beauty_PPP__c == false || cont.Beverage_Appliance_PPP__c == false || cont.Espresso_Domestic_PPP__c == false || cont.Floor_Care_PPP__c == false || cont.Garment_Care_PPP__c == false || cont.Kitchen_Appliances_PPP__c == false || cont.Male_Grooming_PPP__c == false || cont.Mother_Child_Care_PPP__c == false || cont.Mother_Child_Care_PPP__c == false || cont.Pain_Management_PPP__c == false || cont.Philips_Oral_Healthcare_PPP__c == false)){
                     cont.Select_Deselect_all_category__c = false;
                     cont.Flag_for_select__c = false;
                     cont.Flag_to_de_select__c=true;  
                 }
                 
               }
            }
        
    }

}