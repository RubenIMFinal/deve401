public with sharing class todosLosContactosController 
{
    private String ordenar = 'FirstName';
    public List<Contact> getContacts()
    {
        list<Contact> resultados = database.query('select Id, FirstName, LastName, Email From Contact ORDER BY '+ ordenar+' ASC');

        return resultados;
    }

    public void orderPorNombre()
    {
        this.ordenar = 'FirstName';
    }

    public void orderPorEmail()
    {
        this.ordenar = 'Email';
    }
}
