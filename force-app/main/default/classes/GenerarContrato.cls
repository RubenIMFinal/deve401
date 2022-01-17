global with sharing class GenerarContrato {

    //Autor:Rubén Izquierdo Molina.
    //Clase que crea un contrato (pdf) y lo añade (attachment).
    //Actualiza el caso relacionado o de no existir, crea uno.
    //Crea y relaciona con la cuenta el objeto "Error" para poder registrar excepciones...


    public static final String FORM_HTML_START = '<HTML><BODY>';
    public static final String FORM_HTML_END = '</BODY></HTML>';

    global static void metodoContrato(Boolean newAccept, String dni) {

        Account account = [SELECT Id, Name, numDNI__c, Iaccepttheinformationpriorofcontracting__c, Account.IsDeleted FROM Account WHERE numDNI__c=: dni ];
        String pdfContent = '' + FORM_HTML_START;

        account.Iaccepttheinformationpriorofcontracting__c = newAccept;
        update account;

        if(newAccept == true){
            system.debug('RIM account: ' + account);
            system.debug('RIM Iaccepttheinformationpriorofcontracting: ' + newAccept);


            try
            {
                pdfContent = '' + FORM_HTML_START;
                pdfContent = pdfContent + '<H2>Account Information in PDF</H2>';
                
                //obtiene los campos que guarda en el pdf
                Map<String, Schema.SObjectType> sobjectSchemaMap = Schema.getGlobalDescribe();
                Schema.DescribeSObjectResult objDescribe = sobjectSchemaMap.get('Account').getDescribe();
                Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
                system.debug('RIM entra en try');

                //Adjunta cada campo al PDF
                for(Schema.SObjectField fieldDef : fieldMap.values()) 
                {
                    Schema.Describefieldresult fieldDescResult = fieldDef.getDescribe();
                    String name = fieldDescResult.getName();
                    pdfContent = pdfContent + '<P>' + name + ': ' + account.get(name) + '</P>';
                }
    
                pdfContent = pdfContent + FORM_HTML_END;
    
            }catch(Exception e)
    
            {
                pdfContent = '' + FORM_HTML_START;
                pdfContent = pdfContent + '<P>THERE WAS AN ERROR GENERATING PDF: ' + e.getMessage() + '</P>';
                pdfContent = pdfContent + FORM_HTML_END;
            }
            attachPDF(account,pdfContent);
        }else{
            System.debug('Archivo no creado');
        }

        //para mostrarlo en el path:
        Case newOnbrd = new Case();
        try{  
            newOnbrd = [SELECT Id, DNICliente__c FROM Case WHERE DNICliente__c =: dni];
            newOnbrd.Contrato_Aceptado__c = newAccept;
            newOnbrd.Status = 'Escalated';
            System.debug('RIM newOnbrd: ' + newOnbrd);
    
            update newOnbrd;  
        }catch(System.QueryException e){
    
            //Case newOnbrd = new Case();
            newOnbrd.AccountId = account.Id;
            newOnbrd.Status = 'Escalated';
            newOnbrd.Contrato_Aceptado__c = newAccept;
            System.debug('RIM catch onbrd: ' + newOnbrd);
    
            insert newOnbrd;
        }

        //para crear el objeto Contratos: 
        ONB_contract__c newContrato = new ONB_contract__c();
        newContrato.Name = 'Contrato de: ' + account.Name;
        newContrato.ContractAccountId__c = account.id;
        newContrato.CntroCaseId__c = newOnbrd.Id;
        System.debug('RIM nuevo contrato: ' + newContrato);

        insert newContrato;
     
   
    }




    global static void attachPDF(Account account, String pdfContent)
    {
        try
        {
            Attachment attachmentPDF = new Attachment();
            attachmentPDF.parentId = account.Id;
            attachmentPDF.Name = account.Name + '.pdf';
            attachmentPDF.body = Blob.toPDF(pdfContent); //Aquí creamos el pdf
            insert attachmentPDF;

        }catch(Exception e)
        {     
           account.addError(e.getMessage());
        }
    }

}
