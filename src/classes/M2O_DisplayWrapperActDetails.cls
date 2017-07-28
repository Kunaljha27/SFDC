public class M2O_DisplayWrapperActDetails{
    public Activation_Plan__c displayActivationPlan{get;set;}
    public String errorMessage{get;set;}
    public M2O_DisplayWrapperActDetails(Activation_Plan__c displayActivationPlan, String errorMessage) { 
        this.displayActivationPlan=displayActivationPlan;
        this.errorMessage=errorMessage;
    }
}