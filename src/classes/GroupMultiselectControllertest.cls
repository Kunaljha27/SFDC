@isTest
private class GroupMultiselectControllertest {
    static testMethod void GroupMultiselectControllertest() {  
        User u;
        Account a;
        group grp;
        GroupMember GM;
        //SelectOption[] so;
        SelectOption so;
        Account_Team_Member__c ATM;
        Set<Id> GrpId = New Set<Id>();
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
       // Insert account as current user
        System.runAs (thisUser) {
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
            UserRole r = [SELECT Id FROM UserRole WHERE Name='Senior VP PCCI'];
            u = new User(alias = 'jsmtih21', email='jsmith424@acme.com', 
                emailencodingkey='UTF-8', lastname='Smithff', 
                languagelocalekey='en_US', 
                localesidkey='en_US', profileid = p.Id, userroleid = r.Id,
                timezonesidkey='America/Los_Angeles', 
                username='jsmith1232@acme.com');
            insert u;
            /*a = new Account(name='Acme',BillingCity='Pune',BillingCountry='CA',BillingPostalCode='12345',BillingState='ap',BillingStreet='Nakash');
            insert a;*/
            Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
         a = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
        insert a;

         grp = New Group(Name='PCCI');
         insert grp; 
           //so.add(grp.id);
       so = new SelectOption(grp.id,grp.name);
        }
        
        // Update account as the new user
        System.runAs(u) {
        //    a.website = 'www.salesforce.com';
           // update a;
         GM = New GRoupMember(GroupId= grp.id,UserOrGroupId=u.Id);                            
        insert GM;
        }
   /*   ATM = New Account_Team_Member__c(Account__c=a.Id,
                                          Account_Access__c = 'READ',
                                          User__c = u.Id);
                                          
       insert ATM;  */
          
  GroupMultiselectController m1 = new GroupMultiselectController (new ApexPages.StandardController(a));       
   GrpId.add(grp.id);
    m1.AccountAccess = 'Read';
    m1.OpportunityAccess = 'Read';
    m1.CaseAccess = 'read';
    m1.selectedgroups.add(so);
    m1.AccId = a.id;
   
    m1.addteam();
    m1.internalgroups(GrpId);
    }
  }