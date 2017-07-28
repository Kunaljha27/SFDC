/**
@Classname :       HCNA_PdfEmailController_test
@Description :     This test class is written to cover the code of Apex class PdfEmailController 
@Author:           Noor 
@Last Modified:    3/26/2014
**/

@isTest
public class HCNA_PdfEmailController_test {

// This test method is covering code of method sendPdf   
    @isTest static void test_sendPdf(){
        Profile profileid = HCNA_UtilityClass.getHCNAProfileId();
        User userRecordTest=HCNA_UtilityClass.getUserRecord(profileid); 
        insert userRecordTest;
        system.runas(userRecordTest) {        
             Deal_Support_Request_del__c ObjDeal = New Deal_Support_Request_del__c();
             ObjDeal.Name = 'test';
             insert ObjDeal;         
             ApexPages.StandardController stdController = new  ApexPages.StandardController(ObjDeal);                      
             PdfEmailController  pdfEmailControllerTest = new PdfEmailController(stdController);
             pdfEmailControllerTest.email = 'SSA@gmail.com';
             pdfEmailControllerTest.sendPdf();
        }
    }    
}