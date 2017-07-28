/**
* @ClassName : M2O_AccountShareUpdateBatchScheduler
* @Description : This is Scheduler M2O_AccountShareUpdateBatch class.
* @Author : Navaneet Pujar
* @Last Modified : 28 May 2015
* @Discussionpoints : No Information
*/
global class M2O_AccountShareUpdateBatchScheduler implements Schedulable{
    global void execute(SchedulableContext sc) {
        M2O_AccountShareUpdateBatch b = new M2O_AccountShareUpdateBatch (); 
        database.executebatch(b,200);
    }
}