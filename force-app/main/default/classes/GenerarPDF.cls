public with sharing class GenerarPDF {
    @future
    public static void metodoGenerarPDF(Id caseId){
              
            PageReference pdf = new PageReference('/apex/MergePDF?id=' + caseId);
            Attachment attach = new Attachment();
            Case cs = [select Correction_file_number__c,Corrections_needed__c,CaseNumber, Household__c,PropertyCase__c from Case where Id = :caseId];
            System.debug('File Number' + cs.Correction_file_number__c);
            Blob bodyData;
            String htmlBody = '<html><title>Example</title>'
                    + '<head><h1>Example page</h1></head>';
            try {
                bodyData = Blob.valueOf(htmlBody);
            } catch (VisualforceException e) {
            }
            double fileNumber = cs.Correction_file_number__c;
            System.debug('File Number' + fileNumber);
            attach.Body = bodyData;
            attach.Name = 'CorrectionCounter_' + fileNumber + '.pdf';
            attach.IsPrivate = false;
            attach.contentType = 'pdf';
            attach.ParentId = caseId;
            insert attach;
        
    }




}
