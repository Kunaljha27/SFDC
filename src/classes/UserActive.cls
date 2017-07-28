/*
Name : UserActive
Description : Schedule the User In_active Class
*/

global class UserActive implements Schedulable{
   global void execute(SchedulableContext SC) {
    User_Inactive r = new User_Inactive(); 
      r.Check_User_Status();
        }
}