public class WrapperAccount {
  public Account WrapAccount{get; set;}         
  public Boolean selected {get; set;}
     
  public WrapperAccount(Account A) {
    WrapAccount = A;
    selected = false;
   }
}