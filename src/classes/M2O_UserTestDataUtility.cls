/**
@Classname :       M2O_UserTestDataUtility
@Description :     This test class is written to store all the data related to users and profiles which is to be inserted for testing Oppportunity.
@Author:           Piyali Saha/ Meeta Pramanik
@Last Modified:    29/12/2013
**/

@isTest(seeAllData=false)
public class M2O_UserTestDataUtility {
    
    /**
    @Description: gets the M2O Healthcare profile.
    @Return:      M2O Healthcare profile
    **/ 
         
    public static Profile getM2OSalesHCProfileId() {
    
        Profile hcProfile  = [select id from Profile where name = 'M2O Sales Healthcare'];
        return hcProfile;
    }
    
    /**
    @Description: gets the M2O portal profile.
    @Return:      M2O portal profile
    **/ 
         
    public static Profile getM2OPotalProfileId() {
    
        Profile hcProfile  = [select id from Profile where name = 'Customer Portal Manager Standard'];
        return hcProfile;
    }
    
    /**
    @Description: gets the system admin profile.
    @Return:      system admin profile
    **/
    public static Profile getSystemAdminProfileId() {
    
        Profile sysAdminProfile  = [select id from Profile where name = 'System Administrator'];
        return sysAdminProfile;
    }
    /**
    @Description: gets the M2O Lighting profile.
    @Return:      M2O Lighting profile
    **/ 
    
    public static Profile getM2OSalesLIProfileId() {
    
        Profile liprofile  = [select id from Profile where name = 'M2O Sales Lighting'];
        return liprofile;
    }
    
    /**
    @Description: gets the M2O System Administrator profile.
    @Return:      M2O System Administrator profile
    **/
     
    public static Profile getM2OSystemAdminProfileId() {
    
        Profile m2oSystemAdminProfile = [select id from Profile where name = 'M2O System Administrator'];
        return m2oSystemAdminProfile;
    }
    
    /**
    @Description: Insert user with M2O Global Data Management.
    @Return:      Profile M2O KAM profile
    **/
    
    public static Profile getM2ODataManagementProfileId() {
    
        Profile hcProfile  = [select id from Profile where name = 'M2O System Administrator'];
        return hcProfile;
    }
      /**
    @Description: Query Philips Global Role.
    @Return:      Role record.
    **/
     public static UserRole getGlobalRoleRecord(){
        UserRole userRoleRec = [SELECT Name FROM UserRole WHERE Name = 'Philips Global'];
        return userRoleRec;
    }
    /**
    @Description: Insert user with Healthcare profile.
    @Param1:      Id of the profile.
    @Return:      User with Healthcare profile
    **/
     
    public static User getHCUserRecord(Id profileId) {
              
        User  healthCareUser = new User(LastName = 'User1',Username = 'Atest1.user.philips1@abc.com',
                             Email = 'test.user@philips.com',Alias = 'tu1',
                             CommunityNickname= 'tu1123456' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = profileId, LanguageLocaleKey = 'en_US', Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC',isActive=true);
        return healthCareUser;
     }
        /**
    @Description: Insert user with Healthcare profile with Role.
    @Param1:      Id of the profile.
    @Return:      User with Healthcare profile
    **/
   
    public static User getHCRoleUserRecord(Id profileId,Id userRoleRec) {
              
        User  healthCareUser = new User(LastName = 'User2',Username = 'Atest2.user.philips2@abc.com',
                             Email = 'test2.user@philips.com',Alias = 'tu2',
                             CommunityNickname= 'tu11234562' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = profileId, LanguageLocaleKey = 'en_US', Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC', UserRoleId =userRoleRec);
        return healthCareUser;
     }
     
    
     
    /**
    @Description: Insert user with System AdministratorUser profile
    @Param1:      Id of the profile.
    @Return:      user with System AdministratorUser profile
    **/ 
    
    public static User getM2OSystemAdminUserRecord(Id profileId) {
              
        User  m2oSystemAdminUser = new User(LastName = 'User1',Username = 'm2osysadmin.user.philips1@abc.com',
                                Email = 'test.user@philips.com',Alias = 'tu231',
                                CommunityNickname = 'tu111223456' ,TimeZoneSidKey = 'America/Los_Angeles',
                                LocaleSidKey = 'en_US',EmailEncodingKey= 'ISO-8859-1',
                                ProfileId = profileId, LanguageLocaleKey = 'en_US', Market__c = 'Japan',
                                Philips_Sector_Name__c = 'HC');
        return m2oSystemAdminUser;
     }
     
    /**
    @Description: Insert a user.
    @Return:      User record.
    **/
    
     public static User getUser2Record() {
     
        User user2 = new User(LastName = 'User2',Username = 'demotestUser@abc.com',
                             Email = 'test.user@philips.com',Alias = 'du2' ,
                             CommunityNickname= 'du11234516' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = getM2OSalesHCProfileId().Id, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC');
        return user2;
    }
    
    /**
    @Description: Insert Sales team User
    @Param1:      Id of the profile.
    @Return:      Sales team User
    **/
       
    public static User getOpportunityTeamUserRecord(Id profileId) {
    
        User user3 = new User(LastName = 'User3',Username = 'test.user3.philips2@abc.com',
                             Email = 'test.user@philips.com', Alias = 'tu3',
                             CommunityNickname= 'tu11234516' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US', EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = profileId, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                             Philips_Sector_Name__c = 'HC');
        return user3;
    } 
    
    /**
    @Description: Insert a user.
    @Param1:      Id of the Profile.
    @Return:      User record.
    **/
    public static User getOwnerRecord(id profileId) {
        User user4 = new User(LastName = 'User4',Username = 'test.user4.philips2@abc.com',
                             Email = 'test.user@philips4.com', Alias = 'tuser4',
                             CommunityNickname= 'tu8566' ,TimeZoneSidKey = 'America/Los_Angeles',
                             LocaleSidKey='en_US', EmailEncodingKey= 'ISO-8859-1',
                             ProfileId = profileId, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                             Philips_Sector_Name__c = 'LI');
        return user4;
    }
    
    /**
    @Description: Insert a list of users for Sales team.
    @Param1:      Integer count of user.
    @Param2:      Id of the profile.
    @Return:      list of Sales team Users.
    **/ 
    
    public static List<User> getUserRecordsForOpptyTeam(integer userCount, id profileId) {
    
        List<User> lstUser = new List<User>();
        User usr;
        for(integer i = 0; i<userCount; i++) {
            usr = new User(LastName = 'User5',Username = 'test.user'+i+'.philips2@abc.com',
                                 Email = 'test.user@philips5.com', Alias = 'tusr'+i,
                                 CommunityNickname= 'tu8589'+i ,TimeZoneSidKey = 'America/Los_Angeles',
                                 LocaleSidKey='en_US', EmailEncodingKey= 'ISO-8859-1',
                                 ProfileId = profileId, LanguageLocaleKey = 'en_US',Market__c = 'Japan',
                                 Philips_Sector_Name__c = 'LI');
                                 
            lstUser.add(usr);
        }      
        return lstUser;
    }
    
    /**
    @Description: Insert a user.
    @Param1:      Name of profile as a string.
    @Return:      User record.
    **/
    
    public static User getUserRecord(String profileName) {
    
       Id profileId= [select Id from profile where name=:profileName].Id;
       User testUserRecord = new User(LastName = 'User',Username = 'test.user1.philips@philips.com', Email = 'test.user@philips.com',
                            Alias = 'tu1', CommunityNickname= 'tu11234561', TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey='en_US',EmailEncodingKey= 'ISO-8859-1', ProfileId = profileId, LanguageLocaleKey = 'en_US',
                            Permission_For_Data_Loader__c=true,IsActive=true);
       return testUserRecord;
    }
      
}