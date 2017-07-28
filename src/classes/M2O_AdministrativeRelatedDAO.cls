/**
@Classname :     M2O_AdministrativeRelatedDAO 
@Description :   Queries administrative related queries, i.e Company information, currency etc, etc.
@Author:         Piyali Saha
@Last Modified:  09/12/2013
**/
public with sharing class M2O_AdministrativeRelatedDAO {
        
        /**@Description:This method is performing a query on Dated conversion rate object to list out the conversion rate , start date,Next start date ,Isocode ,etc for specific Isocode.
           @Param1:Set of string of currency code.
           @Return: List of dated conversion rate.
           **/
        public List<DatedConversionRate> getDatedExchangeRates(Set<String> setCurrencyCode) {
        List<DatedConversionRate> listExchangeRates = null;
        
            listExchangeRates = [Select StartDate, NextStartDate, IsoCode, Id, ConversionRate From DatedConversionRate
                                 where IsoCode  in : setCurrencyCode];
                        return listExchangeRates;
            }
}