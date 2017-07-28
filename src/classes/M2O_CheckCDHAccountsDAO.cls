/**
@Classname :       M2O_CaptureDeleteRecordsDAO
@Description :     
@Author:           Vishal Kashyap
@Last Modified:    11/15/2013
**/

public class M2O_CheckCDHAccountsDAO {
    /**
    * @Description : This menthod return M2O Data Integration Profile ID.
    * @param       : null.
    * @return      : ID.
    **/
    public static ID dataMigrationID() {
         return ([Select Id from Profile where Name =:Label.M2O_Data_Integration_Profile]).Id;
    }
}