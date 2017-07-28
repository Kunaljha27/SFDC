/*
Name SendEmail
Dependent class : Sharing Settings
Description : Send email to the Added and Deleted user in the Account Team and Sales Team
Created by : Yunus
*/

global Class SendEmail{
    public Static Void Sendmail(String Str_Subject,String Str_Body,String Str_ToAddress){
        system.debug('@@@@@@@@@@@@@Inside the method@@@@@@@@@@@@@@@');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setsubject(str_Subject);
        mail.setHtmlBody(Str_Body);
        mail.setToAddresses(new String[]{Str_ToAddress});
        system.debug('##############mail##########'+mail);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        

    }
}