/*
Created by: Yunus 
Name : Update_Team_Member_Test
Description: Test Class for Code coverage of update_stand_Account_Team, update_stand_Sales_Team, SendEmail  and Sharing_settings    
*/

@istest

Class Update_Team_Member_Test{
static testMethod void AccountTeam(){
list<Account_Team_member__c> add_ATM = new List<Account_Team_Member__c>();
list<Account_Team_member__c> update_ATM = new List<Account_Team_Member__c>();
Account Test_Account = new Account(Name = 'Test_Account_TM',
        billingState = 'West Bengal',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA');
insert Test_Account;

Account Sample = [select id from Account where Name = 'Test_Account_TM'];

//account Team Member code coverage
//insert Account team Member
Profile p = [select id from profile where name='System Administrator']; 
User testUser1 = new User(alias = 'u1', email='u1@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u1@testorg123.com'); 
        insert testUser1;

User testUser3 = new User(alias = 'u34', email='u344@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u14344@testorg123.com'); 
        insert testUser3;
        
User testUser4 = new User(alias = 'u234', email='u3244@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u143424@testorg123.com'); 
        insert testUser4;        
                
//Account_Team_Member__c new_ATMember_1 = new Account_Team_Member__c(Account__c = Sample.id,  User__c = testUser1.id ,Account_Access__c = 'Read Only',Opportunity_Access__c ='Private',Case_Access__c = 'Private', Notify_User_on_add_and_delete__c = true, Team_Role__c = 'Account Manageraaaaa');
/*List<Account_Team_Member__c> insertlst=new List<Account_Team_Member__c>();
Account_Team_Member__c new_ATMember_1 = new Account_Team_Member__c(Account__c = Sample.id,  User__c = testUser1.id ,Account_Access__c = 'Read Only',Opportunity_Access__c ='Read Only',Case_Access__c = 'Read Only', Notify_User_on_add_and_delete__c = true, Team_Role__c = 'Account Manageraaaaa');
Account_Team_Member__c new_ATMember_2 = new Account_Team_Member__c(Account__c = Sample.id,  User__c = testUser3.id ,Account_Access__c = 'Read/Write',Opportunity_Access__c ='Read/Write',Case_Access__c = 'Read/Write', Notify_User_on_add_and_delete__c = true, Team_Role__c = 'Sales Repaaaaaaaaa');
Account_Team_Member__c new_ATMember_3 = new Account_Team_Member__c(Account__c = Sample.id,  User__c = testUser1.id ,Account_Access__c = 'Read/Write',Opportunity_Access__c ='Read/Write',Case_Access__c = 'Read-Only', Notify_User_on_add_and_delete__c = true, Team_Role__c = 'Sales Manageraaaaa');
Account_Team_Member__c new_ATMember_4 = new Account_Team_Member__c(Account__c = Sample.id,  User__c = testUser4.id,Account_Access__c = 'Read/Write',Opportunity_Access__c ='Private',Case_Access__c = 'Private', Notify_User_on_add_and_delete__c = true, Team_Role__c = '');


insert new_ATMember_1;

Insert new_ATMember_2;

Insert new_ATMember_3;

Insert new_ATMember_4;
insertlst.add(new_ATMember_1);
insertlst.add(new_ATMember_2);
insertlst.add(new_ATMember_3);
insertlst.add(new_ATMember_4);*/
//Sharing_settings.Insert_sharing_Account_Team(insertlst);

//Udate Account Team Member
List<Account_Team_Member__c> updateAtTeam= new List<Account_Team_Member__c>();
/*Account_Team_Member__c Update_Account_Team = [Select Account__c, User__c,Account_Access__c,Opportunity_Access__c,Case_Access__c,Notify_User_on_add_and_delete__c, Team_Role__c from Account_Team_Member__c where User__c =: testUser4.id];
Update_Account_Team.Account_Access__c ='Read/Write';
Update_Account_Team.Opportunity_Access__c ='Read/Write';
Update_Account_Team.Case_Access__c = 'Read/Write';
Update_Account_Team.Team_Role__c = 'Lead Qualifier';
//Update Update_Account_Team;
updateAtTeam.add(Update_Account_Team);
Account_Team_Member__c Update_Account_Team_2 = [Select Account__c, User__c,Account_Access__c,Opportunity_Access__c,Case_Access__c,Notify_User_on_add_and_delete__c, Team_Role__c from Account_Team_Member__c where Account__c =: Sample.id and User__c =: testUser4.id];
Update_Account_Team_2.Account_Access__c ='Read/Write';
Update_Account_Team_2.Opportunity_Access__c ='Read-Only';
Update_Account_Team_2.Case_Access__c = 'Read-Only';
Update_Account_Team_2.Team_Role__c = 'Lead Qualifier';
//Update Update_Account_Team_2;
updateAtTeam.add(Update_Account_Team_2);
Account_Team_Member__c Update_Account_Team_3 = [Select Account__c, User__c,Account_Access__c,Opportunity_Access__c,Case_Access__c,Notify_User_on_add_and_delete__c, Team_Role__c from Account_Team_Member__c where Account__c =: Sample.id and User__c =: testUser4.id];
Update_Account_Team_3.Account_Access__c ='Read-Only';
Update_Account_Team_3.Opportunity_Access__c ='Private';
Update_Account_Team_3.Case_Access__c = 'Private';
Update_Account_Team_3.Team_Role__c = 'Lead Qualifier';

//Update Update_Account_Team_3;

updateAtTeam.add(Update_Account_Team_3);*/
/*Account_Team_Member__c Update_Account_Team_4 = [Select Account__c, User__c,Account_Access__c,Opportunity_Access__c,Case_Access__c,Notify_User_on_add_and_delete__c, Team_Role__c from Account_Team_Member__c where Account__c =: Sample.id and User__c =: testUser4.id];
Update_Account_Team_4.Account_Access__c ='Read-Only';
Update_Account_Team_4.Opportunity_Access__c ='Read-Only';
Update_Account_Team_4.Case_Access__c = 'Read-Only';
Update_Account_Team_4.Team_Role__c = 'Lead Qualifier';
//Update Update_Account_Team_4;
updateAtTeam.add(Update_Account_Team_4);

update updateAtTeam;*/
//Sharing_settings.update_sharing_Account_Team(updateAtTeam);
//changes made to cover Sharing_settings class 
/*update_ATM.add(Update_Account_Team_3);

Sharing_settings.update_sharing_Account_Team(update_ATM);*/


//Delete Account Team Member

//List<Account_Team_Member__c> Delete_Account_Team = [Select Account__c, User__c from Account_Team_Member__c where Account__c =: Sample.id and User__c =: testUser1.id];
//Sharing_settings.delete_Sharing_Account_Team(Delete_Account_Team);
//delete Delete_Account_Team;

}

static testMethod void SalesTeam(){

//Account for look-up
Account Test_Account = new Account(Name = 'Test_Account_TM',
billingState = 'West Bengal',
        BillingStreet='Bombai Bagan Road',BillingCity = 'Kolkata',
        BillingPostalCode= '700061', BillingCountry='CA');
insert Test_Account;
Profile p = [select id from profile where name='System Administrator']; 
User testUser2 = new User(alias = 'u2', email='u2222@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u1@testorg12332.com'); 
        insert testUser2;
        
User testUser3 = new User(alias = 'u22', email='u222222@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u1@tes22torg12332.com'); 
        insert testUser3;
    User    testUser4 = new User(alias = 'u22', email='u2242222@testorg.com',
        emailencodingkey='UTF-8', lastname='Testing1', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='u1@tes242torg12332.com'); 
        insert testUser4;
                
Account Sample_Acc = [select id from Account where Name = 'Test_Account_TM'];

//New Opportunity to assign Sales Team
Opportunity Test_Opp = new Opportunity(Name ='Test_Opportunity',AccountId=Sample_Acc.id,closedate = system.today(), StageName='Quatation', Primary_Rep__c=testUser3.id);
Insert Test_Opp;
Opportunity Sample_Opp = [select id from Opportunity where Name = 'Test_Opportunity' limit 1];
List<Sales_Team__c> insertsteam= new List<Sales_Team__c>();
//Insert Sales Team
Sales_Team__c New_STMember_1 = new Sales_Team__c(Opportunity__c = Sample_Opp.id,Opportunity_Access__c = 'Read Only',Notify_User_on_add_and_delete__c = True, Team_Role__c = 'Sales Rep', User__c =testUser2.id);
Sales_Team__c New_STMember_2 = new Sales_Team__c(Opportunity__c = Sample_Opp.id,Opportunity_Access__c = 'Read/Write',Notify_User_on_add_and_delete__c = True, Team_Role__c = 'Account Manager', User__c =testUser3.id);
Sales_Team__c New_STMember_3 = new Sales_Team__c(Opportunity__c = Sample_Opp.id,Opportunity_Access__c = 'Read/Write',Notify_User_on_add_and_delete__c = True, Team_Role__c = 'Sales Manager', User__c =testUser2.id);
Sales_Team__c New_STMember_4 = new Sales_Team__c(Opportunity__c = Sample_Opp.id,Opportunity_Access__c = 'Read/Write',Notify_User_on_add_and_delete__c = True, Team_Role__c = '', User__c =testUser4.id);
insertsteam.add(New_STMember_1);
insertsteam.add(New_STMember_2);
insertsteam.add(New_STMember_3);
insertsteam.add(New_STMember_4);
insert insertsteam;
//insert New_STMember_1;
//insert New_STMember_2;
//insert New_STMember_3;
//insert New_STMember_4;

//Sharing_settings.Insert_Sharing_Sales_team(insertsteam);

//update Sales Team
List<Sales_Team__c> updatesteam= new List<Sales_Team__c>();
Sales_Team__c Update_Sales_Team = [Select Opportunity__c,Opportunity_Access__c , Team_Role__c,User__c from Sales_Team__c where Opportunity__c =: Sample_Opp.id and User__c =:testUser2.id limit 1];

Update_Sales_Team.Opportunity_Access__c = 'Read Only';
Update_Sales_Team.Team_Role__c = 'Lead Qualifier';

//Update Update_Sales_Team;

Sales_Team__c Update_Sales_Team_2 = [Select Opportunity__c,Opportunity_Access__c , Team_Role__c,User__c from Sales_Team__c where Opportunity__c =: Sample_Opp.id and User__c =:testUser2.id limit 1];

Update_Sales_Team_2.Opportunity_Access__c = 'Read/Write';
Update_Sales_Team_2.Team_Role__c = 'Lead Qualifier';

//Update Update_Sales_Team_2;
updatesteam.add(Update_Sales_Team);
//updatesteam.add(Update_Sales_Team_2);
update updatesteam;
//Sharing_settings.Update_Sharing_Sales_Team(updatesteam);

//delete SalesTeam 

//Account Sample = [select id from Account where Name = 'Test_Account_TM_1'];

List<Sales_Team__c> Delete_Sales_Team = [Select Opportunity__c,Opportunity_Access__c , Team_Role__c,User__c from Sales_Team__c where Opportunity__c =: Sample_Opp.id and User__c =:testUser2.id];
//Sharing_settings.Delete_Share_Sales_Team(Delete_Sales_Team);
delete Delete_Sales_Team; 





}
}