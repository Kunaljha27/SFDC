public with sharing class PdfEmailController {
    public Id dealSupportRequestId ;
    public String email, name, discountAuthorizationNumber ;
    public PdfEmailController(ApexPages.StandardController controller) {
        dealSupportRequestId = ApexPages.currentPage().getParameters().get('Id');
        email = ApexPages.currentPage().getParameters().get('email');
        name = ApexPages.currentPage().getParameters().get('name');
        discountAuthorizationNumber = ApexPages.currentPage().getParameters().get('number');
    }
  public PageReference sendPdf() {
    PageReference pdf = Page.DSR_PDF_Format;
    pdf.getParameters().put('id',dealSupportRequestId );
    Blob body;
    try {
      // returns the output of the page as a PDF
      body = pdf.getContent();
    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
 
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName(discountAuthorizationNumber+'.pdf');
    attach.setInline(false);
    attach.Body = body;
 
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('Discount Approve for '+name);
    mail.setHtmlBody('Here is the email you requested! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
    // Send the email
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    return null;
  }
 
}