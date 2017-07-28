/*
    @author         Sneha Chail<Wipro Technologies>.
    @class          MergeAccount.
    @abstract       Merging two accounts.
    @since          2012.03.18
    @discussion     Merging related objects to Destination Account.
*/

public Class MergeAccount{

public Account acc{get;set;}
public Account acc1{get;set;}
public Id accountId {get; set;}
// -------modified by chitranjan---
public Account Account1=new Account();
public Account Account2=new Account();
//public Id Account_Department__c {get; set;}
public String accountName {get; set;}
public Contact con1{get;set;}
public Id idacc;
Public Boolean str {get;set;}
public List<Contact> contacttotransfer=new List<Contact>();
public List<Opportunity> Opportunitytotransfer=new List<Opportunity>();
public List<Department__c> Departmentotransfer=new List<Department__c>();
public List<Account_affiliation__c> Affiliatedotransfer=new List<Account_affiliation__c>();
public List<Task> Tasktotransfer=new List<Task>();
public List<Lead> Leadtotransfer=new List<Lead>();
public List<Event> Evevttotransfer=new List<Event>();
public List<AccountTeamMember> Accountteam=new List<AccountTeamMember>();
public List<AccountTeamMember> Accountteam1=new List<AccountTeamMember>();
public List<Attachment> Attachmenttotransfer=new List<Attachment>();
public List<Note> Notetotransfer=new List<Note>();
public List<AccountContactRole> AccountContactRoletotransfer=new List<AccountContactRole>();
public List<Asset> Assettotransfer=new List<Asset>();
Public set<string> setCombined=new set<string>();
public boolean checkDuContact {get;set;}
public List<Affiliates__c> Affiliatestotransfer=new List<Affiliates__c>();

//Controller class
public MergeAccount(ApexPages.StandardController controller)
{
    idacc=ApexPages.currentPage().getParameters().get('Id');
    str=true;
    checkDuContact = false;
    //--------------chitranjan-----------
    acc=[select id,Account_Alias__c,Phone,Marketing_programs__c,Goldmine_Account__c,gmx_Custom_API_1__c,gmx_Custom_API_5__c,gmx_Custom_API_2__c,gmx_Custom_API_3__c,Urgent_Care_Facility__c,gmx_Custom_API_4__c,gmx_Web_Viewer__c,gmx_Archive_VNA__c,gmx_RIS_Version__c,gmx_CustStatus__c,gmx_PACS_Gear__c,gmx_OrthoView__c,gmx_ClinApps_WF_Solution__c,
    Phone_Book_Account__c,Class_of_Account__c,Expertise__c,Facility_Type__c,Total_Beds__c,Short_Term_Beds__c,TIMS_ID__c,SMG_ID__c,ICUs__c,Competitive_Buying_Information__c,Licensed_Bed_Count__c,Employee_Here__c,Fax,Website,name,Type,Destination_Account_Name__c,SourceSystem__c,Siebel_ID__c,Archived_Record__c from Account where id=:idacc limit 1];
}
//Calling Method 
public static boolean alreadyCreatedTasks = false;
public pageReference transfer()
{
    checkDuContact = false;
    if(accountId==null) 
    {          
       PageReference pg= new pagereference('/apex/MergeAccount?id='+acc.id);
       pg.setredirect(true);
       return pg;
    } 
    else
    {
        try
        {
          update acc;
          Id desacc2;
          desacc2=accountId;
          checkDuContact = false;
          List<Contact> listcon=new list<Contact>();
          listcon=[select id,Name,ConcatenateContact__c  from contact where AccountId=:desacc2];
          if(listcon!=null && listcon.size()>0)
          {
            for(Contact co:listcon)
            {
               setCombined.add(co.ConcatenateContact__c);        
            }
          }   
          MergeAccount.alreadyCreatedTasks = true;
          List<Contact> conlist=new list<Contact>();
          contacttotransfer=[select id,name,AccountId,ConcatenateContact__c  from Contact where AccountId=:idacc];
          for(Contact c :contacttotransfer)
          {
            if(setCombined.contains(c.ConcatenateContact__c ))
            {
                checkDuContact = true;
            } 
          } 
          if(checkDuContact)
          {
             return null;
          }
          else
          {
            MergeAccount.alreadyCreatedTasks = true;
            acc.Archived_Record__c= str;
            acc.Destination_Account_Name__c = accountId ;
            update acc;
            Id desacc;
            desacc=accountId;
            List<Contact> conlist1=new list<Contact>();
            contacttotransfer=[select id,name,AccountId from Contact where AccountId=:idacc];        
            for(Contact c :contacttotransfer)
            {
                c.AccountId=desacc;
                conlist1.add(c);
            }
            if(conlist1.size()>0 && conlist1!=null)
            { 
                update conlist1;
            }
  
            //Moving AccountRole from source account to destination account
            List<AccountContactRole> acr=new List<AccountContactRole>(); 
            AccountContactRoletotransfer=[select Id,ContactId,Role from AccountContactRole where AccountId=:idacc];
            //AccountContactRole opptm=new AccountContactRole();
            for(integer i=0;i<AccountContactRoletotransfer.size();i++)
            {
                AccountContactRole opptm=new AccountContactRole();
                opptm.ContactId=AccountContactRoletotransfer[i].ContactId;
                opptm.AccountId=desacc;
                opptm.Role=AccountContactRoletotransfer[i].Role;
                acr.add(opptm); 
            }
            if(acr!=null  && acr.size()>0)
            { 
                insert acr;
            }
            if(AccountContactRoletotransfer.size()>0 && AccountContactRoletotransfer!=null)
            {
                delete AccountContactRoletotransfer;
            }

            //Moving Opportunity from source account to destination account 
            List<Opportunity> opp=new List<Opportunity>();
            Opportunitytotransfer=[select id,name,CloseDate,StageName,AccountId from Opportunity where AccountId=:idacc];   
            for(Opportunity o:Opportunitytotransfer)
            {
                o.AccountId=desacc;
                opp.add(o);
            }
            if(opp.size()>0 &&  opp!=null)
            { 
                Update opp;
            }
            //Moving Department from source account to destination account 
            List<Department__c > dep=new List<Department__c >();
            Departmentotransfer=[select id,name, Account_Department__c, PMS_Account_Medical_Services__c from Department__c  where Account_Department__c=:idacc];

            for(Department__c  d: Departmentotransfer)
            {
                d.Account_Department__c=desacc;
                dep.add(d);
            }
            if(dep.size()>0 && dep!=null)
            { 
                Update dep;
            }
            
            //Moving Account_affiliation from source account to destination account 
            List<Account_affiliation__c> aff=new List<Account_affiliation__c>();
            Affiliatedotransfer=[select id,name, Affiliated_Account__c, Business_Line__c,Customer_Prospect__c,Custom_Lastmodified__c,Relationship_Type__c,Role__c,Send_to_Siebel__c from Account_affiliation__c  where Customer_Prospect__c=:idacc ];
            System.debug('Affiliatedotransfer'+Affiliatedotransfer);
            for(Account_affiliation__c  a: Affiliatedotransfer)
            {
                //a.Affiliated_Account__c=AffAccount;
                a.Customer_Prospect__c =desacc;
                aff.add(a);
            }
            if(aff.size()>0 && aff!=null)
            { 
                Update aff;
            } 
            
              
            //Moving Account_affiliation from source account to destination account 
            List<Account_affiliation__c> aff1=new List<Account_affiliation__c>();
            Affiliatedotransfer=[select id,name, Affiliated_Account__c, Business_Line__c,Customer_Prospect__c,Custom_Lastmodified__c,Relationship_Type__c,Role__c,Send_to_Siebel__c from Account_affiliation__c  where Affiliated_Account__c=:idacc ];
            System.debug('Affiliatedotransfer'+Affiliatedotransfer);
            for(Account_affiliation__c  a: Affiliatedotransfer)
            {
                a.Affiliated_Account__c=desacc;
                //a.Customer_Prospect__c =desacc;
                aff1.add(a);
            }
            if(aff1.size()>0 && aff1!=null)
            { 
                Update aff1;
            }
            
            //Moving Lead from source account to destination account 
            List<Lead> Led=new List<Lead>();
            Leadtotransfer=[select id,Name,And__c,Account__c from Lead where Account__c=:idacc];
            for(Lead ld:Leadtotransfer)
            {
                ld.Account__c=desacc;
                Led.add(ld);
            }
            if(Led.size()>0  &&  Led!=null)
            { 
                Update Led;
            }

    
            //Moving Task from source account to destination account 
            List<Task> Tsk=new List<Task>();
            Tasktotransfer=[select id,Subject,Status,Priority,WhatId,WhoId from Task where WhatId=:idacc];
            for(Task Tk:Tasktotransfer)
            {
                Tk.WhatId=desacc;
                Tsk.add(Tk);
            }
            if(Tsk.size()>0  &&  Tsk!=null)
            { 
                Update Tsk;
            }
   
    
            //Moving Event from source account to destination account 
            List<Event> Evt=new List<Event>();
            Evevttotransfer=[select id,Subject,StartDateTime,EndDateTime,WhatId,WhoId from Event where WhatId=:idacc];
            for(Event et:Evevttotransfer)
            {
                et.WhatId=desacc;
                Evt.add(et);
            }
            if(Evt.size()>0 && Evt!=null)
            { 
                Update Evt;
            }
     
            //Moving Attachment from source account to destination account  
            List<Attachment> Att=new List<Attachment>();
            Attachmenttotransfer=[select id,ParentId,Name,Body from Attachment where ParentId=:idacc];
            //Attachment attch=new Attachment();
            for(integer i=0;i<Attachmenttotransfer.size();i++)
            {  
                Attachment attch=new Attachment();
                attch.ParentId=desacc;
                attch.Name=Attachmenttotransfer[i].Name;
                attch.Body=Attachmenttotransfer[i].Body;
                Att.add(attch);
            }
            if(Att.size()>0  && Att!=null)
            { 
                Insert Att;
            }
            if(Attachmenttotransfer.size()>0 && Attachmenttotransfer!=null)
            { 
                delete Attachmenttotransfer;
            }
            
            //Moving Notes from source account to destination account 
            List<Note> Nte=new List<Note>(); 
            Notetotransfer=[select id,ParentId,Title,Body from Note where ParentId=:idacc];
            //Note nt=new Note();
            for(integer i=0;i<Notetotransfer.size();i++)
            {
                Note nt=new Note();
                nt.ParentId=desacc;
                nt.Title=Notetotransfer[i].Title;
                nt.Body=Notetotransfer[i].Body;
                Nte.add(nt);
            }
            if(Nte.size()>0 && Nte!=null)
            { 
                Insert Nte;
            }
            if(Notetotransfer.size()>0 && Notetotransfer!=null)
            { 
                delete Notetotransfer;
            }
            
            //Updated by suman
            //Coping field values
            //Account1=[select Total_Beds__c,TIMS_ID__c, SMG_ID__c,ICUs__c,Competitive_Buying_Information__c,Licensed_Bed_Count__c,Employee_Here__c from  Account where Id=:idacc];
            Account2=[select Siebel_ID__c,Goldmine_Account__c,gmx_Custom_API_1__c,gmx_Custom_API_5__c,gmx_Custom_API_2__c,gmx_Custom_API_3__c,Urgent_Care_Facility__c,gmx_Custom_API_4__c,gmx_Web_Viewer__c,gmx_Archive_VNA__c,gmx_RIS_Version__c,gmx_CustStatus__c,gmx_PACS_Gear__c,gmx_OrthoView__c,gmx_ClinApps_WF_Solution__c,Marketing_programs__c,Account_Alias__c,Phone,Fax,Website,Phone_Book_Account__c,Class_of_Account__c,Expertise__c,Facility_Type__c,Short_Term_Beds__c,Total_Beds__c,SourceSystem__c,TIMS_ID__c, SMG_ID__c,ICUs__c,Competitive_Buying_Information__c,Licensed_Bed_Count__c,Employee_Here__c from  Account where Id=:desacc];
            system.debug('check------------------------'+acc.Total_Beds__c);
            if(acc.SourceSystem__c!='Siebel')
            {    
                if(Account2.Siebel_ID__c == NULL && acc.Siebel_ID__c!=NULL)
                {
                    Account2.Siebel_ID__c = acc.Siebel_ID__c;
                    acc.Siebel_ID__c=NULL;
                    system.debug('check------------------------'+acc.Siebel_ID__c);
                }
                if(Account2.Account_Alias__c == NULL && acc.Account_Alias__c!=NULL)
                {
                    Account2.Account_Alias__c = acc.Account_Alias__c;
                    system.debug('check------------------------'+acc.Account_Alias__c);
                }
                if(Account2.Phone == NULL && acc.Phone!=NULL)
                {
                    Account2.Phone = acc.Phone;
                    system.debug('check------------------------'+acc.Phone);
                }
                if(Account2.Fax == NULL && acc.Fax!=NULL)
                {
                    Account2.Fax= acc.Fax;
                    system.debug('check------------------------'+acc.Fax);
                }
                if(Account2.Website== NULL && acc.Website!=NULL)
                {
                    Account2.Website = acc.Website;
                    system.debug('check---website---------------------'+acc.Website);
                }
                if(Account2.Phone_Book_Account__c == False  && acc.Phone_Book_Account__c!=False)
                {
                    Account2.Phone_Book_Account__c = True;
                    acc.Phone_Book_Account__c = False;
                    system.debug('check-------phone book acc-----------------'+acc.Phone_Book_Account__c);
                }
                if(Account2.Total_Beds__c == NULL && acc.Total_Beds__c!=NULL)
                {
                    Account2.Total_Beds__c = acc.Total_Beds__c;
                    system.debug('check------------------------'+acc.Total_Beds__c);
                }
                if(Account2.Class_of_Account__c == NULL && acc.Class_of_Account__c!=NULL)
                {
                    Account2.Class_of_Account__c = acc.Class_of_Account__c;
                    system.debug('check------------------------'+acc.Class_of_Account__c);
                }  
                if(Account2.Facility_Type__c == NULL && acc.Facility_Type__c!=NULL)
                {
                    Account2.Facility_Type__c = acc.Facility_Type__c;
                    system.debug('check------------------------'+acc.Facility_Type__c);
                }
                  
                if(Account2.Expertise__c == NULL && acc.Expertise__c!=NULL)
                {
                    Account2.Expertise__c = acc.Expertise__c;
                    system.debug('check------------------------'+acc.Expertise__c);
                }
                if(Account2.Short_Term_Beds__c == NULL && acc.Short_Term_Beds__c!=NULL)
                {
                    Account2.Short_Term_Beds__c= acc.Short_Term_Beds__c;
                    system.debug('check------------------------'+acc.Short_Term_Beds__c);
                }
                //Modified by Mayank for change request co783834//////
                
                if(Account2.Goldmine_Account__c == NULL && acc.Goldmine_Account__c!=NULL)
                {
                    Account2.Goldmine_Account__c= acc.Goldmine_Account__c;
                    
                }
                if(Account2.Gmx_Custom_API_1__c == NULL && acc.Gmx_Custom_API_1__c!=NULL)
                {
                    Account2.Gmx_Custom_API_1__c= acc.Gmx_Custom_API_1__c;
                    
                }
                if(Account2.Gmx_Custom_API_5__c == NULL && acc.Gmx_Custom_API_5__c!=NULL)
                {
                    Account2.Gmx_Custom_API_5__c= acc.Gmx_Custom_API_5__c;
                    
                }
                if(Account2.Gmx_Custom_API_2__c == NULL && acc.Gmx_Custom_API_2__c!=NULL)
                {
                    Account2.Gmx_Custom_API_2__c= acc.Gmx_Custom_API_2__c;
                    
                }
                if(Account2.Gmx_Custom_API_3__c == NULL && acc.Gmx_Custom_API_3__c!=NULL)
                {
                    Account2.Gmx_Custom_API_3__c= acc.Gmx_Custom_API_3__c;
                    
                }
                if(Account2.Urgent_Care_Facility__c == NULL && acc.Urgent_Care_Facility__c!=NULL)
                {
                    Account2.Urgent_Care_Facility__c= acc.Urgent_Care_Facility__c;
                    
                }
                if(Account2.Gmx_Custom_API_4__c == NULL && acc.Gmx_Custom_API_4__c!=NULL)
                {
                    Account2.Gmx_Custom_API_4__c= acc.Gmx_Custom_API_4__c;
                    
                }
                if(Account2.Gmx_Web_Viewer__c == NULL && acc.Gmx_Web_Viewer__c!=NULL)
                {
                    Account2.Gmx_Web_Viewer__c= acc.Gmx_Web_Viewer__c;
                    
                }
                if(Account2.Gmx_Archive_VNA__c == NULL && acc.Gmx_Archive_VNA__c!=NULL)
                {
                    Account2.Gmx_Archive_VNA__c= acc.Gmx_Archive_VNA__c;
                    
                }
                if(Account2.Gmx_RIS_Version__c == NULL && acc.Gmx_RIS_Version__c!=NULL)
                {
                    Account2.Gmx_RIS_Version__c= acc.Gmx_RIS_Version__c;
                    
                }
                if(Account2.Gmx_CustStatus__c == NULL && acc.Gmx_CustStatus__c!=NULL)
                {
                    Account2.Gmx_CustStatus__c= acc.Gmx_CustStatus__c;
                    
                }
                if(Account2.Gmx_PACS_Gear__c == NULL && acc.Gmx_PACS_Gear__c!=NULL)
                {
                    Account2.Gmx_PACS_Gear__c= acc.Gmx_PACS_Gear__c;
                    
                }
                if(Account2.Gmx_OrthoView__c == NULL && acc.Gmx_OrthoView__c!=NULL)
                {
                    Account2.Gmx_OrthoView__c= acc.Gmx_OrthoView__c;
                    
                }
                if(Account2.Gmx_ClinApps_WF_Solution__c == NULL && acc.Gmx_ClinApps_WF_Solution__c!=NULL)
                {
                    Account2.Gmx_ClinApps_WF_Solution__c= acc.Gmx_ClinApps_WF_Solution__c;
                    
                }
                if(Account2.Marketing_programs__c == NULL && acc.Marketing_programs__c!=NULL)
                {
                    Account2.Marketing_programs__c= acc.Marketing_programs__c;
                    
                }





               
                
                
                
                
                
                //////////////////////////////////////////
                                                   
                if(Account2.TIMS_ID__c == NULL && acc.TIMS_ID__c!=NULL)
                {
                    Account2.TIMS_ID__c = acc.TIMS_ID__c;
                }
                if(Account2.SMG_ID__c == NULL && acc.SMG_ID__c!=NULL)
                {
                    Account2.SMG_ID__c = acc.SMG_ID__c;
                }
                if(Account2.ICUs__c == NULL && acc.ICUs__c!=NULL)
                {
                    Account2.ICUs__c = acc.ICUs__c;
                }
                if(Account2.Competitive_Buying_Information__c == NULL && acc.Competitive_Buying_Information__c!=NULL)
                {
                    Account2.Competitive_Buying_Information__c = acc.Competitive_Buying_Information__c;
                }
                if(Account2.Licensed_Bed_Count__c == NULL && acc.Licensed_Bed_Count__c!=NULL)
                {
                    Account2.Licensed_Bed_Count__c = acc.Licensed_Bed_Count__c;
                }
                if(Account2.Employee_Here__c == NULL && acc.Employee_Here__c!=NULL)
                {
                    Account2.Employee_Here__c = acc.Employee_Here__c;
                }
                if(Account2.SourceSystem__c == NULL && acc.SourceSystem__c!=NULL)
                {
                    Account2.SourceSystem__c = acc.SourceSystem__c;
                    acc.SourceSystem__c=NULL;
                }
            } 
            // For source system is Siebel  
            else
            {
                if(acc.Siebel_ID__c!=NULL)
                {
                    Account2.Siebel_ID__c = acc.Siebel_ID__c;
                    acc.Siebel_ID__c=NULL;
                    system.debug('check------------------------'+acc.Siebel_ID__c);
                }
                if(acc.Account_Alias__c!=NULL)
                {
                    Account2.Account_Alias__c = acc.Account_Alias__c;
                    system.debug('check------------------------'+acc.Account_Alias__c);
                }
                if(acc.Phone!=NULL)
                {
                    Account2.Phone = acc.Phone;
                    system.debug('check------------------------'+acc.Phone);
                }
                if(acc.Fax!=NULL)
                {
                    Account2.Fax= acc.Fax;
                    system.debug('check------------------------'+acc.Fax);
                }
                if(acc.Website!=NULL)
                {
                    Account2.Website = acc.Website;
                    system.debug('check------website------------------'+acc.Website);
                }
                if(acc.Phone_Book_Account__c!=False)
                {
                    Account2.Phone_Book_Account__c = True;
                    acc.Phone_Book_Account__c=False;
                    system.debug('check--------phone book acc----------------'+acc.Phone_Book_Account__c);
                }
                if(acc.Total_Beds__c!=NULL)
                {
                    Account2.Total_Beds__c = acc.Total_Beds__c;
                    system.debug('check------------------------'+acc.Total_Beds__c);
                }
                //Modified for change request co783834 
                
                if(acc.Goldmine_Account__c!=NULL)
                {
                    Account2.Goldmine_Account__c = acc.Goldmine_Account__c;
                    system.debug('check------------------------'+acc.Goldmine_Account__c);
                }
                if(acc.Gmx_Custom_API_1__c!=NULL)
                {
                    Account2.Gmx_Custom_API_1__c = acc.Gmx_Custom_API_1__c;
                    system.debug('check------------------------'+acc.Gmx_Custom_API_1__c);
                }
                if(acc.Gmx_Custom_API_5__c!=NULL)
                {
                    Account2.Gmx_Custom_API_5__c = acc.Gmx_Custom_API_5__c;
                    system.debug('check------------------------'+acc.Gmx_Custom_API_5__c);
                }
                if(acc.Gmx_Custom_API_2__c!=NULL)
                {
                    Account2.Gmx_Custom_API_2__c = acc.Gmx_Custom_API_2__c;
                    system.debug('check------------------------'+acc.Gmx_Custom_API_2__c);
                }
                if(acc.Gmx_Custom_API_3__c!=NULL)
                {
                    Account2.Gmx_Custom_API_3__c = acc.Gmx_Custom_API_3__c;
                    system.debug('check------------------------'+acc.Gmx_Custom_API_3__c);
                }
                if(acc.Urgent_Care_Facility__c!=NULL)
                {
                    Account2.Urgent_Care_Facility__c = acc.Urgent_Care_Facility__c;
                    system.debug('check------------------------'+acc.Urgent_Care_Facility__c);
                }
                if(acc.Gmx_Custom_API_4__c!=NULL)
                {
                    Account2.Gmx_Custom_API_4__c = acc.Gmx_Custom_API_4__c;
                    system.debug('check------------------------'+acc.Gmx_Custom_API_4__c);
                }
                if(acc.Gmx_Web_Viewer__c!=NULL)
                {
                    Account2.Gmx_Web_Viewer__c = acc.Gmx_Web_Viewer__c;
                    system.debug('check------------------------'+acc.Gmx_Web_Viewer__c);
                }
                if(acc.Gmx_Archive_VNA__c!=NULL)
                {
                    Account2.Gmx_Archive_VNA__c = acc.Gmx_Archive_VNA__c;
                    system.debug('check------------------------'+acc.Gmx_Archive_VNA__c);
                }
                if(acc.Gmx_RIS_Version__c!=NULL)
                {
                    Account2.Gmx_RIS_Version__c = acc.Gmx_RIS_Version__c;
                    system.debug('check------------------------'+acc.Gmx_RIS_Version__c);
                }
                if(acc.Gmx_CustStatus__c!=NULL)
                {
                    Account2.Gmx_CustStatus__c = acc.Gmx_CustStatus__c;
                    system.debug('check------------------------'+acc.Gmx_CustStatus__c);
                }
                if(acc.Gmx_PACS_Gear__c!=NULL)
                {
                    Account2.Gmx_PACS_Gear__c = acc.Gmx_PACS_Gear__c;
                    system.debug('check------------------------'+acc.Gmx_PACS_Gear__c);
                }
                if(acc.Gmx_OrthoView__c!=NULL)
                {
                    Account2.Gmx_OrthoView__c = acc.Gmx_OrthoView__c;
                    system.debug('check------------------------'+acc.Gmx_OrthoView__c);
                }
                if(acc.Gmx_ClinApps_WF_Solution__c!=NULL)
                {
                    Account2.Gmx_ClinApps_WF_Solution__c = acc.Gmx_ClinApps_WF_Solution__c;
                    system.debug('check------------------------'+acc.Gmx_ClinApps_WF_Solution__c);
                }
                if(acc.Marketing_programs__c!=NULL)
                {
                    Account2.Marketing_programs__c = acc.Marketing_programs__c;
                    system.debug('check------------------------'+acc.Marketing_programs__c);
                }              
                
                
                
                
                //Modification ends
                          
                
                
                
                if(acc.Class_of_Account__c!=NULL)
                {
                    Account2.Class_of_Account__c = acc.Class_of_Account__c;
                    system.debug('check------------------------'+acc.Class_of_Account__c);
                }  
                if(acc.Facility_Type__c!=NULL)
                {
                    Account2.Facility_Type__c = acc.Facility_Type__c;
                    system.debug('check------------------------'+acc.Facility_Type__c);
                }                  
                if(acc.Expertise__c!=NULL)
                {
                    Account2.Expertise__c = acc.Expertise__c;
                    system.debug('check------------------------'+acc.Expertise__c);
                }
                if(acc.Short_Term_Beds__c!=NULL)
                {
                    Account2.Short_Term_Beds__c= acc.Short_Term_Beds__c;
                    system.debug('check------------------------'+acc.Short_Term_Beds__c);
                }                                   
                if(acc.TIMS_ID__c!=NULL)
                {
                    Account2.TIMS_ID__c = acc.TIMS_ID__c;
                }
                if(acc.SMG_ID__c!=NULL)
                {
                    Account2.SMG_ID__c = acc.SMG_ID__c;
                }
                if(acc.ICUs__c!=NULL)
                {
                    Account2.ICUs__c = acc.ICUs__c;
                }
                if(acc.Competitive_Buying_Information__c!=NULL)
                {
                    Account2.Competitive_Buying_Information__c = acc.Competitive_Buying_Information__c;
                }
                if(acc.Licensed_Bed_Count__c!=NULL)
                {
                    Account2.Licensed_Bed_Count__c = acc.Licensed_Bed_Count__c;
                }
                if(acc.Employee_Here__c!=NULL)
                {
                    Account2.Employee_Here__c = acc.Employee_Here__c;
                }
                if(acc.SourceSystem__c!=NULL)
                {
                    Account2.SourceSystem__c = acc.SourceSystem__c;
                    acc.SourceSystem__c=NULL;
                } 
                      
            }
            acc.Phone_Book_Account__c=False;
                  
            Update Account2;
            update acc;
            
            //Adding Account team member ..........
            Accountteam = [select AccountId,TeamMemberRole, AccountAccessLevel,UserId from AccountTeamMember where AccountId=:idacc];
            Accountteam1=[select  AccountId,TeamMemberRole, AccountAccessLevel,UserId from AccountTeamMember where AccountId=:desacc];
            List<AccountShare> AccShare = new List<AccountShare>();
            AccShare = [select AccountAccessLevel,CaseAccessLevel,OpportunityAccessLevel,UserOrGroupId from AccountShare where AccountId=:idacc AND RowCause = 'team'];
            set<Id> desuser=new set<Id>();
            List<AccountTeamMember> atmc=new list<AccountTeamMember>();
            for(AccountTeamMember at1 : Accountteam1)
            { 
                desuser.add(at1.UserId );
            }
            // system.debug('#########' + );   
            for(AccountTeamMember at : Accountteam)
            { 
                if(!desuser.contains(at.UserId ))
                { 
                    system.debug('source user' +at.UserId );
                    AccountTeamMember  accm = new  AccountTeamMember();
                    accm.AccountId=desacc;
                    accm.TeamMemberRole=at.TeamMemberRole;
                    //AccountShare sharing = new AccountShare();
                    //sharing.AccountAccessLevel = 'edit';
                    accm.UserId =at.UserId ;
                    insert accm;
                    //atmc.add(accm);
                    
                   /* AccountShare caSharingRule = new AccountShare();
                    caSharingRule.AccountId = desacc;
                    caSharingRule.OpportunityAccessLevel = AS.OpportunityAccessLevel;
                  caSharingRule.CaseAccessLevel = AS.CaseAccessLevel;
                  caSharingRule.AccountAccessLevel = at.AccountAccessLevel;
                  caSharingRule.UserOrGroupId = at.UserId; 
                  insert caSharingRule;*/
                }
            }
            for(AccountShare AccS : AccShare)
            {
                AccountShare caSharingRule = new AccountShare();
                caSharingRule.AccountId = desacc;
                caSharingRule.OpportunityAccessLevel = AccS.OpportunityAccessLevel;
                  caSharingRule.CaseAccessLevel = AccS.CaseAccessLevel;
                caSharingRule.AccountAccessLevel = AccS.AccountAccessLevel;
                caSharingRule.UserOrGroupId = AccS.UserOrGroupId; 
                insert caSharingRule;
            }
           /*List<AccountShare> acctSharingRules= new List<AccountShare>();
           AccountShare caSharingRule = new AccountShare();
          caSharingRule.AccountId = desacc;
          //caSharingRule.RowCause = Schema.AccountShare.RowCause.Team ;
          caSharingRule.OpportunityAccessLevel = 'Edit';
          caSharingRule.CaseAccessLevel = 'Edit';
          caSharingRule.AccountAccessLevel = 'Edit';
          caSharingRule.UserOrGroupId = '005d0000001p3X7'; 
          acctSharingRules.add(caSharingRule);
          
           system.debug('source user list' +atmc);
            if(acctSharingRules.size()>0  &&  acctSharingRules!=null)
            {
                insert acctSharingRules;
            }*/
            if(Accountteam!=null && Accountteam.size()>0)
            {
                delete  Accountteam;
            }
          
            // Moving Asset from Source to Destination...........
            List<Asset> asst=new List<Asset>(); 
            /*  Modified in the query for validation rule
            Dated: 22nd march */
            Assettotransfer=[select id,Site_ID__c,ContactId,Description,Phone_Book_Account__c,Booking_Date__c,Ship_Date__c,Sales_Order_Number__c,Lease_Expiration_Date__c,SerialNumber,Hardware_Version__c,Software_Version__c,Vendor_on_product__c,Modality_lookup_product__c,Ship_to_Account__c,Service_Engineer__c,Service_Manager__c,Product2Id,Service_Region__c,AccountId,Name, InstallDate, Department__c, Medical_Services__c,Status from Asset where AccountId=:idacc];
            // Asset Ast=new Asset();
            for(integer i=0;i<Assettotransfer.size();i++)
            {
                Asset Ast=new Asset();
                Ast.AccountId=desacc;
                Ast.Name=Assettotransfer[i].Name;
                //Modified on 22nd March
                Ast.InstallDate = Assettotransfer[i].InstallDate;
                Ast.Department__c = Assettotransfer[i].Department__c;
                Ast.ContactId = Assettotransfer[i].ContactId;
                Ast.Medical_Services__c = Assettotransfer[i].Medical_Services__c;
                Ast.Status = Assettotransfer[i].Status;
                Ast.Site_ID__c=Assettotransfer[i].Site_ID__c;
                Ast.SerialNumber = Assettotransfer[i].SerialNumber;
                Ast.Software_Version__c = Assettotransfer[i].Software_Version__c;
                Ast.Hardware_Version__c = Assettotransfer[i].Hardware_Version__c;
                Ast.Lease_Expiration_Date__c = Assettotransfer[i].Lease_Expiration_Date__c;
                Ast.Service_Engineer__c=Assettotransfer[i].Service_Engineer__c;
                Ast.Sales_Order_Number__c=Assettotransfer[i].Sales_Order_Number__c;
                Ast.Booking_Date__c=Assettotransfer[i].Booking_Date__c;
                Ast.Ship_Date__c=Assettotransfer[i].Ship_Date__c;
                Ast.Phone_Book_Account__c=Assettotransfer[i].Phone_Book_Account__c;
                Ast.Description=Assettotransfer[i].Description;
                Ast.Service_Manager__c=Assettotransfer[i].Service_Manager__c;
                System.debug('Product ID'+Assettotransfer[i].Product2Id);
                Ast.Product2Id=Assettotransfer[i].Product2Id;
                Ast.Service_Region__c=Assettotransfer[i].Service_Region__c;
                Ast.Ship_to_Account__c=Assettotransfer[i].Ship_to_Account__c;                            
                asst.add(Ast);
            }
            if(asst.size()>0 && asst!=null)
            { 
                Insert asst;
            }
            if(Assettotransfer.size()>0 && Assettotransfer!=null)
            { 
                delete Assettotransfer;
            }
                     
            List<Affiliates__c> affl=new List<Affiliates__c>(); 
            Affiliatestotransfer=[select id,Name,Account__c,Contact__c from Affiliates__c where Account__c=:idacc];
            //Affiliates__c Afl=new Affiliates__c();
            for(integer i=0;i<Affiliatestotransfer.size();i++)
            {
                Affiliates__c Afl=new Affiliates__c();
                Afl.Account__c=desacc;
                Afl.Contact__c=Affiliatestotransfer[i].Contact__c;
                affl.add(Afl);
            }
            if(affl.size()>0   &&  affl!=null)
            { 
                Insert affl;
            }
            if(Affiliatestotransfer.size()>0 && Affiliatestotransfer!=null)
            { 
                delete Affiliatestotransfer;
            }
            PageReference pg=new Pagereference('/'+desacc);
            pg.setRedirect(true);
            return pg;
          } 
        }
        catch(Exception e)
        {
            Id desacc1;
            desacc1=accountId;   
            acc1=[select id,name,type,Archived_Record__c,Destination_Account_Name__c from Account where id=:desacc1];  
            System.debug('#################' +acc.type);
            System.debug('%%%%%%%%%%%%%%%%%%' +acc1.type);    
            //Already a validation rule is written for it.
            /*if((acc1.type=='prospect') && (acc.type=='customer'))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Error :You cannot merge Customer Account Type with Prospect Account Type. Please select different Destination Account.'));
            } */    
            if((acc1.id==acc.id)) 
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Error :Your Source Account is same as Destination Account.Please  select different Destination Account.'));
            }
            if((acc1.Archived_Record__c==true || acc1.Destination_Account_Name__c!=Null))  
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Error :Selected Destination Account is already Merged.'));
            }                     
        }   
        return null;
    }
} 
 
public pageReference Merge1()
{ 
    MergeAccount.alreadyCreatedTasks = true; 
    acc.Archived_Record__c= str;
    acc.Destination_Account_Name__c = accountId ;
    update acc;
    Id desacc;
    desacc=accountId; 
    
    //Moving contacts from source account to destination account     
    List<Contact> conlist=new list<Contact>();
    contacttotransfer=[select id,name,AccountId from Contact where AccountId=:idacc];
    for(Contact c :contacttotransfer)
    {
        c.AccountId=desacc;
        conlist.add(c);
    }
    if(conlist!=null && conlist.size()>0)
    { 
        update conlist;
    }
  
    //Moving AccountRole from source account to destination account
    List<AccountContactRole> acr=new List<AccountContactRole>(); 
    AccountContactRoletotransfer=[select Id,ContactId,Role from AccountContactRole where AccountId=:idacc];
    //AccountContactRole opptm=new AccountContactRole();
    for(integer i=0;i<AccountContactRoletotransfer.size();i++)
    {   
        AccountContactRole opptm=new AccountContactRole();
        opptm.ContactId=AccountContactRoletotransfer[i].ContactId;
        opptm.AccountId=desacc;
        opptm.Role=AccountContactRoletotransfer[i].Role;
        acr.add(opptm); 
    }
    if(acr!=null && acr.size()>0)
    { 
        insert acr;
    }
    if(AccountContactRoletotransfer.size()>0 && AccountContactRoletotransfer!=null)
    {
        delete AccountContactRoletotransfer;
    }

    //Moving Opportunity from source account to destination account 
    List<Opportunity> opp=new List<Opportunity>();
    Opportunitytotransfer=[select id,name,CloseDate,StageName,AccountId from Opportunity where AccountId=:idacc];    
    for(Opportunity o:Opportunitytotransfer)
    {
        o.AccountId=desacc;
        opp.add(o);
    }
    if(opp!=null && opp.size()>0)
    { 
        Update opp;
    }
    
    //Moving Account_affiliation from source account to destination account 
    List<Account_affiliation__c> aff=new List<Account_affiliation__c>();
    Affiliatedotransfer=[select id,name, Affiliated_Account__c,Business_Line__c,Customer_Prospect__c,Custom_Lastmodified__c,Relationship_Type__c,Role__c,Send_to_Siebel__c from Account_affiliation__c  where Customer_Prospect__c=:idacc ];
    System.debug('Affiliatedotransfer'+Affiliatedotransfer);
    for(Account_affiliation__c  a: Affiliatedotransfer)
    {
        //a.Affiliated_Account__c=AffAccount;
        a.Customer_Prospect__c =desacc;
        aff.add(a);
    }
    if(aff.size()>0 && aff!=null)
    { 
        Update aff;
    }                           
    
    //Moving Account_affiliation from source account to destination account 
    List<Account_affiliation__c> aff1=new List<Account_affiliation__c>();
    Affiliatedotransfer=[select id,name, Affiliated_Account__c, Business_Line__c,Customer_Prospect__c,Custom_Lastmodified__c,Relationship_Type__c,Role__c,Send_to_Siebel__c from Account_affiliation__c  where Affiliated_Account__c=:idacc ];
    System.debug('Affiliatedotransfer'+Affiliatedotransfer);
    for(Account_affiliation__c  a: Affiliatedotransfer)
    {
        a.Affiliated_Account__c=desacc;
        //a.Customer_Prospect__c =desacc;
        aff1.add(a);
    }
    if(aff1.size()>0 && aff1!=null)
    { 
        Update aff1;
    }
    
    //Moving Lead from source account to destination account 
    List<Lead> Led=new List<Lead>();
    Leadtotransfer=[select id,Name,And__c,Account__c from Lead where Account__c=:idacc];
    for(Lead ld:Leadtotransfer)
    {
        ld.Account__c=desacc;
        Led.add(ld);
    }
    if(Led.size()>0  &&  Led!=null)
    { 
        Update Led;
    }

    //Moving Department from source account to destination account 
    List<Department__c > dep=new List<Department__c >();
    Departmentotransfer=[select id,name, Account_Department__c, PMS_Account_Medical_Services__c from Department__c  where Account_Department__c=:idacc];
    for(Department__c  d: Departmentotransfer)
    {
        d.Account_Department__c=desacc;
        dep.add(d);
    }
    if(dep.size()>0 && dep!=null)
    { 
        Update dep;
    }
   
    //Moving Task from source account to destination account 
    List<Task> Tsk=new List<Task>();
    Tasktotransfer=[select id,Subject,Status,Priority,WhatId,WhoId from Task where WhatId=:idacc];
    for(Task Tk:Tasktotransfer)
    {
        Tk.WhatId=desacc;
        Tsk.add(Tk);
    }
    if(Tsk!=null && Tsk.size()>0)
    { 
        Update Tsk;
    }
   
    
    //Moving Event from source account to destination account 
    List<Event> Evt=new List<Event>();
    Evevttotransfer=[select id,Subject,StartDateTime,EndDateTime,WhatId,WhoId from Event where WhatId=:idacc];
    for(Event et:Evevttotransfer)
    {
        et.WhatId=desacc;
        Evt.add(et);
    }
    if(Evt!=null  && Evt.size()>0)
    { 
        Update Evt;
    }
     
    //Moving Attachment from source account to destination account  
    List<Attachment> Att=new List<Attachment>();
    Attachmenttotransfer=[select id,ParentId,Name,Body from Attachment where ParentId=:idacc];
    //Attachment attch=new Attachment();
    for(integer i=0;i<Attachmenttotransfer.size();i++)
    {  
        Attachment attch=new Attachment();
        attch.ParentId=desacc;
        attch.Name=Attachmenttotransfer[i].Name;
        attch.Body=Attachmenttotransfer[i].Body;
        Att.add(attch);
    }
    if(Att!=null && Att.size()>0)
    { 
        Insert Att;
    }
    if(Attachmenttotransfer.size()>0 && Attachmenttotransfer!=null)
    { 
        delete Attachmenttotransfer;
    }
    
        
    //Moving Notes from source account to destination account 
    List<Note> Nte=new List<Note>(); 
    Notetotransfer=[select id,ParentId,Title,Body from Note where ParentId=:idacc];
    //Note nt=new Note();
    for(integer i=0;i<Notetotransfer.size();i++)
    {
        Note nt=new Note();
        nt.ParentId=desacc;
        nt.Title=Notetotransfer[i].Title;
        nt.Body=Notetotransfer[i].Body;
        Nte.add(nt);
    }
    if(Nte!=null  && Nte.size()>0)
    { 
        Insert Nte;
    }
    if(Notetotransfer.size()>0 && Notetotransfer!=null)
    { 
        delete Notetotransfer;
    }
    
    //Updated By Mayank Jain
    Account2=[select Siebel_ID__c,Account_Alias__c,Phone,Fax,Website,Phone_Book_Account__c,Class_of_Account__c,Expertise__c,Facility_Type__c,Short_Term_Beds__c,Total_Beds__c,SourceSystem__c,TIMS_ID__c, SMG_ID__c,ICUs__c,Competitive_Buying_Information__c,Licensed_Bed_Count__c,Employee_Here__c,Goldmine_Account__c,gmx_Custom_API_1__c,gmx_Custom_API_5__c,gmx_Custom_API_2__c, gmx_Custom_API_3__c,Urgent_Care_Facility__c,gmx_Custom_API_4__c,gmx_Web_Viewer__c,gmx_Archive_VNA__c,gmx_RIS_Version__c, gmx_CustStatus__c,gmx_PACS_Gear__c, gmx_OrthoView__c,gmx_ClinApps_WF_Solution__c,Marketing_programs__c from  Account where Id=:desacc];
    system.debug('check------------------------'+acc.Total_Beds__c);
    if(acc.SourceSystem__c!='Siebel')
    {    
        if(Account2.Siebel_ID__c == NULL && acc.Siebel_ID__c!=NULL)
        {
            Account2.Siebel_ID__c = acc.Siebel_ID__c;
            acc.Siebel_ID__c=NULL;
            system.debug('check------------------------'+acc.Siebel_ID__c);                        
        }
        if(Account2.Account_Alias__c == NULL && acc.Account_Alias__c!=NULL)
        {
            Account2.Account_Alias__c = acc.Account_Alias__c;
            system.debug('check------------------------'+acc.Account_Alias__c);
        }
        if(Account2.Phone == NULL && acc.Phone!=NULL)
        {
            Account2.Phone = acc.Phone;
            system.debug('check------------------------'+acc.Phone);
        }
        if(Account2.Fax == NULL && acc.Fax!=NULL)
        {
            Account2.Fax= acc.Fax;
            system.debug('check------------------------'+acc.Fax);
        }
        if(Account2.Website== NULL && acc.Website!=NULL)
        {
            Account2.Website = acc.Website;
            system.debug('check------------------------'+acc.Website);
        }
        if(Account2.Phone_Book_Account__c == False && acc.Phone_Book_Account__c!=False)
        {
            Account2.Phone_Book_Account__c = True;
            acc.Phone_Book_Account__c = False;
            system.debug('check------------------------'+acc.Phone_Book_Account__c);
        }
        if(Account2.Total_Beds__c == NULL && acc.Total_Beds__c!=NULL)
        {
            Account2.Total_Beds__c = acc.Total_Beds__c;
            system.debug('check------------------------'+acc.Total_Beds__c);
        }
        
        //Modified for co783834
        if(Account2.Goldmine_Account__c == NULL && acc.Goldmine_Account__c!=NULL)
        {
            Account2.Goldmine_Account__c = acc.Goldmine_Account__c;
            system.debug('check------------------------'+acc.Goldmine_Account__c);
        }
        if(Account2.Gmx_Custom_API_1__c == NULL && acc.Gmx_Custom_API_1__c!=NULL)
        {
            Account2.Gmx_Custom_API_1__c = acc.Gmx_Custom_API_1__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_1__c);
        }
        if(Account2.Gmx_Custom_API_5__c == NULL && acc.Gmx_Custom_API_5__c!=NULL)
        {
            Account2.Gmx_Custom_API_5__c = acc.Gmx_Custom_API_5__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_5__c);
        }
        if(Account2.Gmx_Custom_API_2__c == NULL && acc.Gmx_Custom_API_2__c!=NULL)
        {
            Account2.Gmx_Custom_API_2__c = acc.Gmx_Custom_API_2__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_2__c);
        }
        if(Account2.Gmx_Custom_API_3__c == NULL && acc.Gmx_Custom_API_3__c!=NULL)
        {
            Account2.Gmx_Custom_API_3__c = acc.Gmx_Custom_API_3__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_3__c);
        }
        if(Account2.Urgent_Care_Facility__c == NULL && acc.Urgent_Care_Facility__c!=NULL)
        {
            Account2.Urgent_Care_Facility__c = acc.Urgent_Care_Facility__c;
            system.debug('check------------------------'+acc.Urgent_Care_Facility__c);
        }

        if(Account2.Gmx_Custom_API_4__c == NULL && acc.Gmx_Custom_API_4__c!=NULL)
        {
            Account2.Gmx_Custom_API_4__c = acc.Gmx_Custom_API_4__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_4__c);
        }
        if(Account2.Gmx_Web_Viewer__c == NULL && acc.Gmx_Web_Viewer__c!=NULL)
        {
            Account2.Gmx_Web_Viewer__c = acc.Gmx_Web_Viewer__c;
            system.debug('check------------------------'+acc.Gmx_Web_Viewer__c);
        }
        if(Account2.Gmx_Archive_VNA__c == NULL && acc.Gmx_Archive_VNA__c!=NULL)
        {
            Account2.Gmx_Archive_VNA__c = acc.Gmx_Archive_VNA__c;
            system.debug('check------------------------'+acc.Gmx_Archive_VNA__c);
        }
        if(Account2.gmx_RIS_Version__c == NULL && acc.gmx_RIS_Version__c!=NULL)
        {
            Account2.gmx_RIS_Version__c= acc.gmx_RIS_Version__c;
            system.debug('check------------------------'+acc.gmx_RIS_Version__c);
        }
        if(Account2.gmx_CustStatus__c == NULL && acc.gmx_CustStatus__c!=NULL)
        {
            Account2.gmx_CustStatus__c= acc.gmx_CustStatus__c;
            system.debug('check------------------------'+acc.gmx_CustStatus__c);
        }
        if(Account2.gmx_PACS_Gear__c == NULL && acc.gmx_PACS_Gear__c!=NULL)
        {
            Account2.gmx_PACS_Gear__c= acc.gmx_PACS_Gear__c;
            system.debug('check------------------------'+acc.gmx_PACS_Gear__c);
        }
        if(Account2.gmx_OrthoView__c == NULL && acc.gmx_OrthoView__c!=NULL)
        {
            Account2.gmx_OrthoView__c= acc.gmx_OrthoView__c;
            system.debug('check------------------------'+acc.gmx_OrthoView__c);
        }
        if(Account2.gmx_ClinApps_WF_Solution__c == NULL && acc.gmx_ClinApps_WF_Solution__c!=NULL)
        {
            Account2.gmx_ClinApps_WF_Solution__c= acc.gmx_ClinApps_WF_Solution__c;
            system.debug('check------------------------'+acc.gmx_ClinApps_WF_Solution__c);
        }
        if(Account2.Marketing_programs__c == NULL && acc.Marketing_programs__c!=NULL)
        {
            Account2.Marketing_programs__c= acc.Marketing_programs__c;
            system.debug('check------------------------'+acc.Marketing_programs__c);
        }


        //Modification ends
        
        
        if(Account2.Class_of_Account__c == NULL && acc.Class_of_Account__c!=NULL)
        {
            Account2.Class_of_Account__c = acc.Class_of_Account__c;
            system.debug('check------------------------'+acc.Class_of_Account__c);
        }  
        if(Account2.Facility_Type__c == NULL && acc.Facility_Type__c!=NULL)
        {
            Account2.Facility_Type__c = acc.Facility_Type__c;
            system.debug('check------------------------'+acc.Facility_Type__c);
        }                  
        if(Account2.Expertise__c == NULL && acc.Expertise__c!=NULL)
        {
            Account2.Expertise__c = acc.Expertise__c;
            system.debug('check------------------------'+acc.Expertise__c);
        }
        if(Account2.Short_Term_Beds__c == NULL && acc.Short_Term_Beds__c!=NULL)
        {
            Account2.Short_Term_Beds__c= acc.Short_Term_Beds__c;
            system.debug('check------------------------'+acc.Short_Term_Beds__c);
        }                                  
        if(Account2.TIMS_ID__c == NULL && acc.TIMS_ID__c!=NULL)
        {
            Account2.TIMS_ID__c = acc.TIMS_ID__c;
        }
        if(Account2.SMG_ID__c == NULL && acc.SMG_ID__c!=NULL)
        {
            Account2.SMG_ID__c = acc.SMG_ID__c;
        }
        if(Account2.ICUs__c == NULL && acc.ICUs__c!=NULL)
        {
            Account2.ICUs__c = acc.ICUs__c;
        }
        if(Account2.Competitive_Buying_Information__c == NULL && acc.Competitive_Buying_Information__c!=NULL)
        {
            Account2.Competitive_Buying_Information__c = acc.Competitive_Buying_Information__c;
        }
        if(Account2.Licensed_Bed_Count__c == NULL && acc.Licensed_Bed_Count__c!=NULL)
        {
            Account2.Licensed_Bed_Count__c = acc.Licensed_Bed_Count__c;
        }
        if(Account2.Employee_Here__c == NULL && acc.Employee_Here__c!=NULL)
        {
            Account2.Employee_Here__c = acc.Employee_Here__c;
        }
        if(Account2.SourceSystem__c == NULL && acc.SourceSystem__c!=NULL)
        {
            Account2.SourceSystem__c = acc.SourceSystem__c;
            acc.SourceSystem__c=NULL;
        }                   
    } 
   //For source code is Siebel                
    else
    {
        if(acc.Siebel_ID__c!=NULL)
        {
            Account2.Siebel_ID__c = acc.Siebel_ID__c;
            acc.Siebel_ID__c=NULL;
            system.debug('check------------------------'+acc.Siebel_ID__c);
        }
        if(acc.Account_Alias__c!=NULL)
        {
            Account2.Account_Alias__c = acc.Account_Alias__c;
            system.debug('check------------------------'+acc.Account_Alias__c);
        }
        if(acc.Phone!=NULL)
        {
            Account2.Phone = acc.Phone;
            system.debug('check------------------------'+acc.Phone);
        }
        if(acc.Fax!=NULL)
        {
            Account2.Fax= acc.Fax;
            system.debug('check------------------------'+acc.Fax);
        }
        if(acc.Website!=NULL)
        {
            Account2.Website = acc.Website;
            system.debug('check------------------------'+acc.Website);
        }
        if(acc.Phone_Book_Account__c!=False)
        {
            Account2.Phone_Book_Account__c = True;
            acc.Phone_Book_Account__c=False;
            system.debug('check-----phone book acc-------------------'+acc.Phone_Book_Account__c);
        }
        if(acc.Total_Beds__c!=NULL)
        {
            Account2.Total_Beds__c = acc.Total_Beds__c;
            system.debug('check------------------------'+acc.Total_Beds__c);
        }
        // Modifications
        if(acc.Goldmine_Account__c!=NULL)
        {
            Account2.Goldmine_Account__c = acc.Goldmine_Account__c;
            system.debug('check------------------------'+acc.Goldmine_Account__c);
        }
        if(acc.Gmx_Custom_API_1__c!=NULL)
        {
            Account2.Gmx_Custom_API_1__c = acc.Gmx_Custom_API_1__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_1__c);
        }
        if(acc.Gmx_Custom_API_5__c!=NULL)
        {
            Account2.Gmx_Custom_API_5__c = acc.Gmx_Custom_API_5__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_5__c);
        }
        if(acc.Gmx_Custom_API_2__c!=NULL)
        {
            Account2.Gmx_Custom_API_2__c = acc.Gmx_Custom_API_2__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_2__c);
        }
        if(acc.Gmx_Custom_API_3__c!=NULL)
        {
            Account2.Gmx_Custom_API_3__c = acc.Gmx_Custom_API_3__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_3__c);
        }
        if(acc.Urgent_Care_Facility__c!=NULL)
        {
            Account2.Urgent_Care_Facility__c = acc.Urgent_Care_Facility__c;
            system.debug('check------------------------'+acc.Urgent_Care_Facility__c);
        }
        if(acc.Gmx_Custom_API_4__c!=NULL)
        {
            Account2.Gmx_Custom_API_4__c = acc.Gmx_Custom_API_4__c;
            system.debug('check------------------------'+acc.Gmx_Custom_API_4__c);
        }
        if(acc.Gmx_Web_Viewer__c!=NULL)
        {
            Account2.Gmx_Web_Viewer__c = acc.Gmx_Web_Viewer__c;
            system.debug('check------------------------'+acc.Gmx_Web_Viewer__c);
        }
        if(acc.Gmx_Archive_VNA__c!=NULL)
        {
            Account2.Gmx_Archive_VNA__c = acc.Gmx_Archive_VNA__c;
            system.debug('check------------------------'+acc.Gmx_Archive_VNA__c);
        }
        if(acc.Gmx_RIS_Version__c!=NULL)
        {
            Account2.Gmx_RIS_Version__c = acc.Gmx_RIS_Version__c;
            system.debug('check------------------------'+acc.Gmx_RIS_Version__c);
        }
        if(acc.Gmx_CustStatus__c!=NULL)
        {
            Account2.Gmx_CustStatus__c = acc.Gmx_CustStatus__c;
            system.debug('check------------------------'+acc.Gmx_CustStatus__c);
        }
        if(acc.Gmx_PACS_Gear__c!=NULL)
        {
            Account2.Gmx_PACS_Gear__c = acc.Gmx_PACS_Gear__c;
            system.debug('check------------------------'+acc.Gmx_PACS_Gear__c);
        }
        if(acc.Gmx_OrthoView__c!=NULL)
        {
            Account2.Gmx_OrthoView__c = acc.Gmx_OrthoView__c;
            system.debug('check------------------------'+acc.Gmx_OrthoView__c);
        }
        if(acc.Gmx_ClinApps_WF_Solution__c!=NULL)
        {
            Account2.Gmx_ClinApps_WF_Solution__c = acc.Gmx_ClinApps_WF_Solution__c;
            system.debug('check------------------------'+acc.Gmx_ClinApps_WF_Solution__c);
        }
        if(acc.Marketing_programs__c!=NULL)
        {
            Account2.Marketing_programs__c = acc.Marketing_programs__c;
            system.debug('check------------------------'+acc.Marketing_programs__c);
        }


        // Modifications of line-1158 ends 
        
        
        if(acc.Class_of_Account__c!=NULL)
        {
            Account2.Class_of_Account__c = acc.Class_of_Account__c;
            system.debug('check------------------------'+acc.Class_of_Account__c);
        }  
        if(acc.Facility_Type__c!=NULL)
        {
            Account2.Facility_Type__c = acc.Facility_Type__c;
            system.debug('check------------------------'+acc.Facility_Type__c);
        }                   
        if(acc.Expertise__c!=NULL)
        {
            Account2.Expertise__c = acc.Expertise__c;
            system.debug('check------------------------'+acc.Expertise__c);
        }
        if(acc.Short_Term_Beds__c!=NULL)
        {
            Account2.Short_Term_Beds__c= acc.Short_Term_Beds__c;
            system.debug('check------------------------'+acc.Short_Term_Beds__c);
        }                                  
        if(acc.TIMS_ID__c!=NULL)
        {
            Account2.TIMS_ID__c = acc.TIMS_ID__c;
        }
        if(acc.SMG_ID__c!=NULL)
        {
            Account2.SMG_ID__c = acc.SMG_ID__c;
        }
        if(acc.ICUs__c!=NULL)
        {
            Account2.ICUs__c = acc.ICUs__c;
        }
        if(acc.Competitive_Buying_Information__c!=NULL)
        {
            Account2.Competitive_Buying_Information__c = acc.Competitive_Buying_Information__c;
        }
        if(acc.Licensed_Bed_Count__c!=NULL)
        {
            Account2.Licensed_Bed_Count__c = acc.Licensed_Bed_Count__c;
        }
        if(acc.Employee_Here__c!=NULL)
        {
            Account2.Employee_Here__c = acc.Employee_Here__c;
        }
        if(acc.SourceSystem__c!=NULL)
        {
            Account2.SourceSystem__c = acc.SourceSystem__c;
            acc.SourceSystem__c=NULL;
        }                      
    }
    acc.Phone_Book_Account__c=False;
    Update Account2;
    update acc;

    Accountteam = [select AccountId,TeamMemberRole, AccountAccessLevel,UserId from AccountTeamMember where AccountId=:idacc];
    Accountteam1=[select  AccountId,TeamMemberRole, AccountAccessLevel,UserId from AccountTeamMember where AccountId=:desacc];
    set<Id> desuser=new set<Id>();
    List<AccountShare> AccShare1 = new List<AccountShare>();
    AccShare1 = [select AccountAccessLevel,CaseAccessLevel,OpportunityAccessLevel,UserOrGroupId from AccountShare where AccountId=:idacc AND RowCause = 'team'];
    List<AccountTeamMember> atmc=new list<AccountTeamMember>();
    for(AccountTeamMember at1 : Accountteam1)
    { 
        desuser.add(at1.userId);
    }
    system.debug('#########' + desuser);
    for(AccountTeamMember at : Accountteam)
    { 
        if(!desuser.contains(at.userId))
        {
 
            system.debug('source user' +at.UserId);      
            AccountTeamMember  accm = new  AccountTeamMember();
            accm.AccountId=desacc;
            accm.TeamMemberRole=at.TeamMemberRole;
            accm.UserId=at.UserId;
            Insert atmc;
        }
    }
    for(AccountShare AccS1 : AccShare1)
    {
           AccountShare caSharingRule1 = new AccountShare();
           caSharingRule1.AccountId = desacc;
           caSharingRule1.OpportunityAccessLevel = AccS1.OpportunityAccessLevel;
           caSharingRule1.CaseAccessLevel = AccS1.CaseAccessLevel;
           caSharingRule1.AccountAccessLevel = AccS1.AccountAccessLevel;
           caSharingRule1.UserOrGroupId = AccS1.UserOrGroupId; 
           insert caSharingRule1;
     }
    
    /*system.debug('source user list' +atmc);
    if(atmc.size()>0 && atmc!=null)
    {
        insert atmc;
    }*/
    if(Accountteam!=null && Accountteam.size()>0)
    {
        delete  Accountteam;
    } 
    List<Asset> asst=new List<Asset>(); 
    //Assettotransfer=[select id,AccountId,Name from Asset where AccountId=:idacc];
    
    Assettotransfer=[select id,Site_ID__c,ContactId,Description,Phone_Book_Account__c,Booking_Date__c,Ship_Date__c,Sales_Order_Number__c,Lease_Expiration_Date__c,SerialNumber,Hardware_Version__c,Software_Version__c,Vendor_on_product__c,Modality_lookup_product__c,Ship_to_Account__c,Service_Engineer__c,Service_Manager__c,Product2Id,Service_Region__c,AccountId,Name, InstallDate, Department__c, Medical_Services__c,
                     Status from Asset where AccountId=:idacc];                
    //Asset Ast=new Asset();
    for(integer i=0;i<Assettotransfer.size();i++)
    {
                Asset Ast=new Asset();
                Ast.AccountId=desacc;
                Ast.Name=Assettotransfer[i].Name;
                //Modified on 22nd March
                Ast.InstallDate = Assettotransfer[i].InstallDate;
                Ast.Department__c = Assettotransfer[i].Department__c;
                Ast.ContactId = Assettotransfer[i].ContactId;
                Ast.Medical_Services__c = Assettotransfer[i].Medical_Services__c;
                Ast.Status = Assettotransfer[i].Status;
                Ast.Site_ID__c=Assettotransfer[i].Site_ID__c;
                Ast.SerialNumber = Assettotransfer[i].SerialNumber;
                Ast.Software_Version__c = Assettotransfer[i].Software_Version__c;
                Ast.Hardware_Version__c = Assettotransfer[i].Hardware_Version__c;
                Ast.Lease_Expiration_Date__c = Assettotransfer[i].Lease_Expiration_Date__c;
                Ast.Service_Engineer__c=Assettotransfer[i].Service_Engineer__c;
                Ast.Sales_Order_Number__c=Assettotransfer[i].Sales_Order_Number__c;
                Ast.Booking_Date__c=Assettotransfer[i].Booking_Date__c;
                Ast.Ship_Date__c=Assettotransfer[i].Ship_Date__c;
                Ast.Phone_Book_Account__c=Assettotransfer[i].Phone_Book_Account__c;
                Ast.Description=Assettotransfer[i].Description;
                Ast.Service_Manager__c=Assettotransfer[i].Service_Manager__c;
                System.debug('Product ID'+Assettotransfer[i].Product2Id);
                Ast.Product2Id=Assettotransfer[i].Product2Id;
                Ast.Service_Region__c=Assettotransfer[i].Service_Region__c;
                Ast.Ship_to_Account__c=Assettotransfer[i].Ship_to_Account__c;
         
       
        asst.add(Ast);
    }
    if(asst!=null && asst.size()>0)
    { 
        Insert asst;
    }
    if(Assettotransfer.size()>0 && Assettotransfer!=null)
    { 
        delete Assettotransfer;
    }
    List<Affiliates__c> affl=new List<Affiliates__c>(); 
    Affiliatestotransfer=[select id,Name,Account__c,Contact__c from Affiliates__c where Account__c=:idacc];
    //Affiliates__c Afl=new Affiliates__c();
    for(integer i=0;i<Affiliatestotransfer.size();i++)
    {
        Affiliates__c Afl=new Affiliates__c();
        Afl.Account__c=desacc;
        Afl.Contact__c=Affiliatestotransfer[i].Contact__c;
        affl.add(Afl);
    }
    if(affl!=null  && affl.size()>0)
    { 
        Insert affl;
    }
    if(Affiliatestotransfer.size()>0 && Affiliatestotransfer!=null)
    { 
        delete Affiliatestotransfer;
    }       
   
    //Return to destination account page
    PageReference pg=new Pagereference('/'+desacc);
    pg.setRedirect(true);
    return pg;
}

        
    public pageReference Cancel()
    {
        PageReference pg=new Pagereference('/'+idacc);
        pg.setRedirect(true);
        return pg;
    }
}