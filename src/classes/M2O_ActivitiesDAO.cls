/**
@Classname :       M2O_ActivitiesDAO
@Description :     DAO class for Activities
@Author:           Rupsa  Hore
@Last Modified:    19/03/2014
**/

public with sharing class M2O_ActivitiesDAO{
    
    /**Description: get Task values
       Return: list
    **/
    public static List<Task> getTaskList(String sourceAccountID) {
        List<Task> listTask = new List<Task>();
        try{
            if(sourceAccountID != Null){
                listTask = [Select WhoId, WhatId, Task_ID__c, Subject, Status__c, Status, IsClosed, AccountId 
                                    from Task where WhatId =: sourceAccountID];
            }
            if(listTask != Null && !listTask.isEmpty()){
                return listTask ;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getTaskList failed -----> '+ex.getmessage());
            return null;
        }
    } 
    
    /**Description: get Event values
       Return: list
    **/
    public static List<Event> getEventList(String sourceAccountID) {
        List<Event> listEvent = new List<Event>();
        try{
            if(sourceAccountID != Null){
                listEvent = [Select WhoId, WhatId, Subject, AccountId 
                                from Event where WhatId =:sourceAccountID and isChild=false];
            }
            if(listEvent != Null && !listEvent.isEmpty()){
                return listEvent;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getEventList failed -----> '+ex.getmessage());
            return null;
        }
    } 
    
    /**Description: get Note valuee
       Return: list
    **/
    public static List<Note> getNoteList(String sourceAccountID) {
        List<Note> listNote = new List<Note>();
        try{
            if(sourceAccountID != Null){
                listNote = [Select  Id, ParentId, Body, title
                                        from Note where ParentId =: sourceAccountID];
            }
            if(listNote != Null && !listNote.isEmpty()){
                return listNote;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getNoteList failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    /**Description: get Attachment values
       Return: list
    **/
    public static List<Attachment> getAttachmentList(String sourceAccountID) {
        List<Attachment> listAttachment = new List<Attachment>();
        try{
            if(sourceAccountID != Null){
                listAttachment = [Select  Id, ParentId, Body, Name
                                       from Attachment where ParentId =:sourceAccountID];
            }
            if(listAttachment != Null && !listAttachment.isEmpty()){
                return listAttachment;
            }
            return null;
        }catch(DMLException ex){
            system.debug('getAttachmentList failed -----> '+ex.getmessage());
            return null;
        }
    }
    
    /**Description: insert Attachment values
       Return: list
    **/
    public static Boolean setAttachments(List<Attachment> listAttachments){
        Boolean error;
        try{
            if(listAttachments != Null && !listAttachments.isEmpty()){
                insert listAttachments;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Notes insert failed -> '+ex);
        }
        return error;
    }
    
    /**Description: insert Notes values
       Return: list
    **/
    public static Boolean setNotes(List<Note> listNotes){
        Boolean error;
        try{
            if(listNotes != Null && !listNotes.isEmpty()){
                insert listNotes;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Notes insert failed -> '+ex);
        }
        return error;
    }
    
    /**Description: insert Activity values
       Return: list
    **/
    public static Boolean setActivity(List<sObject> listActivity){
        Boolean error;
        try{
            if(listActivity != Null && !listActivity .isEmpty()){
                update listActivity ;
                error = false;
            }
        }catch(DMLException ex){
            error = true;
            system.debug('Activity insert failed -> '+ex);
        }
        return error;
    }
}