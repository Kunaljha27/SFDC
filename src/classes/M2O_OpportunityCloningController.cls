/**
@Classname :       M2O_OpportunityCloningController   
@Description :     This Controller is a presenter that gets the source opportunity id and invokes the bussiness logic class by passing the id as a parameter.
@Author:           Somdev Bhattacharyya
@Last Modified:    13/11/2013
**/
global class M2O_OpportunityCloningController {   
    /**@Description:This method is used to invoke the bussiness logic class methods.
       @Param1: Id of source Opportunity.
       @Return : String of URL.**/
    webService static String OpportunityCloningPresenter (Id sourceOppId) {
        String urlRedirect;
        Opportunity clonedOpportunity = new Opportunity();
        M2O_OpportunityCloneService viewOpportunity = new M2O_OpportunityCloneService();
        //The method to clone the opportunity is invoked.
        clonedOpportunity  = viewOpportunity.cloneOpportunity(sourceOppId);
        //The method to clone the related opportunity EcoSystem.
        viewOpportunity.cloneOpportunityEcoSystem(sourceOppId,clonedOpportunity);
        //The method to clone the related opportunity Team Member
        viewOpportunity.cloneOpportunityTeamMember(sourceOppId,clonedOpportunity);
        //The method to clone the related opportunity line item and returning the base url of the cloned opportunity edit page.
        urlRedirect = viewOpportunity.cloneOpportunityLineItem(sourceOppId,clonedOpportunity);
        return urlRedirect;
    }
}