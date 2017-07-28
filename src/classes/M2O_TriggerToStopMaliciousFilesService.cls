/**
@Classname :       M2O_TriggerToStopMaliciousFilesService
@Description :     This class is the service class for the M2O_TriggerToStopMaliciousFiles trigger which stops a file from getting uploaded
                   if it has malicious extension or file name contains special characters or it has double extension or no extension.
@author:           Somdev Bhattacharyya
@Last Modified:    07/11/2014
**/

public class M2O_TriggerToStopMaliciousFilesService {

    /**@Description: This method is used to any malicious attachment to get uploaded
       @Param1:      List of Attachments.
       @Return:      Void.
    **/
     public void stopMaliciousFileUpload (List<Attachment> attachmentList) {
        Set<String> fileExtList = new Set<String>();
        list<M2O_MalaciousFileExtensionValues__c>extnList = M2O_MalaciousFileExtensionValues__c.getall().values();
        for(M2O_MalaciousFileExtensionValues__c loopVar : extnList ) {
            fileExtList.add(loopVar.Name);
        }
        integer count,scount;
        List<String> ls ;
        List<String> splitByDot;
        Integer flag=0;
        String name;
        String extension;
    
        for (Attachment attch : attachmentList) {
            count=0;
            scount=0;
            name=attch.Name.toLowerCase(); 
            //String strFilename = attachment.Name.toLowerCase();
                   system.debug(name+ 'yehi hai');
    
            ls = new List<String> ();
            ls = name.split('|');
            splitByDot = name.split('\\.');
            system.debug(splitByDot + 'yehi hai');
            for(String loopVar : splitByDot) {
                extension = loopVar;
            }
            
            for (string s :ls) {
                if(s=='.') {
                    count++;
                }system.debug('iam countingAAA'+ s);
                if(s==':'||s==';'||s=='<'||s=='\\'||s=='>'||s=='/'||s=='@'||s=='$'||s=='%'||s=='^'||s=='&'||s=='*'||s=='~'||s=='`'||s=='!') {
                    scount++; 
                    
                }
            }
            
            System.debug('******extension : '+extension);
            
            for(String extnd : fileExtList) {
                System.debug('******Inside loop, extnd : '+extnd);
                
                if(extension.equals(extnd) ) {
                    System.debug('******Inside loop, Match');                
                    flag=1;
                
                }
                else if(count>1) {
                    attch.addError('File cannot be uploaded becuase it has multiple extensions. Please use another file');
                }
                else if(scount>0) {
                    attch.addError('File cannot be uploaded becuase the filename contains special characters. Please use another file. Special Characters not allowed are : , < , > , ^ , % , $ , # , @ , ! , * , ~');
     
                }
                
            }system.debug(flag+'dead man switch');
            if(flag ==0) {
                attch.addError('File Cannot be uploaded. Please try some other type of file or contact your administrator');
            }
            if(count==0) {
                attch.addError('File cannot be uploaded becuase it has no extensions.');
            }
    
            
         }
     }
}