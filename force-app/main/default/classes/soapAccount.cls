global with sharing class soapAccount {
    global static list<Account> getAccount()
    {
       return [Select Id, Name, Dni__c, AccountNUmber From Account];
    }
}
