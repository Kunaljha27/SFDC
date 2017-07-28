@isTest 
   public class TestBatchUpdate_AccountTeamImage
{
         static testMethod void testBatchUpdate_AccountTeamImage() 
 {        
             
 Test.startTest(); 
 BatchUpdate_AccountTeamImage bc = new  BatchUpdate_AccountTeamImage();
 bc.query = 'Select Account_ID__c, Email__c, ID__c From Account_Team_Image__c Limit 200' ;
 Database.executeBatch(bc);
       
 
 User u;
 User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        // Insert account as current user   
            System.runAs (thisUser)
              {           
               Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
                           UserRole r = [SELECT Id FROM UserRole WHERE Name='Senior VP PCCI']; 
                                      u = new User(alias = 'jsmtih21', email='jsmith424@acme.com', 
  emailencodingkey='UTF-8', lastname='Smithff', languagelocalekey='en_US',                
   localesidkey='en_US', profileid = p.Id, userroleid = r.Id,               
    timezonesidkey='America/Los_Angeles',                            
    username='jsmith1232@acme.com');            
    insert u;
    Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
      Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
      insert acc;
 /*Account acc=new Account();
acc.Name='Test1';
acc.BillingStreet='43';
acc.BillingCity='Pune';
acc.BillingState='Maharashtra';
acc.BillingPostalCode='456006';
acc.BillingCountry='CA';
insert acc;*/
    

AccountTeamMember  act=new AccountTeamMember ();
act.UserId=thisUser.id;
act.AccountId=acc.id;
insert act;
delete act;


Account_Team_Image__c accct=new Account_Team_Image__c();
accct.Account_ID__c=acc.id;
accct.Email__c='arru@gmail.com';
//accct.ID__c='test';
insert accct;

}


/*Delete_Account_Team__c deacct=new Delete_Account_Team__c();
 deacct.Name ='Test';
 insert deacct;

delete act;

//bc.query = 'Select Account_ID__c, Email__c, ID__c From Account_Team_Image__c Limit 200' ;
//Database.executeBatch(bc, 200);

           // ID batchprocessid = Database.executeBatch(bc);

          

           Datetime sysTime = System.now();

            sysTime = sysTime.addminutes(1);              

            String chron_exp = '' + sysTime.second() + ' ' + sysTime.minute() + ' ' +

            sysTime.hour() + ' ' + sysTime.day() + ' ' + sysTime.month() + ' ? ' + sysTime.year(); 
                       

  } */               
Test.stopTest(); 
 
}
}