/**
@Classname :       M2O_CPQ_ConnectionHelper
@Description :     Connection helper to get the connection id.
@Author:           Tim(Philips)
@Last Modified:    07/14/2015
**/

public class M2O_CPQ_ConnectionHelper{
    public static Id getConnectionId(String connectionName){    
        List<PartnerNetworkConnection> partnerNetConList =  [Select id from PartnerNetworkConnection where connectionStatus = 'Accepted' and connectionName =:connectionName];        
        if ( partnerNetConList.size()!= 0 ) {
            return partnerNetConList.get(0).Id;
        }        
        return null;
    }
}