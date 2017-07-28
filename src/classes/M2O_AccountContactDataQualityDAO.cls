/**
@Classname :       M2O_AccountContactDataQualityDAO
@Description :     This class is written to query/DML operation on  Account.
@Author:           Avik Bannerjee
@Last Modified:    14/05/2014
**/

Public class M2O_AccountContactDataQualityDAO{
     /**
       * @Description : This method update the Account's Account Has Contact Person checkbox as checked 
       * @return      : None
     **/ 
    public static void updateAccount(List<Account> listUpdateAccount){
        try{
            if(listUpdateAccount!=null && !listUpdateAccount.isEmpty()){
                update listUpdateAccount;
             }   
        }
        catch(System.DmlException e){
            system.debug(e.getmessage());
        }    
    }
}