/**
@Classname :       M2O_HierarchyService
@Description :     This is the service class for the hierarchy
@Last Modified:    19/4/2014
**/

public with sharing class M2O_HierarchyService{
    
    /**
    @Description: Queriy the Account records from the database
    @Param :      Account Id
    @Return:      Account record.
    **/
    public static Account getCurrentAccountRecord(String CurrentAccountId){
        Account accRecord;
        if(CurrentAccountId != Null){
            accRecord = M2O_AccountContactDAO.getCurrentAccount(CurrentAccountId);
        }
        if(accRecord != Null){
            return accRecord;
        }
        return null;
    }
    
    /**
    @Description: Queriy the Account records from the database
    @Param :      Account Id
    @Return:      Account record.
    **/
    public static List<Account> getParentChildRecord(String CurrentAccountTopLevelId, Boolean hasMoreRecord, String CurrentAccountId){
        List<Account> accParentChildList = new List<Account>();
        if(CurrentAccountTopLevelId != Null){
            if(hasMoreRecord)
                accParentChildList = M2O_AccountContactDAO.getParentChildAccountMoreRecords(CurrentAccountTopLevelId);
            else
                accParentChildList = M2O_AccountContactDAO.getParentChildAccountList(CurrentAccountTopLevelId,CurrentAccountId);
        }
        if(accParentChildList != Null && !accParentChildList.isEmpty()){
            return accParentChildList;
        }
        return null;
    }
}