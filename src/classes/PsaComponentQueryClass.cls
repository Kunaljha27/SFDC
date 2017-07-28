global with sharing class PsaComponentQueryClass {
  global String queryString {get; set;}
  global List<sObject> results {get{
      List<sObject> result = Database.Query(queryString);
      return result;
  } set;}
} // End Class