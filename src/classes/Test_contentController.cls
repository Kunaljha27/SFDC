@isTest
public class Test_contentController
{
public static testMethod void Test_contentController()
 {      
 
     ContentVersion conv = new   ContentVersion();   
     conv.Origin = 'H';
      conv.PathOnClient ='test.txt';
       conv.title ='test';
     conv.versionData = Blob.valueOf('I am a file posting to Chatter');

//  ContentVersion conv1 = [Select Title from ContentVersion where Id =: conv.id];
     
  ApexPages.standardController controller = new ApexPages.standardController(conv);                
  contentController pag = new contentController(controller);          
   Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
   
   Account acc = M2O_OpportunityTestDataUtility.getAccountRecord(regionData);
   insert acc;     
 /* Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert acc;    */ 
          Note Mynt = New Note();
    mynt.parentid = acc.id;
    mynt.title ='test';
    insert mynt;         
         pag.FileName='File';
          pag.NoteId = acc.id; 
          pag.file = conv;
          pag.go();                              
      }
    }