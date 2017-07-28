/**
* @ClassName : M2O_ExtendedWarrantyValueBatch
* @Description : This bach class will update Extended warenty value on produt line
* @Author : Navaneet Pujar
* @Last Modified : 9 March 2016
* @Discussionpoints : No Information
*/
global class M2O_ExtendedWarrantyValueBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext BC){
        //set<Id> ids = new set<Id>();
        //ids.add('006d000000K7mU9AAJ');
        //ids.add('006d000000K73MNAAZ');
        //ids.add('006d000000K73Y6AAJ');
        //ids.add('006d000000K7mJbAAJ');
        return Database.getQueryLocator([SELECT Id, Extended_warranty_value_New__c,Extended_Warranty_Value__c FROM Opportunity WHERE Extended_Warranty_Value__c != null]);
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope){
         
         Set<Id> opptyProdIds = new Set<Id>();
         Map<Id, Decimal> opptyLineItemMap = new Map<Id, Decimal>();
         Map<Id, Map<Id, Decimal>> OppLineMap = new Map<Id, Map <Id, Decimal>>();
         Map<Id,Decimal> updateOppLine = new Map<Id,Decimal>();
         List <OpportunityLineItem> updateLineList = new List<OpportunityLineItem>();
                  
         for(Opportunity opp : scope){
             opptyProdIds.add(opp.Id);
             system.debug('@@@@@'+opptyProdIds);
           }
         
         List<OpportunityLineItem> opptylineProd = [Select Id, TotalPrice,Opportunity.Extended_warranty_value_New__c,Opportunity.Extended_Warranty_Value__c,Extended_warranty_value__c from OpportunityLineItem where OpportunityId in:opptyProdIds];
         system.debug('@@@@@'+opptylineProd);
         for(OpportunityLineItem oppLI : opptylineProd){
            //Id oppLIid;
            if(opptyLineItemMap.get(oppLI.OpportunityId)==null) {
                   opptyLineItemMap.Put(oppLI.OpportunityId,oppLI.TotalPrice);
                   //oppLIid = oppLI.id;
                   system.debug('@@@@@opptyLineItemMapIf'+ opptyLineItemMap);
                   OppLineMap.put(oppLI.OpportunityId,new Map<Id,Decimal>{oppLI.Id => oppLI.Opportunity.Extended_Warranty_Value__c});
            }
            else {
                    if(oppLI.TotalPrice > opptyLineItemMap.get(oppLI.OpportunityId)){
                    opptyLineItemMap.put(oppLI.OpportunityId, oppLI.TotalPrice);
                    //oppLIid = oppLI.id;
                    system.debug('@@@@@opptyLineItemMapElse'+ opptyLineItemMap);
                    OppLineMap.put(oppLI.OpportunityId,new Map<Id,Decimal>{oppLI.Id => oppLI.Opportunity.Extended_Warranty_Value__c});
                }
            }
            //if(oppLIid !=null){
                system.debug('@@@@@Latestoppli'+ oppLI);
                
                //OppLineMap.put(oppLI.OpportunityId,new Map<Id,Decimal>{oppLI.Id => oppLI.Opportunity.Extended_Warranty_Value__c});
                system.debug('@@@@@OppLineMap'+OppLineMap);
            //}
        }
        system.debug('@@@@@OppLineMap'+OppLineMap);
        
        OpportunityLineItem LineItemRecord ;
        
        for(Id Key : OppLineMap.keySet()){
        
             updateOppLine = OppLineMap.get(Key);
             system.debug('@@@@@updateOppLine'+updateOppLine);
             for(Id key1 : updateOppLine.KeySet()){
                LineItemRecord = new OpportunityLineItem(Id= Key1);
                LineItemRecord.Extended_Warranty_Value__c  = updateOppLine.get(Key1);
                updateLineList.add(LineItemRecord);
            }
        }
              
        system.debug('@@@@@updateLineList'+updateLineList);
        update updateLineList;
    }
    
    global void finish(Database.BatchableContext BC){
    }
}