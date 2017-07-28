/**
@Classname :       M2O_SchedulerUpdateContctMarketAttribute
@Description :     The scheduler class schedules the batch class M2O_BatchUpdateContactMarketAttribute.
@Author:           Piyali Saha
@Last Modified:    26/11/2013
**/
global class M2O_SchedulerUpdateContctMarketAttribute implements Schedulable {
/**
@Description: This Method is used to execute the batch class M20_BatchUpdateContctMarketAttribute
@return: void
**/

    global void execute(SchedulableContext SC) {
        
        M2O_BatchUpdateContactMarketAttribute batchUpdate = new M2O_BatchUpdateContactMarketAttribute();
        Database.executeBatch(batchUpdate);
    }
}