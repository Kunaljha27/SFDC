global class DFG_HTTPMocksForTests implements HttpCalloutMock {
    global string responseBody {get;set;}
    
    global HttpResponse respond(HttpRequest req){
      system.debug('REQ '+req);
      String token = 'token=96ecd8a4-c0de-461a-b437-f9949e7631b5';
    //String responseBody='userid='+'xyz.test@xyz.com'+'&password='+ 'test123' + '&SAMLRequest=';
      HttpResponse res = new HttpResponse();
      res.setHeader('Content-Type', 'application/json');
    // res.setBody(responseBody); 
      res.setBody(responseBody);
      res.setStatusCode(200);
      
      if(req.getEndpoint() == 'https://app.dfg152.ru:7084/dfg-test/authenticate')  {
        
        res.setHeader('Content-Type', 'application/json');
        res.setBody(createTokenResponse());
        res.setStatusCode(200);
      }else if(req.getEndPoint()== 'https://app.dfg152.ru:7084/dfg-test/entity/type'){
        res.setHeader('Content-Type', 'application/json');
       // res.setBody(createTokenizedObjectResponse());
        res.setBody(createObjectResponse());
        res.setStatusCode(200);
      }else if(req.getEndPoint()=='https://app.dfg152.ru:7084/dfg-test/data/batch/get'){
        res.setBody(createbatchResponse());
        res.setStatusCode(200);
      }
      else{
        res.setHeader('Content-Type', 'application/json');
        res.setBody(createTokenizedObjectResponse());
      //  res.setBody(createObjectResponse());
        res.setStatusCode(200);
            }
        
      return res; 
      
        
    }
    
    public String createTokenResponse(){
    system.debug('createTokenResponse');
        responseBody =' [{"token":"be9004b9-1998-4a74-8dbe-5e230c3bf0c1","domain":"00Dc0000003uhjf"}]';
        system.assertequals(responseBody,' [{"token":"be9004b9-1998-4a74-8dbe-5e230c3bf0c1","domain":"00Dc0000003uhjf"}]');
        return responsebody;
    }
        
    public String createObjectResponse(){
    system.debug('createObjectResponse');
        responseBody = '[{"id":1,"code":"003","name":"Contact","domainId":1,"fieldList":[{"id":1,"name":"FirstName","tokenized":true},{"id":2,"name":"LastName","tokenized":true},{"id":5,"name":"Phone","tokenized":true}]},{"id":2,"code":"00Q","name":"Lead","domainId":1,"fieldList":[{"id":3,"name":"FirstName","tokenized":true},{"id":4,"name":"LastName","tokenized":true}]},{"id":2,"code":"001","name":"Account","domainId":1,"fieldList":[{"id":3,"name":"Name","tokenized":true}]}]';  
        system.assertequals(responseBody,'[{"id":1,"code":"003","name":"Contact","domainId":1,"fieldList":[{"id":1,"name":"FirstName","tokenized":true},{"id":2,"name":"LastName","tokenized":true},{"id":5,"name":"Phone","tokenized":true}]},{"id":2,"code":"00Q","name":"Lead","domainId":1,"fieldList":[{"id":3,"name":"FirstName","tokenized":true},{"id":4,"name":"LastName","tokenized":true}]},{"id":2,"code":"001","name":"Account","domainId":1,"fieldList":[{"id":3,"name":"Name","tokenized":true}]}]' ); 
        return responsebody;
    }
    public String createTokenizedObjectResponse(){
    system.debug('createTokenizedObjectResponse');
       responseBody = '[{"id":1200759,"code":"003","name":"Contact","domainId":1200740,"fields":[{"id":1200760,"name":"FirstName","tokenized":true},{"id":1200763,"name":"Phone","tokenized":true},{"id":1200762,"name":"LastName","tokenized":true}]}]';
        system.assertequals(responseBody,'[{"id":1200759,"code":"003","name":"Contact","domainId":1200740,"fields":[{"id":1200760,"name":"FirstName","tokenized":true},{"id":1200763,"name":"Phone","tokenized":true},{"id":1200762,"name":"LastName","tokenized":true}]}]' ); 
       
        return responsebody;
    }
      public String createbatchResponse(){
      system.debug('createbatchResponse()');
      responseBody = ' [{"key":"s$LastName$","value":"ggff","fieldId":1200762},{"key":"f$TestName$","value":"fdd","fieldId":1200760}]';
     return responsebody;
      }
}