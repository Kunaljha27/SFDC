/**
@Classname :       M2O_CPQ_TestForwardToOneEMS
@Description :     Test Class fpr M2O_CPQ_ForwardToOneEMS
@Author:           Tim(Philips)
@Last Modified:    07/14/2015
**/
@isTest(SeeAllData=false)  
private class M2O_CPQ_TestForwardToOneEMS{  
    
    private static List<StageDataForIntegration__c> testStageDataList;
        
    //Stage Data test data      
    private static List<StageDataForIntegration__c > getTestStagedata(Integer recCount){
        testStageDataList=new List<StageDataForIntegration__c >();
        StageDataForIntegration__c testStageData=null;
        for(Integer counter=0;counter<recCount;counter++){
            testStageData=new StageDataForIntegration__c ();
            testStageData.Agreement_ID__c='Test Account'+counter;
            
            testStageDataList.add(testStageData);
        }
        return testStageDataList;
    }
    
    private static TestMethod void testTrigger(){  
        test.starttest();
        
        List<StageDataForIntegration__c> sdTestList = getTestStagedata(1);
        insert sdTestList;     
         
        
        List<StageDataForIntegration__c> querySD = [Select Id, ConnectionReceivedId from StageDataForIntegration__c where Id = :sdTestList[0].Id];
        
        system.assertEquals(querySD[0].ConnectionReceivedId, null);
        
        test.stoptest();
    }        
}