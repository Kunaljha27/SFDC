/*
    @author         Rahul Shaw <rahul.shaw@wipro.com>
    @class          Role_AuditTrail
    @abstract       Updates Audit Trail object on addition or deletion in Role Hiearchy.
    @since          2012.03.20
    @discussion     Captures changes for role hiearchy in audit trail object
*/
public class Role_AuditTrail{
/*
 public Role_AuditTrail()
 {}
 // Method to check changes in role hiearchy and update Audit Trail object accordingly //
public  void test() 
  {
   List<UserRole> ur = [select id, Name from UserRole  ];
   set<id> InterMedID = new set<id>();
   set<id> URoleId = new set<id>();
   List<Intermediate__c> IntermediateList_1 =[select id, Name,id__c from Intermediate__c];
// Copy all the roles from UserRole to Intermediate Object  
 if(IntermediateList_1.size()==0)
   {
      List<Intermediate__c> intermediate = new List<Intermediate__c>();
    for(UserRole UserR : ur)
   { 
     
     intermediate.add(new Intermediate__c(Name = UserR.Name,id__c=UserR.id));
     
    } 
   insert intermediate;  
 } 

//Compares Intermediate Object & UserRole .If there is any changes in the UserRole,it is captured in the Audit Trail Object 
else       
{

 List< Audit_Trail__c> AuditTT = new List<Audit_Trail__c>();
 for(Intermediate__c Inter_3List : IntermediateList_1)
    {
    InterMedID.add(Inter_3List.id__c);
    }
 for(UserRole UserRR : ur)
   {
   URoleId.add(UserRR.id);
   } 
   
   // Check whether a new role is inserted 
 for(UserRole UserRRR : ur)
    {
    
        if(!InterMedID.contains(UserRRR.id))
           {
            AuditTT.add(new Audit_Trail__c(Role_Name_Hierarchy__c=UserRRR .Name,New_Role__c = UserRRR .id,Comment__c='Role inserted',RecordTypeId=label.AuditTT_RecordTypeId));
           }
       }
       if( AuditTT!=null && AuditTT.size()>0) {
        insert AuditTT;
        }
   
 List< Audit_Trail__c> AuditTT1 = new List<Audit_Trail__c>();
 // Check whether a role is deleted
 for(Intermediate__c InterList : IntermediateList_1)
    {  
    if(!URoleId.contains(InterList.id__c))
          {
          AuditTT1.add(new Audit_Trail__c(Role_Name_Hierarchy__c=InterList.Name,New_Role__c = InterList.id__c,RecordTypeId=label.AuditTT_RecordTypeId,Comment__c='Role deleted'));
           
         }
        }
      if( AuditTT1!=null && AuditTT1.size()>0) {
        insert AuditTT1;
        }   
    } 
//After Audit Trail Updation,every Role is copied from UserRole to Intermediate Object    
List<Intermediate__c> Inter_1List =[select id,Name,id__c from Intermediate__c]; 
if(Inter_1List.size()>0) {
  delete Inter_1List;
  }
  List<Intermediate__c> intermediate = new List<Intermediate__c>();
for(UserRole UserRRRR : ur)
   { 
   intermediate.add(new Intermediate__c(Name = UserRRRR.Name,id__c=UserRRRR.id));
    
    
    }
  if(intermediate!=null && intermediate.size()>0) {
    insert intermediate;
   }  
}*/
}