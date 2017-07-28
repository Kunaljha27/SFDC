@istest
private class  Audit_UpdatesTest{
/*
  static testMethod void User_Role_ChangesTest()
   {
   Userrole UR = [select id,Name from UserRole where Name LIKE 'P%' Limit 1];
   User thisUser = [ select Id,ProfileId,UserRoleid from User where Id = :UserInfo.getUserId() ];
   System.runAs ( thisUser ) {
   User uu = new User();
   Test.startTest();
   uu.firstname='rahul';
   uu.lastname='shaw';
   uu.Alias='RDiNaq';
   uu.Email='rahul@wipro.com';
   uu.Username='rahulshaw@abc.com';
   uu.CommunityNickname='reneedinardo';
   uu.EmailEncodingKey='ISO-8859-1';
   uu.TimeZoneSidKey='America/Los_Angeles';
   uu.LocaleSidKey='en_US';
   uu.LanguageLocaleKey='en_US';
   uu.Profileid=thisUser.ProfileId;
   uu.UserRoleid=thisUser.UserRoleid;
   insert uu;
   uu.UserRoleid=UR.id;
   update uu;
   Test.stopTest();
   uu.IsActive=FALSE;
   update uu;
   uu.IsActive=TRUE;
   update uu;
   }
  }
  */
}