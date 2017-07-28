public class M2O_ActivationPlanWrapperTypCatActivity {
    public string activityType{get; set;}
    public string activityCategory{get; set;}
    public list<list<M2O_ActivationPlanWrapperActDetails>> activity{get; set;}  
    public list<M2O_ActivationPlanWrapperActDetails> activityOnMonths{set; get;}             
    public M2O_ActivationPlanWrapperTypCatActivity(string typeReceived, string categoryReceived) {
        activityType = typeReceived;
        activityCategory = categoryReceived;
        activity= new list<list<M2O_ActivationPlanWrapperActDetails>>();
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths); 
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths); 
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>(); 
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths); 
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>(); 
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();    
        activity.add(activityOnMonths);  
        activityOnMonths= new list<M2O_ActivationPlanWrapperActDetails>();  
        activity.add(activityOnMonths);        
    }
}