/**
* @ClassName :M2O_UpdateNamesService 
* @Description : This class is the business class for M2O_UpdateNames trigger
* @Author : Vishal Kashyap
* @Last Modified : 14/11/2014
* @Discussionpoints : No Information
*/
public class M2O_UpdateNamesService {
    
    /**
    * @Description : This method fetches and updates the record from opportunity team member using opportunity Id.
    * @param       : set of opportunity ids
    * @return      : void
    **/ 
    public void updateProductHierarchyNames(List<Product_Hierarchy__c> newTriggerRecordsList,List<Product_Hierarchy__c> oldTriggerRecordsList){
        
        Integer counter = 0;
        Map<String, Product_Adjustment_ID__c> productIDNameMap = Product_Adjustment_ID__c.getAll();
        
        if(newTriggerRecordsList!= null && !newTriggerRecordsList.isEmpty()){
            for(Product_Hierarchy__c loopVar : newTriggerRecordsList) {                
                if((Product_Adjustment_ID__c.getValues(loopVar.Sector_ID__C)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Sector_ID__C).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Sector_ID__C).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Sector_ID__C).Type__c == 'Sector')) {
                    loopVar.Sector_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Sector_ID__C).Corresponding_Name__c;
                } else if(loopVar.Sector_ID__C == null || loopVar.Sector_ID__C == '') {
                    loopVar.Sector_Name__c = '';
                }
                if((Product_Adjustment_ID__c.getValues(loopVar.Business_Group_ID__c)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Business_Group_ID__c).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Business_Group_ID__c).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Business_Group_ID__c).Type__c == 'Business Group')) {
                    loopVar.Business_Group_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Business_Group_ID__c).Corresponding_Name__c;
                } else if(loopVar.Business_Group_ID__c==null || loopVar.Business_Group_ID__c== '') {
                    loopVar.Business_Group_Name__c = '';
                }
                if((Product_Adjustment_ID__c.getValues(loopVar.Business_Unit_ID__c)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Business_Unit_ID__c).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Business_Unit_ID__c).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Business_Unit_ID__c).Type__c == 'Business Unit')) {
                    loopVar.Business_Unit_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Business_Unit_ID__c).Corresponding_Name__c;
                } else if(loopVar.Business_Unit_ID__c==null || loopVar.Business_Unit_ID__c== '') {
                    loopVar.Business_Unit_Name__c = '';
                }
                if(loopVar.Article_Group_ID__c ==null || loopVar.Article_Group_ID__c== '') {
                    loopVar.Article_Group_Name__c = '';
                }else if((Product_Adjustment_ID__c.getValues(loopVar.Article_Group_ID__c)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Article_Group_ID__c).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Article_Group_ID__c).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Article_Group_ID__c).Type__c == 'Article Group')) {
                    loopVar.Article_Group_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Article_Group_ID__c).Corresponding_Name__c;
                } 
                if((Product_Adjustment_ID__c.getValues(loopVar.Main_Article_Group_ID__c)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Main_Article_Group_ID__c).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Main_Article_Group_ID__c).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Main_Article_Group_ID__c).Type__c == 'Main Article Group')) {
                    loopVar.Main_Article_Group_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Main_Article_Group_ID__c).Corresponding_Name__c;
                } else if(loopVar.Main_Article_Group_ID__c==null || loopVar.Main_Article_Group_ID__c== '') {
                    loopVar.Main_Article_Group_Name__c = '';
                }
                if((Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c)!=null) && (Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c).Corresponding_Name__c != null && Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c).Corresponding_Name__c != '' && Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c).Type__c == 'Sub Article Group')) {
                    system.debug('What is this'+Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c).Corresponding_Name__c != null);
                    loopVar.Sub_Article_Group_Name__c = Product_Adjustment_ID__c.getValues(loopVar.Sub_Article_Group_ID__c).Corresponding_Name__c;
                } else if(loopVar.Sub_Article_Group_ID__c == null || loopVar.Sub_Article_Group_ID__c == '') {
                    loopVar.Sub_Article_Group_Name__c = '';
                }
                counter++;
            }
        }
    }
}