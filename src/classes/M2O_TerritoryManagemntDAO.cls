/**
* @ClassName <M2O_TerritoryManagemntDAO>
* @Description <This class is the DAO class of M2O_TeritotyManagemntSerrvice. This class performes database related action of the page(SOQL and DML)>
* @Author <Somdev Bhattacharyya>
* @Last Modified <17/07/2014>
* @Discussionpoints <No Information>
*/

public class M2O_TerritoryManagemntDAO {
    
    /**
    * @Description : This method updates user territory and sub territory data.
    * @param       : User Record.
    * @return      : Null.
    **/
    
    public static void updateUserTerritorySubTerritory (User usr) {
        try {
            update usr;
        }
        catch (DmlException e) {
            system.debug('@@@@@@@@@@@Exception occured'+e);
            Error_Handling__c error = new Error_Handling__c();
            for (Integer i = 0; i < e.getNumDml(); i++) {
                // Process exception here 
                error.Exception__c=e.getDmlMessage(i);
            }
        //insert error;
        }
    }
    /**
    * @Description : This method retrieves user territory by providing user market and sector data data.
    * @param       : User Id.
    * @return      : Territory list.
    **/
    
    public static list<Territory__c> getTerritoryData (Id userId) {
        list<User> userList = new list<User>();
        list<Territory__c> terriList = new list<Territory__c>();
        try {
            userList = [Select Market__c,Philips_Sector_Name__c from User Where Id = :userId ];
            terriList = [Select Name From Territory__c Where Market__c = :userList[0].Market__c AND Sector__c= :userList[0].Philips_Sector_Name__c];
            return terriList;
        }
        catch (QueryException e) {
            system.debug('TTTTTTTTTTTTT'+e);
            Error_Handling__c error = new Error_Handling__c();
            error.Exception__c=(String)e.getMessage();
            insert error;
            return null;
        }
    }
    
    /**
    * @Description : This method retrieves user Sub-territory by providing user market and sector data data.
    * @param       : User Id.
    * @return      : Sub-Territory list.
    **/
    
    public static list<Sub_Territory__c> getSubTerritoryData (Id userId) {
        User userList = new User();
        list<Sub_Territory__c> terri1List = new list<Sub_Territory__c>();
        list<Sub_Territory__c> terriList = new list<Sub_Territory__c>();
        list<Sub_Territory__c> sbList = new list<Sub_Territory__c>();
        try {
        system.debug('TTTTTT'+userId);
            userList = [Select Market__c,Philips_Sector_Name__c,User_Sales_Sub_Territory__c from User Where Id = :userId ];
            system.debug('TTTTTT'+userList);
            if(userList.User_Sales_Sub_Territory__c <>null) {
                system.debug('TSSST1'+userList.User_Sales_Sub_Territory__c);
                 sbList = [Select Name from Sub_Territory__c where Name=:userList.User_Sales_Sub_Territory__c AND Market__c = :userList.Market__c AND Sector__c= :userList.Philips_Sector_Name__c];
                }
            terri1List = [Select Name From Sub_Territory__c Where Market__c = :userList.Market__c AND Sector__c= :userList.Philips_Sector_Name__c];
             system.debug('TTTTTT'+terri1List);
             if(sbList <>null && sbList.size()>0) {
               for(sub_territory__c sb:sbList){
                   terriList.add(sb);
                }
            }
            for(Sub_Territory__c sub : terri1List) {
                terriList.add(sub);
            }
            return terriList;
        }
        catch (QueryException e) {
            system.debug('TTTTTTTTTTTTT'+e);
           // Error_Handling__c error = new Error_Handling__c();
            //error.Exception__c=(String)e.getMessage();
            //insert error;
            return null;
        }
    }
}