/**
@Classname :       M2O_DSRCloningController   
@Description :     This Controller is a presenter that gets the source DEAL SUPPORT REQUEST(DSR) id and invokes the bussiness logic class by passing the id as a parameter.
@Author:           Somdev Bhattacharyya
@Last Modified:    08/05/2014
**/
global class M2O_DSRCloningController {   
    /**@Description:This method is used to invoke the bussiness logic class methods.
       @Param1: Id of source DSR.
       @Return : String of URL.**/
    webService static String DSRCloningPresenter (Id sourceOppId) {
        String urlRedirect;
        M2O_DSRCloneService viewDSR = new M2O_DSRCloneService();
        //The method to clone the DSR is invoked.
        urlRedirect = viewDSR.cloneDSR(sourceOppId);
        return urlRedirect;
    }
}