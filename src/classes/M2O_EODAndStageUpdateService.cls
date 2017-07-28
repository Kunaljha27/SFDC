/**
@Classname :       M2O_EODAndStageUpdateService
@Description :     The Service class is invoked for the bussiness logic to performed on Opportuinty for
                   Expected Order Date and Stage Update from Master Opportunity.       
@Author:           Somdev Bhattacharyya
@Last Modified:    01/09/2014
**/
public with sharing class M2O_EODAndStageUpdateService {

    /**Method that contains all the business logic to performed on Opportuinty
       for Expected Order Date and Stage Update from Master Opportunity. **/
    public void EODAndStageUpdate (list<Opportunity> opportunityList , set<Id> opportunityIdSet) {
        list<opportunity> masterOpptyList = new list<opportunity>();
         //Method to get the master opportunity list .
        masterOpptyList = M2O_OpportunityDAO.getOpportunityEOD(opportunityIdSet);
        for (Opportunity oppty : opportunityList ) {
            for (Opportunity masOppty :masterOpptyList) {
                if(oppty.Opportunity_Hierarchy_Link__c == masOppty.id) {
                    if (masOppty.Update_Sub_opportunity_Stage__c == True) {
                    system.debug('@@@@@@@@@'+masOppty.StageName);
                        if(masOppty.StageName==M2O_DataUtility.QualifyMaster) {
                            oppty.StageName=M2O_DataUtility.Qualify;
                        }
                        else if (masOppty.StageName==M2O_DataUtility.DevelopMaster) {
                            oppty.StageName=M2O_DataUtility.DevelopSub;    
                        }  
                        else if (masOppty.StageName==M2O_DataUtility.ProposeMaster) {  
                            oppty.StageName=M2O_DataUtility.ProposeSub;        
                        }
                        else if (masOppty.StageName==M2O_DataUtility.SalesRecognizedMaster) {
                            oppty.StageName=M2O_DataUtility.SalesRecognizedSub;            
                        }
                        else if (masOppty.StageName==M2O_DataUtility.DistributingMaster) {
                            oppty.StageName=M2O_DataUtility.DistributingSub;   
                        }
                    }    
                    if (masOppty.Update_Sub_oppty_Expected_Order_Da__c == True) {
                        oppty.CloseDate=masOppty.CloseDate;    
                    }
                }
            }        
        }                
    }  
    public void EODAndStageUpdateThroughMaster (list<Opportunity> opportunityList,set<Id> opportunityIdSet) {
        List<Opportunity> subOpportunityList = new List<Opportunity>();
        list <Opportunity> newSubOpportunityList = new list<Opportunity>();
        subOpportunityList = M2O_OpportunityDAO.getSubOpportunityId(opportunityIdSet);
         for (Opportunity suboppty : subOpportunityList) {
         opportunity oppty ;
        system.debug('for master method');
            //oppty = new opportunity (Id = suboppty.Id);
            for(Opportunity masoppty : opportunityList) {
            system.debug('for master method0');
                if(suboppty.Opportunity_Hierarchy_Link__c == masOppty.id) {
                    if (masOppty.Update_Sub_opportunity_Stage__c == True) {
                    oppty = new opportunity (Id = suboppty.Id);
                    system.debug('for master method1'+oppty);
                        if(masOppty.StageName==M2O_DataUtility.QualifyMaster) {
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.StageName=M2O_DataUtility.Qualify;           
                        }
                        else if (masOppty.StageName==M2O_DataUtility.DevelopMaster) {
                        system.debug('for master method2');
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.StageName=M2O_DataUtility.DevelopSub;    
                        }  
                        else if (masOppty.StageName==M2O_DataUtility.ProposeMaster) {  
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.StageName=M2O_DataUtility.ProposeSub;        
                        }
                        else if (masOppty.StageName==M2O_DataUtility.SalesRecognizedMaster) {
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.StageName=M2O_DataUtility.SalesRecognizedSub;            
                        }
                        else if (masOppty.StageName==M2O_DataUtility.DistributingMaster) {
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.StageName=M2O_DataUtility.DistributingSub;
                        }  
                        else if (masOppty.StageName==M2O_DataUtility.NotPursuing) {                          
                            oppty.StageName=M2O_DataUtility.NotPursuing;
                        }  
                        else if (masOppty.StageName==M2O_DataUtility.CancelledbyCustomer) {                          
                            oppty.StageName=M2O_DataUtility.CancelledbyCustomer;
                        }
                        else if (masOppty.StageName==M2O_DataUtility.Lost) {                          
                            oppty.StageName=M2O_DataUtility.Lost;   
                        }
                        else if (masOppty.StageName==M2O_DataUtility.ProposalAcceptedMaster) {                          
                            oppty.StageName=M2O_DataUtility.ProposeSub;   
                        }
                    }   
                    if (masOppty.Update_Sub_oppty_Expected_Order_Da__c == True) {
                            //oppty = new opportunity (Id = suboppty.Id);
                            oppty.CloseDate=masOppty.CloseDate;    
                    }
                     
                    }
                    }
                    If(Oppty!= null){
                    newSubOpportunityList.add(oppty);
                    system.debug('for method3'+newSubOpportunityList);
                      }
                    }
                    If(newSubOpportunityList != null && !newSubOpportunityList.IsEmpty()){
                        system.debug('for method4'+newSubOpportunityList);
                        update newSubOpportunityList;
                    }   
            }
    }