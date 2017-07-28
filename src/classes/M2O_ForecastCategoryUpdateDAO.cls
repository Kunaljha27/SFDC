/**
* @ClassName <M2O_ForecastCategoryUpdateDAO>
* @Description <This class is the DAO class of M2O_ForecastCategoryUpdateController. This class performes database related action of the page(SOQL and DML)>
* @Author <Somdev Bhattacharyya>
* @Last Modified <17/09/2014>
* @Discussionpoints <No Information>
*/

public class M2O_ForecastCategoryUpdateDAO {
    
    /**
    * @Description : This method updates Opportunity forecast category data.
    * @param       : opportunity Record.
    * @return      : Null.
    **/
    
    public static void updateForecasteCategory (Opportunity opp) {
        try {
            update opp;
        }
        catch (DmlException e) {
            M2O_ErrorHandling.errorHandling(e);
        }
    }
    

    
    /** 
    * @Description : This method gets opportunity owner role hierarchy.
    * @param       : Id of Opportunity and current User Id
    * @return      : Boolean.
    **/
     public static Boolean roleBasedForcasteChange (Id opportunityId,Id currentUserRoleId) {
         try {
            Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{currentUserRoleId});
            Boolean flag ;
            Account acc;
            Map<Id,User> usersMap;
            Opportunity opp = [SELECT CreatedById,OwnerId FROM Opportunity where Id=:opportunityId];
            User usr = new User();
            usr=[Select Name,AccountId,ContactId,Id,IsActive,IsPortalEnabled from User where id=:opp.CreatedById];
            if(usr.IsPortalEnabled==true) {
                system.debug('I am inside partner check'+usr);
                acc = new Account();
                acc=[select OwnerId from Account where Id = :usr.AccountId];
                usersMap = new Map<Id,User>([Select Id, Name From User where  Id =:acc.OwnerId]);
                system.debug('I am inside partner check'+usersMap);     
            }
            else {
            system.debug('iam inside else part');
                 usersMap = new Map<Id,User>([Select Id, Name From User where UserRoleId IN :allSubRoleIds]);
            }    
            system.debug('WWWWWWWWWWWWWWWWWW'+usersMap);
            flag=true;
            for(id userId :usersMap.keySet() ) {
                if(opp.OwnerId==userId ) {
                   flag=false;
                   break;    
                }
                else if (acc !=null) {
                     if(acc.OwnerId==userId) {
                          flag=false;
                          break;    
                     }
                }    
            } system.debug('Flag :'+flag); 
            return flag;
        }
        catch (Exception e) {
            system.debug(e);
            return null;
        }    
        
    }
    /** 
    * @Description : This method gets opportunity owner role hierarchy.
    * @param       : set of role Id.
    * @return      : set of role ids.
    **/
    
    public static Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        try {
            Set<ID> currentRoleIds = new Set<ID>();
            
            // get all of the roles underneath the passed roles
            for(UserRole userRole :[select Id from UserRole where ParentRoleId IN :roleIds AND ParentRoleID != null]) {
                currentRoleIds.add(userRole.Id);
             }
            // go fetch some more rolls!
            if(currentRoleIds.size() > 0) {
              currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
            }
            return currentRoleIds;
         }
         catch (Exception e) {
            M2O_ErrorHandling.errorHandling(e);
            return null;
        }       
    
  }
}