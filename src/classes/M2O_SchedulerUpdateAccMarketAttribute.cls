/**
@Classname :       M2O_SchedulerUpdateAccMarketAttribute
@Description :     The scheduler class schedules the batch class M20_BatchUpdateAccountMArketMarketAttribute.
@Author:           Piyali Saha
@Last Modified:    26/11/2013
**/
global class M2O_SchedulerUpdateAccMarketAttribute implements Schedulable {
    /**
    @Description: This Method is used to execute the batch class M2O_BatchUpdateAccountMarketAttribute
    @Param1:      SchedulableContext
    @return:      Void
    **/ 
        global void execute(SchedulableContext SC) {
            M2O_BatchUpdateAccountMarketAttribute  batchUpdate = new M2O_BatchUpdateAccountMarketAttribute ();
            Database.executeBatch(batchUpdate);
        }
}