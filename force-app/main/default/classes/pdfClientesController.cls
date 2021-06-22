public with sharing class pdfClientesController 
{
    public List<Account> accList{get;set;}
    public pdfClientesController() 
    {
        accList = [select id,name,type,accountnumber,annualrevenue,Rating from account limit 10];
    }
}
