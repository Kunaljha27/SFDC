@istest(SeeAllData=True) 
public class Test_Delay_AddSalesTeam{
    static testMethod void Delay_AddSalesTeam_test(){

                     
                    List<Opportunity>  newop=new List<Opportunity>();
                    List<Opportunity> oldopp=new List<Opportunity>();
                     Profile p = [select id from profile where name='System Administrator']; 
                     UserRole    listuserRole =  [select id , name from UserRole limit 1  ];
                      User testUser1 = new User(alias = 'u1', email='u1@testorg.com',Market__c='North America', Philips_Sector_Name__c='HC',
                                                                          emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
                                                                           localesidkey='en_US', profileid = p.Id, country='United States',
                                                                           timezonesidkey='America/Los_Angeles', username='u1@testorg123.com'); 
                       insert testUser1;
                      User testUser2 = new User(alias = 'u2', email='u2@testorg.com',Market__c='North America', Philips_Sector_Name__c='HC',
                                                                      emailencodingkey='UTF-8', lastname='Testing2', languagelocalekey='en_US',
                                                                         localesidkey='en_US', profileid = p.Id, country='United States',
                                                                           timezonesidkey='America/Los_Angeles', username='u2@testorg1234.com'); 
                         insert testUser2;
       
                   System.runAs(testUser1){
                    Region__c regionData=  M2O_OpportunityTestDataUtility.getRegionData();
        insert regionData; 
        
  Account acc = new Account(name = 'test acc', BillingState='TE', BillingCity='Test', BillingStreet='Test', 
                                      BillingCountry='CA',country__c='India', CL_Account_Classification__c='A', 
                                      HC_Account_Classification__c='A', LI_Account_Classification__c='A',
                                      Philips_Indstry_Clasification_Level1__c='Retail',Philips_Indstry_Clasification_Level2__c='IDN',Account_template_sharing__c='M2O',
                                      Housenumber_Local__c='S12345', Street1_Local__c='CA', City_Local__c='City', Region__c=regionData.id);
  insert acc;     
                   Opportunity opp = new Opportunity(name='testopportunity', CloseDate=date.today(),
                                                                                 Accountid=acc.id,StageName='P1',Vendor_of_Choice__c='Won',
                                                                                 Funding_Status__c='Confident', Secondary_Rep__c=testUser1.id,
                                                                                 Working_Rep__c = testUser2.id,Ownerid=testUser1.id);
                    newop.add(opp);
                   Opportunity opp1 = new Opportunity(name='testopportunity1', CloseDate=date.today(),
                                                                                 Accountid=acc.id,StageName='P1',Vendor_of_Choice__c='Won',
                                                                                 Funding_Status__c='Confident', Secondary_Rep__c=testUser1.id,
                                                                                 Working_Rep__c = testUser2.id,Ownerid=testUser1.id);
                   newop.add(opp1);
                 insert newop;
            opp.Primary_Rep__c = testUser1.id;
            opp.Secondary_Rep__c = testUser2.id;
            opp.Working_Rep__c = testUser2.id;
           
        oldopp.add(opp);

          /*opp.Primary_Rep__c = testUser2 .id;
            opp.Secondary_Rep__c = testUser1.id;
            oldopp.add(opp);*/
           update oldopp; 

Delay_AddSalesTeam daddteam=new Delay_AddSalesTeam();
daddteam.AddSalesTeam(newop,oldopp);
daddteam.AddSalesTeamNew(newop);

AddSalesTeamSchedular schedule = new AddSalesTeamSchedular();
}
}
}