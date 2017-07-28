/*
    @author         Rahul Shaw <rahul.shaw@wipro.com>
    @class          Audit_Updates
    @abstract       Updates Audit Trail object on changes in User Role.
    @since          2012.03.20
    @discussion     Class to track changes in user state(Active/Inactive) and role
*/
global class Audit_Updates { 
//Method to check changes in user role and update Audit trail accordingly 
/*@future
public static void Audit_Role_Update (List<id> newrr,List<id> ui,List<id> old)
{
 Integer i =0;
 List<Audit_Trail__c> Autt1= new List<Audit_Trail__c>();
 map<id,UserRole> UserR = new map<id,UserRole>([select id, Name from UserRole]);
 Integer size = newrr.size();
 system.debug('size' + size);
 for(;i<size; )
 {
 Audit_Trail__c auditinst = new Audit_Trail__c();
 if(newrr[i]=='a00K00000fakeid')//fake value(ID assignment just to check the null value)
    auditinst.New_User_Role__c='None specified';
 else
    auditinst.New_User_Role__c=UserR.get(newrr[i]).Name;
  auditinst.Comment_User_Change__c = 'User  Role Updated';
  auditinst.recordtypeid=label.auditinst_recordtypeid;
 if(old[i]=='a00K00000fakeid')//fake value(ID assignment just to check the null value)
  auditinst.Old_User_Role__c='None specified';
 else
    auditinst.Old_User_Role__c=UserR.get(old[i]).Name;
  auditinst.User_Name1__c=ui[i];
  auditinst.Role_Name_Hierarchy__c=ui[i];
  Autt1.add(auditinst);
 i++;
}
insert Autt1;
}
//Method to check whether a user has been made active and update Audit trail 
@future
public static void Audit_User_Active (List<id> Usrrr)
{
  map<id,UserRole> UserR = new map<id,UserRole>([select id, Name from UserRole]);
  List<User> uuuu =[select id,userroleid,Name from User where id IN : Usrrr];
  List<Audit_Trail__c> Autt1= new List<Audit_Trail__c>();
  for(User uu :uuuu)
  { 
   Audit_Trail__c auditin = new Audit_Trail__c();
  if(uu.userroleid== Null)
   auditin.New_User_Role__c='None specified';
    else
   auditin.New_User_Role__c=UserR.get(uu.userroleid).Name;
  if(uu.userroleid== Null)
   auditin.Old_User_Role__c='None specified';
    else
   auditin.Old_User_Role__c=UserR.get(uu.userroleid).Name;
   auditin.Comment_User_Change__c = 'User Made Active';
   auditin.recordtypeid=label.auditinst_recordtypeid;
   //auditin.Old_User_Role__c=rolename2;
   auditin.User_Name1__c=uu.id;
   auditin.Role_Name_Hierarchy__c=uu.id;
   System.debug('check on dev name in user role std obj : '+ auditin.Role_Name_Hierarchy__c );
   Autt1.add(auditin);
  }
insert Autt1;
}

//Method to check whether a new user has been created and update Audit trail accordingly

@future
public static void Audit_User_Create (list<id> usr)
{
  map<id,UserRole> UserR = new map<id,UserRole>([select id, Name from UserRole]);
  List<Audit_Trail__c> Autt1= new List<Audit_Trail__c>();
  List<user> usrr = [select id,userroleid,Name from User where id IN : usr];
  for(User uuu :usrr )
   {
    Audit_Trail__c auditins = new Audit_Trail__c();
    //auditins.Role_Name_Hierarchy__c=name;
    auditins.User_Name1__c=uuu.id;
    auditins.Comment_User_Change__c = 'User Created';
    if(uuu.userroleid== Null)
     auditins.New_User_Role__c='None specified';
    else
      auditins.New_User_Role__c=UserR.get(uuu.userroleid).Name;
    auditins.recordtypeid=label.auditinst_recordtypeid;
    System.debug('check on dev name in user role std obj : '+ auditins.Role_Name_Hierarchy__c );
    Autt1.add(auditins);
}
Insert Autt1;
}
//Method to check whether a user has been deleted and update Audit trail accordingly

@future
public static void Audit_User_Delete (List<id> Usrrr)
{
map<id,UserRole> UserR = new map<id,UserRole>([select id, Name from UserRole]);
List<User> uuuu =[select id,userroleid,Name from User where id IN : Usrrr];
List<Audit_Trail__c> Autt1= new List<Audit_Trail__c>();
for(User uu :uuuu)
 { 
   Audit_Trail__c auditi = new Audit_Trail__c();
   auditi.User_Name1__c=uu.id;
   auditi.Comment_User_Change__c = 'User Made Inactive';
   if(uu.userroleid== Null)
   auditi.New_User_Role__c='None specified';
    else
   auditi.New_User_Role__c=UserR.get(uu.userroleid).Name;
   if(uu.userroleid== Null)
   auditi.Old_User_Role__c='None specified';
    else
   auditi.Old_User_Role__c=UserR.get(uu.userroleid).Name;
     
   auditi.recordtypeid=label.auditinst_recordtypeid;
   System.debug('check on dev name in user role std obj : '+ auditi.Role_Name_Hierarchy__c );
   //insert auditi;
   Autt1.add(auditi);
 }
 Insert Autt1;
 }*/
}