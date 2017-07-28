/**
@Classname :     M2O_AdministrativeRelatedDAOTest
@Description :   Test class for M2O_AdministrativeRelatedDAO 
@Author:         Piyali Saha
@Last Modified:  09/12/2013
**/

@isTest(SeeAllData=true)
public class M2O_AdministrativeRelatedDAOTest { 
    static testMethod void test_getDatedExchangeRates() {
        M2O_AdministrativeRelatedDAO administrativeDao = new M2O_AdministrativeRelatedDAO();        
        Set<String> setCurrencyCode = new Set<String>();
        setCurrencyCode.add('USD');
        setCurrencyCode.add('INR');
        setCurrencyCode.add('EUR');
        administrativeDao.getDatedExchangeRates(setCurrencyCode);
    }
}