public class contentController 
{  
 Public Id NoteId ;   
  public contentController(ApexPages.StandardController controller)
   {    
    file = new ContentVersion();     
     NoteId = ApexPages.currentPage().getParameters().get('Id');          
     }     
     public string FileName{ get;set;}       
     PageReference pageRef = ApexPages.currentPage();    
      Note Mynt = New Note();           
       public ContentVersion file { get; set; }                  
        public PageReference go()
         {      
         if(NoteId != NULL)
         {        
         Mynt.ParentId = NoteId;    
          
         insert file;         
         ContentVersion conv = [Select Title from ContentVersion where Id =: file.id];        
         Mynt.Title = FileName;            
         insert Mynt;        
         Mynt.Body = 'https://cs9.salesforce.com/sfc/#version/'+file.Id;       
         update Mynt;           
         return new PageReference('/' + NoteId);     
         }    
          else if(file.Id !=NULL)    
           {     
           return pageRef;    
            }    
             else     
             {     
             return pageRef;    
              } 
                 }
                 }