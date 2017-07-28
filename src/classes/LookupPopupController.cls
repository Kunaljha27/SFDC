public with sharing class LookupPopupController 
{
public String query {get; set;}
public List<Account> accounts {get; set;}

public PageReference runQuery()
{
accounts = new List<Account>();
/*List<List<Account>> searchResults=[FIND :query IN ALL FIELDS RETURNING Account (id, name, billingstreet,MP1_Customer_ID__c, billingcity, billingpostalcode)];
accounts=searchResults[0];*/
String name = query + '%';
List<Account> lstacc = [Select name,BillingStreet,BillingCity, BillingPostalCode,MP1_Customer_ID__c,Type,BillingState From Account where name like : name];
String mp = query + '%';
List<Account> lstacc1 = [Select name,MP1_Customer_ID__c,BillingStreet,BillingCity, BillingPostalCode,Type,BillingState From Account where MP1_Customer_ID__c like : mp];

for(Account a : lstacc)
    accounts.add(a);

for(Account a1 : lstacc1)
    accounts.add(a1);
    
  return null;
}
}