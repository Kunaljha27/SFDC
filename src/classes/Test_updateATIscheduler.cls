@istest

public class Test_updateATIscheduler {

   static testmethod void testupdateATIscheduler() {
   
updateATIscheduler sco = new updateATIscheduler();
       // Insert account as current user   
 
       User uu,uu1;
       User thisUser = [ select Id,ProfileId,UserRoleid from User where Id = :UserInfo.getUserId() ];
       System.runAs ( thisUser ) {
        uu = new User();
       Userrole UR = [select id,Name from UserRole where Name LIKE 'P%' Limit 1];
       uu.firstname='rahul';
       uu.lastname='shaw';
       uu.Alias='RDiNaq';
       uu.Email='rahul@wipro.com';
       uu.Username='rahulshaw@abc.com';
       uu.CommunityNickname='reneedinardo';
       uu.EmailEncodingKey='ISO-8859-1';
       uu.TimeZoneSidKey='America/Los_Angeles';
       uu.LocaleSidKey='en_US';
       uu.LanguageLocaleKey='en_US';
       uu.Profileid=thisUser.ProfileId;
       uu.UserRoleid=thisUser.UserRoleid;
       uu.Market__c='North America';
       uu.Philips_Sector_Name__c='HC';
       insert uu;  
       
        uu1 = new User();
       
       uu1.firstname='rahul1';
       uu1.lastname='shaw1';
       uu1.Alias='RDiNaq1';
       uu1.Email='rahul1@wipro.com';
       uu1.Username='rahulshaw1@abc.com';
       uu1.CommunityNickname='reneedinardo1';
       uu1.EmailEncodingKey='ISO-8859-1';
       uu1.TimeZoneSidKey='America/Los_Angeles';
       uu1.LocaleSidKey='en_US';
       uu1.LanguageLocaleKey='en_US';
       uu1.Profileid=thisUser.ProfileId;
       uu1.UserRoleid=thisUser.UserRoleid;
       uu1.Market__c='North America';
       uu1.Philips_Sector_Name__c='HC';
       insert uu1;  
       
         
      }
System.runAs ( uu ) {
    Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert acc;     
  
  AccountTeamMember atm = new AccountTeamMember(TeamMemberRole='Sales Specialist Hospital Central', AccountId=acc.id, userid= uu1.id);
  insert atm;
  
  Account_Team_Image__c ati = new Account_Team_Image__c(Account_ID__c =acc.id,Email__c=uu1.Email, ID__c= atm.id);
      insert  ati;   
}


System.runAs ( thisUser ) {
test.starttest();                        
       String sch = '1 6 23 1 5 ?';  
      system.schedule('Contract Creates1', sch, sco);
           test.stopTest();

   
   }
   }
   }