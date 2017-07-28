/** Class Name: M2O_updateLeadAndContactSubscription.
    Developed By : Somdev Bhattacharyya.
    Description : This class is written for the subscribe and unsubscribe functionality for Lead and Contact.
**/    
    
global class M2O_updateLeadAndContactSubscription{
    
   /**Description: This method is used to subcribe a lead through eloqua.
      Parameter : Id of the lead.
      Return Type : Void.
   **/   
    webservice static void updateSubscribe (Id sourceLeadId){
        Lead ld=[Select Email_Opt_Out1__c , id ,EloquaSubcriptionCheck__c,Sector__c from Lead where Id =:sourceLeadId];
        lead l = new lead(Id=ld.Id);
        l.EloquaSubcriptionCheck__c=1;
        if(ld.Sector__c=='Lighting' ||ld.Sector__c=='Consumer Lifestyle') {
            l.Email_Opt_Out1__c='Subscribed';
            l.EloquaSubcriptionCheck__c=0;
        
        }    
        update l;
    }
    
    /**Description: This method is used to Unsubcribe a lead through eloqua.
      Parameter : Id of the lead.
      Return Type : Void.
   **/ 
    webservice static void updateUnSubscribe (Id sourceLeadId){
        Lead ld=[Select Email_Opt_Out1__c , id ,EloquaSubcriptionCheck__c,Sector__c from Lead where Id =:sourceLeadId];
        lead l = new lead(Id=ld.Id);
        l.EloquaSubcriptionCheck__c=2;
        l.Email_Opt_Out1__c='UnSubscribed';
        if(ld.Sector__c=='Lighting' ||ld.Sector__c=='Consumer Lifestyle') {
            l.EloquaSubcriptionCheck__c=0;
        }    
        update l;
    }
    
    /**Description: This method is used to subcribe a Contact through eloqua.
      Parameter : Id of the Contact.
      Return Type : Void.
   **/ 
    webservice static void updateSubscribeContact(Id sourceContactId){
        Contact ct=[Select Email_Subscription_Status__c,Id,EloquaSubcriptionCheck__c,Sector__c from Contact where Id =:sourceContactId];
        Contact c = new Contact(Id=ct.Id);
        c.EloquaSubcriptionCheck__c=1;
        if(ct.Sector__c=='LI' ||ct.Sector__c=='CL') {
            c.Email_Subscription_Status__c='Subscribed';
            c.EloquaSubcriptionCheck__c=0;
        }
        update c;
    }  
    
    /**Description: This method is used to Unsubcribe a lead through eloqua.
      Parameter : Id of the Contact.
      Return Type : Void.
   **/  
    webservice static void updateUnSubscribeContact(Id sourceContactId){
        Contact ct=[Select Email_Subscription_Status__c,Id,EloquaSubcriptionCheck__c,Sector__c from Contact where Id =:sourceContactId];
        Contact c = new Contact(Id=ct.Id);
        c.EloquaSubcriptionCheck__c=2;
        c.Email_Subscription_Status__c='UnSubscribed';
        if(ct.Sector__c=='LI' ||ct.Sector__c=='CL') {
            c.EloquaSubcriptionCheck__c=0;
        }
        update c;
    }     
}