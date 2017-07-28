global class CMnQuoteLifeCycleOrderWithExternalCall extends REVVY.CMnLifeCycleActionScript
{
    global override Map<String, String> doAction(Map<String,String> values) 
    {
        system.debug(logginglevel.info, 'Entering Life Cycle Order with external call class');
        Id quoteId = values.get('objectId');
        try{
            
            
            M2O_CPQ_StageForIntegrationService.stageDataForIntegration(String.ValueOf(quote.Id));
            //Include the apex call for external api
            //CMnQuoteUtil.updateQuoteStatus(quoteId,'Ordered', true /* isLifeCycleActionPluginCall */);
            List<REVVY__MnQuote__c> qtList = new List<REVVY__MnQuote__c>();
            for(REVVY__MnQuote__c qt : [Select id, REVVY__Status__c FROM REVVY__MnQuote__c WHERE id =: quoteId])
            {
                REVVY__MnQuote__c qtRef = qt;
                qtRef.REVVY__Status__c = 'Ordered';
                qtList.add(qtRef);
            }
            
            upsert qtList;
            
            Map<String,String> pageRefMap = new Map<String,String>();

             pageRefMap.put('PageReference', '/apex/REVVY__PMnConvertToContract?quoteId='+ quoteId);

            return pageRefMap;
        }
        catch(exception e){
            system.debug(logginglevel.info,'Caught error: ' + e);
        }

        Map<String,String> pageRefMap = new Map<String,String>();

        pageRefMap.put('PageReference', '/'+ quoteId);

        return pageRefMap;
    }
    
    public override boolean isShowAction(Map<String, String> values) {
        system.debug(logginglevel.info, '***Test pkonda - isShowAction');
        system.debug(logginglevel.ERROR, '***Test pkonda - isShowAction');
        return true;
    }  
}