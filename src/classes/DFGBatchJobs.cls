public with sharing class DFGBatchJobs {
  public List<BatchJob> batchJobs;
    public Integer numberOfJobs {get; set;}
    public Boolean hasJobs = false;
    public String bulkClassName {get; set;}

  public boolean getHasBatches(){
    if (String.IsEmpty(bulkClassName) == null) {
        //bulkClassName = 'Batch_ContactSendToCrypto';
       // bulkClassName = bulkClassName;
    }
    
    List<AsyncApexJob> jobs = [select Id from AsyncApexJob
                               where ApexClass.Name = :bulkClassName //'Batch_ContactSendToCrypto'
                               order by CreatedDate desc
                               limit 1];
     system.debug('str 16 ' + jobs );                          
         if(jobs.size()>0){
           hasJobs = true;
         }
        return hasJobs;
  }

    public List<BatchJob> getBatchJobs(){
        //Create new list of BatchJobs, a wrapper class that includes the job and percent complete.
        batchJobs = new List<BatchJob>();
        
        //If number of jobs was not defined, default to 20
        if(numberOfJobs== null || numberofJobs <= 0){
            numberofJobs = 20;
        }
        
        if (String.IsEmpty(bulkClassName) == null) {
            //bulkClassName = 'Batch_ContactSendToCrypto';
           //bulkClassName = BulkClassName;
        }
        
        List<AsyncApexJob> jobs = [select TotalJobItems, Status, NumberOfErrors, MethodName, JobType,
                      JobItemsProcessed, Id, CreatedDate, CreatedById, CompletedDate,
                      ApexClassId, ApexClass.Name
                      from AsyncApexJob
                      where ApexClass.Name = :bulkClassName //'Batch_ContactSendToCrypto'
                      order by CreatedDate desc
                      limit 1];
        
         system.debug('str 44 ' + jobs ); 
         
        //Query the Batch apex jobs
        if (jobs.size()>0){
            system.debug('str 48 ' ); 
          hasJobs = true;
          for (AsyncApexJob a : jobs){
              Double itemsProcessed = a.JobItemsProcessed;
              Double totalItems = a.TotalJobItems;

              BatchJob j = new BatchJob();
              j.job = a;

              //Determine the percent complete based on the number of batches complete
              if (totalItems == 0){
                  //A little check here as we don't want to divide by 0.
                  j.percentComplete = 0;
              } else {
                j.percentComplete = ((itemsProcessed  / totalItems) * 100.0).intValue();
              }
              system.debug('str 64 ' ); 
              batchJobs.add(j);    
          }
        }
        return batchJobs;
    }

    //This is the wrapper class the includes the job itself and a value for the percent complete    
    public Class BatchJob{
        public AsyncApexJob job {get; set;}
        public Integer percentComplete {get; set;}
    }  
}