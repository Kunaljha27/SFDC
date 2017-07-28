/**
@Classname :       M2O_CaptureDeleteRecordsDAO 
@Description :     This class is the DAO class for Capture delete triggers.
@Author:           Vishal Kashyap
@Last Modified:    11/15/2013
**/
public with sharing class M2O_CaptureDeleteRecordsDAO {
    /**
    @Description: Inserts record to Delete Notification Object
    @Param : List of Delete Notification Object.
    @Return:      null
    **/
    public static void insertDeletedRecord(List<Delete_Notifications__c> recordToBeInserted) {
        try {
        insert recordToBeInserted;
        }
        catch(Exception e) {
            system.debug('There was an error capturing Deleted Record : ' + e.getmessage());    
        }
    }
    /**
    @Description: Inserts record to Delete Notification Object
    @Param : List of Delete Notification Object.
    @Return:      null
    **/
    public static Profile dataMigrationInfo() {
        Profile dataMigrationProfile = new Profile();
        try {
        dataMigrationProfile=[Select ID from Profile where Name=:Label.M2O_Data_Migration_Profile limit 1];
        }
        catch(Exception e) {
            system.debug('No information found for Data Migration Profile : ' + e.getmessage());    
        }
        return dataMigrationProfile;
    }
}