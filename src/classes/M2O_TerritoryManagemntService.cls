/**
* @ClassName <M2O_TerritoryManagemntService>
* @Description <This class is the Serviceclass of User sales territory and sub territory management vf page . This class performes bussiness logic related to M2O_TerritoryManagement vf page>
* @Author <Somdev Bhattacharyya>
* @Last Modified <17/07/2014>
* @Discussionpoints <No Information>
*/

public class M2O_TerritoryManagemntService {
    public  Id userId       {get;set;}
    public String fullFileURL {get; set;}
    public M2O_TerritoryManagemntService() {}
    public String territoryList {get;set;}
    public String subterritoryList { get; set;}
    public M2O_TerritoryManagemntService(ApexPages.StandardController controller) {
        userId = controller.getRecord().Id;   
    }
    /**
    * @Description : This method retrevies retrieves territory and 
                     sub territoy information and also updates the user..
    * @param       : none
    * @return      : null.
    **/
    public PageReference subTerritoryAddition() {
        User usr = new User();
        usr.Id = userId;
        usr.User_Sales_Territory__c = territoryList; 
        usr.User_Sales_Sub_Territory__c = subterritoryList;
        if(usr != null ) { 
            system.debug('@@@@@@@@@usr'+usr);
            M2O_TerritoryManagemntDAO.updateUserTerritorySubTerritory (usr);
        }
        PageReference userPage = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' +userId+'?noredirect=1');
        userPage.setRedirect(true);
        return null;
    }   
    
    /**
    * @Description : This method retrevies retrieves and shows territory 
                     information on the page..
    * @param       : none
    * @return      : list of SelectOption.
    **/
    
    public list <SelectOption> getitems () {
        list<Territory__c> terriList = new list<Territory__c>();
        terriList = M2O_TerritoryManagemntDAO.getTerritoryData(userId);
        List<SelectOption> options = new List<SelectOption>();
        for(Territory__c terri : terriList) {
            options.add(new SelectOption(terri.Name,terri.Name));
        } 
        return options;
    }
    
    /**
    * @Description : This method retrevies retrieves and shows sub territory 
                     information on the page..
    * @param       : none
    * @return      : list of SelectOption.
    **/
        
    public list <SelectOption> getitemsSub () {
        list<Sub_Territory__c> subTerriList = new list<Sub_Territory__c>();
        subTerriList = M2O_TerritoryManagemntDAO.getSubTerritoryData(userId);
        List<SelectOption> options = new List<SelectOption>();
        for(Sub_Territory__c  terri : subTerriList) {
            options.add(new SelectOption(terri.Name,terri.Name));
        }
        options.add(new SelectOption('','')) ;
        return options;
    }
     
}