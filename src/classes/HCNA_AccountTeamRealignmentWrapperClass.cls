/*** 
@ClassName : HCNA_AccountTeamRealignmentWrapperClass 
*@Description : Wrapper class for HCNA_AccountTeamRealignment page.
*@Author : Albin
*@Last Modified : 23/06/2014
*@Discussionpoints : No Information
***/
public class HCNA_AccountTeamRealignmentWrapperClass {
    public boolean selectCheckbox {get; set;}
    public Account accountRecord {get; set;}
    /**    
    * @Description : This constructor Of class HCNA_AccountTeamRealignmentWrapperClass   
    * @param       : Account accountRecord  
    **/
    public HCNA_AccountTeamRealignmentWrapperClass(Account accountRecord) {
        this.selectCheckbox = false;
        this.accountRecord = accountRecord;
    }
}